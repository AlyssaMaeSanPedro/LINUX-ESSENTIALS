#!/bin/bash
create_backup() {
    BACKUP_DIR="backup"
    echo "Checking for backup folder..."

    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir "$BACKUP_DIR"
        echo "Backup folder created at: $(pwd)/$BACKUP_DIR"
    else
        echo "Backup folder already exists at: $(pwd)/$BACKUP_DIR"
    fi

    echo -e "\nChecking tracked files for recent commits..."
    changes_made=false
    for file in $(git ls-files); do
        if [[ "$file" == "$BACKUP_DIR"* ]]; then
            continue
        fi

        [ -f "$file" ] || continue

        commit_time=$(git log -1 --format="%ct" -- "$file")
        backup_file="$BACKUP_DIR/$file"

        if [ ! -f "$backup_file" ]; then
            mkdir -p "$(dirname "$backup_file")"
            cp "$file" "$backup_file"
            echo "Backed up new file: $file"
            changes_made=true
        else
            backup_time=$(stat -c %Y "$backup_file")

            if [ "$commit_time" -gt "$backup_time" ]; then
                cp "$file" "$backup_file"
                echo "Updated backup: $file"
                changes_made=true
            fi
        fi
    done

    if ! $changes_made; then
        echo "No recent file changes."
    fi
}

create_backup