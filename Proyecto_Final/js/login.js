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

document.addEventListener('DOMContentLoaded', function() {
    const notification = document.getElementById('notification');
    const notificationMessage = document.getElementById('notification-message');

    // Verificar si hay un mensaje y mostrar la notificación
    const message = document.querySelector('p').innerText; // Se obtiene el mensaje
    if (message) {
        notificationMessage.innerText = message;  // Establece el mensaje de la notificación

        // Mostrar la notificación
        notification.classList.add('show');
        
        // Agregar clase 'error' si el mensaje contiene un error
        if (message.includes('error')) {
            notification.classList.add('error');
        }

        // Ocultar la notificación después de 5 segundos
        setTimeout(function() {
            notification.classList.remove('show');
            setTimeout(() => notification.style.display = 'none', 500); // Asegura que la notificación se oculte
        }, 5000);
    }
});
