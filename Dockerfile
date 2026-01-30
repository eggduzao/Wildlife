# syntax=docker/dockerfile:1.7
FROM python:3.12-slim

# System deps (add build tools if needed for scientific libs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install runtime deps first to leverage Docker layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY pyproject.toml setup.cfg MANIFEST.in ./
COPY src ./src

# Editable install isn't typical in Docker; install package
RUN pip install --no-cache-dir .

# Expose a default port for API/GUI (adjust as needed)
EXPOSE 8000

# Default command (CLI help); override in docker-compose or run args
CMD ["phenoteka", "--help"]