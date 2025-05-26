#!/bin/bash
# Build and run VACE Docker container with GPU support

# Step 1: Build the Docker image
docker build -t vace-gpu .

# Step 2: Run the container
docker run --gpus all -it --rm \
  -v $(pwd)/models:/app/models \
  -v $(pwd)/output:/app/output \
  vace-gpu
