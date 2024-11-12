#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use File::Basename;
use File::Path qw(make_path);

# Crear un objeto CGI
my $cgi = CGI->new;

# Obtener la URL del video desde el formulario
my $video_url = $cgi->param('video-url');

# Validar que la URL no esté vacía
if (!$video_url) {
    print $cgi->header(-type => 'text/html', -status => '400 Bad Request');
    print "<h1>Error: La URL es obligatoria.</h1>";
    exit;
}

# Definir la ruta donde se guardarán los archivos descargados
my $download_dir = "../archivos/";

# Crear el directorio de archivos si no existe
make_path($download_dir) unless -d $download_dir;

# Obtener el nombre del archivo del video desde la URL
my $file_name = basename($video_url);

# Establecer la ruta completa para guardar el archivo descargado
my $file_path = $download_dir . $file_name;

# Usar yt-dlp para descargar el video
my $download_command = "yt-dlp -o '$file_path' $video_url";
my $download_status = system($download_command);

# Verificar si la descarga fue exitosa
if ($download_status == 0) {
    print $cgi->header(-type => 'text/html', -status => '200 OK');
    print "<h1>Video descargado con éxito: $file_name</h1>";
} else {
    print $cgi->header(-type => 'text/html', -status => '500 Internal Server Error');
    print "<h1>Error al descargar el video.</h1>";
}
# Obtener la configuración seleccionada desde el formulario
my $config_name = $cgi->param('config-name');
my $input_format = $cgi->param('input-format');
my $output_format = $cgi->param('output-format');
my $video_resolution = $cgi->param('video-resolution');
my $video_bitrate = $cgi->param('video-bitrate');
my $video_codec = $cgi->param('video-codec');
my $audio_sample_rate = $cgi->param('audio-sample-rate');
my $audio_channels = $cgi->param('audio-channels');
my $audio_bitrate = $cgi->param('audio-bitrate');
my $audio_codec = $cgi->param('audio-codec');

# Validar que todos los campos necesarios estén presentes
if (!$config_name || !$input_format || !$output_format || !$video_resolution || !$video_bitrate || !$video_codec || !$audio_sample_rate || !$audio_channels || !$audio_bitrate || !$audio_codec) {
    print $cgi->header(-type => 'text/html', -status => '400 Bad Request');
    print "<h1>Error: Todos los campos son obligatorios.</h1>";
    exit;
}

# Definir la ruta del archivo CSV donde se guardarán las configuraciones
my $config_file = "../configuraciones/configuraciones.csv";

# Abrir el archivo CSV en modo de escritura
open my $fh, '>>', $config_file or die "No se pudo abrir el archivo de configuraciones: $!";

# Escribir la nueva configuración en el archivo CSV
print $fh "$config_name,$input_format,$output_format,$video_resolution,$video_bitrate,$video_codec,$audio_sample_rate,$audio_channels,$audio_bitrate,$audio_codec\n";

# Cerrar el archivo
close $fh;

# Redirigir al usuario de vuelta al index.html después de guardar la configuración
print $cgi->header(-type => 'text/html', -status => '302 Found', -Location => '../publico/index.html');
# Obtener el archivo seleccionado para convertir o borrar
my $archivo = $cgi->param('archivo');

# Verificar si el archivo o directorio existe
if (-e $archivo) {
    if (-d $archivo) {
        # Si es un directorio, listar su contenido
        opendir my $dir, $archivo or die "No se pudo abrir el directorio: $!";
        my @archivos = readdir $dir;
        closedir $dir;

        # Mostrar los archivos y directorios en el formulario
        print $cgi->header(-type => 'text/html');
        print "<h1>Contenido de $archivo:</h1>";
        print "<ul>";
        foreach my $archivo (@archivos) {
            next if $archivo eq '.' or $archivo eq '..';  # Ignorar . y ..
            print "<li>$archivo</li>";
        }
        print "</ul>";

        # Opción de borrar el directorio
        print "<form action='../scripts/procesar-conversion.pl' method='post'>";
        print "<input type='hidden' name='archivo' value='$archivo'>";
        print "<button type='submit'>Borrar Directorio</button>";
        print "</form>";
    } else {
        # Si es un archivo, ofrecer la opción de conversión
        my $configuracion_seleccionada = "configuracion_seleccionada";  # Esto se debe obtener de la interfaz

        # Realizar la conversión utilizando ffmpeg con los parámetros seleccionados
        my $comando_ffmpeg = "ffmpeg -i $archivo -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 192k $archivo.convertido.mp4";

        # Ejecutar el comando de conversión
        system($comando_ffmpeg) == 0 or die "Error al ejecutar ffmpeg: $!";

        print $cgi->header(-type => 'text/html');
        print "<h1>Archivo $archivo convertido con éxito.</h1>";
        print "<a href='../publico/index.html'>Volver al inicio</a>";
    }
} else {
    print $cgi->header(-type => 'text/html', -status => '400 Bad Request');
    print "<h1>Error: El archivo o directorio no existe.</h1>";
}
# Si el archivo es para eliminar
if ($cgi->param('borrar') && -e $archivo) {
    if (-d $archivo) {
        # Si es un directorio, eliminarlo
        rmdir $archivo or die "No se pudo borrar el directorio: $!";
        print $cgi->header(-type => 'text/html');
        print "<h1>Directorio $archivo borrado con éxito.</h1>";
    } elsif (-f $archivo) {
        # Si es un archivo, eliminarlo
        unlink $archivo or die "No se pudo borrar el archivo: $!";
        print $cgi->header(-type => 'text/html');
        print "<h1>Archivo $archivo borrado con éxito.</h1>";
    } else {
        print $cgi->header(-type => 'text/html', -status => '400 Bad Request');
        print "<h1>Error: El archivo no es válido para borrar.</h1>";
    }
    print "<a href='../publico/index.html'>Volver al inicio</a>";
}
# Si el archivo es para convertir
if ($cgi->param('archivo') && -e $archivo) {
    my $config_name = $cgi->param('config-name'); # Obtener el nombre de la configuración seleccionada
    
    # Leer las configuraciones guardadas del archivo CSV
    open my $csv, "<", "../configuraciones/configuraciones.csv" or die "No se pudo abrir el archivo de configuraciones: $!";
    my $config;
    while (my $line = <$csv>) {
        chomp $line;
        my ($name, $input_format, $output_format, $resolution, $bitrate, $codec) = split /,/, $line;
        if ($name eq $config_name) {
            $config = {
                input_format => $input_format,
                output_format => $output_format,
                resolution => $resolution,
                bitrate => $bitrate,
                codec => $codec
            };
            last;
        }
    }
    close $csv;

    # Si la configuración no se encuentra
    unless ($config) {
        print $cgi->header(-type => 'text/html', -status => '400 Bad Request');
        print "<h1>Configuración no encontrada.</h1>";
        print "<a href='../publico/index.html'>Volver al inicio</a>";
        exit;
    }

    # Ejecutar la conversión utilizando ffmpeg con la configuración seleccionada
    my $input_file = $archivo;
    my $output_file = "../archivos/" . basename($archivo, '.' . $config->{input_format}) . '.' . $config->{output_format};
    
    my $command = "ffmpeg -i $input_file -s $config->{resolution} -b:v $config->{bitrate} -c:v $config->{codec} -c:a aac $output_file";
    
    # Ejecutar el comando
    my $status = system($command);
    
    if ($status == 0) {
        print $cgi->header(-type => 'text/html');
        print "<h1>Conversión completada con éxito: $output_file</h1>";
    } else {
        print $cgi->header(-type => 'text/html', -status => '500 Internal Server Error');
        print "<h1>Error al convertir el archivo.</h1>";
    }
    
    print "<a href='../publico/index.html'>Volver al inicio</a>";
}
