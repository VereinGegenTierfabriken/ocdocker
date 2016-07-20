#!/bin/bash
  
EXPECTED_ARGS=3
E_BADARGS=65
MYSQL=`which mysql`
  
Q1="CREATE DATABASE `opencaching` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
Q2="CREATE DATABASE `oc_tmpdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
Q3="GRANT USAGE ON *.* TO opencaching@localhost IDENTIFIED BY 'nix';"
Q4="GRANT USAGE ON *.* TO oc_tmpdb@localhost IDENTIFIED BY 'nix';"
Q5="GRANT ALL PRIVILEGES ON opencaching.* TO opencaching@localhost;"
Q6="GRANT ALL PRIVILEGES ON oc_tmpdb.* TO oc_tmpdb@localhost;"
Q7="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}${Q5}${Q6}${Q7}"
  
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi
  
$MYSQL -uroot -p -e "$SQL"
