#!/bin/bash

mkdir QC
fastqc fastq/. -o QC_RAW_READS
# fastq/.: all fastq files present in directory fastq
