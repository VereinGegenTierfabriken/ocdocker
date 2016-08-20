#!/bin/bash
  
echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
echo "=> Installing MySQL ..."
mysql_install_db 
echo "=> mysql_install_db Done!"  
/create_mysql_admin_user.sh
echo "=> mysql_db filled Done!"  