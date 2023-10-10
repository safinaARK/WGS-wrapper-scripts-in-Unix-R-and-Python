#!/bin/bash

mkdir QC
fastqc fastq/. -o QC_Fastq
# folder(fastq) all fastq files present in directory fastq
##RUN MULTIQC ON QC_Fastq
multiqc QC_Fastq