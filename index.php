<?php
function adminer_object() {
    $plugins = array(
        new AdminerTableStructure,
        new AdminerTableIndexesStructure,
        new AdminerTablesFilter,
    );

    $loginServersFilename = !empty($_SERVER["SERVERS_JSON_FILE"]) ? $_SERVER["SERVERS_JSON_FILE"] : "servers.json";
    if (file_exists($loginServersFilename)) {
        $plugins[] = new AdminerLoginServers($loginServersFilename);
    }

    return new AdminerPlugin($plugins);
}
