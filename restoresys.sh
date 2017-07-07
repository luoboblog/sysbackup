#!/bin/sh

# help: ./restoresys.sh [backup_part] [back_file] [restore_part] [logfile]

export LC_ALL=zh_CN.UTF-8

backup_part=$1
backup_file=$2
restore_part=$3
logfile=$4

backup_mountpoint=$(mktemp -d)
mount $backup_part $backup_mountpoint

restore_mountpoint=$(mktemp -d)
mount $restore_part $restore_mountpoint

cd $restore_mountpoint && cat ${backup_mountpoint}/${backup_file} | cpio \
--quiet -V -idm 2> $logfile

cd
sync

umount $backup_mountpoint
umount $restore_mountpoint
