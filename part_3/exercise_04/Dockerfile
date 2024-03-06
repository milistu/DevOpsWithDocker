FROM docker:latest

# Install git
RUN apk add --no-cach git

WORKDIR /usr/local/bin/

# Copy builder script
COPY builder.sh .

# Make sure script is executable
RUN chmod +x  builder.sh

# Use script as entrypoint
ENTRYPOINT ["./builder.sh"]

