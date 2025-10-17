const nu_config_path = $nu.default-config-dir
const aws_module_path = $nu_config_path + "/aws_m.nu"
const ssh_module_path = $nu_config_path + "/ssh_m.nu"
use $aws_module_path
use $ssh_module_path

export def host_to_profile_region [host: string] {
  let matches = (
    $host |
    parse --regex '(?P<profile>\w+)-(?P<region>\w+)-.+' |
    get 0
  )
  let profile = match [$matches.profile, $matches.region] {
    ["qa", _] => "glooko-qa",
    ["prod", "eu"] => "glooko-prod-eu",
    ["prod", "us"] => "glooko-prod-us",
    _ => null
  }
  let region = match $matches.region {
    "eu" => "eu-west-1",
    "us" => "us-east-1",
    _ => null
  }
  {profile: $profile, region: $region}
}

export def ssh_fix_config [host] {
  let aws_conf = (host_to_profile_region $host)
  let ssh_conf = (ssh_m config_from_file)
  aws_m set_credentials $aws_conf.profile
  let aws_data = (aws_m describe_instances $aws_conf.region)
  let ip = (
    $aws_data |
    where Name == $host |
    get 0?.PrivateIpAddress?
  )
  if ($ip == null) {
    print $"IP not found for ($host)"
    return null
  }
  let $ssh_conf_updated = (ssh_m update_hostname_ip $ssh_conf $host $ip)
  ssh_m config_string $ssh_conf_updated | save -f ~/.ssh/config
  let updated_host = (
    $ssh_conf_updated |
    where host == $host
  )
  print (ssh_m config_string $updated_host)
  $updated_host
}
