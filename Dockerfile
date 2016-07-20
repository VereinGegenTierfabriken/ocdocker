FROM tutum/lamp:latest
ADD *.sh /
RUN rm -fr /app && git clone https://github.com/ritchieGitHub/oc-server3.git /oc
RUN ln -s /oc/htdocs /app
RUN chmod u+x *.sh
CMD ["create_oc.sh"]
CMD ["initialize_oc.sh"]
ADD settings-dist.inc.php /oc/htdocs/config2/settings.inc.php
RUN cp /oc/htdocs/app/autoload.php /oc/htdocs/vendor/
RUN php /oc/sql/stored-proc/maintain.php

EXPOSE 80 3306
CMD ["/run.sh"]
