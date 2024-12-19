#!/usr/bin/perl
use CGI;
use DBI;
use strict;
use warnings;

my $q = CGI->new;

# Obtener los parámetros de la URL
my $professor_id = $q->param('professorId');
my $list_id = $q->param('listId');

# Conectar a la base de datos
my $dsn = "DBI:mysql:login_db:127.0.0.1";
my $username = "pw";  # Cambia esto por tu usuario de base de datos
my $password = "rep";  # Cambia esto por tu contraseña de base de datos
my $dbh = DBI->connect($dsn, $username, $password, { RaiseError => 1, AutoCommit => 1 })
    or die "No se pudo conectar a la base de datos: $DBI::errstr";

# Guardar las respuestas de la encuesta en la tabla 'encuestas'
my $sth = $dbh->prepare("INSERT INTO encuestas (id_profesor, calidad_ensenanza, recomendacion, descripcion_clases, probabilidad_extra, opinion) 
                         VALUES (?, ?, ?, ?, ?, ?)");

$sth->execute(
    $professor_id,
    $q->param('question1'),  # Calidad de enseñanza
    $q->param('question2'),  # Recomendación
    $q->param('question3'),  # Descripción de clases
    $q->param('question4'),  # Probabilidad extra
    $q->param('opinion')     # Opinión
) or die "No se pudo insertar la encuesta: $DBI::errstr";

# Redirigir al siguiente profesor o a la página de finalización
my $next_professor_id = get_next_professor_id($professor_id, $list_id, $dbh);

# Si hay un siguiente profesor, redirigir; si no, redirigir a la página de finalización
if ($next_professor_id) {
    print $q->redirect("encuest.pl?professorId=$next_professor_id&listId=$list_id");
} else {
    print $q->redirect("finalizacion.pl");
}

# Función para obtener el siguiente profesor en la lista
sub get_next_professor_id {
    my ($current_professor_id, $list_id, $dbh) = @_;

    # Obtener la lista de profesores seleccionados para este list_id
    my $sth = $dbh->prepare("SELECT profesores_seleccionados FROM listas_encuestas WHERE id = ?");
    $sth->execute($list_id);

    my $professors_selected = "";
    if (my $row = $sth->fetchrow_hashref) {
        $professors_selected = $row->{profesores_seleccionados};
    }

    # Convertir la lista de profesores a un arreglo
    my @selected_profs = split(',', $professors_selected);

    # Buscar el índice del profesor actual
    my $current_index = 0;
    for my $i (0 .. $#selected_profs) {
        if ($selected_profs[$i] == $current_professor_id) {
            $current_index = $i;
            last;
        }
    }

    # Obtener el siguiente profesor
    return $selected_profs[$current_index + 1] // undef;
}
