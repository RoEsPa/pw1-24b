#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Digest::SHA qw(sha256_hex);
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use JSON;
use utf8;
use CGI::Session;

binmode(STDIN, ":utf8");  # Establece que la entrada será en UTF-8

# Configuración de la conexión a la base de datos
my $dsn = "DBI:mysql:database=login_db;host=127.0.0.1";
my $usuario_db = "pw";
my $password_db = "rep";

# Obtener los datos del formulario
my $username = param('username');
my $password = param('password');
my $confirm_password = param('confirm_password');
my $action = param('action') || '';

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $usuario_db, $password_db, { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Iniciar la sesión CGI
my $session = CGI::Session->new() or die CGI::Session->errstr;

# Función para registrar un nuevo usuario
sub register_user {
    if ($password ne $confirm_password) {
        return { success => 0, message => "Las contraseñas no coinciden" };
    }

    # Encriptar la contraseña con SHA-256
    my $hashed_password = sha256_hex($password);

    # Insertar el nuevo usuario en la base de datos
    my $sql = "INSERT INTO usuarios (username, password) VALUES (?, ?)";
    my $sth = $dbh->prepare($sql);
    eval {
        $sth->execute($username, $hashed_password);
    };
    if ($@) {
        return { success => 0, message => "Error al registrar el usuario: $@" };
    }

    return { success => 1, message => "Registro exitoso. Ahora puedes iniciar sesión." };
}

# Función para hacer login
sub login_user {
    my $sql = "SELECT id, username, password FROM usuarios WHERE username = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($username);

    # Verificar si el usuario existe
    my $row = $sth->fetchrow_hashref;
    unless ($row) {
        return { success => 0, message => "Usuario no encontrado" };
    }

    # Verificar la contraseña encriptada
    my $hashed_input = sha256_hex($password);
    if ($hashed_input eq $row->{password}) {
        $session->param('logged_in', 1);
        $session->param('username', $username);
        $session->param('user_id', $row->{id});

        return { success => 1, message => "Login exitoso" };
    } else {
        return { success => 0, message => "Contraseña incorrecta" };
    }
}

# Procesar la solicitud
my $response = {};
if ($action eq 'login') {
    $response = login_user();
    if ($response->{success}) {
        # Redirigir si el login fue exitoso
        print redirect(-uri => 'panel.pl');  # Cambia 'panel.pl' por tu página de destino
        exit;
    }
} elsif ($action eq 'register') {
    $response = register_user();
} else {
    $response = { message => "Acción no válida: $action" };
}

# Generar el HTML y mostrar el mensaje en la página
print header('text/html');
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="container">
HTML
    my $message = $response->{message} || '';
print <<HTML;
<div id="notification" class="notification">
    <p id="notification-message">$message</p>
</div>
HTML
print <<HTML;
        <div class="form-box">
            <form id="loginForm" action="../cgi-bin/login_register.pl" method="POST" class="loginForm">
                <h2>Login</h2>
                <div class="input-box">
                    <input type="text" name="username" required>
                    <label>Username</label>
                    <i class='bx bxs-user'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="password" required>
                    <label>Password</label>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <button class="btn" type="submit" name="action" value="login">Sign In</button>
                <div class="account-creation">
                    <span>Don't have an account? <a href="#" class="registerLink">Register</a></span>
                </div>
            </form>

            <form id="registerForm" action="../cgi-bin/login_register.pl" method="POST" class="registerForm">
                <h2>Register</h2>
                <div class="input-box">
                    <input type="text" name="username" required>
                    <label>Username</label>
                    <i class='bx bxs-user'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="password" required>
                    <label>Password</label>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="confirm_password" required>
                    <label>Confirm Password</label>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <button class="btn" type="submit" name="action" value="register">Sign Up</button>
                <div class="account-creation">
                    <span>Already have an account? <a href="#" class="loginLink">Login</a></span>
                </div>
            </form>
        </div>
    </div>

    <script src="../js/login.js"></script>
</body>
</html>
HTML