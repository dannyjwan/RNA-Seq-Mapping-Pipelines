#!/bin/bash

#SBATCH -p main
#SBATCH -c 12
#SBATCH -t 0-12:00
#SBATCH --mem=32G
#SBATCH -J Bowtie2_align
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your@email.edu

# Load Bowtie2
ml bowtie2/2.4.1

# Path to the Bowtie2 genome index
INDEX_DIR="/location/of/bowtie2/index"

# Path to RNA-seq samples directory containing fastq.gz files
RAW_DATA_DIR="/location/of/raw_data"

# Path to output directory for results
OUTPUT_DIR="/location/for/output/bowtie2"

mkdir -p $OUTPUT_DIR

for fastq_file in $RAW_DATA_DIR/*.fastq.gz; do
	# Extract the sample name
    SAMPLE_NAME=$(basename $fastq_file .fastq.gz)
    bowtie2 -x $INDEX_DIR/ctl2_index \
	-U $fastq_file -S $OUTPUT_DIR/${SAMPLE_NAME}.sam \
	--very-sensitive-local \
	-N 1 \
	-p 12
done


