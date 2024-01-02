FROM golang:1.16.15-alpine3.15

WORKDIR /app

COPY /example-backend /app

# Install build dependencies
# gcc and musl-dev are typically required for go test
RUN apk add --no-cache gcc musl-dev

# --- Additional for Exercise 1.14
ENV REQUEST_ORIGIN=http://localhost:1000
# --- End

# Change port number here if it is not available
ENV PORT=8080

EXPOSE $PORT

RUN go build
RUN go test ./...

CMD ./server