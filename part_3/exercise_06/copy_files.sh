#!/bin/bash

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Define the source directories relative to the script's location
FRONTEND_SRC_DIR="../../material-applications/example-frontend"
BACKEND_SRC_DIR="../../material-applications/example-backend"

# Define the destination directory
DEST_DIR="."

# Check if the frontend source directory exists
if [ ! -d "$FRONTEND_SRC_DIR" ]; then
    echo "Frontend source directory does not exist: $FRONTEND_SRC_DIR"
    exit 1
fi

# Check if the backend source directory exists
if [ ! -d "$BACKEND_SRC_DIR" ]; then
    echo "Backend source directory does not exist: $BACKEND_SRC_DIR"
    exit 1
fi

# Copy the entire frontend folder
cp -R "$FRONTEND_SRC_DIR" "$DEST_DIR"

# Copy the entire backend folder
cp -R "$BACKEND_SRC_DIR" "$DEST_DIR"

# Confirmation message
echo "Copied $FRONTEND_SRC_DIR and $BACKEND_SRC_DIR to $DEST_DIR"
