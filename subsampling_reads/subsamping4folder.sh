# 本文件用来把一个目录下的所有文件夹里面的所有fastq文件降采样
# 用法： 把含有各个细胞文件的目录路径填到dirContainningCells变量里
# 功效： 遍历dirContainningCells里面所有子文件夹，把子文件夹下面的fastq文件降采样，生成降采样后的小文件，并删除原文件
# 注意： 注意文件末尾是不是fastq,如果是fq，再改一下代码中的fastq; 
#       中间过程中，新生成的降采样小文件以fastqsub结尾，删掉原文件后，会重命名成fastq


dirContainningCells="/data/hca/chensijie/SMART1/SmallFASTQfiles"


# 递归地遍历所有第一个参数传入的文件夹里的所有文件
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ];then 
            getdir $dir_or_file
        else
        	# 检查是否是fastq文件ge'w
            if [[ $dir_or_file =~ \.fastq$ ]];then
                printf "%s\n" "$dir_or_file"
            fi
        fi  
    done
}


fileArr=( `getdir $dirContainningCells` )  #  fileArr=$(getdir $dirContainningCells) 这么写就错了，没有形成数组

for originalFile in  ${fileArr[@]}
do
    #BASENAME=`basename $originalFile`
    #DIR=`dirname $originalFile`
	newFile=${originalFile}"sub"
	echo $newFile

	#神奇的降采样代码
    cat $originalFile | \
	awk '{ printf("%s",$0); n++; if(n%4==0) { printf("\n");} else { printf("\t");} }' | \
	awk -v k=10000 'BEGIN{srand(systime() + PROCINFO["pid"]);}{s=x++<k?x-1:int(rand()*x);if(s<k)R[s]=$0}END{for(i in R)print R[i]}' |\
	awk -F"\t" '{print $1"\n"$2"\n"$3"\n"$4 > "$newFile"}'
	
	rm $originalFile
	mv $newFile $originalFile
done

