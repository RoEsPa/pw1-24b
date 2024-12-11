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
