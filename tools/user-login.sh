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


data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "----------------------------------------------"
echo "Checking Dropbear login" | lolcat;
echo "----------------------------------------------"
echo "   PID.  USERNAME.       IP" | lolcat
echo "----------------------------------------------"

for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	username=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $username - $IP";
	fi
done

echo "";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
echo "----------------------------------------------"
echo "Checking OpenSSH login" | lolcat;
echo "----------------------------------------------"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
	username=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
	IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $username - $IP";
	fi
done

echo "";

echo "-----------------------------------"
echo "Checking OpenVPN login" | lolcat;
echo "-----------------------------------"
tail -f /etc/openvpn/server-vpn.log

echo "";

echo "----------------------------------------------"
echo "Checking PPTP login" | lolcat;
echo "----------------------------------------------"
last | grep ppp | grep still

echo "";

#History Login User
echo "----------------------------------------------"
echo "Checking PPTP Login History" | lolcat;
echo "----------------------------------------------"
last | grep ppp

echo "";
echo "----------------------------------------------------------------"
echo " Kalau ada Multi Login Kill Aja " | lolcat
echo " Tetap Multi Login Ganti Passnya baru Kill Lagi " | lolcat
echo " Caranya pake Kill nomor PID " | lolcat
echo "----------------------------------------------------------------"

	echo "          DEVELOPED BY Inject69 " | lolcat
echo "----------------------------------------------------------------"
echo ""


