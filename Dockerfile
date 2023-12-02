# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required tools
RUN apt-get update -y && \
    apt-get install -y wget curl && \
    if [ ! -f cloudflared ]; then \
        wget -q -nc https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared; \
        chmod +x cloudflared; \
    fi && \
    curl -fsSL https://code-server.dev/install.sh | sh

# Set environment variable for the port
ENV PORT=8080

# Start VSCode
CMD code-server --port 8080 --disable-telemetry --auth none
