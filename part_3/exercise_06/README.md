# EXERCISE 3.6 🤔
Return now back to our [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) Dockerfile.

Document both image sizes at this point, as was done in the material. Optimize the Dockerfiles of both apps, frontend and backend, by joining the RUN commands and removing useless parts.

After your improvements document the image sizes again. The size difference may not be very much yet.

# Solution 💡

## 1. Copy Necessary files:
_**Note**: Make sure you are located in `./part_3/exercise_06/` directory._

Run command:
```bash
./copy_files.sh
```

You will now see both **exercise-frontend** and **exercise-backend** dirs.

## 2. Optimize Frontend Image:
We will be joining the RUN commands and removing useless parts from Docker files.

### Initial Image size:
We already have frontend and backend images built from the previous exercise. If you do not, please refer to [exercise 3.05](https://github.com/milistu/DevOpsWithDocker/tree/main/part_3/exercise_05) for detailed instructions on how to build them.

To check image size you can run the command:
```bash
docker images
```

We can see that our **frontend** docker image has **663MB**. 

### Image optimization
We can merge RUN commands and see the difference in size:

```dockerfile
RUN npm install && \
    npm run build && \
    npm install -g serve

# Create a non-root user
RUN adduser -D appuser && \
    chown -R appuser:appuser /app
```
Our RUN commands will now look like this:

```Dockerfile
RUN npm install && \
    npm run build && \
    npm install -g serve && \
    adduser -D appuser && \
    chown -R appuser:appuser /app
```

After optimization image size is now **478MB**. Great job!

## 3. Optimize Backend Image:

### Initial Image size:
To check image size you can run this command:
```bash
docker images
```

We can see that our **frontend** docker image has **554MB**. 

### Image optimization
We can merge RUN and ENV commands and see the difference in size. <br>
Docker image before:

```dockerfile
FROM node:16.20.2-alpine3.18

WORKDIR /app

# --- Additional for Exercise 1.14
# Accept REACT_APP_BACKEND_URL as a build-time argument
ARG REACT_APP_BACKEND_URL

# Use the argument to set the environment variable
ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL

COPY . /app

RUN npm install && \
    npm run build && \
    npm install -g serve && \
    adduser -D appuser && \
    chown -R appuser:appuser /app

USER appuser

# Change port number here if it is not available
ENV PORT=1000
EXPOSE $PORT

CMD serve -s -l $PORT build
```
Docker image after:

```Dockerfile
FROM golang:1.16.15-alpine3.15

WORKDIR /app

COPY . /app

RUN apk add --no-cache gcc musl-dev && \
    adduser -D appuser && \
    chown -R appuser:appuser /app

USER appuser

ENV REQUEST_ORIGIN=http://localhost:1000 PORT=8080
EXPOSE $PORT

RUN go build && \
    go test ./...

CMD ./server
```

After optimization, there are no changes in image size.

