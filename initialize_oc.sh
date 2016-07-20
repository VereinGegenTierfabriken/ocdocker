#!/bin/bash
 
cd /oc/sql/tables
find . -maxdepth 1 -type f -name \*.sql -exec cat {} \; | mysql -uroot -p opencaching

cd /oc/static-data
find . -maxdepth 1 -type f -name \*.sql -exec cat {} \; | mysql -uroot -p opencaching
 
