#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp 'fatalsToBrowser';
use Text::CSV;
use utf8;

# Asegura que la salida STDOUT está en UTF-8
binmode STDOUT, ':encoding(UTF-8)';

my $archivo_csv = "Data_Universidades_LAB06.csv";

# Obtiene los parámetros del formulario
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


# Elimina guiones de las fechas para hacer coincidir el formato del CSV
$fecha_inicio =~ s/-//g;
$fecha_fin =~ s/-//g;

# Imprimimos el encabezado HTML
print header(-charset => 'utf-8');
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Búsqueda de Universidades</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Búsqueda de Universidades</h1>
        <form action="../cgi-bin/buscar_universidades.pl" method="GET" class="search-form">
            <label for="codigo_entidad">Código de Entidad:</label>
            <input type="text" id="codigo_entidad" name="codigo_entidad">

            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre">

            <label for="tipo_gestion">Tipo de Gestión:</label>
            <select id="tipo_gestion" name="tipo_gestion">
                <option value="">Seleccione un tipo de Gestión</option>
                <option value="Público">Público</option>
                <option value="Privado">Privado</option>
            </select>
            
            <label for="estado_licenciamiento">Estado de Licenciamiento:</label>
            <select id="estado_licenciamiento" name="estado_licenciamiento">
                <option value="">Seleccione un estado de Licenciamiento</option>
                <option value="Licencia denegada">Licencia denegada</option>
                <option value="Licencia otorgada">Licencia otorgada</option>
                <option value="No presentado">No presentado</option>
            </select>
            
            <label for="fecha_inicio">Fecha de Inicio de Licenciamiento:</label>
            <input type="date" id="fecha_inicio" name="fecha_inicio">

            <label for="fecha_fin">Fecha de Fin de Licenciamiento:</label>
            <input type="date" id="fecha_fin" name="fecha_fin">

            <label for="periodo_licenciamiento">Periodo de Licenciamiento:</label>
            <input type="text" id="periodo_licenciamiento" name="periodo_licenciamiento">

            <label for="departamento">Departamento:</label>
            <select id="departamento" name="departamento">
                <option value="">Seleccione un departamento</option>
                <option value="LIMA">LIMA</option>
                <option value="AYACUCHO">AYACUCHO</option>
                <option value="LA LIBERTAD">LA LIBERTAD</option>
                <option value="AREQUIPA">AREQUIPA</option>
                <option value="LORETO">LORETO</option>
                <option value="PUNO">PUNO</option>
                <option value="CAJAMARCA">CAJAMARCA</option>
                <option value="PIURA">PIURA</option>
                <option value="TACNA">TACNA</option>
                <option value="ÁNCASH">ÁNCASH</option>
                <option value="UCAYALI">UCAYALI</option>
                <option value="CUSCO">CUSCO</option>
                <option value="LAMBAYEQUE">LAMBAYEQUE</option>
                <option value="AMAZONAS">AMAZONAS</option>
                <option value="HUANCAVELICA">HUANCAVELICA</option>
                <option value="APURÍMAC">APURÍMAC</option>
                <option value="MOQUEGUA">MOQUEGUA</option>
                <option value="JUNÍN">JUNÍN</option>
                <option value="HUÁNUCO">HUÁNUCO</option>
                <option value="PASCO">PASCO</option>
                <option value="CALLAO">CALLAO</option>
                <option value="SAN MARTÍN">SAN MARTÍN</option>
                <option value="TUMBES">TUMBES</option>
                <option value="MADRE DE DIOS">MADRE DE DIOS</option>
            </select>
            
            <label for="provincia">Provincia:</label>
            <select id="provincia" name="provincia">
                <option value="">Seleccione una provincia</option>
                <option value="LIMA">LIMA</option>
                <option value="HUAMANGA">HUAMANGA</option>
                <option value="TRUJILLO">TRUJILLO</option>
                <option value="AREQUIPA">AREQUIPA</option>
                <option value="MAYNAS">MAYNAS</option>
                <option value="PUNO">PUNO</option>
                <option value="CAJAMARCA">CAJAMARCA</option>
                <option value="PIURA">PIURA</option>
                <option value="TACNA">TACNA</option>
                <option value="HUARAZ">HUARAZ</option>
                <option value="CORONEL PORTILLO">CORONEL PORTILLO</option>
                <option value="CUSCO">CUSCO</option>
                <option value="CHICLAYO">CHICLAYO</option>
                <option value="CHACHAPOYAS">CHACHAPOYAS</option>
                <option value="ANGARAES">ANGARAES</option>
                <option value="ANDAHUAYLAS">ANDAHUAYLAS</option>
                <option value="MARISCAL NIETO">MARISCAL NIETO</option>
                <option value="SAN ROMÁN">SAN ROMÁN</option>
                <option value="JAÉN">JAÉN</option>
                <option value="CHOTA">CHOTA</option>
                <option value="BARRANCA">BARRANCA</option>
                <option value="CAÑETE">CAÑETE</option>
                <option value="BAGUA">BAGUA</option>
                <option value="CHANCHAMAYO">CHANCHAMAYO</option>
                <option value="ALTO AMAZONAS">ALTO AMAZONAS</option>
                <option value="TARMA">TARMA</option>
                <option value="HUANTA">HUANTA</option>
                <option value="HUANCAYO">HUANCAYO</option>
                <option value="TAYACAJA">TAYACAJA</option>
                <option value="SÁNCHEZ CARRIÓN">SÁNCHEZ CARRIÓN</option>
                <option value="LEONCIO PRADO">LEONCIO PRADO</option>
                <option value="HUÁNUCO">HUÁNUCO</option>
                <option value="PASCO">PASCO</option>
                <option value="PROV. CONST. DEL CALLAO">PROV. CONST. DEL CALLAO</option>
                <option value="HUAURA">HUAURA</option>
                <option value="LAMBAYEQUE">LAMBAYEQUE</option>
                <option value="SAN MARTÍN">SAN MARTÍN</option>
                <option value="TUMBES">TUMBES</option>
                <option value="SANTA">SANTA</option>
                <option value="TAMBOPATA">TAMBOPATA</option>
                <option value="UTCUBAMBA">UTCUBAMBA</option>
                <option value="LA CONVENCIÓN">LA CONVENCIÓN</option>
                <option value="HUAROCHIRÍ">HUAROCHIRÍ</option>
                <option value="CHINCHA">CHINCHA</option>
            </select>
            
            <label for="distrito">Distrito:</label>
            <select id="distrito" name="distrito">
                <option value="">Seleccione un distrito</option>
                <option value="LIMA">LIMA</option>
                <option value="AYACUCHO">AYACUCHO</option>
                <option value="TRUJILLO">TRUJILLO</option>
                <option value="AREQUIPA">AREQUIPA</option>
                <option value="RÍMAC">RÍMAC</option>
                <option value="LA MOLINA">LA MOLINA</option>
                <option value="SAN MIGUEL">SAN MIGUEL</option>
                <option value="SAN JUAN BAUTISTA">SAN JUAN BAUTISTA</option>
                <option value="PUNO">PUNO</option>
                <option value="SAN MARTÍN DE PORRES">SAN MARTÍN DE PORRES</option>
                <option value="CAJAMARCA">CAJAMARCA</option>
                <option value="JESÚS MARÍA">JESÚS MARÍA</option>
                <option value="SANTIAGO DE SURCO">SANTIAGO DE SURCO</option>
                <option value="SANTA ANITA">SANTA ANITA</option>
                <option value="PIURA">PIURA</option>
                <option value="TACNA">TACNA</option>
                <option value="INDEPENDENCIA">INDEPENDENCIA</option>
                <option value="CALLERIA">CALLERIA</option>
                <option value="LURIGANCHO">LURIGANCHO</option>
                <option value="SAN JERÓNIMO">SAN JERÓNIMO</option>
                <option value="POCOLLAY">POCOLLAY</option>
                <option value="VILLA EL SALVADOR">VILLA EL SALVADOR</option>
                <option value="CHICLAYO">CHICLAYO</option>
                <option value="LOS OLIVOS">LOS OLIVOS</option>
                <option value="CHACHAPOYAS">CHACHAPOYAS</option>
                <option value="PUEBLO LIBRE">PUEBLO LIBRE</option>
                <option value="LIRCAY">LIRCAY</option>
                <option value="YARINACOCHA">YARINACOCHA</option>
                <option value="MOQUEGUA">MOQUEGUA</option>
                <option value="JULIACA">JULIACA</option>
                <option value="JAÉN">JAÉN</option>
                <option value="MAGDALENA DEL MAR">MAGDALENA DEL MAR</option>
                <option value="CHOTA">CHOTA</option>
                <option value="BARRANCA">BARRANCA</option>
                <option value="SAN VICENTE DE CAÑETE">SAN VICENTE DE CAÑETE</option>
                <option value="BAGUA">BAGUA</option>
                <option value="CHANCHAMAYO">CHANCHAMAYO</option>
                <option value="YURIMAGUAS">YURIMAGUAS</option>
                <option value="TARMA">TARMA</option>
                <option value="HUANTA">HUANTA</option>
                <option value="BARRANCO">BARRANCO</option>
                <option value="SAN JUAN DE LURIGANCHO">SAN JUAN DE LURIGANCHO</option>
                <option value="HUANCAYO">HUANCAYO</option>
                <option value="DANIEL HERNÁNDEZ">DANIEL HERNÁNDEZ</option>
                <option value="HUAMACHUCO">HUAMACHUCO</option>
                <option value="CUSCO">CUSCO</option>
                <option value="ICA">ICA</option>
                <option value="EL TAMBO">EL TAMBO</option>
                <option value="CASTILLA">CASTILLA</option>
                <option value="RUPA-RUPA">RUPA-RUPA</option>
                <option value="PILLCO MARCA">PILLCO MARCA</option>
                <option value="LINCE">LINCE</option>
                <option value="YANACANCHA">YANACANCHA</option>
                <option value="BELLAVISTA">BELLAVISTA</option>
                <option value="HUACHO">HUACHO</option>
                <option value="LAMBAYEQUE">LAMBAYEQUE</option>
                <option value="TARAPOTO">TARAPOTO</option>
                <option value="ABANCAY">ABANCAY</option>
                <option value="TUMBES">TUMBES</option>
                <option value="NUEVO CHIMBOTE">NUEVO CHIMBOTE</option>
                <option value="PIMENTEL">PIMENTEL</option>
                <option value="HUANUCO">HUANUCO</option>
                <option value="HUANCAVELICA">HUANCAVELICA</option>
                <option value="VICTOR LARCO HERRERA">VICTOR LARCO HERRERA</option>
                <option value="CHIMBOTE">CHIMBOTE</option>
                <option value="CHORRILLOS">CHORRILLOS</option>
                <option value="MOCHE">MOCHE</option>
                <option value="SULLANA">SULLANA</option>
                <option value="YANAHUARA">YANAHUARA</option>
                <option value="TIABAYA">TIABAYA</option>
                <option value="BREÑA">BREÑA</option>
                <option value="ATE">ATE</option>
                <option value="SANTA ANA">SANTA ANA</option>
                <option value="SAN ANTONIO">SAN ANTONIO</option>
                <option value="CHINCHA ALTA">CHINCHA ALTA</option>
                <option value="IQUITOS">IQUITOS</option>
                <option value="BAGUA GRANDE">BAGUA GRANDE</option>
                <option value="SAN BORJA">SAN BORJA</option>
                <option value="CALLAO">CALLAO</option>
            </select>
                            
             
            <label for="codigo_ubigeo">Código de Ubigeo:</label>
            <input type="text" id="codigo_ubigeo" name="codigo_ubigeo">

            <button type="submit">Buscar</button>
        </form>
        <div class="results">
            <h2>Resultados</h2>
            <div class="result-header">
                <div>Código de Entidad</div>
                <div>Nombre</div>
                <div>Tipo de Gestión</div>
                <div>Estado de Licenciamiento</div>
                <div>Fecha de Inicio</div>
                <div>Fecha de Fin</div>
                <div>Periodo</div>
                <div>Departamento</div>
                <div>Provincia</div>
                <div>Distrito</div>
                <div>Código de Ubigeo</div>
                <div>Ubicación</div>

            </div>
            <div class="result-body">
HTML

# Leer el archivo CSV y buscar coincidencias
my $csv = Text::CSV->new({ binary => 1 });
open my $fh, '<:encoding(UTF-8)', $archivo_csv or die "No se pudo abrir el archivo CSV: $!";

# Saltamos el encabezado
my $header = <$fh>;

while (my $row = $csv->getline($fh)) {
    # Asignar valores de cada columna a variables según la posición
    my ($cod, $nom, $tipo, $estado, $f_inicio, $f_fin, $periodo, $depto, $prov, $dist, $ubigeo, $lat, $long, $f_corte) = @$row;

    # Aplica filtros basados en los parámetros de búsqueda usando el índice del campo
    next if ($codigo_entidad && $cod ne $codigo_entidad);                 # Campo 1
    next if ($nombre && $nom !~ /\Q$nombre\E/i);                          # Campo 2
    next if ($tipo_gestion && $tipo !~ /\Q$tipo_gestion\E/i);             # Campo 3
    next if ($estado_licenciamiento && $estado !~ /\Q$estado_licenciamiento\E/i); # Campo 4
    next if ($fecha_inicio && $f_inicio ne $fecha_inicio);                # Campo 5
    next if ($fecha_fin && $f_fin ne $fecha_fin);                         # Campo 6
    next if ($periodo_licenciamiento && $periodo ne $periodo_licenciamiento); # Campo 7
    next if ($departamento && $depto !~ /\Q$departamento\E/i);            # Campo 8
    next if ($provincia && $prov !~ /\Q$provincia\E/i);                   # Campo 9
    next if ($distrito && $dist !~ /\Q$distrito\E/i);                     # Campo 10
    next if ($codigo_ubigeo && $ubigeo ne $codigo_ubigeo);                # Campo 11

    # Genera el enlace de Google Maps usando las coordenadas lat y long
    my $google_maps_link = "https://www.google.com/maps?q=$lat,$long";

    # Imprime cada fila de resultado
    print <<HTML;
    <div class="result-row">
        <div>$cod</div>
        <div>$nom</div>
        <div>$tipo</div>
        <div>$estado</div>
        <div>$f_inicio</div>
        <div>$f_fin</div>
        <div>$periodo</div>
        <div>$depto</div>
        <div>$prov</div>
        <div>$dist</div>
        <div>$ubigeo</div>
        <div><a href="$google_maps_link" target="_blank">Ver en mapa</a></div>
    </div>
HTML
}
close $fh;

# Finaliza el HTML
print <<HTML;
            </div>
        </div>
    </div>
</body>
</html>
HTML
