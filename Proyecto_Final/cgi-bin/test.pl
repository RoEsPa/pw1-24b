#!/usr/bin/perl
use strict;
use warnings;
use Crypt::Argon2;

# Definir una contraseña para encriptar
my $password = 'test_grande';

# Encriptar la contraseña usando Argon2
my $hashed_password = Crypt::Argon2::argon2id_pass($password, salt_size => 16, time_cost => 2, memory_cost => 1024);

# Imprimir el hash generado
print "Contraseña original: $password\n";
print "Contraseña cifrada con Argon2: $hashed_password\n";

# Verificar la contraseña
if (Crypt::Argon2::argon2id_verify($password, $hashed_password)) {
    print "La contraseña coincide.\n";
} else {
    print "La contraseña NO coincide.\n";
}
