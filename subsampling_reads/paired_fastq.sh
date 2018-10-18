paste forward.fastq reverse.fastq | \
awk '{ printf("%s",$0); n++;if(n%4==0) { printf("\n");} else { printf("\t");} }' | \
awk -v k=300000 'BEGIN{srand(systime() + PROCINFO["pid"]);}{s=x++<k?x-1:int(rand()*x);if(s<k)R[s]=$0}END{for(i in R)print R[i]}' | \
awk -F"\t" '{print $1"\n"$3"\n"$5"\n"$7 > '    "\"forward_sub.fastq\""    ';print $2"\n"$4"\n"$6"\n"$8 >'    "\"reverse_sub.fastq\"}"