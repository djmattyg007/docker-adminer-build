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

To get the custom version of adminer.php, run this:
docker run --rm=true -v /tmp:/data/release djmattyg007/adminer-build:${VERSION}
