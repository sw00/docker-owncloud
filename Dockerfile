FROM ubuntu:12.04
MAINTAINER Sett Wai "sett@rigmarolesoup.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get -y update && apt-get install wget

# Install PHP5
RUN add-apt-repository ppa:ondrej/php5
RUN apt-get update
RUN apt-get install php5

# Install Apache
RUN apt-get install apache2 mysql-server libapache2-mod-php5
RUN apt-get install php5-gd php5-json php5-mysql php5-curl
RUN apt-get install php5-intl php5-mcrypt php5-imagick

# Download and untar owncloud installation
RUN wget https://download.owncloud.org/community/owncloud-7.0.1.tar.bz2
RUN tar -xjf owncloud-7.0.1.tar.bz2

RUN cp -r owncloud /var/www
RUN chown -R www-data:www-data /var/www/owncloud

# Enable SSL with Apache
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN service apache2 reload
