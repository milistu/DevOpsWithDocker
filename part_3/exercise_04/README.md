# EXERCISE 3.4: BUILDING IMAGES INSIDE OF A CONTAINER 🤔
As seen from the Docker Compose file, the Watchtower uses a volume to [docker.sock](https://stackoverflow.com/questions/35110146/what-is-the-purpose-of-the-file-docker-sock) socket to access the Docker daemon of the host from the container:
```docker
services:
watchtower:
  image: containrrr/watchtower
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
  # ...
```
In practice this means that Watchtower can run commands on Docker the same way we can "command" Docker from the cli with _docker ps, docker run_ etc.

We can easily use the same trick in our own scripts! So if we mount the _docker.sock_ socket to a container, we can use the command _docker_ inside the container, just like we are using it in the host terminal!

Dockerize now the script you did for the previous exercise. You can use images from [this repository](https://hub.docker.com/_/docker) to run Docker inside Docker!

Your Dockerized could be run like this (the command is divided into many lines for better readability, note that copy-pasting a multiline command does not work):
```bash
docker run -e DOCKER_USER=mluukkai \
  -e DOCKER_PWD=password_here \
  -v /var/run/docker.sock:/var/run/docker.sock \
  builder mluukkai/express_app mluukkai/testing2
```
Note that now the Docker Hub credentials are defined as environment variables since the script needs to login to Docker Hub for the push.

Submit the Dockerfile and the final version of your script.

Hint: you quite likely need to use [ENTRYPOINT](https://docs.docker.com/reference/dockerfile/#entrypoint) in this Exercise. See [Part 1](https://devopswithdocker.com/part-1/section-4) for more.

# Solution 💡

To Dockerize our script for Docker-in-Docker functionality, our Dockerfile should build an image equipped with our script, Docker CLI, and required dependencies, using a base image with Docker installed. It will communicate with the host's Docker daemon by mounting` /var/run/docker.sock`, enabling containerized Docker commands.

## 1. Copy Script:

First we will need to copy our script `builder.sh` from [previous exercise](https://github.com/milistu/DevOpsWithDocker/tree/main/part_3/exercise_03) to dir `./part_3/exercise_04/`.

## 2. Create Dockerfile:

```dockerfile
FROM docker:latest

# Install git
RUN apk add --no-cach git

# Copy builder script
COPY builder.sh /usr/local/bin/builder.sh

# Make sure script is executable
RUN chmod +x  /usr/local/bin/builder.sh

# Use script as entrypoint
ENTRYPOINT [ " /usr/local/bin/builder.sh" ]
```

## 3. Updated Script (builder.sh)
Change the shebang line in your builder.sh script from `#!/bin/bash` to` #!/bin/sh`. This makes your script explicitly use the sh shell, which is available in our container.

Alos, we will Modify our script to login to Docker Hub using environment variables for Docker Hub credentials. This change is necessary because we'll be passing the Docker Hub username and password through environment variables for security and convenience.

Additional code:
```bash
 #!/bin/sh
```
```bash
# Login to Docker Hub
if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PWD" ]; then
    echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin
else
    echo "Docker Hub credentials not provided."
    exit 1
fi
```

## 4. Build an Image:
```bash
docker build -t builder .
```

## 5. Run Dockerized script:
```bash
docker run --rm -e DOCKER_USER=<your_username> \
  -e DOCKER_PWD=<your_password_here> \
  -v /var/run/docker.sock:/var/run/docker.sock \
  builder mluukkai/express_app <your_username>/testing2

```

And you can check your Docker Hub for a new Image named `testing2`.