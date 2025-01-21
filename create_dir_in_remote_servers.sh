#!/bin/bash

cat servers | while read line
do
        echo
        echo "Logging to $line"
        expect create_directory.expect $line

done

echo
echo "Directories are created successfully"

cd ..