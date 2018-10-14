# 本文件用来把目录下的所有sra文件解包成对应的fastq文件
# 用法： 直接把该文件放在含有sra文件们的目录底下，用shell执行该文件就好。
# 功效： 列举该目录下所有以sra为后缀的文件，把它们解包后的文件放在该文件命名的子文件夹里面
# 注意: single-end和paired-end的reads都适用

for sra in `ls *.sra`
do
    #echo $sra
    filename=$(echo ${sra} | sed 's/\.[^.]*$//');
    fastq-dump --split-3 \
               --defline-qual '+' \
               --defline-seq '@\$ac-\$si/\$ri' \
               ${sra} \
               -O "./${filename}/"
done
