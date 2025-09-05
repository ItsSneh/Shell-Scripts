#!/bin/bash

# This script takes a backup of a directory and stores it on a remote backup server.
# Note: Ensure SSH key-based authentication is set up before using this script.

# === Configuration ===
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="html_backup_$DATE.zip"
REMOTE_USER="sneh"
REMOTE_HOST="my-backup-server"
REMOTE_PATH="/backup/"

# === Validate source directory ===
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# === Create backup directory if not exists ===
mkdir -p "$BACKUP_DIR"

# === Create the zip archive ===
echo "Creating backup of $SOURCE_DIR..."
zip -r "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR" > /dev/null

if [ $? -ne 0 ]; then
    echo "Error: Failed to create archive."
    exit 1
fi

# === Transfer backup to remote server ===
echo "Transferring backup to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH ..."
scp "$BACKUP_DIR/$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

if [ $? -eq 0 ]; then
    echo "✅ Backup successful: $BACKUP_DIR/$ARCHIVE_NAME"
    
    # Optionally delete local archive
    # Uncomment the line below if you want to remove the local copy after transfer
    # rm -f "$BACKUP_DIR/$ARCHIVE_NAME"
else
    echo "Backup transfer failed!"
    exit 1
fi
