#!/bin/sh

#help: ./findbackfile.sh [/dev/sda]

block=$1

echo "start"
# find all linux part, exclude extended
all_linux_partes=$(parted $block print | sed -e '/extended/d'| \
grep ext | awk '{print $1}')

# mount all linux part
for part in $all_linux_partes; do
	mount_point=$(mktemp -d)
	mount ${block}${part} $mount_point
	if [ ! -f ${mount_point}/etc/os-release ]; then
		for file in $(ls $mount_point/ghost-sda* 2>/dev/null); do
			echo ${file##/} ${block}${part}
		done
	fi
	umount $mount_point
done
echo "end"
