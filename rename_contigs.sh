#!/bin/bash


# Create the 'fasta' folder if it doesn't exist
mkdir -p fasta

# Iterate over all '*_assemble' folders
for folder in *_assemble; do 
new_name=${folder%%_assemble};if [ -e "$folder/contigs.fasta" ]; then
  # Check if 'contigs.fasta' exists in the folder
  if [ -e "$folder/contigs.fasta" ]; then
    # Rename 'contigs.fasta' to the folder name
    cp "$folder/contigs.fasta" "fasta/$new_name.fasta"
  fi
done
