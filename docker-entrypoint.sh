#!/bin/bash

/usr/local/bin/prelude-manager -d
/usr/local/bin/prelude-lml -d
/usr/bin/prelude-correlator -d 
/usr/bin/prewikka-httpd -c /etc/prewikka/prewikka.conf