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

    echo -e "\nChecking tracked files for recent commits..."

    # List of all files tracked by git
    git ls-files | while read -r file; do
        # Skip if it's not a regular file
        [ -f "$file" ] || continue

        # Get last commit time in epoch seconds
        commit_time=$(git log -1 --format="%ct" -- "$file")
        backup_file="$BACKUP_DIR/$file"

        # If no backup exists, create it
        if [ ! -f "$backup_file" ]; then
            cp --parents "$file" "$BACKUP_DIR/"
            echo "Backed up new file: $file"
        else
            # Get backup file's last modification time
            backup_time=$(stat -c %Y "$backup_file")

            # Compare times
            if [ "$commit_time" -gt "$backup_time" ]; then
                cp --parents "$file" "$BACKUP_DIR/"
                echo "Updated backup: $file"
            fi
        fi
    done
}

create_backup