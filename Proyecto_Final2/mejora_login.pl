#!/usr/bin/perl

use strict;
use warnings;
use CGI qw(:standard);
use DBI;
use XML::Simple;

# Encabezado XML
print header('application/xml');
print "<?xml version='1.0' encoding='utf-8'?>\n";

# Obtener parámetros CGI
my $query  = CGI->new();
my $user   = $query->param('user');
my $passwd = $query->param('password');

# Respuesta inicial
my $response = {};

# Validación de entrada
if ( !$user || !$passwd ) {
    $response = {
        status  => 'error',
        message => 'Parámetros incompletos: user y password son requeridos'
    };
    print XMLout($response);
    exit;
}

# Configuración de conexión a la base de datos
my $dsn      = "DBI:mysql:database=nombre_base;host=localhost";
my $db_user  = "usuario";
my $db_pass  = "contraseña";

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { RaiseError => 1, PrintError => 0 });

eval {
    # Preparar consulta para obtener la contraseña del usuario
    my $sth = $dbh->prepare("SELECT password FROM Users WHERE userName = ?");
    $sth->execute($user);
    my ($stored_password) = $sth->fetchrow_array();

    # Verificar contraseña
    if ( defined $stored_password && $stored_password eq $passwd ) {
        $response = { status => 'success' };
    } else {
        $response = {
            status  => 'error',
            message => 'Usuario o contraseña incorrectos'
        };
    }
    $sth->finish();
};

# Captura de errores de la base de datos
if ($@) {
    $response = {
        status  => 'error',
        message => 'Error del servidor: ' . $@
    };
}

# Cerrar conexión
$dbh->disconnect();

# Generar salida XML
print XMLout($response);
