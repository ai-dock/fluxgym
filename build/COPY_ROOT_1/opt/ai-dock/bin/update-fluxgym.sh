#!/bin/bash
umask 002

source /opt/ai-dock/etc/environment.sh
source /opt/ai-dock/bin/venv-set.sh fluxgym

if [[ -n "${FLUXGYM_REF}" ]]; then
    ref="${FLUXGYM_REF}"
else
    # The latest tagged release
    ref="$(curl -s https://api.github.com/repos/cocktailpeanut/fluxgym/tags | \
            jq -r '.[0].name')"
fi

# -r argument has priority
while getopts r: flag
do
    case "${flag}" in
        r) ref="$OPTARG";;
    esac
done

[[ -n $ref ]] || { echo "Failed to get update target"; exit 1; }

printf "Updating FluxGym (${ref})...\n"

cd /opt/kohya_ss
git stash
git fetch --tags
git checkout ${ref}
git pull
git submodule update --recursive

printf "\n%s\n" '#myTensorButton, #myTensorButtonStop {display:none!important;}' >> assets/style.css

"$FLUXGYM_VENV_PIP" install --no-cache-dir \
    -r requirements.txt
