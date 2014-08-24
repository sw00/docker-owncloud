#!/bin/bash
chown -R www-data:www-data /var/www/owncloud/data
. /etc/apache2/envvars &&
/usr/sbin/apache2 -D FOREGROUND