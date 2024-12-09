#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use JSON;
use DBI;

# Conectar a la base de datos SQLite
my $dbh = DBI->connect('dbi:SQLite:dbname=/var/cgi-bin/mascotas.db', '', '', { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Obtener datos del formulario
my $cgi = CGI->new();
my $nombre = $cgi->param('nombre');
my $edad = $cgi->param('edad');
my $tipo = $cgi->param('tipo');
my $propietario = $cgi->param('propietario');

# Insertar en la base de datos
my $sth = $dbh->prepare("INSERT INTO mascotas (nombre, edad, tipo, propietario) VALUES (?, ?, ?, ?)");
$sth->execute($nombre, $edad, $tipo, $propietario);

# Responder con JSON
print $cgi->header('application/json');
print encode_json({ status => 'success' });

# Cerrar la conexión a la base de datos
$dbh->disconnect;
