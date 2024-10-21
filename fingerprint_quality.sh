#!/bin/bash

# Directory containing your fingerprint images
image_dir="dataset/"

# Output CSV file
output_file="nfiq_scores.csv"

# Create or overwrite the CSV file, and add the header
echo "File,NFIQ_Score" > "$output_file"

# Loop through all PNG images in the directory
for img_file in "$image_dir"/*.png; do
    # Extract the base filename (without the path)
    base_file=$(basename "$img_file" .png)
    
    # Run nfiq on the image and capture the output
    nfiq_score=$(nfiq "$img_file" | head -n 1)
    
    # Append the result to the CSV file
    echo "$base_file,$nfiq_score" >> "$output_file"
done

echo "NFIQ scores saved to $output_file"
