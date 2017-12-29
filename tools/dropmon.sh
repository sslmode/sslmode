#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

echo ""| lolcat
echo "|   Tgl-Jam    | PID   |   User Name  |      Dari IP      |"| boxes -d peek | lolcat
echo "-------------------------------------------------------------"| lolcat
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);

echo "=================[ Checking Dropbear login ]================="| lolcat
echo "-------------------------------------------------------------"| lolcat
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $12}'`;
	waktu=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk -F" " '{print $1,$2,$3}'`;
	if [ $NUM -eq 1 ]; then
		echo "$waktu - $PID - $USER - $IP"| lolcat;
	fi
done


echo "-------------------------------------------------------------"| lolcat
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

echo "==================[ Checking OpenSSH login ]================="| lolcat
echo "-------------------------------------------------------------"| lolcat
for PID in "${data[@]}"
do
        #echo "check $PID";
		NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
		USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
		IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
		waktu=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $1,$2,$3}'`;
        if [ $NUM -eq 1 ]; then
                echo "$waktu - $PID - $USER - $IP"| lolcat;
        fi
done

echo "-------------------------------------------------------------"| lolcat
echo -e "==============[ User Monitor Dropbear & OpenSSH]=============" | lolcat
PS3='Silahkan type nomor 1-3 lalu ENTER: '
options=("Kick User" "Kembali Ke MENU" "Keluar")
select opt in "${options[@]}"
do
    case $opt in
        "Kick User")
	read -p "Masukan angka (PID) user yang mau di Kick: " tendangan
	kill -9 $tendangan
	echo "Tunggu..." | lolcat
	sleep 3
	echo "Ok.. User Sudah Di Kick Boss.. !!" | lolcat
	break
	;;
	"Kembali Ke MENU")
	cd /root
	menu
	break
	;;
	"Keluar")
	exit
	break
	;;
	
*) echo invalid option;
	esac
done
