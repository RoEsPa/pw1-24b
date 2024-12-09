#!/usr/bin/perl

use strict;
use warnings;

print "Content-type: text/html\n\n";

print <<EOF;
Content-type: text/html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Registro de Mascotas</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
  <h2>Formulario de Registro de Mascotas</h2>
  <form id="mascotaForm">
    <div class="form-group">
      <label for="nombre">Nombre de la Mascota:</label>
      <input type="text" class="form-control" id="nombre" placeholder="Ingrese el nombre" name="nombre" required>
    </div>
    <div class="form-group">
      <label for="edad">Edad:</label>
      <input type="number" class="form-control" id="edad" placeholder="Edad" name="edad" required>
    </div>
    <div class="form-group">
      <label for="tipo">Tipo de Mascota:</label>
      <select class="form-control" id="tipo" name="tipo" required>
        <option value="Perro">Perro</option>
        <option value="Gato">Gato</option>
        <option value="Otro">Otro</option>
      </select>
    </div>
    <div class="form-group">
      <label for="propietario">Propietario:</label>
      <input type="text" class="form-control" id="propietario" placeholder="Ingrese el propietario" name="propietario" required>
    </div>
    <div id="respAjax" class="form-group"></div>
    
    <button type="submit" class="btn btn-primary">Registrar Mascota</button>
  </form>

  <h3>Lista de Mascotas Registradas</h3>

  <!-- Campo de búsqueda -->
  <div class="form-group">
    <label for="buscar">Buscar Mascota:</label>
    <input type="text" class="form-control" id="buscar" placeholder="Buscar por cualquier campo...">
  </div>

  <table class="table table-bordered" id="mascotasTable">
    <thead>
      <tr>
        <th>#</th>
        <th>Nombre</th>
        <th>Edad</th>
        <th>Tipo</th>
        <th>Propietario</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      <!-- Las mascotas se cargarán aquí -->
    </tbody>
  </table>
</div>

<script>
$(document).ready(function() {
  cargarMascotas();

  // Registrar nueva mascota
  $('#mascotaForm').on('submit', function(e) {
    e.preventDefault();
    var mascotaData = {
      nombre: $('#nombre').val(),
      edad: $('#edad').val(),
      tipo: $('#tipo').val(),
      propietario: $('#propietario').val()
    };

    $.post("registrar_mascota.pl", mascotaData, function() {
      $('#respAjax').html("<div class='alert alert-success'>Mascota registrada con éxito!</div>");
      cargarMascotas();
    }).fail(function() {
      $('#respAjax').html("<div class='alert alert-danger'>Error al registrar mascota</div>");
    });
  });

  // Función para cargar las mascotas
  function cargarMascotas() {
    $.getJSON("obtener_mascotas.pl", function(response) {
      var tbody = $('#mascotasTable tbody');
      tbody.empty();
      response.forEach(function(mascota, index) {
        tbody.append('<tr id="fila_' + mascota.id + '">' +
          '<td>' + (index + 1) + '</td>' +
          '<td>' + mascota.nombre + '</td>' +
          '<td>' + mascota.edad + '</td>' +
          '<td>' + mascota.tipo + '</td>' +
          '<td>' + mascota.propietario + '</td>' +
          '<td>' +
            '<button class="btn btn-warning btn-sm editar" data-id="' + mascota.id + '">Editar</button> ' +
            '<button class="btn btn-danger btn-sm eliminar" data-id="' + mascota.id + '">Eliminar</button>' +
          '</td>' +
        '</tr>');
      });
    });
  }

  // Eliminar mascota
  $(document).on('click', '.eliminar', function() {
    var id = $(this).data('id');
    $.post("eliminar_mascota.pl", { id: id }, function() {
      cargarMascotas();
    }).fail(function() {
      alert("Error al eliminar la mascota.");
    });
  });

  // Editar mascota
  $(document).on('click', '.editar', function() {
    var id = $(this).data('id');
    var fila = $('#fila_' + id);
    var nombre = prompt("Nuevo nombre:", fila.find('td:nth-child(2)').text());
    var edad = prompt("Nueva edad:", fila.find('td:nth-child(3)').text());
    var tipo = prompt("Nuevo tipo:", fila.find('td:nth-child(4)').text());
    var propietario = prompt("Nuevo propietario:", fila.find('td:nth-child(5)').text());

    if (nombre && edad && tipo && propietario) {
      $.post("editar_mascota.pl", {
        id: id,
        nombre: nombre,
        edad: edad,
        tipo: tipo,
        propietario: propietario
      }, function() {
        cargarMascotas();
      }).fail(function() {
        alert("Error al editar la mascota.");
      });
    }
  });

  // Buscar mascotas en tiempo real
  $('#buscar').on('keyup', function() {
    var valor = $(this).val().toLowerCase();
    $('#mascotasTable tbody tr').filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(valor) > -1);
    });
  });
});
</script>

</body>
</html>
EOF
