FROM centos:centos7
MAINTAINER "Hiroki Takeyama"

# python
RUN yum -y install epel-release; \
    yum -y install python36 mod_ssl; \
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
    echo 'certificate = /etc/pki/tls/certs/localhost.crt'; \
    echo 'key = /etc/pki/tls/private/localhost.key'; \
    echo 'protocol = PROTOCOL_TLSv1_2'; \
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
    echo 'rm -f /etc/localtime'; \
    echo 'ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime'; \
    echo 'sed -i "s/^\(ssl\) =.*/\1 = False/" /conf/conf'; \
    echo 'sed -i "s/^\(hosts.*\):.*/\1:80/" /conf/conf'; \
    echo 'if [ ${SSL,,} = "true" ]; then'; \
    echo '  sed -i "s/^\(ssl\) =.*/\1 = True/" /conf/conf'; \
    echo '  sed -i "s/^\(hosts.*\):.*/\1:443/" /conf/conf'; \
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

ENV USER user
ENV PASSWORD password

VOLUME /radicale

EXPOSE 80
EXPOSE 443

CMD ["python3.6", "-m", "radicale", "--config", "/conf/conf"]
