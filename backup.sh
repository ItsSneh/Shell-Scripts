#!/bin/bash

# This script takes a backup of a directory and stores on a remote backup server
# Note: Create a public key and copy it to remote server for passwordless authentication before executing the script

# Define variables
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backup"
ARCHIVE_NAME="html_backup.zip"
REMOTE_USER="sneh" 
REMOTE_HOST="my-backup-server"
REMOTE_PATH="/backup/"

# Create the zip archive
zip -r "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"

# Copy the archive to Nautilus Backup Server
scp "$BACKUP_DIR/$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

# Remove the temporary archive on current server after successful copy (Optional)
rm "$BACKUP_DIR/$ARCHIVE_NAME"
