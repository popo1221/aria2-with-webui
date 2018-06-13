FROM alpine:latest

MAINTAINER po1221 <popo1221@outlook.com>

RUN mkdir -p /conf && \
mkdir -p /conf-copy && \
mkdir -p /data && \
apk update && \
apk add --no-cache --update aria2 && \
apk add curl && \
curl -L https://codeload.github.com/ziahamza/webui-aria2/zip/master -o /tmp/webui-aria2-master.zip && \
unzip /tmp/webui-aria2-master.zip -d / && \
rm /tmp/webui-aria2-master.zip && \
apk add --update darkhttpd

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/dht.dat /conf-copy/dht.dat
ADD files/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh

WORKDIR /

VOLUME ["/data"]
VOLUME ["/conf"]

EXPOSE 6800
EXPOSE 80
EXPOSE 8080
EXPOSE 60000

CMD ["/conf-copy/start.sh"]