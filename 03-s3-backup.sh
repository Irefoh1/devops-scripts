#!/bin/bash
# Lesson: backups with timestamps and variables.
# Usage: ./03-s3-backup.sh /path/to/folder my-bucket-name

SOURCE_DIR="$1"
BUCKET="$2"

if [ -z "$SOURCE_DIR" ] || [ -z "$BUCKET" ]; then
    echo "Usage: $0 <folder> <bucket>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Folder $SOURCE_DIR does not exist."
    exit 1
fi

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="/tmp/backup-$TIMESTAMP.tar.gz"

echo "Compressing $SOURCE_DIR..."
tar -czf "$ARCHIVE" "$SOURCE_DIR"

echo "Uploading to s3://$BUCKET/backups/"
aws s3 cp "$ARCHIVE" "s3://$BUCKET/backups/"

rm "$ARCHIVE"   # clean up the local copy
echo "Backup complete: backup-$TIMESTAMP.tar.gz"
