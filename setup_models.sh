#!/bin/bash
# Create model folders and download dependencies

mkdir -p models

# Clone VACE-Annotators
if [ ! -d "models/VACE-Annotators" ]; then
    git clone https://github.com/ali-vilab/VACE-Annotators.git models/VACE-Annotators
else
    echo "VACE-Annotators already exists."
fi

# Clone LTX-Video (ltx-video-0.9.1)
if [ ! -d "models/VACE-LTX-Video-0.9" ]; then
    git clone --branch ltx-video-0.9.1 https://github.com/Lightricks/LTX-Video.git models/VACE-LTX-Video-0.9
else
    echo "VACE-LTX-Video-0.9 already exists."
fi

# Create empty folder for Wan2.1
if [ ! -d "models/VACE-Wan2.1-1.3B-Preview" ]; then
    mkdir -p models/VACE-Wan2.1-1.3B-Preview
    echo "Please manually place Wan2.1 model files into models/VACE-Wan2.1-1.3B-Preview"
else
    echo "VACE-Wan2.1-1.3B-Preview already exists."
fi
