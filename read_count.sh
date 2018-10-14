# source: https://www.biostars.org/p/139006/

# for fasta file
grep -c "^>" file.fasta

# for fastq file
awk '{s++}END{print s/4}' file.fastq