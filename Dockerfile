# Use an official Python image
FROM python:3.9-slim

# Set environment variables to reduce interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory in the container
WORKDIR /app

# Copy the application files into the container
COPY . .

# Install system dependencies (needed for `aiortc`, `opencv`, etc.)
RUN apt-get update && apt-get install -y \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavfilter-dev \
    libopus-dev \
    libvpx-dev \
    libx264-dev \
    libportaudio2 \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Expose the default port for Streamlit
EXPOSE 8080

# Run the Streamlit application
CMD ["streamlit", "run", "Demo.py", "--server.port=8080", "--server.address=0.0.0.0"]

