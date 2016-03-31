# docker-prelude-siem

From Docker hub 
```
$ docker run -h prelude-manager.foo --name prelude -p 8000:8000 2xyo/prelude-siem

```

From source
```
$ cd /home/yoyo/projects/
$ git clone https://github.com/2xyo/docker-prelude-siem.git
$ cd docker-prelude-siem
$ docker build -t prelude .
$ docker run -h prelude-manager.foo -d --name prelude -p 8000:8000 \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/apache2:/var/log/apache2 \
    -v /home/yoyo/projects/docker-prelude-siem/data/conf:/usr/local/etc/prelude/profile/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/db:/srv/prelude/db/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/prelude:/var/log/prelude/ \
    prelude
```

Or interactive start :
```
$  docker run -h prelude-manager.foo --name prelude -it -p 8000:8000  \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/apache2:/var/log/apache2 \
    -v /home/yoyo/projects/docker-prelude-siem/data/conf:/usr/local/etc/prelude/profile/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/db:/srv/prelude/db/ \
    -v /home/yoyo/projects/docker-prelude-siem/data/logs/prelude:/var/log/prelude/ \
    --entrypoint=/bin/bash prelude 
# /docker-entrypoint.sh
```

Then open http://127.0.0.1:8000

Test prelude-lml

```
$ echo '[Sat Mar 12 22:48:24 2005] [error] [client 127.0.0.1] Directory index forbidden by rule: /var/www/sample/' >> ./data/logs/apache2/error_log
```

More logs 
```
$ docker exec prelude egrep ^#LOG /usr/local/etc/prelude-lml/ruleset/httpd.rules | awk -F'#LOG:' '{print $2}'
[Sat Mar 12 22:56:12 2005] [error] [client 127.0.0.1] File does not exist: /var/www/favicon.ico
[Sat Mar 12 22:56:13 2005] [error] [client 127.0.0.1] Premature end of script headers: /var/www/sample/index.pl
[Sat Mar 12 22:48:24 2005] [error] [client 127.0.0.1] Directory index forbidden by rule: /var/www/sample/
[Sat Mar 12 22:38:41 2005] [error] [client 127.0.0.1] client denied by server configuration: /var/www/sample/
[Sun Jan  2 22:42:47 2005] [error] [client 127.0.0.1] request failed: error reading the headers
[Sun Jan  2 23:48:19 2005] [error] [client 127.0.0.1] request failed: URI too long
[Sat Apr 16 14:30:12 2005] [error] [client ::1] File does not exist: /var/www/favicon.ico
Apr 17 12:58:51 mail httpd: OK: Pass Phrase Dialog successful.
Apr 17 12:58:48 mail httpd: Apache:mod_ssl:Error: Pass phrase incorrect (5 more retries permitted).
Apr 17 14:00:48 mail httpd: Apache:mod_ssl:Error: Pass phrase incorrect.
Apr 17 14:00:13 mail httpd: httpd shutdown succeeded
Apr 17 14:02:41 mail httpd: httpd startup succeeded
```

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