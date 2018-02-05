#!/bin/bash
clear

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;

flag=0

echo

	#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
	#if [ "$MYIP" = "" ]; then
		#MYIP=$(wget -qO- ipv4.icanhazip.com)
	#fi
lolcat -F 0.3 -S 0 /usr/bin/bannermenu
echo "                       Server: $MYIP" | lolcat
date +"                        %A, %d-%m-%Y" | lolcat
date +"                           %H:%M:%S %Z" | lolcat
echo -e "\e[40;38;5;101m                           SIMPLE MENU
";PS3='Select an option [1-39] Then Press ENTER: '
options=("Create User" "Create Account Trial" "Renew User" "Change Password User Premium" "All User" "Delete User" "Create User PPTP VPN" "Monitor Multi Login" "Online User" "User Active List" "User Expired" "Banned User" "Unbanned User" "Delete User Expired" "Status Ram" "Speedtest" "Benchmark" "Manual Kill Multi Login" "(ON) Auto Kill Multi Login" "(OFF) Auto Kill Multi Login" "Change Password VPS" "Clear Cache Ram" "Restart Webmin" "Restart Server VPS" "Restart Dropbear" "Install OpenVpn"  "Restart OpenSSH" "Restart Squid3" "Restart OpenVPN" "Change Port OpenSSH" "Change Port Dropbear" "Change Port Squid3" "Change Port OpenVPN" "Download Client Ovpn" "Install Ocs_Panel" "Edit Banner SSH" "Edit Banner Menu" "Change Password VPS" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Create User")
	clear
        user-add
        break
            ;;
	"Create Account Trial")
	clear
	user-gen
	break
	;;
	"Renew User")
	clear
	user-renew
	break
	;;
	"Change Password User Premium")
	clear
	user-pass
	break
	;;
	"All User")
	clear
	user-list | lolcat
	break
	;;
	"Delete User")
	clear
	user-del
	break
	;;
	"Create User PPTP VPN")
	clear
	user-add-pptp
	break
	;;
	"Monitor Multi Login")
	clear
	dropmon
	break
	;;
	"Online User")
	clear
	user-login
	break
	;;
	"Manual Kill Multi Login")
	clear
        read -p "Isikan Maximal User Login (1-2): " MULTILOGIN
        userlimit.sh $MULTILOGIN
	userlimitssh.sh $MULTILOGIN
	break
	;;
	"(ON) Auto Kill Multi Login")
	clear 
	read -p "please fill in maximal user login (1-2): " MULTILOGIN2
	#echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimitreboot
	service cron stop
	echo "* * * * * root /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit1
	   echo "* * * * * root sleep 10; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit2
           echo "* * * * * root sleep 20; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit3
           echo "* * * * * root sleep 30; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit4
           echo "* * * * * root sleep 40; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit5
           echo "* * * * * root sleep 50; /usr/bin/userlimit.sh $MULTILOGIN2" > /etc/cron.d/userlimit6
	   #:echo "@reboot root /root/userlimitssh.sh" >> /etc/cron.d/userlimitreboot
	   echo "* * * * * root /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit1
	   echo "* * * * * root sleep 11; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit2
           echo "* * * * * root sleep 21; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit3
           echo "* * * * * root sleep 31; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit4
           echo "* * * * * root sleep 41; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit5
           echo "* * * * * root sleep 51; /usr/bin/userlimitssh.sh $MULTILOGIN2" >> /etc/cron.d/userlimit6
	    service cron start
	    service cron restart
	    service ssh restart
	    service dropbear restart
	    echo "------------+ AUTO KILL SUDAH DI AKTIFKAN BOSS +--------------" | lolcat
	    
	echo "Dasar Kedekut!!! Kalau User Marah Marah Jangan Salah Kan Saya Ya Bos¡¡¡
nanti jangan lupa di off boss
biar user senang boleh multilogin lagi.." | boxes -d boy | lolcat
	break
	;;
	"(OFF) Auto Kill Multi Login")
	clear
	service cron stop
	rm -rf /etc/cron.d/userlimit1
	rm -rf /etc/cron.d/userlimit2
	rm -rf /etc/cron.d/userlimit3
	rm -rf /etc/cron.d/userlimit4
	rm -rf /etc/cron.d/userlimit5
	rm -rf /etc/cron.d/userlimit6
	#rm -rf /etc/cron.d/userlimitreboot
	service cron start
	service cron restart
	    service ssh restart
	    service dropbear restart
	clear
	echo "AUTO KILL LOGIN,SUDAH SAYA OFF KAN BOS 
User Sudah Boleh Multi Login Lagi!!!" | boxes -d boy | lolcat
	break
	;;
	"Change Password VPS")
	clear
	read -p "Silahkan isi New Password untuk VPS anda: " pass	
        echo "root:$pass" | chpasswd
	echo "Success New Password Already Set...!!!"| boxes -d boy | lolcat
	break
	;;
	"Clear Cache Ram")
	clear
	echo "---------------------------------------------"
	echo "Before..." | lolcat
	echo "---------------------------------------------"
       free -h
	echo 1 > /proc/sys/vm/drop_caches
	sleep 1
	echo 2 > /proc/sys/vm/drop_caches
	sleep 1
	echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
	sleep 1
	echo "---------------------------------------------"
	echo "After..." | lolcat
	echo "---------------------------------------------"
	free -h
	echo "---------------------------------------------"
	echo "Success..!!!Cache ram anda sudah di bersihkan." | boxes -d boy | lolcat
        echo ""
	break
	;;
	"User Active List")
	clear
	user-active-list | boxes -d dog | lolcat
	break
	;;
	"User Expired")
	clear
	user-expire-list | lolcat
	break
	;;
	"Disable User Expired")
	clear
	disable-user-expire
	break
	;;
	"Delete User Expired")
	clear
	delete-user-expire
	break
	;;
	"Banned User")
	clear
	banned-user
	break
	;;
	"Unbanned User")
	clear
	unbanned-user
	break
	;;
	"Status Ram")
	clear
	ps-mem | boxes -d dog | lolcat
	break
	;;
	"Speedtest")
	clear
	echo "SPEEDTEST SERVER" | boxes -d peek | lolcat
	echo "-----------------------------------------"
	speedtest --share | lolcat
	echo "-----------------------------------------"
	break
	;;
	"Benchmark")
	clear
	echo "BENCHMARK" | boxes -d peek | lolcat
	benchmark | lolcat
	break
	;;
	"See Location User")
	clear
	user-login
	echo "Contoh: 112.123.345.126 lalu Enter" | lolcat
        read -p "Taip Salah Satu Alamat IP User: " userip
        curl ipinfo.io/$userip
	echo "-----------------------------------" | lolcat
        break
	;;
	"Restart Webmin")
	clear
	 service webmin restart
	 echo "Webmin sudah di restart boss!!!" | boxes -d boy | lolcat
	 break
	 ;;
	 "Restart Server VPS")
	 clear
	 reboot
	 echo "Done Restart , Please Wait !!!" | boxes -d boy | lolcat
	 break
	 ;;
	 "Restart Dropbear")
	 clear
	 service dropbear restart
	 echo "Dropbear Done Restart!!!" | boxes -d boy | lolcat
	 break
	 ;;
	 "Restart OpenSSH")
	 clear
	 service ssh restart
	 echo "OpenSSH Done Restart!!!" | boxes -d boy | lolcat
	 break
	 ;;
	 "Restart OpenVPN")
	 clear
	 service openvpn restart
	 echo "openvpn Done Restart!!!" | boxes -d boy | lolcat
	 break
	 ;;
	 "Restart Squid3")
	 clear
	 service squid3 restart
	 echo "Squid3 Done Restart!!!" | boxes -d boy | lolcat
	 break
	 ;;
	 "Change Port OpenSSH")
	 clear
            echo "Sila Tukar port Openssh Anda , The Press enter."| boxes -d peek | lolcat
            echo "Port default dan Port 2 tidak boleh sama !!!"| lolcat
	    echo "Port default: 22"| lolcat
	    read -p "Port 2: " -e -i 143 PORT
	    service dropbear stop
	    service ssh stop
	    service openvpn stop
	    sed -i "6s/Port [0-9]*/Port $PORT/" /etc/ssh/sshd_config
           service ssh start 
	   service dropbear start
	   service openvpn start
            echo "Openssh Updated Port: $PORT"| lolcat
	 break
         ;;
	 "Change Port Dropbear")
	 clear
            echo "Sila Tukar port Dropbear anda Then Press ENTER!!!
Port dropbear tidak boleh sama dengan port openVPN/openSSH/squid3 !!!"| boxes -d peek | lolcat
           echo "Port1: 443 (Default)"
	    read -p "Port2: " -e -i 80 PORT
	    service dropbear stop
	    service ssh stop
	    service openvpn stop
            sed -i "s/DROPBEAR_PORT=[0-9]*/DROPBEAR_PORT=$PORT/g" /etc/default/dropbear
	    #sed -i 's/DROPBEAR_EXTRA_ARGS="-p [0-9]*"/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear	
            service dropbear start
	    service ssh start
	    service openvpn start
            echo "Dropbear Updated Port2 : $PORT"| lolcat
	    #echo "Dropbear Updated : Port2 $PORT2" | lolcat
	    #echo "Dropbear Updated : Port3 $PORT3" | lolcat
	 break
	 ;;
	 "Change Port Squid3")
	 clear
	 echo "Sila tukar  port Squid3 anda and Press Enter"| boxes -d dog | lolcat
	    echo "please Fill with Number Not Alphabet !!!"| lolcat
	    echo -e "Port Squid3 1: 8080"
	    read -p "Port Squid3 2: " -e -i 3128 PORT
            #sed -i 's/http_port [0-9]*\nhttp_port [0-9]*/http_port $PORT1\nhttp_port $PORT2/g' /etc/squid3/squid.conf
            sed -i "23s/http_port [0-9]*/http_port $PORT/" /etc/squid3/squid.conf
	   service squid3 restart
            echo "Squid3 Updated Port: $PORT"| lolcat
			break
			;;
			"Speedtest")
			clear
			python speedtest.py --share | lolcat
			break		
	 ;;
	 "Change Port OpenVPN")
	 clear
	           echo "Sila Tukar port OpenVPN anda And Press Enter enter?"| boxes -d peek | lolcat
            read -p "Port: " -e -i 55 PORT
	    service dropbear stop
	    service ssh stop
	    service openvpn stop
            #sed -i "s/port [0-9]*/port $PORT/" /etc/openvpn/1194.conf
	    cp /etc/openvpn/client.ovpn /home/vps/public_html/client.ovpn
            sed -i "s/ipserver ports/$MYIP $PORT/g" /home/vps/public_html/client.ovpn
	    sed -i "s/ipserver/$MYIP/g" /home/vps/public_html/client.ovpn
	   service openvpn start
	    service dropbear start
	    service ssh start
	 break
	 ;;
	"Install OpenVpn")
	clear
	wget http://vpsproject.me/site5/Debian7/openvpn.sh
	chmod +x openvpm.sh
	./openvpn.sh
	break
	;;
  "Download Client Ovpn")
   clear
   echo -e "\e[36m Download Config Ovpn Anda Di   ..."
   echo -e "\e[31m http://$MYIP:81/client.ovpn"
    break
    ;;
    "Install Ocs_Panel")
    wget http://vpsproject.me/site5/Debian7/panel
    chmod +x panel
    bash panel
    break
    ;;
    "Edit Banner SSH")
	clear
	echo "-----------------------------------------------------------" | lolcat
	echo -e "1.) Simpan text (CTRL + X, lalu ketik Y dan tekan Enter) " | lolcat
	echo -e "2.) Membatalkan edit text (CTRL + X, lalu ketik N dan tekan Enter)" | lolcat
	echo "-----------------------------------------------------------" | lolcat
	read -p "Tekan ENTER untuk melanjutkan........................ " | lolcat
	nano /etc/issue.net
	service dropbear restart && service ssh restart
	break
        ;;
	"Edit Banner Menu")
	clear
	echo "--------------------------------------------------------" | lolcat
	echo -e "1. Simpan text (CTRL + X, lalu ketik Y dan tekan ENTER)" | lolcat
	echo -e "2. Membatalkan edit text (CTRL + X,lalu ketik N dan tekan ENTER)" | lolcat
	echo "--------------------------------------------------------" | lolcat
	read -p "Tekan ENTER untuk melanjutkan..................." | lolcat
	nano /usr/bin/bannermenu
	break
	 ;;
        "Change Password VPS")
	read -p "Silahkan isi password baru untuk VPS anda: " pass	
	echo "root:$pass" | chpasswd
	echo "Ciieeee.. ciieeeeeee.. abis ganti password VPS ni yeeee...!!!"| boxes -d boy | lolcat
	break
	;;
	"Quit")
	
	break
	;;
	 
        *) echo invalid option;
	esac
done 
