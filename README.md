# aria2-with-webui

```bash
sudo docker run -d \
--name aria2-with-webui \
-p 6800:6800 \
-p 6880:80 \
-p 6888:8080 \
-p 60000:60000 \
-v DATA_DIR:/data \
-v CONF_DIR:/conf \
-e SECRET=SECRET \
-e TRACKERS_URL=https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt \
popo1221/aria2-with-webui
```
