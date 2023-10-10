#!/bin/bash

mkdir gffs


prokka --locustag Ref --outdir annotated_Ref --prefix Paratyphi_C_ref Ref.fasta

cp annotated_*/*.gff gffs

