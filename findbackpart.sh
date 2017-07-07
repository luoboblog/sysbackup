#!/bin/sh

#help: ./findbackpart.sh [/dev/sda]

block=$1

echo "start"
# find all linux part, exclude extended
all_linux_partes=$(parted $block print | sed -e '/extended/d'| \
grep ext | awk '{print $1}')

# mount all linux part
for part in $all_linux_partes; do
	mount_point=$(mktemp -d)
	mount ${block}${part} $mount_point
	[ -f ${mount_point}/etc/os-release ] || echo ${block}${part} $(parted \
$block print | grep '^ '${part} | awk '{print \
$4 "\t" $6}')
	umount $mount_point
done
echo "end"
