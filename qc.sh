#!/bin/bash

mkdir QC_RAW_READS
fastqc fastq_ST/* -o QC_RAW_READS

