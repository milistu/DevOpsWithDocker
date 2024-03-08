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