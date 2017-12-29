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

echo "GENERATE  ACCOUNT TRIAL ........"

echo ""

read -p "Berapa hari account trial aktif: " AKTIF

	uname=trial-`</dev/urandom tr -dc 0-9 | head -c1`
	masaaktif="$AKTIF"
	pass=`</dev/urandom tr -dc 0-9 | head -c4`
	clear

clear
echo -e ""| lolcat
echo -e ""| lolcat
echo -e ""| lolcat
echo -e ""| lolcat
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $uname
exp="$(chage -l $uname | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$pass\n$pass\n"|passwd $uname &> /dev/null
echo -e ""| lolcat
echo -e "|      Informasi Akun Baru SSH      |" | boxes -d dog | lolcat
echo -e "===========-[[SERVER-PREMIUM]]-============" | lolcat
echo -e "     Host: $MYIP" | lolcat
echo -e "     Username: $uname" | lolcat
echo -e "     Password: $pass                       " | lolcat
echo -e "     Port default dropbear: 443,80         " | lolcat
echo -e "     Port default openSSH : 22,143         " | lolcat
echo -e "     Port default squid   : 8080,3128      " | lolcat
echo -e "                                           " | lolcat
echo -e "     Auto kill user maximal login 2        " | lolcat
echo -e "-------------------------------------------" | lolcat
echo -e "     Aktif Sampai: $exp                    " | lolcat
echo -e "===========================================" | lolcat
echo -e "   WARNING BAN FOR:                              "| lolcat
echo -e "   HACKING-DDOS-PHISING-SPAM-TORENT        " | lolcat
echo -e "   CARDING-CRIMINAL CYBER.                 "| lolcat
echo -e "===========================================" | lolcat
echo -e "   Script by inject69               "| lolcat
echo -e "   Config OVPN:                            "| lolcat
echo -e "   http://$MYIP:81/client.tar        " | lolcat
echo -e "-------------------------------------------" | lolcat
echo -e ""
echo -e ""
