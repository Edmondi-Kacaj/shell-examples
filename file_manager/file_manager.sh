#!/bin/bash

# Uncomment to enable debugging mode
# set -x

# Variables
LOG_FILE="file_manager.log"
ARCHIVE_FILE="archive.tar.gz"

# Trap to clean up and handle exits
trap cleanup EXIT
trap 'echo "Operation interrupted"; exit 1' INT

# Functions

# Log a message with timestamp
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

# Cleanup function
cleanup() {
    log_message "Cleaning up temporary files and resources..."
    rm -f "$TARGET_DIR/$ARCHIVE_FILE"
    log_message "Exiting script."
}

# Organize files by extension dynamically (copy instead of move)
organize_files() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <directory_path>"
        exit 1
    fi

    TARGET_DIR="$1"

    # Verify the target directory exists
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Error: Directory '$TARGET_DIR' does not exist."
        exit 1
    fi

    # Create a base directory for organized files
    ORGANIZED_DIR="$TARGET_DIR/organized"
    mkdir -p "$ORGANIZED_DIR"

    # Iterate over files in the target directory (not including subdirectories)
    for file in "$TARGET_DIR"/*; do
        if [ -f "$file" ]; then
            # Extract file extension
            ext="${file##*.}"

            # Handle files without an extension
            if [ "$file" == "$ext" ]; then
                ext="no_extension"
            fi

            # Create a directory for the extension and copy the file
            mkdir -p "$ORGANIZED_DIR/$ext"
            cp "$file" "$ORGANIZED_DIR/$ext/"
        fi
    done

    log_message "Files organized into '$ORGANIZED_DIR'."
}

# View organized files
view_files() {
    if [ ! -d "$ORGANIZED_DIR" ]; then
        log_message "No organized files found in '$ORGANIZED_DIR'."
        return
    fi
    log_message "Displaying organized files in '$ORGANIZED_DIR':"
    find "$ORGANIZED_DIR" -type f
}

# Delete organized files
delete_files() {
    if [ ! -d "$ORGANIZED_DIR" ]; then
        log_message "No organized files to delete in '$ORGANIZED_DIR'."
        return
    fi
    read -r -p "Are you sure you want to delete the entire '$ORGANIZED_DIR' folder? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        rm -rf "$ORGANIZED_DIR"
        log_message "Deleted the folder '$ORGANIZED_DIR'."
    else
        log_message "Deletion canceled."
    fi
}

# Archive organized files
archive_files() {
    if [ ! -d "$ORGANIZED_DIR" ]; then
        log_message "No organized files to archive in '$ORGANIZED_DIR'."
        return
    fi
    tar -czf "$TARGET_DIR/$ARCHIVE_FILE" -C "$ORGANIZED_DIR" .
    log_message "Archived files into '$TARGET_DIR/$ARCHIVE_FILE'."
}

# Clean the archive
clean_archive() {
    if [ -f "$TARGET_DIR/$ARCHIVE_FILE" ]; then
        rm -f "$TARGET_DIR/$ARCHIVE_FILE"
        log_message "Removed the archive file '$TARGET_DIR/$ARCHIVE_FILE'."
    else
        log_message "No archive file to clean."
    fi
}

# Menu system
menu() {
    while true; do
        echo
        echo "File Management Utility"
        echo "-----------------------"
        echo "1. Organize files"
        echo "2. View organized files"
        echo "3. Delete organized files"
        echo "4. Archive organized files"
        echo "5. Clean archive"
        echo "6. Exit"
        read -r -p "Choose an option: " choice

        case $choice in
            1) organize_files "$TARGET_DIR" ;;
            2) view_files ;;
            3) delete_files ;;
            4) archive_files ;;
            5) clean_archive ;;
            6) break ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Main Script Execution
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

TARGET_DIR="$(realpath "$1")"
ORGANIZED_DIR="$TARGET_DIR/organized"
log_message "Starting File Management Utility for directory: $TARGET_DIR..."
menu
