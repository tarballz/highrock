#!/usr/bin/env bash

# Usage: ./restore_db.sh <hrs_db_data>.tar.gz

# Exit if no arg provided
if [ -z "$1" ]; then
    echo "Usage $0 <hrs_db_data>.tar.gz"
    exit 1
fi

# Create volume if deleted
docker volume inspect hrs_db_data > /dev/null 2>&1 || \
  docker volume create hrs_db_data

# Runs a Docker container and automatically removes it when finished.
# Mounts the Docker volume hrs_db_data to the container's directory /data.
# Mounts your local backups folder to the container's /backup directory.
# Runs alpine, and extracts the .tar.gz
docker run --rm \
  -v hrs_db_data:/data \
  -v "$(dirname "$1"):/backup" \
  alpine sh -c "rm -rf /data/* && tar xzf /backup/$(basename "$1") -C /data"