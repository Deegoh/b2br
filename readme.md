# Born2beroot

## Introduction
Ce document permet de realiser le projet Born2beroot.

## VirutalBox
VDI

Dynamicallz allocated

Select image

## Debian
Install
English
other
Europe
Switzerland
United States
Hostname:debian
Domain name:none
Root pwd:....
Full name:tpinto-m42
Username:tpinto-m42
time zone:
Partioning method: Manual
Select disk (SCSI1)
Create empty partition:YES
Select avalible space
Create a new partition:
- 500M primary - beginning - /boot
- Max logical - beginning - none
Config encrypted volumes
Yes
Create encrypted
Select second disk
finish encrypted
erase data
add pwd
config tje logical volume manager
yes
create volume group
- LVMGroup
Select sda5_crypt
create logical volume
- root 2G
- swap 1024M
- home 1G
- var 1G
- srv 1G
- tmp 1G
- var-log rest
Finish
Select 1# disk
Use as ext4 journaling
mount /home
select 2#
select 3#
select swap
Use as swap area
...
...
select var log
Use as /var/log
finish partitioning and write
write save
no package
no service
install grub
