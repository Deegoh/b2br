# Born2beroot

## Introduction
Ce document permet de realiser le projet Born2beroot.

## VirutalBox
VDI\
Dynamicallz allocated\
Select image

## Debian
Install\
English\
other\
Europe\
Switzerland\
United States\
American English\
Hostname:tpinto-m42\
Domain name:none\
Root pwd:....\
Full name:tpinto-m42\
Username:tpinto-m42\
user:pwd\
Partioning method: Manual\
Select disk (SCSI1)\
Create empty partition:YES\
Select avalible space\
Create a new partition:
- 500M primary - beginning - /boot
- Max logical - beginning - none(do not mount it)\

Configure encrypted volumes\
Yes\
Create encrypted volumes\
Select second disk(sda5)\
Done setting up the partition\
Finish encrypted\
Really erase the data on this partition - yes\
Encryption passphrase - add pwd\
Configure the Logical Volume Manager\
yes\
create volume group
- LVMGroup\

Select sda5_crypt\
create logical volume
- root 2G\
- swap 1024M\
- home 1G\
- var 1G\
- srv 1G\
- tmp 1G\
- var-log rest\

Finish\
Select 1# disk\
Use as ext4 journaling\
mount /home\
select 2#\
select 3#\
select swap\
Use as swap area\
...\
...\
select var log\
Use as /var/log\
finish partitioning and write\
write save\
no package\
no service\
install grub\

## Install Sudo
switch to root\
su -\
apt install sudo\
dpkg -l | grep sudo (check install)\

## Adding user to sudo Group
adduser <user> sudo\
getent group sudo (check sudo group)\
reboot\
sudo -v\

## Update and test root privilege
sudo apt update\

## Configure sudo
sudo vim /etc/sudoer/\
sudo mkdir /var/log/sudo\
add\
- Defaults passwd_tries=3\
- Defaults badpass_message="<custom-error-message>"\
- Defaults logfile="/var/log/sudo/sudo.log"\
- Defaults log_input, log_output\
- Defaults requiretty\

## Install SSH
sudo apt install openssh-server\
sudo vim /etc/ssh/sshd_config\
replace line 13 #Port 22\
replace line 32 #PermitRootLogin no\

## Install UFW
sudo apt install ufw\
sudo ufw enable\
sudo ufw status numbered\
sudo ufw allow ssh\
sudo ufw allow 4242\
sudo ufw status numbered\
sudo ufw delete (arg=numbered)\

## Configure VM
Add port forwarding 4242\

## Configure password policy
sudo apt install libpam-pwquality\
sudo vim /etc/pam.d/common-password\
replace password [succes=2 default=ignore] pam_unix.so obscure sha512\
replace password    requisite         pam_pwquality.so retry=3 lcredit=-1 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root\
minlen=10 - mini length 10\
ucredit=-1 - mini 1 uper char\
dcredit=-1 - mini 1 numeric char\
maxrepeat=3 - max 3 consecutive char
reject_username - no username\
difok=7\

sudo vim /etc/login.defs\
replace line #160 PASS_MAX_DAYS 99999 to 30\
replace line #161 PASS_MAX_DAYS 0 to 2\

## Create group
sudo groupadd user42\
getent group\
sudo adduser tpinto-m42 user42\
getent group user42\

## Change hostname
hostnamectl set-hostname tpinto-m42\

## Configure Cron
sudo crontab -e\
add \*/10 * * * * ./usr/local/bin/monitoring.sh\

# Bonus
## Install lighttpd
sudo apt install lighttpd\
sudo ufw allow 80\

## Install mariaDB
sudo apt install mariadb-server\
sudo mysql_secure_installation\

### Create DB
sudo mariadb\
CREATE DATABASE wp\
GRANT ALL ON wp.\* TO b2br@localhost IDENTIFIED BY '1234' WITH GRANT OPTION;\
FLUSH PRIVILEGES;\
SELECT User FROM mysql.user;\

## Install PHP
sudo apt install php-cgi php-mysql\

## Install wordpress
sudo wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz\
sudo tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html\
sudo rm /tmp/wordpress.tar.gz\

## COnfig db
do thinks\

## Config lighttpd
sudo lighty-enable-mod fastcgi; sudo lighty-enable-mod fastcgi-php; sudo service lighttpd force-reloadi\

## Install Cockpit-project
sudo apt install cockpit\
sudo systemctl enable --now cockpit.socket\
sudo /etc/pam.d/cockpit\
add auth requisite pam_succeed_if.so uid >= 1000\

## Aide memoire
groups\
getent\
hostnamectl\
hostnamectl set-hostname tpinto-m42\
sudo chage -l tpinto-m42\
lsblk\

