#!/bin/bash

mkdir QC
fastqc fastq/. -o QC_Fastq
# fastq/.: all fastq files present in directory fastq
