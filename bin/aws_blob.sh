set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

. $(dirname "$0")/aws_common.sh

function usage {
  echo "Usage: ${0} <bucket_mapper> <blob_name>"
  exit 2
}

if [ $# -lt 2 ]
then
  usage
fi

function bucket_identifier {
  bucket_mapper=$1
  base="glooko-analyzer-logs"
  case $bucket_mapper in
    "qa-us")
      echo "${base}-qa-us-east-1"
      return 0
      ;;

    "prod-us")
      echo "${base}-prod"
      return 0
      ;;

    "prod-eu")
      echo "${base}-prod-eu-west-1"
      return 0
      ;;

    *)
      >&2 echo "Cannot map bucket mapper to bucket_identifier: ${bucket_mapper}"
      exit 2
      ;;
  esac
}

bucket_mapper=$1
echo "Bucket mapper: ${bucket_mapper}"
mfa_profile="$(instance_to_mfa_profile ${bucket_mapper})"
echo "Profile: ${mfa_profile}"
region=$(instance_to_region ${bucket_mapper})
echo "Region: ${region}"
bucket_identifier=$(bucket_identifier ${bucket_mapper})
echo "Bucket identifier: ${bucket_identifier}"

aws s3 cp --profile ${mfa_profile} --region ${region} s3://${bucket_identifier}/${2} ~/Downloads/.
