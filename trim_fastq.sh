	##!/bin/bash

#trim nanopore reads using porechop
#porechop -i data/P7741_minion.fastq -o trimmed_reads/P7741_minion.fastq --format fastq -t 4


mkdir trim_fastq
#input directory fastq
# output directory trim_fastq
for F in fastq/*_1.fastq.gz;  do R=${F/_1/_2}; 
out=$(basename ${F/_1.fastq.gz});echo sickle pe -g -f $F -r $R -t sanger
 -o trim_fastq/$(basename ${F%.fastq.gz}.trim.fastq.gz)
 -p trim_fastq/$(basename ${R%.fastq.gz}.trim.fastq.gz) -q 20 -l 20; done