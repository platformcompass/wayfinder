#!/usr/bin/env bash

set -Eeo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -r v2.1.0

Sets up keys to your hidden treasure chest.

Available options:

-h, --help                Print this help and exit
-v, --verbose             Print script debug info
--voyage                  Path to your voyage directory
EOF
    exit
}

cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
}

setup_colors() {
    if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
        NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
    else
        NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
    fi
}

msg() {
    echo >&2 -e "${1-}"
}

die() {
    local msg=$1
    local code=${2-1}
    msg "$msg"
    exit "$code"
}

parse_params() {
    force=0
    releaseVersion=''

    # Default to VOYAGE environment variable of set
    if [[ -n ${VOYAGE:-} ]]; then
        voyage=$VOYAGE
    fi

    while :; do
        case "${1-}" in
        -h | --help) usage ;;
        -v | --verbose) set -x ;;
        --no-color) NO_COLOR=1 ;;
        --voyage)
            voyage="${2-}"
            shift
            ;;
        -?*) die "Unknown option: $1" ;;
        *) break ;;
        esac
        shift
    done

    args=("$@")
    [[ -z "${voyage}" ]] && die "Where to sailor? Please provide the '--voyage' parameter or set VOYAGE environment variable."

    return 0
}

parse_params "$@"
setup_colors

VOYAGE=$voyage
msg "voyage: $VOYAGE"

sopsConfig=$VOYAGE.sops.yaml
SOPS_AGE_KEY_FILE=$VOYAGE/.wayfinder/key.txt

if [[ ! -f $sopsConfig ]]; then
    msg "${YELLOW}You'll need a place for your loot...let's create a .sops.yaml file in your voyage directory${NOFORMAT}"

    if [[ ! -f $SOPS_AGE_KEY_FILE ]]; then
        msg "${YELLOW}I'll forge a key...${NOFORMAT}"
        
        age-keygen -o $SOPS_AGE_KEY_FILE
    fi

    export SOPS_AGE_KEY=$(grep 'public key:'  $SOPS_AGE_KEY_FILE | awk {'print $4'})

    gomplate  -f templates/.sops.yaml.tpl > $sopsConfig

    # For Production use, you'll want a stronger lock - consider https://github.com/getsops/sops?tab=readme-ov-file#26encrypting-using-hashicorp-vault
    msg "${GREEN}Chest is hidden and ye have the key to open it. Dig up $sopsConfig if you want to make changes.${NOFORMAT}"

else
    msg "${YELLOW}Found yer chest..Dig up $sopsConfig if you want to make changes.${NOFORMAT}"
fi




