#!/bin/bash

#BATCH -p main
#SBATCH -t 0-2:00
#SBATCH -n 4
#SBATCH --mem 12G
#SBATCH --job-name Bowtie2_index
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your@email.edu
 
ml Bowtie2

OUTPUT_DIR="/location/of/output"

bowtie2-build genome.fasta $OUTPUT_DIR/genome