#!/bin/bash

# ******************************************
# START SCRIPT (amput.tk)
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
if [ $USER != 'root' ]; then
echo "Sorry, for run the script please using root user"
exit 1
fi
if [[ "$EUID" -ne 0 ]]; then
echo "Sorry, you need to run this as root"
exit 2
fi
if [[ ! -e /dev/net/tun ]]; then
echo "TUN is not available"
exit 3
fi
echo "
AUTOSCRIPT BY amput.tk

PLEASE CANCEL ALL PACKAGE POPUP

AMBIL PERHATIAN !!!"
clear
echo "MULA MEMASANG AUTOSCRIPT"
clear
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo "
ENABLE IPV4 AND IPV6

COMPLETE 1%
"
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
echo "
REMOVE SPAM PACKAGE

COMPLETE 10%
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
clear
echo "
UPDATE AND UPGRADE PROCESS

PLEASE WAIT TAKE TIME 1-5 MINUTE
"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update;
apt-get -y autoremove;
apt-get -y install wget curl;
echo "
INSTALLER PROCESS PLEASE WAIT

TAKE TIME 5-10 MINUTE
"

# script
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/sslmode/sslmode/master/common-password"
chmod +x /etc/pam.d/common-password
service exim4 stop;sysv-rc-conf exim4 off;
# webmin
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
# dropbear
apt-get -y install dropbear
wget -O /etc/default/dropbear "https://raw.githubusercontent.com/sslmode/sslmode/master/dropbear"
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
# squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/sslmode/sslmode/master/squid.conf"
wget -O /etc/squid/squid.conf "http://rzvpn.net/random/squid.conf"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
sed -i "s/ipserver/$myip/g" /etc/squid/squid.conf
# openvpn
apt-get -y install openvpn
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/sslmode/sslmode/master/openvpn.tar"
cd /etc/openvpn/;tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/rc.local "https://raw.githubusercontent.com/sslmode/sslmode/master/conf/rc.local";chmod +x /etc/rc.local
#wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/iceiceice77/sslmode/master/iptables.up.rules"
#sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
#iptables-restore < /etc/iptables.up.rules
# install webserver
cd
apt-get -y install nginx php-fpm php-mcrypt php-cli libexpat1-dev libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/sslmode/sslmode/master/conf/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/sslmode/sslmode/master/vps.conf"
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php//fpm/php.ini
sed -i 's/listen = \/var\/run\/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf
sed -i $MYPORT /etc/nginx/conf.d/vps.conf;
useradd -m vps && mkdir -p /home/vps/public_html
rm /home/vps/public_html/index.html && echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html && chmod -R g+rw /home/vps/public_html
service php7.0-fpm restart && service nginx restart
# etc
wget -O /home/vps/public_html/client.ovpn "https://raw.githubusercontent.com/sslmode/sslmode/master/client.ovpn"
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
useradd -m -g users -s /bin/bash ARCHANGELS
echo "7C22C4ED" | chpasswd
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
cd;rm *.sh;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;

#install PPTP
apt-get -y install pptpd
cat > /etc/ppp/pptpd-options <<END
name pptpd
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
require-mppe-128
ms-dns 8.8.8.8
ms-dns 8.8.4.4
proxyarp
nodefaultroute
lock
nobsdcomp
END

cat > /etc/pptpd.conf <<END
option /etc/ppp/pptpd-options
logwtmp
localip 10.1.0.1
remoteip 10.1.0.5-100
END

cat >> /etc/ppp/ip-up <<END
ifconfig ppp0 mtu 1400
END
mkdir /var/lib/premium-script
/etc/init.d/pptpd restart

# asd
apt-get update
apt-get upgrade
apt-get install stunnel4
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/sslmode/sslmode/master/stunnel.conf"
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart
cd

#Setting USW
apt-get install ufw
ufw allow ssh
ufw allow 1194/tcp
sed -i 's|DEFAULT_INPUT_POLICY="DROP"|DEFAULT_INPUT_POLICY="ACCEPT"|' /etc/default/ufw
sed -i 's|DEFAULT_FORWARD_POLICY="DROP"|DEFAULT_FORWARD_POLICY="ACCEPT"|' /etc/default/ufw
cat > /etc/ufw/before.rules <<-END
# START OPENVPN RULES
# NAT table rules
*nat
:POSTROUTING ACCEPT [0:0]
# Allow traffic from OpenVPN client to eth0
-A POSTROUTING -s 10.8.0.0/8 -o eth0 -j MASQUERADE
COMMIT
# END OPENVPN RULES
END
ufw enable
ufw status
ufw disable
# mtrt
wget https://raw.githubusercontent.com/sslmode/sslmode/master/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php
# ssw
cd
apt-get -y install cmake make gcc
wget https://raw.githubusercontent.com/sslmode/sslmode/master/badvpn-1.999.127.tar.bz2
tar xf badvpn-1.999.127.tar.bz2
mkdir badvpn-build
cd badvpn-build
cmake ~/badvpn-1.999.127 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
screen badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
cd
# block 
sed -i '$ i\iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 21 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 22 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 53 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 81 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 109 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 110 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 143 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 443 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 1194 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 3128 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 8000 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 8080 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp --dport 10000 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p udp -m udp --dport 2500 -j ACCEPT' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p udp -m udp -j DROP' /etc/rc.local
sed -i '$ i\iptables -A OUTPUT -p tcp -m tcp -j DROP' /etc/rc.local
apt-get -y install fail2ban;service fail2ban restart

# text gambar
apt-get install boxes

# color text
cd
rm -rf /root/.bashrc
wget -O /root/.bashrc "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/.bashrc"

# install lolcat
sudo apt-get -y install ruby
sudo gem install lolcat

# download script
cd
wget -O /usr/bin/motd "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/motd"
wget -O /usr/bin/benchmark "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/benchmark.sh"
wget -O /usr/bin/speedtest "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/speedtest_cli.py"
wget -O /usr/bin/ps-mem "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/ps_mem.py"
wget -O /usr/bin/dropmon "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/dropmon.sh"
wget -O /usr/bin/menu "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/menu.sh"
wget -O /usr/bin/user-active-list "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-active-list.sh"
wget -O /usr/bin/user-add "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-add.sh"
wget -O /usr/bin/user-add-pptp "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-add-pptp.sh"
wget -O /usr/bin/user-del "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-del.sh"
wget -O /usr/bin/disable-user-expire "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/disable-user-expire.sh"
wget -O /usr/bin/delete-user-expire "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/delete-user-expire.sh"
wget -O /usr/bin/banned-user "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/banned-user.sh"
wget -O /usr/bin/unbanned-user "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/unbanned-user.sh"
wget -O /usr/bin/user-expire-list "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-expire-list.sh"
wget -O /usr/bin/user-gen "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-gen.sh"
wget -O /usr/bin/userlimit.sh "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/userlimit.sh"
wget -O /usr/bin/userlimitssh.sh "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/userlimitssh.sh"
wget -O /usr/bin/user-list "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-list.sh"
wget -O /usr/bin/user-login "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-login.sh"
wget -O /usr/bin/user-pass "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-pass.sh"
wget -O /usr/bin/user-renew "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/user-renew.sh"
wget -O /usr/bin/clearcache.sh "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/clearcache.sh"
wget -O /usr/bin/bannermenu "https://raw.githubusercontent.com/sslmode/sslmode/master/tools/bannermenu"
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

# make
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

#clearing history
history -c

## info
echo ""  | tee -a log-install.txt
echo "--------------------------- Penjelasan Setup Server ----------------------------" | lolcat
echo "                         Copyright OrangKuatSabahanTerkini.net                  " | lolcat
echo "                        https://www.OrangKuatSabahanTerkini.net                 " | lolcat
echo "--------------------------------------------------------------------------------" | lolcat
echo "========================================"  | tee -a log-install.txt | lolcat
echo "Service Autoscript OrangKuatSabahanTerkini (OrangKuatSabahanTerkini SCRIPT 2017)"  | tee -a log-install.txt | lolcat
echo "----------------------------------------"  | tee -a log-install.txt | lolcat
echo ""  | tee -a log-install.txt | lolcat
echo "nginx : http://$myip:80"   | tee -a log-install.txt | lolcat
echo "Webmin : http://$myip:10000/"  | tee -a log-install.txt | lolcat
echo "Squid3 : 8080"  | tee -a log-install.txt | lolcat
echo "OpenSSH : 22"  | tee -a log-install.txt | lolcat
echo "Dropbear : 109'110'442"  | tee -a log-install.txt | lolcat
echo "SSL : 443"  | tee -a log-install.txt | lolcat
echo "OpenVPN  : IP/client.ovpn"  | tee -a log-install.txt | lolcat
echo "Fail2Ban : [on]"  | tee -a log-install.txt | lolcat
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt | lolcat
echo "Menu : type menu to check menu script"  | tee -a log-install.txt | lolcat
echo ""  | tee -a log-install.txt | lolcat
echo "----------------------------------------" | lolcat
echo "LOG INSTALL  --> /root/log-install.txt" | lolcat
echo "----------------------------------------" | lolcat
echo "========================================"  | tee -a log-install.txt | lolcat
echo "      PLEASE REBOOT TO TAKE EFFECT !" | lolcat
echo "========================================"  | tee -a log-install.txt | lolcat
cat /dev/null > ~/.bash_history && history -c
