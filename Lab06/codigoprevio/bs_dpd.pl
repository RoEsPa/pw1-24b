#!/usr/bin/perl
use strict;
use warnings;

my $archivo_csv = "Data_Universidades_LAB06.csv";

if (@ARGV != 3) {
    die "Uso: perl buscar_ubicacion.pl <departamento> <provincia> <distrito>\n";
}

my ($departamento_a_buscar, $provincia_a_buscar, $distrito_a_buscar) = @ARGV;

open(my $fh, '<', $archivo_csv) or die "No se puede abrir el archivo '$archivo_csv' $!";

my $encontrado = 0;
while (my $linea = <$fh>) {
    chomp $linea;
    my @campos = split /,/, $linea;

    if (defined $campos[7] && defined $campos[8] && defined $campos[9] &&
        $campos[7] =~ /\b\Q$departamento_a_buscar\E\b/i &&
        $campos[8] =~ /\b\Q$provincia_a_buscar\E\b/i &&
        $campos[9] =~ /\b\Q$distrito_a_buscar\E\b/i) {
        
        print "Encontrado: $linea\n";
        $encontrado = 1;
    }
}

print "No se encontraron registros para la ubicación especificada.\n" unless $encontrado;

close($fh);
