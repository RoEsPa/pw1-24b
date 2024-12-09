#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use CGI;
use JSON;

my $cgi = CGI->new;
print $cgi->header('application/json');

# Obtener el ID de la mascota a eliminar
my $id = $cgi->param('id');

# Conectar a la base de datos MySQL
my $dbh = DBI->connect('dbi:mysql:mascotas_db;host=localhost', 'root', '', { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Preparar la consulta para eliminar la mascota
my $sth = $dbh->prepare("DELETE FROM mascotas WHERE id = ?");
$sth->execute($id);

# Cerrar la conexión a la base de datos
$dbh->disconnect;

# Responder con JSON
print encode_json({ success => 1, message => "Mascota eliminada exitosamente" });
