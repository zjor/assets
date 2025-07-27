#!/bin/bash

# Script to create a 760x760 round avatar with transparent background
# Usage: ./make-round-avatar.sh input.png [output.png]

# Check if filename argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_image> [output_image]"
    echo "Example: $0 sergey.png sergey_round.png"
    exit 1
fi

INPUT_FILE="$1"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found!"
    exit 1
fi

# Set output filename
if [ $# -eq 2 ]; then
    OUTPUT_FILE="$2"
else
    # If no output specified, add '_round' before extension
    FILENAME=$(basename "$INPUT_FILE")
    EXTENSION="${FILENAME##*.}"
    NAME="${FILENAME%.*}"
    OUTPUT_FILE="${NAME}_round.${EXTENSION}"
fi

echo "Creating round avatar from '$INPUT_FILE' -> '$OUTPUT_FILE'"

# Create the round avatar
convert "$INPUT_FILE" \
  -resize 760x760^ \
  -gravity center \
  -extent 760x760 \
  \( -size 760x760 xc:none -fill white -draw "circle 380,380 380,0" \) \
  -compose dstin -composite \
  "$OUTPUT_FILE"

# Check if conversion was successful
if [ $? -eq 0 ]; then
    echo "✅ Round avatar created successfully: $OUTPUT_FILE"
    echo "📐 Size: 760x760 pixels with transparent background"
else
    echo "❌ Error creating round avatar"
    exit 1
fi