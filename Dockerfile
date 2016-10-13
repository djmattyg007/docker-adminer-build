FROM alpine:3.4
MAINTAINER Matthew Gamble <git@matthewgamble.net>

ENV VERSION="4.2.5-patch2"

RUN apk add --update git php5 php5-common
RUN mkdir -p /data/compile /data/release && \
    git clone https://github.com/djmattyg007/adminer.git /data/git

WORKDIR /data/git
RUN git checkout ${VERSION} && \
    git submodule init && \
    git submodule update

COPY index.php /tmp/index.php
RUN php compile.php mysql && \
    cp plugins/plugin.php /data/compile/01.php && \
    tail -n +2 plugins/login-servers.php > /data/compile/02.php && \
    tail -n +2 plugins/table-structure.php > /data/compile/03.php && \
    tail -n +2 plugins/table-indexes-structure.php > /data/compile/04.php && \
    tail -n +2 plugins/tables-filter.php > /data/compile/05.php && \
    tail -n +2 /tmp/index.php > /data/compile/10.php

RUN cat /data/compile/*.php > /data/adminer.php && \
    echo '?>' >> /data/adminer.php && \
    cat adminer-mysql.php >> /data/adminer.php

CMD cp /data/adminer.php /data/release/adminer.php
