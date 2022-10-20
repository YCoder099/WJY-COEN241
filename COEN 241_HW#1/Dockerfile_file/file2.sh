#!/bin/bash
echo "FileIO 2, Threads=16, size=4G"
for i in 1 2 3 4 5
do
	echo "****** No. "$i
	sysbench --num-threads=16 --test=fileio --file-total-size=4G --file-test-mode=rndrw prepare
	sysbench --num-threads=16 --test=fileio --file-total-size=4G --file-test-mode=rndrw run
	sysbench --num-threads=16 --test=fileio --file-total-size=4G --file-test-mode=rndrw cleanup
done
