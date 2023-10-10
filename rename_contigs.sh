#!/bin/bash
#make new directory and transfer all contigs file into it with new name 

mkdir fasta
for f in *_assemble;do  
cp "$f/contigs.fasta" fasta/"$(basename "$f" '_assemble').fasta ";done
