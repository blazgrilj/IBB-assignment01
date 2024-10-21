#!/bin/bash

folder_name="./dataset/"

# Convert all .tif files in the specified folder to .png
for img in ${folder_name}*.tif; do
    # Check if there are any .tif files
    if [ ! -f "$img" ]; then
        echo "No .tif files found in the ${folder_name} directory."
        exit
    fi

    # Extract the base name without the extension
    base_name="${img%.tif}"
    # Convert the image using ImageMagick
    magick "$img" "${base_name}.png"

    echo "Converted $img to ${base_name}.png"
done
