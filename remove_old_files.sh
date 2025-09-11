#!/bin/bash

# Directory to clean up
TARGET_DIR="/path/to/your/directory"

# Number of days (7 for a week)
DAYS=7

# Check if directory if present
if [ ! -d $TARGET_DIR ]
then
  echo "Directory doesn't exist:" $TARGET_DIR
  exit 1
fi

# Find and delete files older than $DAYS in the target directory
find "$TARGET_DIR" -type f -mtime +$DAYS -exec rm -f {} \;

echo "Deleted files older than $DAYS days in $TARGET_DIR"
