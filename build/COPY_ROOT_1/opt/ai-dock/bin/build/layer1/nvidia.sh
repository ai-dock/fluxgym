#!/bin/false

build_nvidia_main() {
    build_nvidia_install_fluxgym
    build_common_run_tests
    build_nvidia_run_tests
}

build_nvidia_install_fluxgym() {
    build_common_install_fluxgym
    "$FLUXGYM_VENV_PIP" install --no-cache-dir \
        bitsandbytes \
        onnxruntime-gpu \
        tensorrt==10.0.1 --extra-index-url https://pypi.nvidia.com
    
    ln -s "$FLUXGYM_VENV/lib/python${PYTHON_VERSION}/site-packages/tensorrt_libs/libnvinfer.so.10" \
        "$FLUXGYM_VENV/lib/libnvinfer.so"
    ln -s "$FLUXGYM_VENV/lib/python${PYTHON_VERSION}/site-packages/tensorrt_libs/libnvinfer_plugin.so.10" \
        "$FLUXGYM_VENV/lib/libnvinfer_plugin.so"
}

build_nvidia_run_tests() {
    installed_pytorch_cuda_version=$("$FLUXGYM_VENV_PYTHON" -c "import torch; print(torch.version.cuda)")
    if [[ "$CUDA_VERSION" != "$installed_pytorch_cuda"* ]]; then
        echo "Expected PyTorch CUDA ${CUDA_VERSION} but found ${installed_pytorch_cuda}\n"
        exit 1
    fi
}

build_nvidia_main "$@"