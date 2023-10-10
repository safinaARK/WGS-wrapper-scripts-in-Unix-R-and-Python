
mkdir fasta
for f in *_assemble;do  
cp "$f/contigs.fasta" fasta/"$(basename "$f" '_assemble').fasta ";done