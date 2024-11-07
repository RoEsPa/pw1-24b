#!/usr/bin/perl
use strict;
use warnings;

my $archivo_csv = "Data_Universidades_LAB06.csv";

# Verificamos que se hayan proporcionado ambas fechas
if (@ARGV != 2) {
    die "Uso: perl buscar_licenciamiento.pl <fecha_inicio> <fecha_fin>\n";
}

my ($fecha_inicio, $fecha_fin) = @ARGV;

# Convertimos las fechas a formato comparable
$fecha_inicio =~ s/-//g;
$fecha_fin =~ s/-//g;

open(my $fh, '<', $archivo_csv) or die "No se puede abrir el archivo '$archivo_csv' $!";

my $encontrado = 0;
while (my $linea = <$fh>) {
    chomp $linea;
    my @campos = split /,/, $linea;

    # Verificamos que ambas fechas de licenciamiento estén definidas
    if (defined $campos[4] && defined $campos[5]) {
        my $inicio_licenciamiento = $campos[4];
        my $fin_licenciamiento = $campos[5];

        # Convertimos las fechas de licenciamiento a formato comparable
        $inicio_licenciamiento =~ s/-//g;
        $fin_licenciamiento =~ s/-//g;

        # Comprobamos si hay una superposición en el rango de fechas
        if ($inicio_licenciamiento <= $fecha_fin && $fin_licenciamiento >= $fecha_inicio) {
            print "Encontrado: $linea\n";
            $encontrado = 1;
        }
    }
}

print "No se encontraron registros dentro del rango de fechas especificado.\n" unless $encontrado;

close($fh);
