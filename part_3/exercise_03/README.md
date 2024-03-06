# EXERCISE 3.3: BUILDING IMAGES INSIDE OF A CONTAINER 🤔
Create a now script/program that downloads a repository from GitHub, builds a Dockerfile located in the root and then publishes it into the Docker Hub.

You can use any scripting or programming language to implement the script. Using [shell script](https://www.shellscript.sh/) might make the next exercise a bit easier... and do not worry if you have not done a shell script earlier, you do not need much for this exercise and Google helps.

The script could eg. be designed to be used so that as the first argument it gets the GitHub repository and as the second argument the Docker Hub repository. Eg. when run as follows

```bash
./builder.sh mluukkai/express_app mluukkai/testing
```
the script clones https://github.com/mluukkai/express_app, builds the image, and pushes it to Docker Hub repository mluukkai/testing

# Solution 💡

## 1. Create bash script:
First we can check if we are logged-in in our Docker Hub:
```bash
docker login
```

## 2. Create the Script:
_**Note**: Be shure you are in directory `./part_3/exercise_03/`_

We will create `builder.sh` that looks like this:

```bash
#!/bin/bash

# Exit if any command fails
set -e

# Check if exactly two arguments are given
if ["$#" -ne 2]; then
    echo "Usage: $0 <GitHub repository> <Docker Hub repository>"
    exit 1
fi

# Assign command line arguments to variables
GITHUB_REPO = $1
DOCKER_REPO = $2

# Extract the repository name for image tagging
REPO_NAME = $(basename $GITHUB_REPO)

# Clone the GitHub repository
git clone https://github.com/$GITHUB_REPO.git

# Navigate into the repository directory
cd $REPO_NAME

# Build Docker image
docker build -t $DOCKER_REPO .

# Push the Docker image to Docker Hub
docker push $DOCKER_REPO

echo "Image $DOCKER_REPO has been successfully built and pushed to Docker Hub.
```

## 3. Make the script executable:

Run the following command in your terminal:
```bash
chmod +x builder.sh
```

## 4. Run the Script

To use the script as described, you simply need to provide it with the GitHub repository and the Docker Hub repository as arguments. For example:

```bash
./builder.sh mluukkai/express_app <your_docker_hub_name>/testing
```

_**NOTE**: Replace `<your_docker_hub_name>` with your Docker Hub User name!_

This command will clone the repository from https://github.com/mluukkai/express_app, build a Docker image using the Dockerfile located in the cloned repository's root, and push the image to the Docker Hub repository <your_docker_hub_name>/testing.