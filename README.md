# docker-prelude-siem


From Docker hub 
```
$ docker run -p 8000:8000 2xyo/prelude-siem

```

From source
```
$ cd /home/yoyo/projects/
$ git clone https://github.com/2xyo/docker-prelude-siem.git
$ cd docker-prelude-siem
$ docker build -t prelude .
$ docker run -h prelude-manager.foo -d -p 8000:8000 \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/apache2:/var/log/apache2 \
    -v /home/yoyo/projects/docker-prelude-siem/data/conf:/usr/local/etc/prelude/profile/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/db:/srv/prelude/db/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/prelude:/var/log/prelude/ \
    prelude
```

Or interactive start :
```
$  docker run -h prelude-manager.foo -it -p 8000:8000  \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/apache2:/var/log/apache2 \
    -v /home/yoyo/projects/docker-prelude-siem/data/conf:/usr/local/etc/prelude/profile/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/db:/srv/prelude/db/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/prelude:/var/log/prelude/ \
    --entrypoint=/bin/bash prelude 
# /docker-entrypoint.sh
```

Then open http://127.0.0.1:8000


Clean data
```
$ sudo rm -rf ./data/db/prelude.db \
    ./data/db/prewikka.db \
    ./data/db/nodes \
    ./data/conf/prelude-manager \
    ./data/conf/prelude-correlator \ 
    ./data/conf/prelude-lml 
$ sudo echo "" > data/logs/apache2/access_log
```