#!/bin/bash

# Output CSV file
output_file="filtered_pcasys_out.csv"

# Write the header to the CSV file
echo "File,hyp" > "$output_file"

# Read through the file line by line
while IFS= read -r line; do
    # Extract the file name without the extension (remove everything after the dot)
    file_name=$(echo "$line" | awk -F ':' '{print $1}' | sed 's/\.wsq//')
    
    # Use grep and sed to extract the first letter after "hyp"
    letter=$(echo "$line" | grep -o 'hyp [A-Z]' | head -n 1 | sed 's/hyp //')
    
    # Check if both file name and letter were found and write them to the CSV file
    if [ -n "$file_name" ] && [ -n "$letter" ]; then
        echo "$file_name,$letter" >> "$output_file"
    fi
done < pcasys.out