#!/usr/bin/env bash

# Runs a docker container and automatically removes it when the task is done
# Mounts the docker volume "hrs_db_data" inside the container in the /data dir
# Mounts the "backups" dir from the curr dir to the /backup dir in the container
# Uses alpine to compress /data into a tar and puts it into the backups dir
BACKUP_DIR="./backups/db"
mkdir -p "$BACKUP_DIR"
docker run --rm \
    -v hrs_db_data:/data \
    -v "$(pwd)/$BACKUP_DIR:/backup" \
    alpine tar czf /backup/hrs_db_data_$(date +%F_%H-%M-%S).tar.gz -C /data .
