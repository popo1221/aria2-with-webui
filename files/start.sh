#!/bin/sh
if [ ! -f /conf/aria2.conf ]; then
	cp /conf-copy/aria2.conf /conf/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /conf/aria2.conf
	fi
fi
if [ $TRACKERS_URL ]; then
    trackers=`curl -L ${TRACKERS_URL}`
    trackers=`echo ${trackers} | sed 's/\ /;/g'`
    sed -i '/bt-tracker/d' /conf/aria2.conf
    echo "bt-tracker=${trackers}" >> /conf/aria2.conf
    echo >> /conf/aria2.conf
fi
if [ ! -f /conf/dht.dat ]; then
	cp /conf-copy/dht.dat /conf/dht.dat
fi
if [ ! -f /conf/on-complete.sh ]; then
	cp /conf-copy/on-complete.sh /conf/on-complete.sh
fi

chmod +x /conf/on-complete.sh
touch /conf/aria2.session

darkhttpd /webui-aria2-master --port 80 &
darkhttpd /data --port 8080 &
aria2c --conf-path=/conf/aria2.conf --dht-file-path=/conf/dht.dat 

