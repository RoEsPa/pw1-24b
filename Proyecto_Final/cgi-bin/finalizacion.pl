#!/usr/bin/perl
use CGI;
use DBI;
use strict;
use warnings;
use Text::CSV;
use CGI::Carp qw(fatalsToBrowser);
use open ':std', ':encoding(UTF-8)';  # Configura la entrada/salida en UTF-8

use utf8;


# Crear el objeto CGI
my $q = CGI->new;

# Ruta al archivo CSV
my $csv_file = "/var/www/html/data/Lista.csv";

# Crear objeto CSV
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

# Abrir archivo CSV
open my $fh, "<", $csv_file or die "No se puede abrir el archivo $csv_file: $!";

# Leer las filas del archivo CSV
my @professors;
while (my $row = $csv->getline($fh)) {
    my ($id, $name, $image) = @$row;
    push @professors, { id => $id, name => $name, image => $image };
}
close $fh;

# Conectar a la base de datos
my $dsn = "DBI:mysql:login_db:localhost";
my $username = "root";
my $password = "rep";
my $dbh = DBI->connect($dsn, $username, $password, { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Consulta para obtener las puntuaciones de la tabla correcta
my $sth = $dbh->prepare("SELECT id_profesor, 
                                AVG((calidad_ensenanza + recomendacion + descripcion_clases + probabilidad_extra) / 4) AS avg_score
                         FROM encuestas
                         GROUP BY id_profesor");
$sth->execute();  # Se añadió el punto y coma aquí

# Almacenar las puntuaciones en un hash
my %scores;
while (my $row = $sth->fetchrow_hashref) {
    $scores{$row->{id_profesor}} = $row->{avg_score};  # Se corrigió 'professor_id' a 'id_profesor'
}

# Mostrar la página HTML
print $q->header(-type => 'text/html', -charset => 'UTF-8');
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados Encuesta de Profesores</title>
    <link rel="stylesheet" href="../css/style_p.css">
</head>
<body>
        <!-- Aquí está el logout en la parte superior derecha -->
<div class="logout-container">
    <a href="/cgi-bin/logout.pl">
        <i class="bx bx-log-out" style="font-size: 24px; color: #000;"></i>
    </a>
</div>

    <div class="container">
        <div class="form-box">
            <h2>Resultados de los Profesores</h2>
            <div class="professor-list">
HTML

# Mostrar los profesores con sus puntuaciones
foreach my $prof (@professors) {
    my $id = $prof->{id};
    my $name = $prof->{name};
    my $image = $prof->{image};
    my $score = $scores{$id} // "No disponible";  # Si no tiene puntuación, mostrar "No disponible"
    
    print <<HTML;
                <div class="professor">
                    <img src="$image" alt="$name">
                    <div class="info">
                        <h3>$name</h3>
                        <p>Puntuación: <strong>$score/5</strong></p>
                    </div>
                </div>
HTML
}

print <<HTML;
            </div>
        </div>
    </div>

</body>
</html>
HTML
