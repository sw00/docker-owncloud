<?php
$AUTOCONFIG = array(
  "directory"     => "/data/owncloud",
  "dbtype"        => "pgsql",
  "dbname"        => "owncloud",
  "dbuser"        => "ouser",
  "dbpassword"    => "opassword",
  "dbhost"        => getenv('DB_PORT_5432_TCP_ADDR'),
  "dbtableprefix" => "",
);
