#!/bin/sh

# Exit if any command fails
set -e

# Check if exactly two arguments are given
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <GitHub repository> <Docker Hub repository>"
    exit 1
fi

# Login to Docker Hub
if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
    echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin
else
    echo "Docker Hub credentials not provided."
    exit 1
fi

# Assign command line arguments to variables
GITHUB_REPO=$1
DOCKER_REPO=$2

# Extract the repository name for image tagging
REPO_NAME=$(basename $GITHUB_REPO)

# Clone the GitHub repository
git clone https://github.com/$GITHUB_REPO.git

# Navigate into the repository directory
cd $REPO_NAME

# Build Docker image
docker build -t $DOCKER_REPO .

# Push the Docker image to Docker Hub
docker push $DOCKER_REPO

echo "Image $DOCKER_REPO has been successfully built and pushed to Docker Hub."