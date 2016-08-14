FROM nir/oc-lamp-app
RUN apt-get -y install php5-xdebug
RUN echo "xdebug.remote_enable=on" >> /etc/php5/mods-available/xdebug.ini
RUN echo "xdebug.remote_autostart=on" >> /etc/php5/mods-available/xdebug.ini
EXPOSE 80 3306
CMD ["/run.sh"]
