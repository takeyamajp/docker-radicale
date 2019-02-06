FROM centos:centos7
MAINTAINER "Hiroki Takeyama"

# python
RUN yum -y install epel-release; \
    yum -y install python36 httpd-tools; \
    python3.6 -m ensurepip; \
    pip3 install bcrypt passlib; \
    yum clean all;

# radicale
RUN mkdir /radicale /conf; \
    pip3 install --upgrade radicale; \
    { \
    echo '[server]'; \
    echo 'hosts = 0.0.0.0:443'; \
    echo 'ssl = True'; \
    echo 'certificate = /conf/cert.pem'; \
    echo 'key = /conf/key.pem'; \
    echo '[logging]'; \
    echo 'config = /conf/log'; \
    echo '[auth]'; \
    echo 'type = htpasswd'; \
    echo 'htpasswd_filename= /conf/user'; \
    echo 'htpasswd_encryption = bcrypt'; \
    echo '[storage]'; \
    echo 'filesystem_folder = /radicale'; \
    } >> /conf/conf; \
    { \
    echo '[loggers]'; \
    echo 'keys = root'; \
    echo '[handlers]'; \
    echo 'keys = console'; \
    echo '[formatters]'; \
    echo 'keys = full'; \
    echo '[logger_root]'; \
    echo 'level = INFO'; \
    echo 'handlers = console'; \
    echo '[handler_console]'; \
    echo 'class = StreamHandler'; \
    echo 'args = (sys.stdout,)'; \
    echo 'formatter = full'; \
    echo '[formatter_full]'; \
    echo 'format = %(asctime)s %(levelname)s: %(message)s'; \
    } >> /conf/log; \
    yum -y install openssl; \
    openssl genrsa -out "/conf/key.pem" 2048; \
    openssl req -new -key "/conf/key.pem" -x509 -subj "/CN=radicale" -days 36500 -out "/conf/cert.pem"; \
    yum clean all;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'rm -f /etc/localtime'; \
    echo 'ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime'; \
    echo 'sed -i "s/^\(ssl\) =.*/\1 = False/" /conf/conf'; \
    echo 'sed -i "s/^\(hosts.*\):.*/\1:80/" /conf/conf'; \
    echo 'if [ ${SSL,,} = "true" ]; then'; \
    echo '  sed -i "s/^\(ssl\) =.*/\1 = True/" /conf/conf'; \
    echo '  sed -i "s/^\(hosts.*\):.*/\1:443/" /conf/conf'; \
    echo 'fi'; \
    echo 'sed -i "s/^\(config\) =.*/\1 = /" /conf/conf'; \
    echo 'if [ ${LOG,,} = "true" ]; then'; \
    echo '  sed -i "s/^\(config\) =.*/\1 = \/conf\/log/" /conf/conf'; \
    echo '  sed -i "s/^\(level\) =.*/\1 = ${LOG_LEVEL}/" /conf/log'; \
    echo 'fi'; \
    echo 'if [ -e /conf/user ]; then'; \
    echo '  rm -f /conf/user'; \
    echo 'fi'; \
    echo 'htpasswd -Bbc /conf/user ${USER} ${PASSWORD} &>/dev/null'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entrypoint.sh; \
    chmod +x /usr/local/bin/entrypoint.sh;
ENTRYPOINT ["entrypoint.sh"]

ENV TIMEZONE Asia/Tokyo

ENV SSL true

ENV LOG true
ENV LOG_LEVEL INFO

ENV USER user
ENV PASSWORD password

VOLUME /radicale

EXPOSE 80
EXPOSE 443

CMD ["python3.6", "-m", "radicale", "--config", "/conf/conf"]
