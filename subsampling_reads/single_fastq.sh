cat single.fastq | awk '{ printf("%s",$0); n++; if(n%4==0) {
printf("\n");} else { printf("\t");} }' |
awk -v k=10000 'BEGIN{srand(systime() + PROCINFO["pid"]);}{s=x++<k?x-
1:int(rand()*x);if(s<k)R[s]=$0}END{for(i in R)print R[i]}' |
awk -F"\t" '{print $1"\n"$2"\n"$3"\n"$4 > "single_sub.fastq"}'