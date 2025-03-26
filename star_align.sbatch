#!/bin/bash

#SBATCH -p main
#SBATCH -c 12
#SBATCH -t 0-48:00
#SBATCH --mem=32G
#SBATCH -J STAR_align
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your@email.edu

# Load the STAR module
module load gcc/10.3.0-pgarias STAR/2.7.5a

# Path to the STAR genome index
INDEX_DIR="/location/of/star_index"

# Path to RNA-seq samples directory containing fastq.gz files
RAW_DATA_DIR="/location/of/raw_data"

# Path to output directory for results
OUTPUT_DIR="/location/of/output/STAR"

# Create the output directory
mkdir -p $OUTPUT_DIR

# Set the number of threads
threads=12

# This for loop will looop through all FASTQ files in the "RAW_DATA_DIR"
for fastq_file in $RAW_DATA_DIR/*.fastq.gz; do
    # Extract the sample name
    SAMPLE_NAME=$(basename $fastq_file .fastq.gz)

    # Run STAR
    echo "Running STAR for $SAMPLE_NAME"
    STAR --runThreadN $THREADS \
         --genomeDir $INDEX_DIR \
		 --readFilesCommand zcat \
         --readFilesIn $fastq_file \
         --outFileNamePrefix "${OUTPUT_DIR}/${SAMPLE_NAME}" \
         --outSAMtype SAM
done

echo "STAR alignment complete for all samples."

