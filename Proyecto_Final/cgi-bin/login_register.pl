#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Crypt::Bcrypt qw(bcrypt);
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use JSON;

# Configuración de la conexión a la base de datos
my $dsn = "DBI:mysql:login_db:localhost";
my $usuario_db = "root";
my $password_db = "rep";

# Obtener los datos del formulario
my $username = param('username');
my $password = param('password');
my $confirm_password = param('confirm_password');
my $action = param('action');

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $usuario_db, $password_db, { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Función para registrar un nuevo usuario
sub register_user {
    if ($password ne $confirm_password) {
        return { message => "Las contraseñas no coinciden" };
    }

    # Hashear la contraseña
    my $hashed_password = bcrypt($password);

    # Insertar el nuevo usuario en la base de datos
    my $sql = "INSERT INTO usuarios (username, password) VALUES (?, ?)";
    my $sth = $dbh->prepare($sql);
    $sth->execute($username, $hashed_password);

    return { message => "Registro exitoso. Ahora puedes iniciar sesión." };
}

# Función para hacer login
sub login_user {
    my $sql = "SELECT id, username, password FROM usuarios WHERE username = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($username);

    # Verificar si el usuario existe
    my $row = $sth->fetchrow_hashref;
    unless ($row) {
        return { message => "Usuario no encontrado" };
    }

    # Verificar la contraseña encriptada
    if (bcrypt($password, $row->{password})) {
        return { message => "Login exitoso" };
    } else {
        return { message => "Contraseña incorrecta" };
    }

    ############################
}

# Determinar qué acción se realiza
my $response;
if ($action eq 'register') {
    $response = register_user();
} elsif ($action eq 'login') {
    $response = login_user();
} else {
    $response = { message => "Acción no válida" };
}

# Devolver respuesta en formato JSON
print header('application/json');
print to_json($response);
