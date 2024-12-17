# Imagen base oficial de Debian con Apache2
FROM debian:latest

# Configuración de variables
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2

# Actualizar paquetes e instalar dependencias
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-perl2 \
    libdbi-perl \
    libdbd-mysql-perl \
    libxml-simple-perl \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Habilitar el módulo CGI en Apache
RUN a2enmod cgi

# Configurar permisos para CGI y carpeta de scripts
RUN mkdir -p /usr/lib/cgi-bin \
    && chown -R www-data:www-data /usr/lib/cgi-bin \
    && chmod +x /usr/lib/cgi-bin

# Copiar el script Perl al directorio de CGI
COPY login.pl /usr/lib/cgi-bin/login.pl

# Permisos para el script Perl
RUN chmod +x /usr/lib/cgi-bin/login.pl

# Configurar Apache para ejecutar CGI en el directorio /cgi-bin
RUN echo "ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/" > /etc/apache2/conf-available/cgi-bin.conf \
    && echo "<Directory \"/usr/lib/cgi-bin\">" >> /etc/apache2/conf-available/cgi-bin.conf \
    && echo "    AllowOverride None" >> /etc/apache2/conf-available/cgi-bin.conf \
    && echo "    Options +ExecCGI -MultiViews +FollowSymLinks" >> /etc/apache2/conf-available/cgi-bin.conf \
    && echo "    Require all granted" >> /etc/apache2/conf-available/cgi-bin.conf \
    && echo "</Directory>" >> /etc/apache2/conf-available/cgi-bin.conf

# Habilitar la configuración CGI
RUN a2enconf cgi-bin

# Exponer el puerto 80 para Apache
EXPOSE 80

# Comando de inicio
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
