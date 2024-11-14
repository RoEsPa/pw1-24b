#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp 'fatalsToBrowser';

# Ruta del archivo CSV
my $archivo_csv = "/ruta/al/archivo/Data_Universidades_LAB06.csv"; # Actualiza esta ruta

# Obtén los parámetros del formulario
my $codigo_entidad = param('codigo_entidad') || '';
my $nombre = param('nombre') || '';
my $tipo_gestion = param('tipo_gestion') || '';
my $estado_licenciamiento = param('estado_licenciamiento') || '';
my $fecha_inicio = param('fecha_inicio') || '';
my $fecha_fin = param('fecha_fin') || '';
my $periodo_licenciamiento = param('periodo_licenciamiento') || '';
my $departamento = param('departamento') || '';
my $provincia = param('provincia') || '';
my $distrito = param('distrito') || '';
my $codigo_ubigeo = param('codigo_ubigeo') || '';

# Convertimos las fechas a un formato sin guiones para facilitar comparaciones
$fecha_inicio =~ s/-//g;
$fecha_fin =~ s/-//g;

# Imprimimos la cabecera HTML y el formulario
print header;
print start_html(-title => "Buscar Universidades", -style => [{ -src => '../css/styles.css' }]);

print <<'HTML';
<div class="container">
    <h1>Búsqueda de Universidades</h1>
    <form method="GET" action="/cgi-bin/buscar_universidades.pl">
        <label for="codigo_entidad">Código de Entidad:</label>
        <input type="text" name="codigo_entidad" id="codigo_entidad">

        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" id="nombre">

        <label for="tipo_gestion">Tipo de Gestión:</label>
        <input type="text" name="tipo_gestion" id="tipo_gestion">

        <label for="estado_licenciamiento">Estado de Licenciamiento:</label>
        <input type="text" name="estado_licenciamiento" id="estado_licenciamiento">

        <label for="fecha_inicio">Fecha Inicio:</label>
        <input type="date" name="fecha_inicio" id="fecha_inicio">

        <label for="fecha_fin">Fecha Fin:</label>
        <input type="date" name="fecha_fin" id="fecha_fin">

        <label for="periodo_licenciamiento">Periodo de Licenciamiento:</label>
        <input type="text" name="periodo_licenciamiento" id="periodo_licenciamiento">

        <label for="departamento">Departamento:</label>
        <input type="text" name="departamento" id="departamento">

        <label for="provincia">Provincia:</label>
        <input type="text" name="provincia" id="provincia">

        <label for="distrito">Distrito:</label>
        <input type="text" name="distrito" id="distrito">

        <label for="codigo_ubigeo">Código de Ubigeo:</label>
        <input type="text" name="codigo_ubigeo" id="codigo_ubigeo">

        <button type="submit">Buscar</button>
    </form>
</div>
HTML

# Abrimos el archivo y buscamos coincidencias
print "<div class='container'>";
print "<h2>Resultados de la Búsqueda</h2>";
print "<div class='results'>";
print "<div class='result-header'>";
print "<div>Código de Entidad</div><div>Nombre</div><div>Tipo de Gestión</div><div>Estado de Licenciamiento</div><div>Fecha de Inicio</div><div>Fecha de Fin</div><div>Periodo</div><div>Departamento</div><div>Provincia</div><div>Distrito</div><div>Código de Ubigeo</div>";
print "</div>";
print "<div class='result-body'>";

open(my $fh, '<', $archivo_csv) or die "No se puede abrir el archivo '$archivo_csv': $!";
my $encontrado = 0;

while (my $linea = <$fh>) {
    chomp $linea;
    my @campos = split /,/, $linea;

    # Verificación de coincidencias
    next if $codigo_entidad && $campos[0] !~ /\Q$codigo_entidad\E/i;
    next if $nombre && $campos[1] !~ /\Q$nombre\E/i;
    next if $tipo_gestion && $campos[2] !~ /\Q$tipo_gestion\E/i;
    next if $estado_licenciamiento && $campos[3] !~ /\Q$estado_licenciamiento\E/i;
    next if $periodo_licenciamiento && $campos[6] !~ /\Q$periodo_licenciamiento\E/i;
    next if $departamento && $campos[7] !~ /\Q$departamento\E/i;
    next if $provincia && $campos[8] !~ /\Q$provincia\E/i;
    next if $distrito && $campos[9] !~ /\Q$distrito\E/i;
    next if $codigo_ubigeo && $campos[10] !~ /\Q$codigo_ubigeo\E/i;

    # Comparación de rango de fechas
    if ($fecha_inicio && $fecha_fin) {
        my $inicio_licenciamiento = $campos[4];
        my $fin_licenciamiento = $campos[5];
        $inicio_licenciamiento =~ s/-//g;
        $fin_licenciamiento =~ s/-//g;
        
        next if ($inicio_licenciamiento > $fecha_fin || $fin_licenciamiento < $fecha_inicio);
    }

    # Imprimimos la fila de resultados si hay coincidencia
    print "<div class='result-row'>";
    print "<div>$campos[0]</div><div>$campos[1]</div><div>$campos[2]</div><div>$campos[3]</div><div>$campos[4]</div><div>$campos[5]</div><div>$campos[6]</div><div>$campos[7]</div><div>$campos[8]</div><div>$campos[9]</div><div>$campos[10]</div>";
    print "</div>";
    $encontrado = 1;
}

print "<div class='result-row'>No se encontraron resultados.</div>" unless $encontrado;
print "</div>"; # Cierra result-body
print "</div>"; # Cierra results
print "</div>"; # Cierra container

print end_html;
close($fh);

