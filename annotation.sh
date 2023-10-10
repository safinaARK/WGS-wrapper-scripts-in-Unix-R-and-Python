#!/bin/bash
#Genome annotation using prokka

for F in *_assemble/contigs.fasta; 
do FOLDER=${F/_assemble*};FILE=${F##*/} ;PREFIX=${FILE/.fasta/};
prokka --locustag $FOLDER --outdir annotated_$FOLDER --prefix $FOLDER $F;done