set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

VALID_PROFILES=(glooko-qa glooko-prod-eu glooko-prod-us glooko-prod-defr)

function usage {
  echo "Usage: ${0} <profile>"
  echo "Valid profiles: ${VALID_PROFILES[@]}"
  exit 2
}

if [ $# -lt 1 ]
then
  echo "Missing mandatory <profile> arg"
  usage
fi

if [[ ! " ${VALID_PROFILES[@]} " =~ " ${1} " ]]
then
  echo "Invalid profile: ${1}"
  usage
fi

profile=${1}

# one_pass_id=$(op item list --vault Private | grep -i ${aws_one_pass_id} | awk '{print $1}')
one_pass_id=$(op item list --vault Private | grep -i ${profile} | awk '{print $1}')
otp=$(op item get ${one_pass_id} --otp)
mfa_serial_number=$(aws iam list-mfa-devices --profile "$profile" --query 'MFADevices[].SerialNumber' --output text)

creds=$(aws sts get-session-token --profile ${profile} --serial-number ${mfa_serial_number} --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' --output text --token-code ${otp})

access_key_id=$(echo ${creds} | awk '{print $1}')
secret_access_key=$(echo ${creds} | awk '{print $2}')
session_token=$(echo ${creds} | awk '{print $3}')

aws configure set aws_access_key_id  ${access_key_id} --profile=${profile}-mfa
aws configure set aws_secret_access_key  ${secret_access_key} --profile=${profile}-mfa
aws configure set aws_session_token  ${session_token} --profile=${profile}-mfa

echo "MFA credentials configured for profile: ${profile}-mfa"
echo "aws_access_key_id: ${access_key_id}"
echo "aws_secret_access_key: ${secret_access_key}"
echo "aws_session_token: ${session_token}"
