FROM centos:centos7

MAINTAINER 2xyo

# No RPM for Centos 7 :/

ARG PRELUDE_VERSION
ENV PRELUDE_VERSION ${PRELUDE_VERSION:-1.2.6}

RUN mkdir -p /opt/prelude-src

WORKDIR /opt/prelude-src

RUN curl https://www.prelude-siem.org/attachments/download/408/libpreludedb-${PRELUDE_VERSION}.tar.gz | tar xz && \
    curl https://www.prelude-siem.org/attachments/download/409/prelude-correlator-${PRELUDE_VERSION}.tar.gz | tar xz && \
    curl https://www.prelude-siem.org/attachments/download/410/libprelude-${PRELUDE_VERSION}.tar.gz | tar xz && \
    curl https://www.prelude-siem.org/attachments/download/411/prelude-lml-${PRELUDE_VERSION}.tar.gz | tar xz && \
    curl https://www.prelude-siem.org/attachments/download/412/prelude-lml-rules-${PRELUDE_VERSION}.tar.gz | tar xz && \
    curl https://www.prelude-siem.org/attachments/download/413/prewikka-${PRELUDE_VERSION}.tar.gz | tar xz && \
    curl https://www.prelude-siem.org/attachments/download/414/prelude-manager-${PRELUDE_VERSION}.tar.gz | tar xz

RUN ls -alh *

RUN yum -y update 

RUN yum -y install gcc \
    libgcrypt-devel \
    gnutls-devel \
    gcc-c++ \
    pcre-devel \
    python-devel \
    lua-devel \
    sqlite-devel \
    gettext


RUN curl https://bootstrap.pypa.io/get-pip.py | python 

RUN pip install lesscpy cheetah python-dateutil Babel

WORKDIR /opt/prelude-src/libprelude-${PRELUDE_VERSION}
RUN ./configure --with-python2 --with-lua-config && \
    make -j$(nproc) && \
    make install && \
    /sbin/ldconfig /usr/local/lib

WORKDIR /opt/prelude-src/libpreludedb-${PRELUDE_VERSION}
RUN ./configure --with-sqlite3 && \
    make -j$(nproc) && \
    make install && \
    /sbin/ldconfig /usr/local/lib

WORKDIR /opt/prelude-src/prelude-manager-${PRELUDE_VERSION}
RUN ./configure && \
    make -j$(nproc) && \
    make install

WORKDIR /opt/prelude-src/prelude-correlator-${PRELUDE_VERSION}
RUN python setup.py install

WORKDIR /opt/prelude-src/prelude-lml-${PRELUDE_VERSION}
RUN ./configure && \
    make -j$(nproc) && \
    make install


WORKDIR /opt/prelude-src/prewikka-${PRELUDE_VERSION}
RUN python setup.py install

RUN mkdir -p /srv/prelude/db 
COPY prewikka.conf /etc/prewikka/

RUN sqlite3 /srv/prelude/db/prelude.db ".databases" && \
    sqlite3 /srv/prelude/db/prewikka.db ".databases"

EXPOSE 8000

ENTRYPOINT ["/usr/bin/prewikka-httpd"]
