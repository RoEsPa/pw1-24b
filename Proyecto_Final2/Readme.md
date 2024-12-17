# 🚀 Proyecto CGI con Apache2 y Perl

Este proyecto utiliza **Docker** para configurar un servidor **Apache2** con soporte **CGI** que ejecuta un script en **Perl** (`login.pl`) para autenticación de usuarios usando una base de datos **MySQL/MariaDB**.

---

## 📂 **Estructura del Proyecto**

```plaintext
.
├── Dockerfile   # Configuración de Apache2 y CGI
└── login.pl     # Script Perl para autenticación de usuarios
🛠 Configuración y Ejecución
1. Construir la Imagen Docker
bash
Copiar código
docker build -t apache-cgi-perl .
2. Ejecutar el Contenedor
bash
Copiar código
docker run -d -p 8080:80 --name apache-cgi apache-cgi-perl
3. Probar el Script
Accede a la URL:

bash
Copiar código
http://localhost:8080/cgi-bin/login.pl?user=testUser&password=1234
💻 Explicación Rápida
Dockerfile
Paso	Descripción
a2enmod cgi	Habilita el módulo CGI en Apache.
COPY login.pl ...	Copia el script a /usr/lib/cgi-bin/.
chmod +x login.pl	Asigna permisos de ejecución al script.
Script login.pl
El script recibe user y password como parámetros GET y devuelve una respuesta en XML.

Ejemplo de Respuesta Exitosa:

xml
Copiar código
<?xml version='1.0' encoding='utf-8'?>
<response>
    <status>success</status>
</response>
✅ Pruebas
Usando Curl
bash
Copiar código
curl "http://localhost:8080/cgi-bin/login.pl?user=testUser&password=1234"
⚠️ Notas
Configura las credenciales de base de datos en login.pl.
Asegúrate de que el script tenga permisos de ejecución (chmod +x).
¡Listo! 🚀 Tu servidor Apache2 con CGI está configurado y listo para pruebas.

Copiar código





