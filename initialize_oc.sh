#!/bin/bash

cd /oc/htdocs/lib/
cp settings-dist.inc.php settings.inc.php
patch settings.inc.php -i /lib-settings-dist.inc.php.patch

cd /oc/htdocs/config2/
cp settings-dist.inc.php settings.inc.php
patch settings.inc.php -i /config2-settings-dist.inc.php.patch

cd /oc/htdocs

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

rm composer.lock
php composer.phar install

chown -R www-data.www-data /oc

