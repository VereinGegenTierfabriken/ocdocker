#!/bin/bash
  
  
Q1="CREATE DATABASE opencaching DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
Q2="CREATE DATABASE oc_tmpdb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
Q3="CREATE USER opencaching@'%' IDENTIFIED BY 'nix';"
Q4="CREATE USER oc_tmpdb@'%' IDENTIFIED BY 'nix';"
Q5="GRANT ALL PRIVILEGES ON opencaching.* TO 'opencaching'@'%';"
Q6="GRANT ALL PRIVILEGES ON oc_tmpdb.* TO 'oc_tmpdb'@'%';"
Q7="GRANT ALL PRIVILEGES ON oc_tmpdb.* TO 'opencaching'@'%';"
Q8="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}${Q5}${Q6}${Q7}"
  
mysql -uadmin -p$PASS -e "$SQL"
#!/bin/bash
 
cd /oc/sql/tables
find . -maxdepth 1 -type f -name \*.sql -exec cat {} \; | mysql -uadmin -p$PASS opencaching

cd /oc/sql/static-data
find . -maxdepth 1 -type f -name \*.sql -exec cat {} \; | mysql -uadmin -p$PASS opencaching

cd /oc/sql/stored-proc/
php maintain.php

cd /
mysql -uadmin -p$PASS -e "DROP TABLE opencaching.geodb_coordinates, opencaching.geodb_hierarchies, opencaching.geodb_locations, opencaching.geodb_textdata;"   
wget http://www.fa-technik.adfc.de/code/opengeodb/opengeodb-begin.sql
wget http://www.fa-technik.adfc.de/code/opengeodb/AT.sql
wget http://www.fa-technik.adfc.de/code/opengeodb/opengeodb-end.sql
sed -i -- 's/TYPE=InnoDB/ENGINE=InnoDB/g' opengeodb-*.sql
cat opengeodb-begin.sql  | mysql -uadmin -p$PASS opencaching
cat AT.sql  | mysql -uadmin -p$PASS opencaching
cat opengeodb-end.sql  | mysql -uadmin -p$PASS opencaching

