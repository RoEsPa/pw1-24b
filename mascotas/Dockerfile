FROM ubuntu:20.04

# Configurar localización y evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    apache2 \
    perl \
    libdbi-perl \
    libjson-perl \
    sqlite3 \
    cpanminus \
    build-essential \
    && apt-get clean

# Instalar dependencias de Perl (incluye DBD::SQLite)
RUN cpanm install CGI DBI JSON DBD::SQLite

# Habilitar módulo CGI en Apache
RUN a2enmod cgi

# Crear directorios necesarios
RUN mkdir -p /var/www/html /var/cgi-bin

# Copiar archivos
COPY echo.pl /var/cgi-bin/echo.pl
COPY registrar_mascota.pl /var/cgi-bin/registrar_mascota.pl
COPY obtener_mascotas.pl /var/cgi-bin/obtener_mascotas.pl
COPY editar_mascota.pl /var/cgi-bin/editar_mascota.pl
COPY eliminar_mascota.pl /var/cgi-bin/eliminar_mascota.pl
COPY init_db.pl /init_db.pl
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Permisos de ejecución para los scripts Perl
RUN chmod +x /var/cgi-bin/echo.pl /var/cgi-bin/*.pl /init_db.pl

# Crear la base de datos SQLite automáticamente
RUN perl /init_db.pl

# Exponer puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2ctl", "-D", "FOREGROUND"]
