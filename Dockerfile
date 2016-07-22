FROM tutum/lamp:latest
RUN apt-get update && \
apt-get -y install wget
ADD *.sh /
ADD *.patch /
RUN rm -fr /app && git clone -b stable https://github.com/ritchieGitHub/oc-server3.git /oc
RUN ln -s /oc/htdocs /app
RUN ln -s /oc/sql/stored-proc /app/stored-proc
RUN chmod u+x *.sh
RUN /initialize_oc.sh

EXPOSE 80 3306
CMD ["/run.sh"]
