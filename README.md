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
    
    ENV SSL false
    
    ENV LOG_LEVEL warning
    
    ENV USER user1,user2  
    ENV PASSWORD password1,password2
    
    VOLUME /radicale
    
    EXPOSE 5232

## How to use
This container is supposed to be used as a backend of a reverse proxy server.  
However, it can be simply used without the reverse proxy server.

    docker run -d --name radicale \  
           -e TIMEZONE=Asia/Tokyo \  
           -e USER=user \  
           -e PASSWORD=password \  
           -p 5232:5232 \  
           takeyamajp/radicale

Please access it via `http://localhost:5232` in your browser.

## Time zone
You can use any time zone such as America/Chicago that can be used in CentOS.  

See below for zones.  
https://www.unicode.org/cldr/charts/latest/verify/zones/en.html

## Logging
Available log levels:

    debug, info, warning, error, critical

Use the following command to view the logs in real time.

    docker logs -f radicale
