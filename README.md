# radicale
[![Docker Stars](https://img.shields.io/docker/stars/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![Docker Pulls](https://img.shields.io/docker/pulls/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![](https://img.shields.io/badge/GitHub-Dockerfile-orange.svg)](https://github.com/takeyamajp/docker-radicale/blob/master/Dockerfile)
[![license](https://img.shields.io/github/license/takeyamajp/docker-radicale.svg)](https://github.com/takeyamajp/docker-radicale/blob/master/LICENSE)

This container is really easy to use and works out-of-the-box.  

    docker run -d -e SSL=false -p 5232:80 -v ~/.var/lib/radicale/collections:/radicale takeyamajp/radicale

When your server is launched, you can check that everything's OK by going to http://localhost:5232/ with your browser!

If you want to use this container with the SSL connection, You have to run it behind a reverse proxy server including a valid SSL certificate.

    FROM centos:centos7  
    MAINTAINER "Hiroki Takeyama"
    
    ENV TIMEZONE Asia/Tokyo
    
    ENV SSL true
    
    ENV LOG true  
    ENV LOG_LEVEL INFO
    
    ENV USER user  
    ENV PASSWORD password
    
    VOLUME /radicale
    
    EXPOSE 80  
    EXPOSE 443
