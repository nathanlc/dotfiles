function instance_to_mfa_profile {
  instance_name=$1
  instance_split=(${instance_name//-/ })
  environment=${instance_split[0]}
  region=${instance_split[1]}
  if [[ "${region}" == "de" ]]; then
    region="defr"
  fi
  if [[ "${environment}" == "qa" ]]; then
    profile="qa"
  elif [[ "${environment}" == "qa2" ]]; then
    profile="qa"
  elif [[ "${environment}" == "staging" ]]; then
    profile="prod-${region}"
  else
    # e.g. prod-eu
    profile="${environment}-${region}"
  fi
  echo "glooko-${profile}-mfa"
}

function instance_to_region {
  instance_name=$1
  instance_split=(${instance_name//-/ })
  region_short=${instance_split[1]}
  case $region_short in
	"us")
	  echo "us-east-1"
    return 0
	  ;;
	"eu")
    echo "eu-west-1"
	  return 0
	  ;;
	"defr"|"de")
	  echo "eu-central-1"
    return 0
	  ;;
	*)
	  echo "Invalid region: ${region_short}"
	  exit 2
	  ;;
  esac
}
