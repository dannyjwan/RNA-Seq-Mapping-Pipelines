#!/bin/bash

#SBATCH -p main
#SBATCH -c 12
#SBATCH -t 0-12:00
#SBATCH --mem=32G
#SBATCH -J HISAT2_align
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your@email.edu

# Load HISAT2
ml HISAT2

# Path to the HISAT2 genome index
INDEX_DIR="/location/of/hisat2_index/index"

# Path to RNA-seq samples directory containing fastq.gz files
RAW_DATA_DIR="/location/of/raw_data"

# Define the output directory for HISAT2 results
OUTPUT_DIR="/location/of/output/HISAT2"

# Create the output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Set the number of threads
THREADS=12

# This for loop will looop through all FASTQ files in the "RAW_DATA_DIR"
for fastq_file in $RAW_DATA_DIR/*.fastq.gz; do
    # Extract the sample name
    SAMPLE_NAME=$(basename $fastq_file .fastq.gz)

    # Run HISAT2 
    echo "Running HISAT2 for $SAMPLE_NAME"
    hisat2 -p $THREADS \
           -x $INDEX_DIR \
           -U $fastq_file \
           --rna-strandness R \
           -S "${OUTPUT_DIR}/${SAMPLE_NAME}.sam"
done

echo "HISAT2 alignment complete for all samples."

