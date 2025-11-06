#!/bin/bash

image_name="open-webui"
ghcr_repo="ghcr.io/courseville/${image_name}"
#github_pat="ghp_pnbMhNI7PXOtnnPvB7Pagp8NsK22z72Sxxxx"
github_pat=""
#github_username="ryuinxxxx"
github_username=""

# Authenticate to GHCR
echo ${github_pat} | docker login ghcr.io -u ${github_username} --password-stdin

# Create a builder if it doesn't exist
docker buildx create --use --name multiarch-builder || docker buildx use multiarch-builder

# Build multi-platform image
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "$ghcr_repo" \
  --push .  # Important: use --push when using buildx for remote registry
