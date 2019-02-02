# radicale
[![Docker Stars](https://img.shields.io/docker/stars/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![Docker Pulls](https://img.shields.io/docker/pulls/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![](https://img.shields.io/badge/GitHub-Dockerfile-orange.svg)](https://github.com/takeyamajp/docker-radicale/blob/master/Dockerfile)
[![license](https://img.shields.io/github/license/takeyamajp/docker-radicale.svg)](https://github.com/takeyamajp/docker-radicale/blob/master/LICENSE)

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
