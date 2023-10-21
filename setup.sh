#!/bin/bash

# Function to create directories if they don't exist
create_directory_if_not_exists() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Read the configuration file line by line
while read -r source_path symlink_path; do
    # Create the destination directory if it doesn't exist
    destination_dir=$(dirname "$symlink_path")
    create_directory_if_not_exists "$destination_dir"

    # Check if the symlink already exists
    if [ -e "$symlink_path" ]; then
        echo "Config already exists at $symlink_path"
    else
        if [ -d "$source_path" ]; then
            # If source_path is a directory, symlink the contents to the destination directory
            ln -sT "$source_path" "$symlink_path"
            echo "Created symlink from $source_path to $symlink_path"
        else
            # If source_path is a file, symlink the file directly
            ln -s "$source_path" "$symlink_path"
            echo "Created symlink from $source_path to $symlink_path"
        fi
    fi
done < paths.txt
