#!/bin/bash

# cd "$(dirname "$0")"

# Define the source directory relative to the script's location
SRC_DIR="../../material-applications/scaling-exercise"

# Define the destination directory
DEST_DIR="."

# Check if the source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Source directory does not exist: $SRC_DIR"
    exit 1
fi

# Copy the entire folder
cp -R "$SRC_DIR" "$DEST_DIR"

# Confirmation message
echo "Copied $SRC_DIR to $DEST_DIR"
