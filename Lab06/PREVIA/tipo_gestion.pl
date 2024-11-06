#!/usr/bin/perl
use strict;
use warnings;

my $archivo_csv = "Data_Universidades_LAB06.csv";

if (@ARGV != 1) {
    die "Uso: perl buscar_tipo_gestion.pl <tipo de gestion>\n";
}

my $tipo_gestion_a_buscar = $ARGV[0];

open(my $fh, '<', $archivo_csv) or die "No se puede abrir el archivo '$archivo_csv' $!";

my $encontrado = 0;
while (my $linea = <$fh>) {
    chomp $linea;
    my @campos = split /,/, $linea;
    if (defined $campos[2] && $campos[2] =~ /\b\Q$tipo_gestion_a_buscar\E\b/i) {
        print "Encontrado: $linea\n";
        $encontrado = 1;
    }
}

print "Tipo de gestión '$tipo_gestion_a_buscar' no encontrado.\n" unless $encontrado;

close($fh);

