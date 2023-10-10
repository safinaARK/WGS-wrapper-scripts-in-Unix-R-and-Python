#!/bin/bash


mkdir tmp_fastas
cp Ref.fasta tmp_fastas
cp fasta/*.fasta tmp_fastas/
mkdir dendogram
dRep compare dendogram -g tmp_fastas/*.fasta
rm -fr tmp_fastas

echo "dendogram generated"
echo "output: ./dendogram"
