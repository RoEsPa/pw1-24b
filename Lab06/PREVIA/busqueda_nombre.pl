#!/usr/bin/perl
use strict;
use warnings;

my $archivo_csv = "Data_Universidades_LAB06.csv";

if (@ARGV != 1) {
    die "Uso: perl buscar_nombre.pl <nombre>\n";
}

my $nombre_a_buscar = $ARGV[0];

open(my $fh, '<', $archivo_csv) or die "No se puede abrir el archivo '$archivo_csv' $!";

my $encontrado = 0;
while (my $linea = <$fh>) {
    chomp $linea;
    
    if ($linea =~ /\b\Q$nombre_a_buscar\E\b/i) {
        print "Encontrado: $linea\n";
        $encontrado = 1;
    }
}

print "Nombre '$nombre_a_buscar' no encontrado.\n" unless $encontrado;

close($fh);
