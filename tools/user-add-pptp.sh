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


echo "-------------- CREATE ACCOUNT PPTP VPN -----------------" | lolcat

echo ""

read -p "Create Username: " username
read -p "Create Password For [$username]: " password

echo "$username pptpd $password *" >> /etc/ppp/chap-secrets

echo ""
echo "-----------------------------------"
echo "INFO ACCOUNT PPTP VPN:" | boxes -d peek | lolcat
echo "-----------------------------------"
echo "Host/IP: $MYIP" | lolcat
echo "Username: $username" | lolcat
echo "Password: $password" | lolcat
echo "-----------------------------------"
