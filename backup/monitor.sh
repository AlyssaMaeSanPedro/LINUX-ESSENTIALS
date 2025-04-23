#!/bin/bash
create_backup() {
    BACKUP_DIR="backup"
    echo "Checking for backup folder..."

    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir "$BACKUP_DIR"
        echo -e "\nBackup folder created at: $(pwd)/$BACKUP_DIR"
    else
        echo -e "\nBackup folder already exists at: $(pwd)/$BACKUP_DIR"
    fi

    echo -e "\nCopying recently modified files to the backup folder..."
    RECENT_FILES=$(find . -maxdepth 1 -type f -mtime -1)

    if [ -z "$RECENT_FILES" ]; then
        echo -e "\nNo recently modified files found."
    else
        echo "$RECENT_FILES" | while read file; do
            cp "$file" "$BACKUP_DIR/"
            echo "Backed up: $file"
        done
    fi
}

create_backup