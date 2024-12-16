#!/usr/bin/perl
use strict;
use warnings;
use CGI::Session;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

# Función para verificar sesión
sub verify_session {
    my $session = CGI::Session->new() or die CGI::Session->errstr;

    # Si no hay sesión iniciada, redirige al login
    unless ($session->param('logged_in')) {
        print redirect(-uri => 'login_register.pl');  # Cambia a tu archivo de login
        exit;
    }

    # Retorna la sesión para obtener otros datos si es necesario
    return $session;
}

# Ejemplo de uso en una página
my $session = verify_session();  # Verifica la sesión
my $username = $session->param('username');  # Obtén datos de la sesión

print header(-charset => 'UTF-8');
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Página Protegida</title>
</head>
<body>
    <h1>Bienvenido, $username</h1>
    <p>Esta es una página protegida que solo pueden ver los usuarios logueados.</p>
    <a href="logout.pl">Cerrar sesión</a>
</body>
</html>
HTML
