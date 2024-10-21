#!/bin/bash

# Input dataset directory and output directory
DATASET_FOLDER="dataset"
OUTPUT_DIR="out"

# Check if input directory exists
if [ ! -d "$DATASET_FOLDER" ]; then
    echo "Error: Input dataset directory '$INPUT_DIR' not found."
    exit 1
fi

# Create output directory if it doesn't exist
if [ ! -d "$DATASET_FOLDER/$OUTPUT_DIR" ]; then
    echo "Output directory '$DATASET_FOLDER/$OUTPUT_DIR' not found. Creating..."
    mkdir -p "$DATASET_FOLDER/$OUTPUT_DIR"
fi

# Loop through all images in the input directory
for img in "$DATASET_FOLDER"/*.png; do
    # Check if there are any .png files
    if [ ! -f "$img" ]; then
        echo "No .png files found in '$DATASET_FOLDER'."
        exit 1
    fi

    # Get the base name of the image (without directory and extension)
    base_name=$(basename "$img" .png)

    # Run mindtct on each image and save the results in the output directory
    echo "Processing $img..."
    mindtct "$img" "$DATASET_FOLDER/$OUTPUT_DIR/$base_name"

    # Check if mindtct ran successfully
    if [ $? -eq 0 ]; then
        echo "Minutiae points for '$img' extracted successfully."
    else
        echo "Error: mindtct failed for '$img'."
    fi
done

echo "Processing complete. Results are saved in '$DATASET_FOLDER/$OUTPUT_DIR'."
