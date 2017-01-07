#!/bin/bash
#OJ Install Script for Debian 8

#Configure variables
WWW_PATH=/var/www/html/
JUDGER_USER=judge
HTTPD_USER=www-data
DB_USER=root
DB_PASSWORD=root

#Install dept package
sudo apt-get install flex g++ libmysql++-dev php5 apache2 mysql-server php5-mysql php5-gd php5-cli mono-gmcs git make

#Start MySQL service
sudo service mysql start

#Fetch source code
git clone https://github.com/BLumia/BLumiaOJ.git --depth=1
git clone https://github.com/BLumia/HUSTOJ-Core.git --depth=1
git clone https://github.com/BLumia/BLumiaOJ-Installation-Helper.git --depth=1
#Maybe you wanna using a mirror?
#git clone https://git.oschina.net/blumia/BLumiaOJ.git --depth=1
#git clone https://git.oschina.net/blumia/HUSTOJ-Core.git --depth=1
#git clone https://git.oschina.net/blumia/BLumiaOJ-Installation-Helper.git --depth=1

#Judger account
sudo useradd -m -u 1536 $JUDGER_USER

#Compile Judger
sudo ./HUSTOJ-Core/make.sh

#Running database sql and copy www data
sudo cp -r BLumiaOJ/ $WWW_PATH/OnlineJudge/
sudo chmod -R 771 $WWW_PATH/OnlineJudge/
sudo chown -R $HTTPD_USER $WWW_PATH/OnlineJudge/
sudo mysql -h localhost -u$DB_USER -p$DB_PASSWORD < BLumiaOJ-Installation-Helper/sql_runner/db.sql

#Creating folder for Judger
sudo mkdir /home/$JUDEGR_USER/etc
sudo mkdir /home/$JUDEGR_USER/data
sudo mkdir /home/$JUDEGR_USER/log
sudo mkdir /home/$JUDEGR_USER/run0
sudo mkdir /home/$JUDEGR_USER/run1
sudo mkdir /home/$JUDEGR_USER/run2
sudo mkdir /home/$JUDEGR_USER/run3

#A+B Problem data
sudo mkdir /home/$JUDEGR_USER/data/1000
sudo echo "61 4" > /home/$JUDEGR_USER/data/1000/sample.in
sudo echo "65" > /home/$JUDEGR_USER/data/1000/sample.out

#Copying data for judger
cd BLumiaOJ-Installation-Helper/install/
sudo cp java0.policy judge.conf /home/$JUDEGR_USER/etc

#Ownership with judger and httpd user
sudo chown -R $JUDEGR_USER /home/$JUDEGR_USER
sudo chgrp -R $HTTPD_USER /home/$JUDEGR_USER/data
sudo chgrp -R root /home/$JUDEGR_USER/etc /home/$JUDEGR_USER/run?
sudo chmod 775 /home/$JUDEGR_USER /home/$JUDEGR_USER/data /home/$JUDEGR_USER/etc /home/$JUDEGR_USER/run?

#Make judge daemon run at boot up
sudo cp judged /etc/init.d/judged
sudo chmod +x /etc/init.d/judged
sudo ln -s /etc/init.d/judged /etc/rc3.d/S93judged
sudo ln -s /etc/init.d/judged /etc/rc2.d/S93judged
sudo /etc/init.d/judged start