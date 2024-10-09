set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

. $(dirname "$0")/aws_common.sh

function usage {
  echo "Usage: ${0} <instance_name>"
  exit 2
}

if [ $# -lt 1 ]
then
  echo "Missing instance name"
  usage
fi

instance_name=$1
echo "Instance name: ${instance_name}"
mfa_profile="$(instance_to_mfa_profile ${instance_name})"
echo "Profile: ${mfa_profile}"
region=$(instance_to_region ${instance_name})
echo "Region: ${region}"

instance_ids=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value | [0],InstanceId]' --filter "Name=tag:Name,Values=${instance_name}" --output text --profile ${mfa_profile} --region ${region})

instance_id=$(echo ${instance_ids} | head -1 | awk '{print $2}')
echo "Instance ID: ${instance_id}"

aws ssm start-session --target ${instance_id} --profile ${mfa_profile}
