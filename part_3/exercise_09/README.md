# EXERCISE 3.9: MULTI-STAGE BACKEND 🤔
Let's do a multi-stage build for the [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) project since we've come so far with the application.

The project is in Golang and building a binary that runs in a container, while straightforward, isn't exactly trivial. Use resources that you have available (Google, example projects) to build the binary and run it inside a container that uses `FROM scratch`.

To successfully complete the exercise the image must be smaller than **25MB**.

# Solution 💡

## 1. Copy Necessary files:
_**Note**: Make sure you are located in the `./part_3/exercise_9/` directory._

Run command:
```bash
./copy_files.sh
```

## 2. Optimize Images:
Remember from exercise [3.07](https://github.com/milistu/DevOpsWithDocker/tree/main/part_3/exercise_07), our image has **554MB**.

Our Docker image looks like this:
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

When we introduce multi-stage build, now it looks like this:
```Dockerfile
FROM golang:1.16.15-alpine3.15 as builder

WORKDIR /app

COPY ./example-backend .

# Ensure the binary is statically linked by setting CGO_ENABLED=0
# and passing -ldflags to 'go build' to strip unnecessary information
# which can reduce the binary size
RUN apk add --no-cache gcc musl-dev && \
    CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o server . && \
    go test ./...

FROM scratch

# Copy the built binary from the builder stage
COPY --from=builder /app/server /server

ENV REQUEST_ORIGIN=http://localhost:1000 PORT=8080
EXPOSE $PORT

CMD ["/server"]
```

And now our image is **17.1MB**! Great job!
