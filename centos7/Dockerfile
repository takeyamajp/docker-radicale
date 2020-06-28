FROM centos:centos7
MAINTAINER "Hiroki Takeyama"

# certificate
RUN mkdir /cert; \
    yum -y install openssl; \
    openssl genrsa -aes256 -passout pass:dummy -out "/cert/key.pass.pem" 2048; \
    openssl rsa -passin pass:dummy -in "/cert/key.pass.pem" -out "/cert/key.pem"; \
    rm -f /cert/key.pass.pem; \
    yum clean all;

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
    echo 'hosts = 0.0.0.0:5232'; \
    echo 'ssl = False'; \
    echo 'certificate = /cert/cert.pem'; \
    echo 'key = /cert/key.pem'; \
    echo '[logging]'; \
    echo 'level = warning'; \
    echo '[auth]'; \
    echo 'type = htpasswd'; \
    echo 'htpasswd_filename= /conf/user'; \
    echo 'htpasswd_encryption = bcrypt'; \
    echo '[storage]'; \
    echo 'filesystem_folder = /radicale'; \
    } >> /conf/conf;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime'; \
    echo 'openssl req -new -sha384 -key "/cert/key.pem" -subj "/CN=${HOSTNAME}" -out "/cert/csr.pem"'; \
    echo 'openssl x509 -req -days 36500 -in "/cert/csr.pem" -signkey "/cert/key.pem" -out "/cert/cert.pem" &>/dev/null'; \
    echo 'sed -i "s/^\(certificate\) =.*/\1 = \/cert\/cert.pem/" /conf/conf'; \
    echo 'sed -i "s/^\(key\) =.*/\1 = \/cert\/key.pem/" /conf/conf'; \
    echo 'sed -i "s/^\(ssl\) =.*/\1 = False/" /conf/conf'; \
    echo 'if [ ${SSL,,} = "true" ]; then'; \
    echo '  sed -i "s/^\(ssl\) =.*/\1 = True/" /conf/conf'; \
    echo 'fi'; \
    echo 'sed -i "s/^\(level\) =.*/\1 = ${LOG_LEVEL}/" /conf/conf'; \
    echo 'if [ -e /conf/user ]; then'; \
    echo '  rm -f /conf/user'; \
    echo 'fi'; \
    echo 'ARRAY_USER=(`echo ${USER} | tr "," " "`)'; \
    echo 'ARRAY_PASSWORD=(`echo ${PASSWORD} | tr "," " "`)'; \
    echo 'INDEX=0'; \
    echo 'for e in ${ARRAY_USER[@]}; do'; \
    echo '  htpasswd -Bbn ${ARRAY_USER[${INDEX}]} ${ARRAY_PASSWORD[${INDEX}]} | head -c -1 >> /conf/user'; \
    echo '  ((INDEX+=1))'; \
    echo 'done'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entrypoint.sh; \
    chmod +x /usr/local/bin/entrypoint.sh;


ENV TIMEZONE Asia/Tokyo

ENV SSL true

ENV LOG_LEVEL warning

ENV USER user1,user2
ENV PASSWORD password1,password2

VOLUME /radicale

EXPOSE 5232

ENTRYPOINT ["entrypoint.sh"]
CMD ["python3.6", "-m", "radicale", "--config", "/conf/conf"]
