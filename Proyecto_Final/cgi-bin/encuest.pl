#!/usr/bin/perl
use CGI;
use DBI;
use Text::CSV;
use strict;
use warnings;

use utf8;

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

# Obtener los profesores seleccionados para el listId
my $sth = $dbh->prepare("SELECT profesores_seleccionados FROM listas_encuestas WHERE id = ?");
$sth->execute($list_id);

my $professors_selected = "";
if (my $row = $sth->fetchrow_hashref) {
    $professors_selected = $row->{profesores_seleccionados};
}

# Si no se encontró el listId o no hay profesores seleccionados, redirigir al error.pl
unless ($professors_selected) {
    print $q->redirect('error.pl');
    exit;
}

# Comprobar si el professor_id está en la lista de profesores seleccionados
my @selected_profs = split(',', $professors_selected);
unless (grep { $_ == $professor_id } @selected_profs) {
    print $q->redirect('error.pl');
    exit;
}

# Ruta al archivo CSV
my $csv_file = "/var/www/html/data/Lista.csv";
open my $fh, '<:encoding(UTF-8)', $csv_file or die "No se pudo abrir el archivo '$csv_file': $!";

# Leer el archivo CSV
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

# Buscar el profesor en el archivo CSV
my $professor;
while (my $row = $csv->getline($fh)) {
    my ($id, $name, $image) = @$row;
    if ($id == $professor_id) {
        $professor = { id => $id, name => $name, image => $image };
        last;
    }
}

# Cerrar el archivo CSV
close $fh;

# Si no se encontró el profesor, redirigir a error.pl
unless ($professor) {
    print $q->redirect('error.pl');
    exit;
}

# Mostrar el formulario de la encuesta para este profesor
print $q->header('text/html');
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encuesta</title>
    <link rel="stylesheet" href="../css/styles_encuest.css">
</head>
<body>
    <div class="container">
        <div class="form-box">
            <!-- Imagen a la izquierda -->
            <div class="image-section">
                <img src="../$professor->{image}" alt="$professor->{name}">
                <p class="teacher-name">$professor->{name}</p>
            </div>

            <!-- Encuesta a la derecha -->
            <form class="survey-section" method="POST" action="submit_survey.pl">
                <h2>Encuesta</h2>
                <div class="question">
                    <label for="question1">Calidad de enseñanza</label>
                    <select id="question1" name="question1" required>
                        <option value="" disabled selected>Elige una opción</option>
                        <option value="1">Mala</option>
                        <option value="2">Básica</option>
                        <option value="3">Pasable</option>
                        <option value="4">Regular</option>
                        <option value="5">Excelente</option>
                    </select>
                </div>
                <div class="question">
                    <label for="question2">¿Recomendarías al Docente?</label>
                    <select id="question2" name="question2" required>
                        <option value="" disabled selected>Elige una opción</option>
                        <option value="1">Nunca</option>
                        <option value="2">No</option>
                        <option value="3">Tal vez</option>
                        <option value="4">Sí</option>
                        <option value="5">Obviamente</option>
                    </select>
                </div>
                <div class="question">
                    <label for="question3">¿Cuál de estas frases describe mejor las clases de tu profesor?</label>
                    <select id="question3" name="question3" required>
                        <option value="" disabled selected>Elige una opción</option>
                        <option value="1">Aburridas, miro el reloj cada 5 minutos.</option>
                        <option value="2">Confusas, a veces estoy volando.</option>
                        <option value="3">Estructuradas, pero algo monótonas.</option>
                        <option value="4">Motivadoras y dinámicas, siempre aprendo algo nuevo.</option>
                        <option value="5">El mejor, nunca falla.</option>
                    </select>
                </div>
                <div class="question">
                    <label for="question4">¿Qué tan probable es que tu profesor te dé un extra si le das un panetón?</label>
                    <select id="question4" name="question4" required>
                        <option value="" disabled selected>Elige una opción</option>
                        <option value="1">Me retira de la carrera</option>
                        <option value="2">Ni siquiera lo piensa</option>
                        <option value="3">Si está de buen humor</option>
                        <option value="4">Solo si es razonable</option>
                        <option value="5">100%</option>
                    </select>
                </div>
                <div class="question">
                    <label for="opinion">Opinión</label>
                    <textarea id="opinion" name="opinion" rows="4" placeholder="Escribe tu opinión"></textarea>
                </div>
                <input type="hidden" name="professorId" value="$professor_id">
                <input type="hidden" name="listId" value="$list_id">
                <button class="btn" type="submit">Enviar</button>
            </form>
        </div>
    </div>
</body>
</html>
HTML

# Guardar la encuesta
sub save_survey {
    my $sth = $dbh->prepare("INSERT INTO respuestas_encuesta (list_id, professor_id, question1, question2, question3, question4, opinion) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $sth->execute($list_id, $professor_id, $q->param('question1'), $q->param('question2'), $q->param('question3'), $q->param('question4'), $q->param('opinion'));
}

# Redirigir al siguiente profesor
sub redirect_to_next_professor {
    my $current_index = 0;
    for my $i (0 .. $#selected_profs) {
        if ($selected_profs[$i] == $professor_id) {
            $current_index = $i;
            last;
        }
    }

    # Obtener el siguiente profesor
    my $next_professor_id = $selected_profs[$current_index + 1] // undef;

    # Si no hay un siguiente profesor, redirigir a la página de finalización
    unless ($next_professor_id) {
        print $q->redirect('finalizacion.pl');
        exit;
    }

    # Redirigir al siguiente profesor
    print $q->redirect("encuesta.pl?professorId=$next_professor_id&listId=$list_id");
    exit;
}
