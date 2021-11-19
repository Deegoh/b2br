#!/bin/bash

archi=$(uname -a)
cpu=$(grep "physival id" /proc/cpuinfo | wc -l)
vcpu=$(grep "processor" /proc/cpuinfo | wc -l)
fram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
fdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lastboot=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvm=$(lsblk | grep "lvm" | wc -l | awk '{if($1){print "yes"}else{print "no"}}')
tcp=$(ss -s | awk '$1 == "TCP" {print $3}')
log=$(users | wc -l)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "
#Architecture: $archi
#CPU physical: $cpu
#vCPU: $vcpu
#Memory Usage: $uram/${fram}MB ($pram%)
#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)
#CPU load: $cpul
#Last boot: $lastboot
#LVM use: $lvm
#Connection TCP: $tcp ESTABLISHED
#User log: $log
#Network: IP $ip ($mac)
#Sudo: $sudo cmd"
