#!/bin/bash
#OJ Install Script for Debian 8

#Configure variables
WWW_PATH=/var/www/html/
JUDGER_USER=judge
HTTPD_USER=www-data
DB_USER=root
DB_PASSWORD=root

#Install dept package
echo "mysql-server mysql-server/root_password password ${DB_PASSWORD}" | sudo debconf-set-selections 
echo "mysql-server mysql-server/root_password_again password ${DB_PASSWORD}" | sudo debconf-set-selections 
sudo apt-get -y install flex g++ libmysql++-dev php5 apache2 mysql-server php5-mysql php5-gd php5-cli mono-gmcs git make

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
cd HUSTOJ-Core/
sudo bash make.sh
cd ../

#Running database sql and copy www data
sudo cp -r BLumiaOJ/ $WWW_PATH/OnlineJudge/
sudo chmod -R 771 $WWW_PATH/OnlineJudge/
sudo chown -R $HTTPD_USER $WWW_PATH/OnlineJudge/
sudo mysql -h localhost -u$DB_USER -p$DB_PASSWORD < BLumiaOJ-Installation-Helper/sql_runner/db.sql

#Creating folder for Judger
sudo mkdir /home/$JUDGER_USER/etc
sudo mkdir /home/$JUDGER_USER/data
sudo mkdir /home/$JUDGER_USER/log
sudo mkdir /home/$JUDGER_USER/run0
sudo mkdir /home/$JUDGER_USER/run1
sudo mkdir /home/$JUDGER_USER/run2
sudo mkdir /home/$JUDGER_USER/run3

#A+B Problem data
sudo mkdir /home/$JUDGER_USER/data/1000
sudo echo "61 4" > /home/$JUDGER_USER/data/1000/sample.in
sudo echo "65" > /home/$JUDGER_USER/data/1000/sample.out

#Copying data for judger
cd BLumiaOJ-Installation-Helper/install/
sudo cp java0.policy judge.conf /home/$JUDGER_USER/etc

#Ownership with judger and httpd user
sudo chown -R $JUDGER_USER /home/$JUDGER_USER
sudo chgrp -R $HTTPD_USER /home/$JUDGER_USER/data
sudo chgrp -R root /home/$JUDGER_USER/etc /home/$JUDGER_USER/run?
sudo chmod 775 /home/$JUDGER_USER /home/$JUDGER_USER/data /home/$JUDGER_USER/etc /home/$JUDGER_USER/run?

#Make judge daemon run at boot up
sudo cp judged /etc/init.d/judged
sudo chmod +x /etc/init.d/judged
sudo ln -s /etc/init.d/judged /etc/rc3.d/S93judged
sudo ln -s /etc/init.d/judged /etc/rc2.d/S93judged
sudo /etc/init.d/judged start
