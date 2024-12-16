// Array para almacenar los profesores seleccionados
let selectedProfessors = [];
let selectedLists = [];  // Array para almacenar las listas de profesores

function addToList(id, name, image) {
    // Verificar si el profesor ya está en la lista
    if (!selectedProfessors.some(prof => prof.id === id)) {
        // Agregar el profesor a la lista
        selectedProfessors.push({ id, name, image });
        // Actualizar la lista en el HTML
        updateSelectedProfessors();
    }
}

function updateSelectedProfessors() {
    const listContainer = document.getElementById('selected-professors-list');
    listContainer.innerHTML = ''; // Limpiar la lista actual

    // Agregar cada profesor seleccionado a la lista
    selectedProfessors.forEach(prof => {
        const professorDiv = document.createElement('div');
        professorDiv.className = 'selected-professor';
        professorDiv.innerHTML = `<img src="${prof.image}" alt="${prof.name}" class="professor-image"><p>${prof.name}</p>`;
        listContainer.appendChild(professorDiv);
    });

    // Habilitar el botón de crear lista si hay profesores seleccionados
    const createListButton = document.getElementById('create-list-btn');
    createListButton.disabled = selectedProfessors.length === 0;
}

// Función para enviar los datos de la lista de profesores al servidor
function createList() {
    // Obtener el nombre de la lista
    const listName = document.getElementById('list-name').value;

    // Verificar que haya profesores seleccionados
    if (selectedProfessors.length === 0 || !listName) {
        alert('Por favor ingresa un nombre para la lista y selecciona al menos un profesor.');
        return;
    }

    // Crear el objeto de datos a enviar
    const data = {
        action: 'save',
        list_name: listName,
        professors_list: selectedProfessors.map(prof => prof.id) // Solo los IDs de los profesores
    };

    // Enviar los datos al servidor usando AJAX (con fetch)
    fetch('../cgi-bin/guardar_lista.pl', {  // Asegúrate de que la ruta sea correcta
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => response.json())
    .then(data => {
        console.log('Lista creada con éxito:', data);
        alert('Lista de profesores guardada exitosamente.');
        
        // Opcional: Redirigir a otra página o actualizar la UI
        // window.location.href = '/ruta/a/otra/pagina'; // Redirigir
        // O limpiar la selección después de guardar la lista
        selectedProfessors = [];
        updateSelectedProfessors();

        // Actualizar las listas sin recargar la página
        getLists();  // O también puedes llamar a renderLists directamente si no necesitas hacer una nueva solicitud al servidor
    })
    .catch(error => {
        console.error('Error al crear la lista:', error);
        alert('Hubo un error al crear la lista.');
    });
}

document.getElementById('create-list-btn').addEventListener('click', createList);

// Función para obtener todas las listas creadas
function getLists() {
    const data = { action: 'get_lists' };

    fetch('../cgi-bin/guardar_lista.pl', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            renderLists(data.lists);
        } else {
            console.log('Error al obtener las listas');
        }
    })
    .catch(error => {
        console.error('Error al obtener las listas:', error);
    });
}

// Función para renderizar las listas en el HTML
function renderLists(lists) {
    const listsTable = document.getElementById('lists-table');
    listsTable.innerHTML = '';  // Limpiar la tabla actual

    selectedLists = lists;  // Guardar las listas obtenidas para edición posterior

    lists.forEach(list => {
        const listDiv = document.createElement('div');
        listDiv.className = 'list-item';
        listDiv.innerHTML = `
            <div class="list-name">${list.nombre_lista}</div>
            <div class="professors-images">
                ${list.profesores_seleccionados.split(',').map(id => {
                    const prof = selectedProfessors.find(p => p.id == id);
                    return prof ? `<img src="${prof.image}" alt="${prof.name}" class="professor-image">` : '';
                }).join('')}
            </div>
            <div class="list-actions">
                <button onclick="editList(${list.id})">Editar</button>
                <button onclick="deleteList(${list.id})">Borrar</button>
                <button onclick="startSurvey(${list.id})">Empezar Encuesta</button>
            </div>
        `;
        listsTable.appendChild(listDiv);
    });
}

// Función para editar una lista
function editList(listId) {
    const list = selectedLists.find(l => l.id === listId);
    if (list) {
        // Mostrar el nombre de la lista en un campo de entrada para permitir la edición
        const listNameInput = document.getElementById('list-name');
        listNameInput.value = list.nombre_lista;

        // Limpiar el contenedor de profesores seleccionados
        const listContainer = document.getElementById('selected-professors-list');
        listContainer.innerHTML = '';  // Limpiar la lista actual

        // Mostrar los profesores de la lista con una "X" para eliminar
        list.profesores_seleccionados.split(',').forEach(profId => {
            const prof = selectedProfessors.find(p => p.id == Number(profId));
            if (prof) {
                const professorDiv = document.createElement('div');
                professorDiv.className = 'selected-professor';
                professorDiv.innerHTML = `
                    <img src="${prof.image}" alt="${prof.name}" class="professor-image">
                    <p>${prof.name}</p>
                    <button type="button" class="remove-professor-btn" onclick="removeProfessorFromList(${prof.id}, ${listId})">X</button>
                `;
                listContainer.appendChild(professorDiv);
            }
        });

        // Habilitar el botón de "Crear Lista" para guardar los cambios
        const createListButton = document.getElementById('create-list-btn');
        createListButton.disabled = false;
    }
}

// Función para eliminar un profesor de la lista
function removeProfessorFromList(professorId, listId) {
    const list = selectedLists.find(l => l.id === listId);
    if (list) {
        // Filtrar el profesor eliminado de la lista
        list.profesores_seleccionados = list.profesores_seleccionados.split(',').filter(id => id != professorId).join(',');
        // Actualizar la lista visualmente
        editList(listId);  // Vuelve a cargar la lista editada
    }
}

// Función para borrar una lista
function deleteList(listId) {
    const data = {
        action: 'delete',
        list_id: listId
    };

    fetch('../cgi-bin/guardar_lista.pl', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Lista eliminada con éxito');
            getLists();  // Actualizar las listas
        }
    })
    .catch(error => {
        console.error('Error al borrar la lista:', error);
        alert('Hubo un error al borrar la lista.');
    });
}

// Función para iniciar la encuesta
function startSurvey(listId) {
    // Obtener la lista seleccionada
    const list = selectedLists.find(l => l.id === listId);
    
    if (list) {
        // Obtener los IDs de los profesores seleccionados
        const professorIds = list.profesores_seleccionados.split(',');

        // Redirigir a la encuesta para el primer profesor de la lista
        const firstProfessorId = professorIds[0]; // Suponiendo que deseas comenzar con el primero
        window.location.href = `encuest.pl?professorId=${firstProfessorId}&listId=${listId}`;
    }
}


// Llamar a la función para cargar las listas al cargar la página
window.onload = getLists;
