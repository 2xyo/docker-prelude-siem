#!/bin/bash

if [ ! -f "/srv/prelude/db/nodes" ]; then 
    echo "First start" && \
    cat /usr/local/share/libpreludedb/classic/sqlite.sql |sqlite3 /srv/prelude/db/prelude.db && \
    sqlite3 /srv/prelude/db/prewikka.db ".databases" && \
    prelude-admin add prelude-manager --uid 0 --gid 0 && \
    source /opt/nodes.sh && \
    touch /srv/prelude/db/nodes && \
    echo "End First start"; 
fi

/usr/local/bin/prelude-manager -d
/usr/local/bin/prelude-lml -d
/usr/bin/prelude-correlator -d 
/usr/bin/prewikka-httpd -c /etc/prewikka/prewikka.conf