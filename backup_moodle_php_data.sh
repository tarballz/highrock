#!/usr/bin/env bash

BACKUP_DIR="./backups/moodle_php_data"
mkdir -p "$BACKUP_DIR"
docker run --rm \
    -v moodle_php_data:/data \
    -v "$(pwd)/$BACKUP_DIR:/backup" \
    alpine tar czf /backup/moodle_php_data_$(date +%F_%H-%M-%S).tar.gz -C /data .
