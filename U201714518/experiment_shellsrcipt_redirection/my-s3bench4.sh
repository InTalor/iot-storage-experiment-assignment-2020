#!/bin/bash
#test shell-script 4 for NumClient=1 NumSample=[5,1280] ObjectSize=1KB

# Locate s3bench

s3bench=~/go/bin/s3bench

if [ -n "$GOPATH" ]; then
    s3bench=$GOPATH/bin/s3bench
fi

# minio on port 9000
# mock-s3 on port 9000
endpoint="http://127.0.0.1:9000"
# endpoint="http://127.0.0.1:9000"
bucket="loadgen"
ObjectNamePrefix="loadgen"
AccessKey="hust"
AccessSecret="hust_obs"
filepath="minio_server_4.txt"
# filepath="mock_s3_server_4.txt"

declare  -a  NumClient
declare  -a  NumSample
declare  -a  ObjectSize

NumClient=( 1    1    1    1    1    1    1    1    1)
NumSample=( 5    10   20   40   80   160  320  640  1280)
ObjectSize=(1024 1024 1024 1024 1024 1024 1024 1024 1024)

#display run progress
progress=8

for(( i=0;i<${#NumClient[@]};i++)) 
do  
    # run sh
    $s3bench -accessKey=$AccessKey -accessSecret=$AccessSecret -bucket=$bucket -endpoint=$endpoint \
    -numClients=${NumClient[i]} -numSamples=${NumSample[i]} -objectNamePrefix=$ObjectNamePrefix -objectSize=${ObjectSize[i]} >> $filepath

    echo -e "=========================================================> $i/$progress done\n" >> $filepath
    echo -e "=========================================================> $i/$progress done\n"
done
