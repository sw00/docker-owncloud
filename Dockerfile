FROM ubuntu:14.04
MAINTAINER Sett Wai "sett@rigmarolesoup.com"
RUN apt-get -y update 
RUN apt-get install -yq wget python-software-properties bzip2

# update apt cache
RUN apt-get -y update

# Install apache2 and php5
RUN apt-get install -yq php5
RUN apt-get install -yq apache2 libapache2-mod-php5
RUN apt-get install -yq php5-gd php5-json php5-sqlite php5-curl
RUN apt-get install -yq php5-intl php5-mcrypt php5-imagick

# Install samba for external storage plugin support
RUN apt-get install -yq smbclient

# Download and untar owncloud installation
RUN wget https://download.owncloud.org/community/owncloud-8.0.2.tar.bz2
RUN tar -xjf owncloud-8.0.2.tar.bz2

RUN cp -r owncloud /var/www
RUN chown -R www-data:www-data /var/www/owncloud

# install the news app plugin
RUN wget https://github.com/owncloud/news/archive/5.2.8.tar.gz -O news.tgz
RUN tar -xvf news.tgz && mv news-5.2.8 /var/www/owncloud/apps/news

# Copy the autoconfig
ADD autoconfig.php /var/www/owncloud/config/autoconfig.php

# Configure it
RUN rm -rf /etc/apache2/sites-enabled/*
ADD 001-owncloud.conf /etc/apache2/sites-enabled/001-owncloud.conf

RUN a2enmod rewrite

ADD start.sh /bin/start.sh
RUN chmod 733 /bin/start.sh

VOLUME ["/var/www/owncloud/data"]
EXPOSE 80

CMD ["/bin/start.sh"]
