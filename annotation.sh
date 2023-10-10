#!/bin/bash
#Genome annotation using prokka

for F in fasta/*.fasta; do FILE=${F##*/}; PREFIX=${FILE/.fasta/}; 
prokka --locustag $PREFIX --outdir annotated_$PREFIX --prefix $PREFIX $F; done