#!/usr/bin/php
<?php

$host=getenv('MYSQL_HOST');
$port=getenv('MYSQL_PORT');
$pass=getenv('MYSQL_ROOT_PASSWORD');
$db=getenv('MYSQL_DATABASE');
$user="root";

$mysqli = @ new mysqli($host, $user, $pass, $db, $port);

if ($mysqli->connect_errno) {
    printf("Connect failed: %s\n", $mysqli->connect_error);
    exit();
}

if ($mysqli->ping()) {
    printf('1');
} else {
    printf('0');
}

$mysqli->close();

?>
