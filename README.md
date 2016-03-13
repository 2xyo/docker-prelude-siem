# docker-prelude-siem


From Docker hub 
```
$ docker run -p 8000:8000 2xyo/prelude-siem

```

From source
```
$ git clone https://github.com/2xyo/docker-prelude-siem.git
$ cd docker-prelude-siem
$ docker build -t prelude .
$ docker run -d -p 8000:8000 prelude
```
Interactive start :
```
$  docker run -it -p 8000:8000  -v /<local>/var/logs/apache2:/var/log/apache2 --entrypoint=/bin/bash prelude 
# /docker-entrypoint.sh
```
