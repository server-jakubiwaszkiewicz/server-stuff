#!/bin/bash

# Define the image name you want to search for
<<<<<<< HEAD
IMAGE_NAME="$(basename "$(pwd)")"
=======
IMAGE_NAME="your_image_name_here"
>>>>>>> 87a28a8326806e7a9a1f5bcb1aa373b5a40077c9

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
<<<<<<< HEAD
fi
docker rmi "$IMAGE_NAME" # Remove the image
=======
fi
>>>>>>> 87a28a8326806e7a9a1f5bcb1aa373b5a40077c9
