# Key is relative to $WORKSPACE/storage/

declare -A storage_map
storage_map["stable_diffusion/models/unet"]="/opt/fluxgym/models/unet"
storage_map["stable_diffusion/models/clip"]="/opt/fluxgym/models/clip"
storage_map["stable_diffusion/models/vae"]="/opt/fluxgym/models/vae"

# Add more mappings for other repository directories as needed