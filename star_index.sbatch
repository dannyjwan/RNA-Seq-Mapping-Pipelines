#!/bin/bash

#BATCH -p main
#SBATCH -t 0-2:00
#SBATCH -n 4
#SBATCH --mem 12G
#SBATCH --job-name STAR_index
#SBATCH --mail-type=ALL
#SBATCH --mail-user=your@email.edu
 

ml gcc/10.3.0-pgarias STAR/2.7.5a

STAR --runThreadN 4 \
--runMode genomeGenerate \
--genomeDir /index/output/location/star_index \
--genomeFastaFiles /location/of/reference/genome/file.fasta \
--sjdbGTFfile /location/of/reference/annotation/file.gff3 \
--genomeSAindexNbases 8 \
--sjdbOverhang 99
