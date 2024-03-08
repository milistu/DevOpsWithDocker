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
