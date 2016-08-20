#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "copieing the initial database"
    rm -rf /etc/mysql/*
	rm -rf /var/lib/mysql/*
	cp -r -p /etc/mysql-init/* /etc/mysql
	cp -r -p /var/lib/mysql-init/* /var/lib/mysql
else
    echo "=> Using an existing volume of MySQL"
fi

exec supervisord -n
