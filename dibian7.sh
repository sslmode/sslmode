#!/bin/bash
clear
echo "=============================="
echo "        Selamat Datang        "
echo "=============================="
echo "Ketik 'I' Untuk VPS Non-Lokal"
echo "Ketik 'L' Untuk VPS Lokal" 
echo "=============================="
read -p "Location : " -e loc
apt-get update

# go to root
cd

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
ver=`cat /etc/debian_version`
if [ $ver = '6.0' ]
then
debver='6'
elif [ $ver = '6.1' ]
then
debver='6'
elif [ $ver = '6.2' ]
then
debver='6'
elif [ $ver = '6.3' ]
then
debver='6'
elif [ $ver = '6.4' ]
then
debver='6'
elif [ $ver = '6.5' ]
then
debver='6'
elif [ $ver = '6.6' ]
then
debver='6'
elif [ $ver = '6.7' ]
then
debver='6'
elif [ $ver = '6.8' ]
then
debver='6'
elif [ $ver = '6.9' ]
then
debver='6'
elif [ $ver = '7.0' ]
then
debver='7'
elif [ $ver = '7.1' ]
then
debver='7'
elif [ $ver = '7.2' ]
then
debver='7'
elif [ $ver = '7.3' ]
then
debver='7'
elif [ $ver = '7.4' ]
then
debver='7'
elif [ $ver = '7.5' ]
then
debver='7'
elif [ $ver = '7.6' ]
then
debver='7'
elif [ $ver = '7.7' ]
then
debver='7'
elif [ $ver = '7.8' ]
then
debver='7'
elif [ $ver = '7.9' ]
then
debver='7'
elif [ $ver = '8.0' ]
then
debver='8'
elif [ $ver = '8.1' ]
then
debver='8'
elif [ $ver = '8.2' ]
then
debver='8'
elif [ $ver = '8.3' ]
then
debver='8'
elif [ $ver = '8.4' ]
then
debver='8'
elif [ $ver = '8.5' ]
then
debver='8'
elif [ $ver = '8.6' ]
then
debver='8'
elif [ $ver = '8.7' ]
then
debver='8'
elif [ $ver = '8.8' ]
then
debver='8'
elif [ $ver = '8.9' ]
then
debver='8'
else
debver='Null'
fi
if [ $debver = '6' ]; then
	if [[ "$loc" = "I" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "L" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "i" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "l" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	fi
elif [ $debver = '7' ]; then
	if [[ "$loc" = "I" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "L" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "i" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "l" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian7.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	fi
elif [ $debver = '8' ]; then
	if [[ "$loc" = "I" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "L" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "i" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	elif [[ "$loc" = "l" ]]; then
		wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/sources.list.debian8.lokal"
		wget "https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/dotdeb.gpg"
		apt-key add dotdeb.gpg
		rm dotdeb.gpg
		apt-get install python-software-properties 
		apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
		cd /root
		wget http://www.webmin.com/jcameron-key.asc
		apt-key add jcameron-key.asc
		cd
		apt-get update
	fi
else
	cd
fi

gpg --keyserver pgpkeys.mit.edu --recv-key  9D6D8F6BC857C906      
gpg -a --export 9D6D8F6BC857C906 | sudo apt-key add -
gpg --keyserver pgpkeys.mit.edu --recv-key  7638D0442B90D010      
gpg -a --export 7638D0442B90D010 | sudo apt-key add -

# update
apt-get update

# Install Essential Package
apt-get -y install build-essential


# install webmin
cd
wget "http://insomnet4u.me/debi-ssl/ngising/webmin_1.801_all.deb"
dpkg --install webmin_1.801_all.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm /root/webmin_1.801_all.deb
service webmin restart
service vnstat restart
apt-get -y --force-yes -f install libxml-parser-perl


# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i '/Port 22/a Port  90' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=80/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110 -p 442"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart
# upgrade dropbear 2017
apt-get install zlib1g-dev
wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2017.75.tar.bz2
bzip2 -cd dropbear-2017.75.tar.bz2  | tar xvf -
cd dropbear-2017.75
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear1
ln /usr/local/sbin/dropbear /usr/sbin/dropbear
service dropbear restartgi

# Install Webserver Port 81
apt-get install nginx php5 libapache2-mod-php5 php5-fpm php5-cli php5-mysql php5-mcrypt libxml-parser-perl -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
curl https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/nginx.conf > /etc/nginx/nginx.conf
curl https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/uptime.php "http://autoscript.kepalatupai.com/uptime.php1"
wget -O /home/vps/public_html/index.html "https://raw.githubusercontent.com/sslmode/sslmode/master/index.html1"
service php5-fpm restart
service nginx restart
cd

# Install VNSTAT
apt-get install vnstat -y
cd /home/vps/public_html/
wget https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
if [[ `ifconfig -a | grep "venet0"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "venet0:0"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "venet0:0-00"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "venet0-00"` ]]
then
cekvirt='OpenVZ'
elif [[ `ifconfig -a | grep "eth0"` ]]
then
cekvirt='KVM'
elif [[ `ifconfig -a | grep "eth0:0"` ]]
then
cekvirt='KVM'
elif [[ `ifconfig -a | grep "eth0:0-00"` ]]
then
cekvirt='KVM'
elif [[ `ifconfig -a | grep "eth0-00"` ]]
then
cekvirt='KVM'
fi
if [ $cekvirt = 'KVM' ]; then
	sed -i 's/eth0/eth0/g' config.php
	sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
	sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
	sed -i 's/Internal/Internet/g' config.php
	sed -i '/SixXS IPv6/d' config.php
	cd
elif [ $cekvirt = 'OpenVZ' ]; then
	sed -i 's/eth0/venet0/g' config.php
	sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array('venet0');/g" config.php
	sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
	sed -i 's/Internal/Internet/g' config.php
	sed -i '/SixXS IPv6/d' config.php
	cd
else
	cd
fi

# Install BadVPN
apt-get -y install cmake make gcc
wget https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/badvpn-1.999.127.tar.bz2
tar xf badvpn-1.999.127.tar.bz2
mkdir badvpn-build
cd badvpn-build
cmake ~/badvpn-1.999.127 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
screen badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
cd
# install mrtg
wget -O /etc/snmp/snmpd.conf "https://raw.githubusercontent.com/chunyen91/0109475453/master/snmpd.conf"
wget -O /root/mrtg-mem.sh "https://raw.githubusercontent.com/chunyen91/0109475453/master/mrtg-mem.sh"
chmod +x /root/mrtg-mem.sh
cd /etc/snmp/
sed -i 's/TRAPDRUN=no/TRAPDRUN=yes/g' /etc/default/snmpd
service snmpd restart
snmpwalk -v 1 -c public localhost 1.3.6.1.4.1.2021.10.1.3.1
mkdir -p /home/vps/public_html/mrtg
cfgmaker --zero-speed 100000000 --global 'WorkDir: /home/vps/public_html/mrtg' --output /etc/mrtg.cfg public@localhost
curl "https://raw.githubusercontent.com/chunyen91/0109475453/master/mrtg.conf" >> /etc/mrtg.cfg
sed -i 's/WorkDir: \/var\/www\/mrtg/# WorkDir: \/var\/www\/mrtg/g' /etc/mrtg.cfg
sed -i 's/# Options\[_\]: growright, bits/Options\[_\]: growright/g' /etc/mrtg.cfg
indexmaker --output=/home/vps/public_html/mrtg/index.html /etc/mrtg.cfg
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
cd

# openvpn
apt-get -y install openvpn
cd /etc/openvpn/
wget https://raw.githubusercontent.com/chunyen91/Ford_7752/master/vervpn8/openvpn.tar;tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/chunyen91/Ford_7752/master/vervpn8/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules
# etc
wget -O /home/vps/public_html/client.ovpn "https://raw.githubusercontent.com/chunyen91/Ford_7752/master/vervpn8/client.ovpn"
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
cd;wget https://raw.githubusercontent.com/chunyen91/Ford_7752/master/vervpn8/cronjob.tar
tar xf cronjob.tar;mv uptime.php /home/vps/public_html/
mv usertol userssh uservpn /usr/bin/;mv cronvpn cronssh /etc/cron.d/
chmod +x /usr/bin/usertol;chmod +x /usr/bin/userssh;chmod +x /usr/bin/uservpn;
useradd -m -g users -s /bin/bash dragon
echo "Wutoh:369" | chpasswd
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm $0;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;
clear
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
echo "option /etc/ppp/pptpd-options" > /etc/pptpd.conf
echo "logwtmp" >> /etc/pptpd.conf
echo "localip 10.1.0.1" >> /etc/pptpd.conf
echo "remoteip 10.1.0.5-100" >> /etc/pptpd.conf
cat >> /etc/ppp/ip-up <<END
ifconfig ppp0 mtu 1400
END
mkdir /var/lib/premium-script
/etc/init.d/pptpd restart
# 3some
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

# vvsl
apt-get update
apt-get upgrade
apt-get install stunnel4
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/sslmode/sslmode/master/stunnel.conf"
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# somefuck
cd
wget https://raw.githubusercontent.com/sslmode/sslmode/master/tools/setup && chmod +x setup && ./setup
# install dos2unix
apt-get install dos2unix

# toto
wget -q https://github.com/ForNesiaFreak/FNS/raw/master/go/fornesia87.tgz
tar xvfz fornesia87.tgz
cd fornesia87
make

# mimpingeri
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


# Install Squid
wget https://raw.githubusercontent.com/GegeEmbrie/autosshvpn/master/file/squid.sh && bash squid.sh

# text gambar
apt-get install boxes

# color text
cd
rm -rf /root/.bashrc
wget -O /root/.bashrc "https://raw.githubusercontent.com/iceiceice77/iceScripts/master/box/.bashrc"

# install lolcat
sudo apt-get -y install ruby
sudo gem install lolcat

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
# buat swap
mkswap /swapfile
# jalan swapfile
swapon /swapfile
#auto star saat reboot
wget https://raw.githubusercontent.com/iceiceice77/iceScripts/master/isossl/fstab
mv ./fstab /etc/fstab
chmod 644 /etc/fstab
sysctl vm.swappiness=10
#permission swapfile
chown root:root /swapfile 
chmod 0600 /swapfile
cd
# Log
clear
wget https://raw.githubusercontent.com/iceiceice77/2342q42q34/master/details.sh && bash details.sh
rm details.sh
history -c
