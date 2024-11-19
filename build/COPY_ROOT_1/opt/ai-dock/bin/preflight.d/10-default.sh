#!/bin/false
# This file will be sourced in init.sh

function preflight_main() {
    source /opt/ai-dock/bin/venv-set.sh fluxgym

    preflight_configure_accelerate
    preflight_update_fluxgym
    printf "%s" "${FLUXGYM_ARGS}" > /etc/fluxgym_args.conf
    export TENSORBOARD_ARGS=${TENSORBOARD_ARGS:-"--logdir /opt/fluxgym/logs"}
    env-store TENSORBOARD_ARGS
    printf "%s" "${TENSORBOARD_ARGS}" > /etc/tensorboard_args.conf
}

function preflight_configure_accelerate() {
     sudo -u "$USER_NAME" rm -f "/home/$USER_NAME/.cache/huggingface/accelerate/default_config.yaml"
     sudo -u "$USER_NAME" "$FLUXGYM_VENV_PYTHON" \
         -c "from accelerate.utils import write_basic_config; write_basic_config()"
     # Make this available for user root
     mkdir -p /root/.cache/huggingface/accelerate/
     cp "/home/$USER_NAME/.cache/huggingface/accelerate/default_config.yaml" \
         /root/.cache/huggingface/accelerate/
}

function preflight_update_fluxgym() {
    if [[ ${AUTO_UPDATE,,} == "true" ]]; then
        /opt/ai-dock/bin/update-fluxgym.sh
    else
        printf "Skipping auto update (AUTO_UPDATE != true)"
    fi
}

preflight_main "$@"