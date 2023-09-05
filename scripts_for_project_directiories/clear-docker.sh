#!/bin/bash

# Get the parent folder name
parent_folder_name="$(basename "$(pwd)")"

# Specify the image name based on the parent folder name
image_name="image-$parent_folder_name"

# Specify the container name based on the parent folder name
container_name="$parent_folder_name"

# Stop and remove the Docker container
docker stop "$container_name" && docker rm "$container_name"

# Remove the Docker image
docker rmi "$image_name"