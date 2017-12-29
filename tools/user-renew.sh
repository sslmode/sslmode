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

echo "----------------- RENEW ACCOUNT PREMIUM --------------------"

	echo "                       DEVELOPED BY Inject69           "
echo ""

# begin of user-list
echo "-----------------------------------"
echo "USERNAME              EXP DATE     " | lolcat
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------"
echo ""
# end of user-list

read -p "Enter Username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	#read -p "Input password account [$username]: " password
	read -p "Berapa Hari Nak Renew Acc [$username] : " AKTIF
	
	expiredate=$(chage -l $username | grep "Account expires" | awk -F": " '{print $2}')
	today=$(date -d "$expiredate" +"%Y-%m-%d")
	expire=$(date -d "$today + $AKTIF days" +"%Y-%m-%d")
	chage -E "$expire" $username
	passwd -u $username
	#useradd -M -N -s /bin/false -e $expire $username
clear
	
echo -e ""| lolcat
echo -e "|       INFO NEW ACCOUNT      |" | boxes -d dog | lolcat
echo -e "===========[[-SERVER PREMIUM-]]============" | lolcat
echo -e "     Host: $MYIP" | lolcat
echo -e "     Username: $username" | lolcat
echo -e "                                           " | lolcat
echo -e "     Port default dropbear: 443,80         " | lolcat
echo -e "     Port default openSSH : 22,143         " | lolcat
echo -e "     Port default squid   : 8080,3128      " | lolcat
echo -e "                                           " | lolcat
echo -e "     Auto kill user maximal login 2        " | lolcat
echo -e "-------------------------------------------" | lolcat
echo -e "     Expired Date : $(date -d "$AKTIF days" +"%d-%m-%Y")" | lolcat
echo -e "===========================================" | lolcat
echo -e "   WARNING BAN FOR:                              "| lolcat
echo -e "   HACKING-DDOS-PHISING-SPAM-TORENT        " | lolcat
echo -e "   CARDING-CRIMINAL CYBER.                 "| lolcat
echo -e "===========================================" | lolcat
echo -e "   Script by inject69              "| lolcat
echo -e "   Config OVPN:                            "| lolcat
echo -e "   http://$MYIP:81/client.tar        " | lolcat
echo -e "-------------------------------------------" | lolcat
echo -e ""
echo -e ""
else
	echo "Username [$username] Not Registered!"
	exit 1
fi
