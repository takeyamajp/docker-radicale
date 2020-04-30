# radicale
[![Docker Stars](https://img.shields.io/docker/stars/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![Docker Pulls](https://img.shields.io/docker/pulls/takeyamajp/radicale.svg)](https://hub.docker.com/r/takeyamajp/radicale/)
[![license](https://img.shields.io/github/license/takeyamajp/docker-radicale.svg)](https://github.com/takeyamajp/docker-radicale/blob/master/LICENSE)

### Supported tags and respective Dockerfile links  
- [`latest`, `centos8` (In trouble with Docker Hub)](https://github.com/takeyamajp/docker-radicale/blob/master/centos8/Dockerfile)
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

## How to use
This container is supposed to be used as a backend of a reverse proxy server.  
However, it can be simply used without the reverse proxy server.

    docker run -d --name radicale \  
           -e TIMEZONE=Asia/Tokyo \  
           -e SSL=false \  
           -e USER=user \  
           -e PASSWORD=password \  
           -p 8080:80 \  
           takeyamajp/radicale

Please access it via `http://localhost:8080` in your browser.

## Time zone
You can use any time zone such as America/Chicago that can be used in CentOS.  

See below for zones.  
https://www.unicode.org/cldr/charts/latest/verify/zones/en.html

## Logging
Use the following command to view the logs in real time.

    docker logs -f radicale
