#!/bin/sh

#help: ./findblockdisk.sh

# find all block devices
all_block_diskes=$(fdisk -l -o device | grep '^/dev' | sed -e 's/\/dev\///g' | \
sed -e 's/[0-9]//g' | uniq)

echo "start"
for disk in $all_block_diskes; do
	echo /dev/$disk
done
echo "end"
