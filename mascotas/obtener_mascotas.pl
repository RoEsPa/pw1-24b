#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use DBI;
use JSON;

# Conectar a la base de datos SQLite
my $dbh = DBI->connect('dbi:SQLite:dbname=/var/cgi-bin/mascotas.db', '', '', { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Obtener las mascotas
my $sth = $dbh->prepare("SELECT id, nombre, edad, tipo, propietario FROM mascotas");
$sth->execute();

# Crear la respuesta en JSON
my @mascotas;
while (my @row = $sth->fetchrow_array) {
    push @mascotas, { id => $row[0], nombre => $row[1], edad => $row[2], tipo => $row[3], propietario => $row[4] };
}

# Devolver en formato JSON
print "Content-type: application/json\n\n";
print encode_json(\@mascotas);

# Cerrar la conexión a la base de datos
$dbh->disconnect;
