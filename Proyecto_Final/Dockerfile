# Usar una imagen base de Ubuntu 22.04
FROM ubuntu:22.04

# Actualizar el sistema e instalar Apache2
RUN apt-get update && apt-get install -y apache2 && \
    apt-get clean

# Crear los directorios necesarios para el proyecto
RUN mkdir -p /var/www/html/css /var/www/html/js /var/www/html/galery

# Copiar los archivos HTML, CSS, JS y la imagen al directorio de Apache
COPY html/index.html /var/www/html/
COPY html/encuest.html /var/www/html/
COPY css/styles.css /var/www/html/css/
COPY css/styles_encuest.css /var/www/html/css/
COPY js/login.js /var/www/html/js/
COPY galery/background.jpg /var/www/html/galery/

# Exponer el puerto 8094
EXPOSE 8094

# Modificar la configuración de Apache para escuchar en el puerto 8094
RUN sed -i 's/80/8094/g' /etc/apache2/ports.conf && \
    sed -i 's/:80/:8094/g' /etc/apache2/sites-enabled/000-default.conf

# Iniciar Apache en modo foreground
CMD ["apachectl", "-D", "FOREGROUND"]



tmb crear lista de usuarios 



-- Tabla para las listas de encuestas
CREATE TABLE listas_encuestas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_lista VARCHAR(255) NOT NULL,
    profesores_seleccionados TEXT NOT NULL -- Aquí se guardará una lista de IDs de profesores
);





para el etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ScriptAlias /cgi-bin/ /var/www/html/cgi-bin/

    <Directory /var/www/html/cgi-bin>
        Options +Indexes +ExecCGI
        AddHandler cgi-script .pl
        Require all granted
    </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>