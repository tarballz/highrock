#!/bin/bash

# Usage: ./restore_moodle_data.sh <moodle_data>.tar.gz

if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_tar.gz>"
  exit 1
fi

# Create volume if deleted
docker volume inspect moodle_data > /dev/null 2>&1 || \
    docker volume create moodle_data

docker run --rm \
    -v moodle_data:/data \
    -v "$(dirname "$1"):/backup" \
    alpine sh -c "rm -rf /data/* && tar xzf /backup/$(basename "$1") -C /data"
