FROM golang:1.16.15-alpine3.15

WORKDIR /app

COPY /example-backend /app

# Install build dependencies
# gcc and musl-dev are typically required for go test
RUN apk add --no-cache gcc musl-dev

ENV PORT=8080
EXPOSE $PORT

RUN go build
RUN go test ./...

CMD ./server