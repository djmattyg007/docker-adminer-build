adminer-build

This Dockerfile builds a custom version of the Adminer database management tool.
It includes all of my custom patches (which you can find at my github repository,
linked below), as well as the latest bugfixes from upstream, and an advanced
table search plugin.

The following plugins will be active by default:

- Extended table structure output
- Extended table indexes structure output
- Advanced table list filter

Additionally, the Login servers plugin will be activated if a file named
"servers.json" is in the same folder as adminer.php, or if the path to a JSON
config file is passed through the SERVERS_JSON_FILE environment variable.

There are currently four builds of Adminer built by this Dockerfile: one with
support for MySQL, SQLite and PostgreSQL, and one each with support for just
an individual engine.

To get the build of Adminer with support for all three engines, run this:
docker run --rm=true -v /tmp:/data/release djmattyg007/adminer-build:${VERSION}

To get the build of Adminer with support for a specific engine, run this:
docker run --rm=true -v /tmp:/data/release djmattyg007/adminer-build:${VERSION} cp /data/adminer-${ENGINE}.php /data/release/adminer-${ENGINE}.php
Where ${ENGINE} is one of "mysql", "sqlite" or "pgsql".

Adminer is built using this repository:
https://github.com/djmattyg007/adminer
