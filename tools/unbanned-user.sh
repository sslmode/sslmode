#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com)


# go to root
cd

echo "         UNBANNED USER ACCOUNT           "
echo ""

cat /root/banneduser.txt
echo "---------------------------------------"
echo ""


read -p "Enter Username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Are You sure You Want to Unban This Account [$username] [y/n]: " -e -i y UNBANNED
	if [[ "$UNBANNED" = 'y' ]]; then
		sed -i "s/ User : $username//g" /root/banneduser.txt
		sed -i /^$/d /root/banneduser.txt
		passwd -u $username
		echo ""
		echo "Account [$username] successfull unbanned!"
	else
		echo ""
		echo "Unbanned account [$username] cancelled!"
	fi
else
	echo "Username [$username] Not available!"
	exit 1
fi
