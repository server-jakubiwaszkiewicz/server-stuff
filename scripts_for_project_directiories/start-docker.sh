#!/bin/bash

echo "This script will build a Docker image from the Dockerfile in the current directory and run a container from the built image."
echo "It will also prompt you for the port to be used for the container on the host (outside Docker)."
echo "If the port is already in use, the script will exit."
echo "The script assumes that you have a .env file in the current directory with the necessary variables."


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
echo "Checking for .env file..."
if [ -f .env ]; then
  # Use the source (or .) command to load the variables
  source .env
else
  echo ".env file not found. Please create one with the necessary variables."
  exit 1
fi

# Prompt for the port to be used
app_port=$PORT

# Check if the port is defined in the .env file
if [ -z "$app_port" ]; then
  echo "PORT variable not found in .env file. Please create one with the necessary variables."
  exit 1
fi

# Prompt for the port to be used
echo "Enter the port for the container on the host (outside Docker): "
read host_port

# Get the name of the current directory (the script's parent directory)
container_name="$(basename "$(pwd)")"

# Check if the port is already in use
if port_in_use "$host_port"; then
  echo "Port $host_port is already in use. Please choose a different port."
  exit 1
fi

echo "Properties of the container to be created"
echo ""
echo "  Container name: $container_name"
echo "  Host port: $host_port"
echo "  App port: $app_port"
echo
echo "Building Docker image and running container..."

# Build a Docker image from the Dockerfile in the current directory
docker build -t "image-$container_name" .

# Run a container from the built image and map port 3001
docker run -dp "$host_port:$app_port" --name "$container_name" "image-$container_name"