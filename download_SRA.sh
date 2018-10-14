# 本文件用来下载SRA
# 用法： 把SRR id放在SRAList的括号里，在destDir里面指定下载到的目录，在ascpInfo里面指定aspera的文件位置和密钥位置
# 功效： 把SRA文件下载到指定的位置
# 注意： 该脚本会调用aspera来极速下载，如果不想要aspera下载，也可以把-t 和-a 参数给关掉，就会默认下载了。

SRAList=(
SRR522081 SRR522082 SRR522083 SRR522084 SRR522085 SRR522086
SRR522087 SRR522088
)

destDir="/data/hca/chensijie/SMART1"
ascpInfo="/var/lib/hcaadmin/.aspera/connect/bin/ascp|/var/lib/hcaadmin/.aspera/connect/etc/asperaweb_id_dsa.openssh"

for sra in ${SRAList[@]}
do
    prefetch -t ascp -a "${ascpInfo}"  -O ${destDir} ${sra}
done

