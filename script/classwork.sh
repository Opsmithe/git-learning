#!/bin/bash
set -ex

echo "creating a directory called classwork......."

mkdir classwork
sleep 3

touch ./classwork/file1
echo "this file is to be found in file3.." > ./classwork/file1
sleep 3

touch ./classwork/file2
touch ./classwork/file3

scp ./classwork/file1 ./classwork/file3

sleep 3 

cat ./classwork/file3

echo "this is the end of the script...."

