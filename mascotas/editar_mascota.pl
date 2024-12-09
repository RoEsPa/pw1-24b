#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use CGI;
use JSON;

my $cgi = CGI->new;
print $cgi->header('application/json');

# Obtener datos del formulario
my $id = $cgi->param('id');
my $nombre = $cgi->param('nombre');
my $edad = $cgi->param('edad');
my $tipo = $cgi->param('tipo');
my $propietario = $cgi->param('propietario');

# Conectar a la base de datos MySQL
my $dbh = DBI->connect('dbi:mysql:mascotas_db;host=localhost', 'root', '', { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Preparar la consulta para actualizar la mascota
my $sth = $dbh->prepare("UPDATE mascotas SET nombre = ?, edad = ?, tipo = ?, propietario = ? WHERE id = ?");
$sth->execute($nombre, $edad, $tipo, $propietario, $id);

# Cerrar la conexión a la base de datos
$dbh->disconnect;

# Responder con JSON
print encode_json({ success => 1, message => "Mascota actualizada exitosamente" });
