#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use JSON;
use DBI;

# Configura la base de datos
my $dsn = "DBI:mysql:login_db:127.0.0.1";
my $username = 'pw';  # Cambia por tu usuario
my $password = 'rep';  # Cambia por tu contraseña
my $dbh = DBI->connect($dsn, $username, $password, { RaiseError => 1, AutoCommit => 1 });

# Crear un objeto CGI
my $cgi = CGI->new;

# Asegúrate de que la respuesta sea en formato JSON
print $cgi->header('application/json');  # Devuelve JSON

# Leer el cuerpo de la solicitud
my $json_text = $cgi->param('POSTDATA');  # Usamos input para leer el cuerpo completo
my $data = eval { decode_json($json_text) };  # Usamos eval para capturar errores

# Si ocurre un error al leer el JSON
if ($@) {
    print encode_json({ success => 0, message => "Error al parsear los datos JSON" });
    exit;
}

# Función para crear o actualizar la lista
sub save_or_update_list {
    my ($list_name, $professors_list, $list_id) = @_;

    if ($list_id) {
        # Actualizar la lista existente
        my $sth = $dbh->prepare('UPDATE listas_encuestas SET nombre_lista = ?, profesores_seleccionados = ? WHERE id = ?');
        $sth->execute($list_name, $professors_list, $list_id);
    } else {
        # Crear una nueva lista
        my $sth = $dbh->prepare('INSERT INTO listas_encuestas (nombre_lista, profesores_seleccionados) VALUES (?, ?)');
        $sth->execute($list_name, $professors_list);
    }
}

# Función para borrar una lista
sub delete_list {
    my ($list_id) = @_;
    my $sth = $dbh->prepare('DELETE FROM listas_encuestas WHERE id = ?');
    $sth->execute($list_id);
}

# Función para obtener todas las listas
sub get_lists {
    my $sth = $dbh->prepare('SELECT * FROM listas_encuestas');
    $sth->execute();

    my @lists;
    while (my $row = $sth->fetchrow_hashref) {
        push @lists, $row;
    }

    return \@lists;
}

# Obtener acción solicitada
my $action = $data->{action};

if ($action eq 'save') {
    my $list_name = $data->{list_name};
    my $professors_list = join(",", @{$data->{professors_list}});
    save_or_update_list($list_name, $professors_list, undef);  # Crear nueva lista
    print encode_json({ success => 1, message => "Lista creada con éxito" });

} elsif ($action eq 'update') {
    my $list_id = $data->{list_id};
    my $list_name = $data->{list_name};
    my $professors_list = join(",", @{$data->{professors_list}});
    save_or_update_list($list_name, $professors_list, $list_id);  # Actualizar lista existente
    print encode_json({ success => 1, message => "Lista actualizada con éxito" });

} elsif ($action eq 'delete') {
    my $list_id = $data->{list_id};
    delete_list($list_id);  # Borrar lista
    print encode_json({ success => 1, message => "Lista eliminada con éxito" });

} elsif ($action eq 'get_lists') {
    my $lists = get_lists();  # Obtener todas las listas
    print encode_json({ success => 1, lists => $lists });

} else {
    print encode_json({ success => 0, message => "Acción no válida" });
}
