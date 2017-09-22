#!/bin/bash

# Change user password, bug fix

echo "ubuntu:ubuntu" | sudo chpasswd

echo "Installing..."

# Update

apt-get install build-essential python-software-properties tcl8.5 vim curl debconf-utils composer -y > /dev/null 2>&1

apt-get update -y > /dev/null 2>&1
apt-get upgrade -y > /dev/null 2>&1

# Git

echo "Installing Git"
apt-get install git -y > /dev/null 2>&1

# Apache

echo "Installing Apache"
apt-get install apache2 -y > /dev/null 2>&1

# PHP

echo "Installing PHP"
apt-get install -y php php-cli php-mysql php-redis php-mcrypt php-xsl php-soap php-curl php-json libapache2-mod-php php-intl php-xsl php-xdebug php-mbstring php-zip > /dev/null 2>&1

# Composer

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer > /dev/null 2>&1

# Redis

echo "Installing Redis"
apt-get install redis-server redis-tools -y > /dev/null 2>&1

# MySQL

debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

echo "Installing MySQL"
apt-get install mysql-server -y > /dev/null 2>&1

# phpMyAdmin

debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

echo "Installing phpMyAdmin"
apt-get install phpmyadmin -y > /dev/null 2>&1

# phpRedisAdmin

echo "Installing phpRedisAdmin"

composer create-project -n -s dev erik-dubbelboer/php-redis-admin /usr/share/phpredisadmin > /dev/null 2>&1
cp /usr/share/phpredisadmin/includes/config.sample.inc.php /usr/share/phpredisadmin/includes/config.inc.php

# Konfiguracja Apache

echo "Setting up Apache"

rm -rf /etc/apache2/sites-available/*.conf
rm -rf /etc/apache2/sites-enabled/*.conf

cp /vagrant/provision/config/ports.conf /etc/apache2/ports.conf > /dev/null 2>&1

cp /vagrant/provision/config/localhost.conf /etc/apache2/sites-available/localhost.conf > /dev/null 2>&1
cp /vagrant/provision/config/phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf > /dev/null 2>&1
cp /vagrant/provision/config/phpredisadmin.conf /etc/apache2/sites-available/phpredisadmin.conf > /dev/null 2>&1

a2ensite localhost.conf phpmyadmin.conf phpredisadmin.conf > /dev/null 2>&1
a2enmod rewrite > /dev/null 2>&1

# Restart Apache

service apache2 restart > /dev/null 2>&1

# End

echo "That's it! You can use your virtual machine."
