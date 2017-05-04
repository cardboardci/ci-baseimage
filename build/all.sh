#!/bin/sh
set -e

CURRENT=$(pwd)

cd ../src/
for filename in Dockerfile.*
do
    extension="${filename#*.}"
	echo "Building: $filename"
    
    cd $CURRENT
    make VERSION=${extension} build
done