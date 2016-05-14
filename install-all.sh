#!/bin/bash

for dir in `find -maxdepth 1 -type d -not -path . -not -path '*/\.*' -printf '%f\n'`
do
	cp ./$dir/run.sh ~/bin/$dir
	echo "Copied ./$dir/run.sh to ~/bin/$dir"
done
