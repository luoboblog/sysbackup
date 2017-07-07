#!/bin/sh

# help: ./backupsys.sh  [sys_part] [backup_part] [logfile]

sys_part=$1
backup_part=$2
logfile=$3

# mount sys part
sys_mountpoint=$(mktemp -d)
mount $sys_part $sys_mountpoint

# mount backup part
backup_mountpoint=$(mktemp -d)
mount $backup_part $backup_mountpoint

file_number=$(cd $sys_mountpoint && find | wc -l)
cd $sys_mountpoint && find | cpio -H newc -V --quiet -o > \
$backup_mountpoint/ghost-${sys_part##/dev/}-$(date "+%Y%m%d%H%M%S")-${file_number} 2> \
$logfile

cd
sync

umount $sys_mountpoint
umount $backup_mountpoint
