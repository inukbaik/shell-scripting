#!/bin/bash

# Check if both source and destination directories are provided
# if not, print "src and dest dirs missing" and exit with status 0
if [ $# -ne 2 ]
then
    echo "src and dest dirs missing"
    exit 0
fi

src_dir=$1
dest_dir=$2

# if src directory doesn't exist
if [ ! -d $src_dir ]
then
    echo "$src_dir not found"
    exit 0
fi

# Check if destination directory exists
# if not, it should be created.
if [ ! -d $dest_dir ]
then
    mkdir -p $dest_dir
fi


move_files() {
    local source_dir="$1"
    local destination_dir="$2"

    local files=("$source_dir"/*.c)
    local file_count=${#files[@]}

    # Check if the directory contains more than 3 C files
    if [ "$file_count" -gt 3 ]; then
        echo "List of files to move:"
        
        # Display the list of files to be moved
        for file in "${files[@]}"; do
            if [[ $file == *.c ]]; then
                echo "$file"
                # Prompt the user for confirmation
                read -p "Do you want to move these files? (Type y/Y for Yes): " user_response
                if [[ "$user_response" =~ ^[Yy]$ ]]; then
                relative_path="${file#$src_dir/}"
                dest_path="$destination_dir/$relative_path"
                mkdir -p "$(dirname "$dest_path")"
                mv "$file" "$dest_path"
                fi
            fi
        done
    else
        # Directory contains 3 or fewer C files, proceed with moving files without confirmation
        move_files_recursive "$source_dir" "$destination_dir"
    fi
}


# Helper function for recursive file and directory moving
move_files_recursive() {
    local source_dir="$1"
    local destination_dir="$2"

    for file in "$source_dir"/*; do
        if [ -f "$file" ] && [[ $file == *.c ]]; then
            # Extract relative path
            relative_path="${file#$src_dir/}"

            # Construct destination path
            dest_path="$destination_dir/$relative_path"

            # Create destination directory if it doesn't exist
            mkdir -p "$(dirname "$dest_path")"

            # Move the file
            mv "$file" "$dest_path"
        elif [ -d "$file" ]; then
            # Recursively call the function for subdirectories
            move_files "$file" "$destination_dir"
        fi
    done
}


# Call the function with the source and destination directories
move_files "$src_dir" "$dest_dir"



# Clean up temporary files
rm -f "$dest_dir"/*.tmp

