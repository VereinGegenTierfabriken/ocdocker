#!/bin/bash
cat /etc/php.ini | sed -e 's/upload_max_filesize = 2M/upload_max_filesize = 10M/' > /etc/php.ini.tmp
echo "extension=imagick.so" >> /etc/php.ini.tmp
mv /etc/php.ini.tmp /etc/php.ini
