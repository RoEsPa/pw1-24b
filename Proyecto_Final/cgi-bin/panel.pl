#!/usr/bin/perl
use strict;
use warnings;
use utf8;                # Permite manejar caracteres Unicode como la ñ
use open ':std', ':encoding(UTF-8)';  # Configura la entrada/salida en UTF-8
use Text::CSV;

# Ruta al archivo CSV con la lista de docentes
my $csv_file = '../data/Lista.csv';

# Crear un objeto CSV para procesar el archivo
my $csv = Text::CSV->new({
    sep_char  => ',',
    eol       => $/,      # Maneja distintos saltos de línea
    binary    => 1,       # Soporta caracteres especiales
    auto_diag => 1,       # Imprime errores si los encuentra
});

# Abrimos el archivo CSV con codificación UTF-8
open my $fh, '<:encoding(UTF-8)', $csv_file or die "No se pudo abrir el archivo '$csv_file': $!";

# Leer la cabecera (ignoramos)
$csv->getline($fh);

# Array para almacenar los docentes
my @professors;

# Leemos el archivo CSV línea por línea
while (my $row = $csv->getline($fh)) {
    # Eliminar espacios adicionales de cada valor
    my ($id, $name, $image) = map { s/^\s+|\s+$//gr } @$row;

    # Solo agregar filas válidas
    if (defined $id && defined $name && defined $image) {
        push @professors, { id => $id, name => $name, image => $image };
    } else {
        warn "Fila inválida: ", join(", ", @$row), "\n";
    }
}

# Cerramos el archivo CSV
close $fh;

# Imagen predeterminada si no existe la imagen del docente
my $default_image = "Docentes/default.png";

# Imprimir el inicio del HTML
print "Content-Type: text/html; charset=UTF-8\n\n"; # Encabezado correcto para UTF-8
print <<'HTML';
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encuesta a Docentes</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <header class="header">
        <a href="https://www.unsa.edu.pe" target="_blank">
            <img src="../galery/pagina/panel/logo-unsa.png" alt="Logo UNSA" class="logo">
        </a>
        <div class="overlay">
            <h1>ENCUESTA A DOCENTES</h1>
        </div>
    </header>

    <div class="container">
        <div class="professors-grid">
HTML

# Bucle para generar cada tarjeta de profesor
foreach my $prof (@professors) {
    # Verificar si la imagen existe, si no usar imagen por defecto
    my $image_path = -e "$prof->{image}" ? "$prof->{image}" : $default_image;

    print <<HTML;
            <div class="professor-card">
                <a href="cgi/encuesta.cgi?docente=$prof->{id}">
                    <img src="$image_path" alt="$prof->{name}" class="professor-image">
                </a>
                <p>$prof->{name}</p>
            </div>
HTML
}

# Imprimir el cierre del HTML
print <<'HTML';
        </div>
    </div>
</body>
</html>
HTML
