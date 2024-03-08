# EXERCISE 3.7 🤔
As you may have guessed, you shall now return back to the example frontend and backend.

Change the base image in FROM to something more suitable. Both should have at least Alpine variants ready in DockerHub. Make sure the application still works after the changes.

Document the size before and after your changes.

# Solution 💡

## 1. Copy Necessary files:
_**Note**: Make sure you are located in `./part_3/exercise_07/` directory._

Run command:
```bash
./copy_files.sh
```

You will now see both **exercise-frontend** and **exercise-backend** dirs. We will be using Dockerfiles from the [previous exercise](https://github.com/milistu/DevOpsWithDocker/tree/main/part_3/exercise_06).

## 2. Optimize Images:
Because we are already using Alpine as base images we can change them to Ubuntu and compare the size.

### Frontend:
We can see that our **frontend** docker image is **478MB** with Alpine. 

When we switch to the `16-bullseye` tag and make changes to the run commands to work with the Ubuntu image:
```Dockerfile
FROM node:16-bullseye

WORKDIR /app

ARG REACT_APP_BACKEND_URL

# Use the argument to set the environment variable
ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL

COPY . /app

RUN npm install && \
    npm run build && \
    npm install -g serve && \
    useradd -m appuser && \
    chown -R appuser:appuser /app

USER appuser

# Change port number here if it is not available
ENV PORT=1000
EXPOSE $PORT

CMD serve -s -l $PORT build
```
And build the new image:
```bash
docker build -t frontend:ubuntu -f Dockerfile.ubuntu .
```
Now our image size is **1.25GB**, that is a pretty big difference!

### Backend:
We can see that our **backend** docker image is **554MB** with Alpine. 

When we switch to the latest tag and make changes to the run commands to work with the Ubuntu image:
```Dockerfile
FROM golang:1.22.1-bullseye

WORKDIR /app

COPY . /app

RUN apt-get update && \
    apt-get install -y gcc musl-dev && \
    useradd -m appuser && \
    chown -R appuser:appuser /app && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER appuser

ENV REQUEST_ORIGIN=http://localhost:1000 PORT=8080
EXPOSE $PORT

RUN go build && \
    go test ./...

CMD ./server
```

And Build the new image:
```
docker build . -t backend -f Dockerfile.ubuntu
```

Now our image size is **980MB**, that is also a pretty big difference!