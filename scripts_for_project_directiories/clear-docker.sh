#!/bin/bash

# Define the image name you want to search for
IMAGE_NAME="your_image_name_here"

# Get the container ID(s) based on the image name
CONTAINER_IDS=$(docker ps -q --filter "ancestor=${IMAGE_NAME}")

# Check if any containers were found
if [ -z "$CONTAINER_IDS" ]; then
  echo "No containers found with the image name: ${IMAGE_NAME}"
else
  # Loop through each container and stop/remove it
  for CONTAINER_ID in $CONTAINER_IDS; do
    echo "Stopping and removing container ID: ${CONTAINER_ID}"
    docker stop "$CONTAINER_ID"  # Stop the container
    docker rm "$CONTAINER_ID"    # Remove the container
  done
fi