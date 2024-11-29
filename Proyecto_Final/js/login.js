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