const loginForm = document.querySelector(".loginForm");
const registerForm = document.querySelector(".registerForm");
const registerLink = document.querySelector(".registerLink");
const loginLink = document.querySelector(".loginLink");

registerLink.onclick=() => {
    registerForm.classList.add('active');
    loginForm.classList.add('active');
}

loginLink.onclick=() => {
    registerForm.classList.remove('active');
    loginForm.classList.remove('active');
}

        // Función para mostrar la notificación
        function showNotification(message) {
            const notificationDiv = document.createElement("div");
            notificationDiv.classList.add("notification");
            notificationDiv.textContent = message;
            document.body.appendChild(notificationDiv);
            setTimeout(() => {
                notificationDiv.style.opacity = '0';
                setTimeout(() => notificationDiv.remove(), 500);
            }, 3000);
        }

        // Función para manejar el formulario de login o registro
        async function handleFormSubmit(event) {
            event.preventDefault();  // Prevenir que el formulario recargue la página
            const formData = new FormData(event.target);
            const action = formData.get('action');

            const response = await fetch('../cgi-bin/login_register.pl', {
                method: 'POST',
                body: formData
            });

            const data = await response.json(); // Recibir la respuesta en formato JSON
            showNotification(data.message); // Mostrar el mensaje en la página
        }

        // Asignar el manejador a los formularios
        document.getElementById('loginForm').addEventListener('submit', handleFormSubmit);
        document.getElementById('registerForm').addEventListener('submit', handleFormSubmit);

        window.onload = function() {
            // Verificar si hay un mensaje de notificación
            var message = document.getElementById('notificationMessage') ? document.getElementById('notificationMessage').innerText : '';
        
            if (message) {
                // Mostrar la notificación
                var notification = document.getElementById('notification');
                notification.style.display = 'block';
                notification.classList.add('show');
        
                // Ocultar la notificación después de 5 segundos
                setTimeout(function() {
                    notification.style.display = 'none';
                }, 5000);
            }
        };
