# Use Python 3.10 as the base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python build tools
RUN pip install --upgrade pip setuptools wheel

# Set the working directory
WORKDIR /app

# Copy the repository code into the container
COPY . /app

# Install the repository
RUN pip install torch datasets \
    && pip install .

# Default command for verification
CMD ["python", "-c", "from transformers import pipeline; print(pipeline('sentiment-analysis')('I love this!'))"]
