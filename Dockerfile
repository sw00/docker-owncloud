FROM ubuntu:12.04
MAINTAINER Sett Wai "sett@rigmarolesoup.com"
RUN apt-get -y update 
RUN apt-get install -yq wget python-software-properties bzip2

# Install PHP5
RUN add-apt-repository ppa:ondrej/php5
RUN apt-get -y update
RUN apt-get install -yq php5

# Install apache2 and php5
RUN apt-get install -yq apache2 libapache2-mod-php5
RUN apt-get install -yq php5-gd php5-json php5-mysql php5-curl
RUN apt-get install -yq php5-intl php5-mcrypt php5-imagick

# Download and untar owncloud installation
RUN wget https://download.owncloud.org/community/owncloud-7.0.1.tar.bz2 --no-check-certificate
RUN tar -xjf owncloud-7.0.1.tar.bz2

RUN cp -r owncloud /var/www
RUN chown -R www-data:www-data /var/www/owncloud

# Configure it
RUN rm -rf /etc/apache2/sites-enabled/*
ADD 001-owncloud.conf /etc/apache2/sites-enabled/001-owncloud.conf

RUN a2enmod rewrite

ADD start.sh /bin/start.sh
RUN chmod 733 /bin/start.sh

VOLUME ["/var/www/owncloud/data"]
EXPOSE 80

ENTRYPOINT ["/bin/start.sh"]