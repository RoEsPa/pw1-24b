#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use Text::CSV;

# Crear un objeto CGI
my $cgi = CGI->new;

# Obtener los valores enviados por el formulario
my $input_format = $cgi->param('input-format');
my $output_format = $cgi->param('output-format');
my $video_resolution = $cgi->param('video-resolution');
my $video_bitrate = $cgi->param('video-bitrate');
my $video_codec = $cgi->param('video-codec');
my $audio_sample_rate = $cgi->param('audio-sample-rate');
my $audio_channels = $cgi->param('audio-channels');
my $audio_bitrate = $cgi->param('audio-bitrate');
my $audio_codec = $cgi->param('audio-codec');
my $config_name = $cgi->param('config-name');

# Validar que todos los campos estén completos
if (!$config_name || !$input_format || !$output_format || !$video_resolution || !$video_bitrate || !$video_codec || !$audio_sample_rate || !$audio_channels || !$audio_bitrate || !$audio_codec) {
    print $cgi->header(-type => 'text/html', -status => '400 Bad Request');
    print "<h1>Error: Todos los campos son obligatorios.</h1>";
    exit;
}

# Ruta al archivo CSV donde se guardarán las configuraciones
my $file_path = "../configuraciones/configuraciones.csv";

# Abrir el archivo CSV para agregar la configuración
open(my $fh, '>>', $file_path) or die "No se pudo abrir el archivo '$file_path' $!";

# Crear un objeto CSV
my $csv = Text::CSV->new({ binary => 1, eol => "\n" });

# Escribir la nueva configuración en el archivo CSV
$csv->say($fh, [$config_name, $input_format, $output_format, $video_resolution, $video_bitrate, $video_codec, $audio_sample_rate, $audio_channels, $audio_bitrate, $audio_codec]);

# Cerrar el archivo CSV
close($fh);

# Redirigir a la página de index
print $cgi->header(-type => 'text/html', -status => '302 Found', -Location => '../publico/index.html');
