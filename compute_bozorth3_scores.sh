#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory_with_xyt_files> <output_csv_file>"
    exit 1
fi

# Input directory containing the .xyt files
INPUT_DIR=$1
OUTPUT_CSV=$2

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory '$INPUT_DIR' not found."
    exit 1
fi

# Get a list of all .xyt files in the directory
xyt_files=("$INPUT_DIR"/*.xyt)

# Check if there are any .xyt files
if [ ${#xyt_files[@]} -eq 0 ]; then
    echo "No .xyt files found in '$INPUT_DIR'."
    exit 1
fi

# Create or overwrite the CSV file and write the header
echo "File1,File2,Score" > "$OUTPUT_CSV"

# Perform all-vs-all Bozorth3 comparisons and save results to CSV
echo "Starting Bozorth3 comparisons..."
for ((i = 0; i < ${#xyt_files[@]}; i++)); do
    for ((j = i; j < ${#xyt_files[@]}; j++)); do
        file1="${xyt_files[$i]}"
        file2="${xyt_files[$j]}"
        
        # Get the base names for better readability in the output
        base_name1=$(basename "$file1" .xyt)
        base_name2=$(basename "$file2" .xyt)

        # Run Bozorth3 comparison
        echo "Comparing $base_name1 with $base_name2..."
        score=$(bozorth3 "$file1" "$file2")

        # Write the result to the CSV file
        echo "$base_name1,$base_name2,$score" >> "$OUTPUT_CSV"
    done
done

echo "Bozorth3 comparisons complete. Results saved to '$OUTPUT_CSV'."
