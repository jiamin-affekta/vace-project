# Base image: Ubuntu 22.04 with CUDA 12.4 and cuDNN
FROM nvidia/cuda:12.4.0-cudnn8-runtime-ubuntu22.04

# Install system dependencies and Python 3.10
RUN apt-get update && apt-get install -y \
    git curl ffmpeg build-essential \
    python3.10 python3.10-dev python3.10-venv python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set python3.10 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Upgrade pip
RUN pip install --upgrade pip

# Set working directory and copy all project files
WORKDIR /app
COPY . .

# Install PyTorch and torchvision compatible with CUDA 12.4
RUN pip install torch==2.5.1 torchvision==0.20.1 --index-url https://download.pytorch.org/whl/cu124

# Install VACE dependencies
RUN pip install -r vace/requirements.txt

# Option A: Install Wan2.1-based model support
RUN pip install "wan@git+https://github.com/Wan-Video/Wan2.1"

# Option B (mutually exclusive): Install LTX-Video-based model support
# RUN pip install "ltx-video@git+https://github.com/Lightricks/LTX-Video@ltx-video-0.9.1" sentencepiece --no-deps

# (Optional) Install preprocessing tool requirements
# RUN pip install -r vace/requirements/annotator.txt

# Default command: enter bash shell (can be replaced with python run_vace.py or vace_gui.py)
CMD ["/bin/bash"]
