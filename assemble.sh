#!/bin/bash

#DE NOVO ASSEMBLY WITH SPADES

for F in trim_fastq/*_1.trim.fastq.gz; do   R=${F/_1/_2};   out=$(basename ${F%%_1.trim.fastq.gz});   output_dir="${out}_assemble";   echo spades.py --careful -o $output_dir -1 $F -2 $R; done



