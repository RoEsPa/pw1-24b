#!/usr/bin/perl
use strict;
use warnings;
use CGI::Session;
use CGI qw(:standard);

# Iniciar sesión existente
my $session = CGI::Session->new() or die CGI::Session->errstr;

# Eliminar la sesión
$session->delete();
$session->flush();

# Redirigir al usuario a la página de login
print redirect(-uri => 'login_register.pl');
