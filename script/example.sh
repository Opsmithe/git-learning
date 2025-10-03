#!/bin/bash

echo "this is a conditional statement........."


touch kinwa.txt

echo "i am here" > ./kinwa.txt

FILE=kinwa.txt

if [ -f "$FILE" ]; then
   
   echo "the file '$FILE' exist"

else
   echo "the file '$FILE' does not exist"

fi