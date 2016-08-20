FROM debian:wheezy
MAINTAINER Richard van Nieuwenhoven<ritchie@gmx.at>, Peter Haering<ph@inrane.de>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt wget nullmailer net-tools && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
ADD *.sh /
ADD *.patch /
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure /app folder with sample app
RUN git clone -b stable https://github.com/ritchieGitHub/oc-server3.git /oc
RUN rm -fr /var/www && ln -s /app /var/www
RUN ln -s /oc/htdocs /app
RUN ln -s /oc/sql/stored-proc /app/stored-proc
RUN chmod u+x *.sh
RUN /initialize_oc.sh

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

RUN /mysql-fill.sh
RUN cp -r -p /etc/mysql /etc/mysql-init
RUN cp -r -p /var/lib/mysql /var/lib/mysql-init

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]


EXPOSE 80 3306
CMD ["/run.sh"]

