#!/usr/bin/perl

use strict;
use warnings;
use DBI;

# Crear conexión a SQLite
my $dbh = DBI->connect("dbi:SQLite:dbname=/var/cgi-bin/mascotas.db", "", "", { RaiseError => 1, AutoCommit => 1 });

# Crear tabla de mascotas
$dbh->do("CREATE TABLE IF NOT EXISTS mascotas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    edad INTEGER NOT NULL,
    tipo TEXT NOT NULL,
    propietario TEXT NOT NULL
)");

print "Base de datos creada correctamente\n";
$dbh->disconnect;
