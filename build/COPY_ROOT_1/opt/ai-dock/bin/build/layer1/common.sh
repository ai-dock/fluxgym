#!/bin/false

source /opt/ai-dock/etc/environment.sh

build_common_main() {
    # Nothing to do
    :
}

build_common_install_fluxgym() {
    # Get latest tag from GitHub if not provided
    if [[ -z $FLUXGYM_BUILD_REF ]]; then
        export FLUXGYM_BUILD_REF="$(curl -s https://api.github.com/repos/cocktail_peanut/fluxgym/tags | \
            jq -r '.[0].name')"
        env-store FLUXGYM_BUILD_REF
    fi

    [[ -n $FLUXGYM_BUILD_REF ]] || exit 1

    cd /opt
    git clone --recursive https://github.com/cocktailpeanut/fluxgym
    cd /opt/fluxgym
    git checkout "$FLUXGYM_BUILD_REF"
    git clone https://github.com/kohya-ss/sd-scripts
    cd /opt/fluxgym/sd-scripts
    git checkout ${KOHYA_BUILD_REF:-sd3}
    # Kohya Scripts
    "$FLUXGYM_VENV_PIP" install --no-cache-dir \
        -r requirements.txt

    # FluxGym
    cd /opt/fluxgym
    "$FLUXGYM_VENV_PIP" install --no-cache-dir \
        tensorboard \
        -r requirements.txt
}

build_common_run_tests() {
    installed_pytorch_version=$("$FLUXGYM_VENV_PYTHON" -c "import torch; print(torch.__version__)")
    if [[ "$installed_pytorch_version" != "$PYTORCH_VERSION"* ]]; then
        echo "Expected PyTorch ${PYTORCH_VERSION} but found ${installed_pytorch_version}\n"
        exit 1
    fi
}

build_common_main "$@"