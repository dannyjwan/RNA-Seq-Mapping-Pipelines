#!/bin/bash

#SBATCH -p main
#SBATCH -c 12
#SBATCH -t 0-12:00
#SBATCH --mem=32G
#SBATCH -J featureCounts_All
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your@email.edu

# Install subread package on conda or miniconda

# Load Miniconda module and activate the conda environment containing subread
ml miniconda
source /home/dannywan/miniconda3/etc/profile.d/conda.sh
conda activate rna_counts

# Reference annotation file
ANNOT_FILE="/location/of/reference/annotation/genome.gtf"

# Generate SAMPLE_NAME_counts.txt and SAMPLE_NAME_counts.txt.summary for each SAM file in ALIGN_DIR
run_featureCounts() {
    local ALIGN_DIR=$1
    local OUTPUT_DIR=$2
	local EXTRA_PARAMS=$3

    mkdir -p $OUTPUT_DIR

    for align_file in $ALIGN_DIR/*.sam; do
        SAMPLE_NAME=$(basename $align_file .sam)

        echo "Running featureCounts for $SAMPLE_NAME in $ALIGN_DIR"
        featureCounts -T 12 -s 2 -t exon -g gene_id --primary -M -a $ANNOT_FILE $EXTRA_PARAMS -o ${OUTPUT_DIR}/${SAMPLE_NAME}_counts.txt $align_file
    done
}

# Run featureCounts for HISAT2
run_featureCounts "/location/of/results/HISAT2" "/location/for/results/featureCounts_HISAT2"

# Run featureCounts for Bowtie2 (includes additional parameters)
run_featureCounts "/location/of/results/Bowtie2" "/location/for/results/featureCounts_Bowtie2" "-Q 10 -C"

# Run featureCounts for STAR
run_featureCounts "/location/of/results/STAR" "/location/for/results/featureCounts_STAR"

echo "featureCounts completed for all alignments."
