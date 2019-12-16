# radicale
[![Docker Stars](https://img.shields.io/docker/stars/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![Docker Pulls](https://img.shields.io/docker/pulls/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![license](https://img.shields.io/github/license/takeyamajp/docker-radicale.svg)](https://github.com/takeyamajp/docker-radicale/blob/master/LICENSE)

### Supported tags and respective Dockerfile links  
- [`latest`, `centos8`](https://github.com/takeyamajp/docker-radicale/blob/master/centos8/Dockerfile)
- [`centos7`](https://github.com/takeyamajp/docker-radicale/blob/master/centos7/Dockerfile)

### Image summary
    FROM centos:centos8  
    MAINTAINER "Hiroki Takeyama"
    
    ENV TIMEZONE Asia/Tokyo
    
    ENV SSL true
    
    ENV LOG true  
    ENV LOG_LEVEL INFO
    
    ENV USER user1,user2  
    ENV PASSWORD password1,password2
    
    VOLUME /radicale
    
    EXPOSE 80  
    EXPOSE 443
