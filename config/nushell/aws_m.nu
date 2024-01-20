def aws_profiles_from_config_file [] {
  let profiles_table = (
    cat ~/.aws/config |
    jc  --ini |
    from json |
    transpose key value |
    select key |
    where key != default
  )
  let profiles_list = (
    $profiles_table.key |
    each { |it| str replace "profile " "" }
  )
  $profiles_list
}

def one_password_identifier [profile: string] {
  let row = (
    op item list --vault Private |
    from ssv |
    where TITLE =~ $profile
  )
  $row.0.ID
}

def one_password_otp [identifier: string] {
  (
    op item get $identifier --otp |
    str trim
  )
}

def fetch_aws_credentials [profile: string, otp: string] {
  let username = (
    aws sts get-caller-identity --profile $profile |
    from json |
    get Arn |
    parse "{sth}/{username}" |
    get username.0
  )
  let device = (
    aws iam list-mfa-devices --user-name $username --profile $profile |
    from json |
    get MFADevices |
    get SerialNumber.0
  )
  let credentials = (
    aws sts get-session-token --profile $profile --serial-number $device --token-code $otp |
    from json |
    get Credentials
  )
  $credentials
}

def get_credentials [profile: string] {
  let defined_profiles = aws_profiles_from_config_file
  if ($defined_profiles | any { |it| $it == $profile }) {
    let identifier = one_password_identifier $profile
    let otp = one_password_otp $identifier
    let creds = fetch_aws_credentials $profile $otp
    $creds
  } else {
    echo $"Profile '($profile)' not found in ~/.aws/config: ($defined_profiles)"
    {}
  }
}

export def --env set_credentials [profile: string] {
  let creds = get_credentials $profile
  $env.AWS_ACCESS_KEY_ID = $creds.AccessKeyId
  $env.AWS_SECRET_ACCESS_KEY = $creds.SecretAccessKey
  $env.AWS_SESSION_TOKEN = $creds.SessionToken
  echo $creds
}

export def describe_instances [region?: string] {
  # No need to specify --profile, it's deduced from the env variables populated
  # by set_credentials (which needs to be run first).
  let instances = match $region {
    null => (aws ec2 describe-instances --output json),
    _ => (aws ec2 describe-instances --region $region --output json)
  }
  let data = (
    $instances |
    from json |
    get Reservations.Instances |
    select -i Tags PrivateIpAddress |
    each { |it|
      let empty_tags = [{Key: "Name", Value: ""}]
      let tags = match $it.Tags {
	      null => $empty_tags,
	      _ => $it.Tags.0?
      }
      let safe_tags = match $tags {
        null => $empty_tags,
	      _ => $tags
      }
      let name_tags = ($safe_tags | where Key == "Name")
      # {Tags: $name_tags, PrivateIpAddress: $it.PrivateIpAddress}
      let name = $name_tags.0?.Value?
      let ip = match $it.PrivateIpAddress {
        [] => "",
	      _ => $it.PrivateIpAddress.0
      }
      {Name: $name, PrivateIpAddress: $ip}
    } |
    filter { |it| ($it.Name != "" and $it.Name != null) }
  )
  $data
}
