[![Docker Build](https://github.com/ai-dock/kohya_ss/actions/workflows/docker-build.yml/badge.svg)](https://github.com/ai-dock/kohya_ss/actions/workflows/docker-build.yml)

# Flux Gym Docker Image

Run [Flux Gym](https://github.com/cocktailpeanut/fluxgym) in a docker container locally or in the cloud.

>[!NOTE]  
>These images do not bundle models or third-party configurations. You should use a [provisioning script](https://github.com/ai-dock/base-image/wiki/4.0-Running-the-Image#provisioning-script) to automatically configure your container. You can find examples in `config/provisioning`.

## Documentation

All AI-Dock containers share a common base which is designed to make running on cloud services such as [vast.ai](https://link.ai-dock.org/vast.ai) as straightforward and user friendly as possible.

Common features and options are documented in the [base wiki](https://github.com/ai-dock/base-image/wiki) but any additional features unique to this image will be detailed below.


#### Version Tags

The `:latest` tag points to `:latest-cuda`

Tags follow these patterns:

##### _CUDA_
- `:v2-cuda-[x.x.x]-base-[ubuntu-version]`

- `:latest-cuda` &rarr; `:v2-cuda-12.1.1-base-22.04`

##### _ROCm_
- `:v2-rocm-[x.x.x]-core-[ubuntu-version]`

- `:latest-rocm` &rarr; `:v2-rocm-6.0-core-22.04`


Browse [here](https://github.com/ai-dock/kohya_ss/pkgs/container/kohya_ss) for an image suitable for your target environment.

Supported Python versions: `3.10`

Supported Platforms: `NVIDIA CUDA`, `AMD ROCm`

## Additional Environment Variables

| Variable                 | Description |
| ------------------------ | ----------- |
| `AUTO_UPDATE`            | Update Kohya_ss on startup (default `false`) |
| `FLUXGYM_PORT_HOST`      | Flux Gym port (default `7860`) |
| `FLUXGYM_REF`            | Git reference for auto update. Accepts branch, tag or commit hash. Default: latest release |
| `FLUXGYM_URL`            | Override `$DIRECT_ADDRESS:port` with URL for Kohya's GUI |
| `TENSORBOARD_ARGS`       | Startup arguments (default `--logdir /opt/fluxgym`) |
| `TENSORBOARD_PORT_HOST`  | Tensorboard port (default `6006`) |
| `TENSORBOARD_URL`        | Override `$DIRECT_ADDRESS:port` with URL for Tensorboard |

See the base environment variables [here](https://github.com/ai-dock/base-image/wiki/2.0-Environment-Variables) for more configuration options.

### Additional Python Environments

| Environment    | Packages |
| -------------- | ----------------------------------------- |
| `fluxgym`      | Kohya's GUI and dependencies |

This virtualenv will be activated on shell login.


## Additional Services

The following services will be launched alongside the [default services](https://github.com/ai-dock/base-image/wiki/1.0-Included-Software) provided by the base image.

### Flux Gym

The service will launch on port `7860` unless you have specified an override with `FLUXGYM_PORT`.

To manage this service you can use `supervisorctl [start|stop|restart] kohya_ss`.

### Tensorboard

The service will launch on port `6006` unless you have specified an override with `TENSORBOARD_PORT`.

To manage this service you can use `supervisorctl [start|stop|restart] tensorboard`.

>[!NOTE]
>All services are password protected by default. See the [security](https://github.com/ai-dock/base-image/wiki#security) and [environment variables](https://github.com/ai-dock/base-image/wiki/2.0-Environment-Variables) documentation for more information.


## Pre-Configured Templates

**Vast.​ai**

- [Flux Gym:latest-cuda](https://link.ai-dock.org/template-vast-fluxgym)

---

_The author ([@robballantyne](https://github.com/robballantyne)) may be compensated if you sign up to services linked in this document. Testing multiple variants of GPU images in many different environments is both costly and time-consuming; This helps to offset costs_