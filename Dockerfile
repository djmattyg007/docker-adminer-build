FROM alpine:3.5
MAINTAINER Matthew Gamble <git@matthewgamble.net>

ENV VERSION="4.2.5-patch4"

RUN apk add --update git grep php7 php7-common
RUN mkdir -p /data/compile /data/release && \
    git clone https://github.com/djmattyg007/adminer.git /data/git

WORKDIR /data/git
RUN git checkout ${VERSION} && \
    git submodule init && \
    git submodule update

COPY index.php /tmp/index.php
RUN find adminer/drivers -mindepth 1 -not -name 'mysql*' -a -not -name 'sqlite*' -a -not -name 'pgsql*' -print -delete && \
    grep -v -P '^include.*drivers\/((?!mysql|sqlite|pgsql).)+' adminer/include/bootstrap.inc.php > /tmp/bootstrap.inc.php && \
    mv /tmp/bootstrap.inc.php adminer/include/bootstrap.inc.php && \
    php7 compile.php && \
    php7 compile.php mysql && \
    php7 compile.php sqlite && \
    php7 compile.php pgsql && \
    cp plugins/plugin.php /data/compile/01.php && \
    tail -n +2 plugins/login-servers.php > /data/compile/02.php && \
    tail -n +2 plugins/table-structure.php > /data/compile/03.php && \
    tail -n +2 plugins/table-indexes-structure.php > /data/compile/04.php && \
    tail -n +2 plugins/tables-filter.php > /data/compile/05.php && \
    tail -n +2 /tmp/index.php > /data/compile/10.php

RUN cat /data/compile/*.php > /data/adminer.php && \
    echo '?>' >> /data/adminer.php && \
    cat /data/adminer.php adminer-mysql.php > /data/adminer-mysql.php && \
    cat /data/adminer.php adminer-sqlite.php > /data/adminer-sqlite.php && \
    cat /data/adminer.php adminer-pgsql.php > /data/adminer-pgsql.php && \
    cat adminer.php >> /data/adminer.php

CMD cp /data/adminer.php /data/release/adminer.php
