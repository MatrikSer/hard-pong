#!/bin/bash

# JackCompiler.sh
# Equivalent Bash script for JackCompiler.bat

INPUT_DIR="../src"
OUTPUT_DIR="../game"

# Usage message
if [[ $# -gt 1 ]]; then
    echo "Usage:"
    echo "    ./build.sh              compiles all .jack files in the Source directory."
    exit 1
fi

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Remove previous .vm files from the output directory
echo "Cleaning up old .vm files in \"$OUTPUT_DIR\"..."
rm -f "$OUTPUT_DIR"/*.vm

echo "Compiling \"$INPUT_DIR\""

java -classpath "$CLASSPATH:bin/classes:bin/lib/Hack.jar:bin/lib/Compilers.jar" \
  Hack.Compiler.JackCompiler "$INPUT_DIR"

# Move compiled .vm files to output directory
mv "$INPUT_DIR"/*.vm "$OUTPUT_DIR" 2>/dev/null

# Check if move was successful
if [[ $? -ne 0 ]]; then
    echo "Error moving files. Check paths."
else
    echo "Files have been successfully saved to $OUTPUT_DIR."
fi