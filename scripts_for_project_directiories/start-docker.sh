#!/bin/bash

#
# This script will build a Docker image from the Dockerfile in the current directory and run a container from the built image."
# 
# It will also prompt you for the port to be used for the container on the host (outside Docker)."
# 
# If the port is already in use, the script will exit."
# 
# The script assumes that you have a .env file in the current directory with the necessary variables."
#
echo "Building Docker image and running container..."
# Function to check if a port is in use
port_in_use() {
  local port="$1"
  if [ -n "$(netstat -tuln | grep ":$port")" ]; then
    return 0 # Port is in use
  else
    return 1 # Port is not in use
  fi
}

# Check if the .env file exists
if [ -f .env ]; then
  # Use the source (or .) command to load the variables
  source .env
else
  echo ".env file not found. Please create one with the necessary variables."
  exit 1
fi


port=$PORT

# Check if the port is defined in the .env file
if [ -z "$port" ]; then
  echo "PORT variable not found in .env file. Please create one with the necessary variables."
  exit 1
fi

# Get the name of the current directory (the script's parent directory)
container_name="$(basename "$(pwd)")"

# Check if the port is already in use
if port_in_use "$port"; then
  echo "Port $port is already in use. Please choose a different port."
  exit 1
fi

echo "Properties of the container"
echo ""
echo "  Container name: $container_name"
echo "  Host port: $port"
echo "  App port: $port"
echo ""
echo "Building Docker image and running container..."

# Build a Docker image from the Dockerfile in the current directory
docker build -t "image-$container_name" .

# Run a container from the built image and map port from .env variable
docker run -dp "$port:$port" --name "$container_name" "image-$container_name"

echo "Docker image and container created."