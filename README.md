sysbackup-lite
==============

- 发现可用磁盘

  #./findblockdisk.sh

  start
  /dev/sda
  end

- 发现备份分区

  #./findbackpart.sh /dev/sda

  start
  /dev/sda1
  /dev/sda2
  end

- 发现备份的文件

  #./findbackfile.sh /dev/sda
  start
  ghost-sda3-20170330160124-233047 /dev/sda5
  end

- 备份系统

  #./backupsys.sh /dev/sda3 /dev/sda5 /tmp/progress.log

- 恢复系统(文件数为ghost-sda3-20170330160124-233047的末尾的数)

  #./restoresys.sh /dev/sda5 ghost-sda3-20170330160124-233047 /dev/sda5 /tmp/progress.log

> 加入start、end标志是因为挂载磁盘等需要时间，便于等判断执行到什么程度了
