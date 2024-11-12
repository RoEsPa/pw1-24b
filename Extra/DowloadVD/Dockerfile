# Usa la imagen base bitnami/minideb
FROM bitnami/minideb

# Establecer el entorno para evitar prompts durante la instalación
ENV DEBIAN_FRONTEND="noninteractive"

# Actualizar e instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y apache2 perl openssh-server vim bash locales tree libcgi-pm-perl libtext-csv-perl dos2unix yt-dlp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Establecer las configuraciones locales a UTF-8
RUN echo "es_PE.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen es_PE.UTF-8 && \
    update-locale LANG=es_PE.UTF-8 LC_ALL=es_PE.UTF-8
    
# Crear usuario y directorios necesarios
RUN mkdir -p /home/pweb && \
    useradd pweb -m && echo "pweb:12345678" | chpasswd && \
    echo "root:12345678" | chpasswd && \
    chown pweb:www-data /usr/lib/cgi-bin/ && \
    chown pweb:www-data /var/www/html/ && \
    chmod 750 /usr/lib/cgi-bin/ && \
    chmod 750 /var/www/html/

# Configurar entorno bash
RUN echo "export LC_ALL=es_PE.UTF-8" >> /home/pweb/.bashrc && \
    echo "export LANG=es_PE.UTF-8" >> /home/pweb/.bashrc && \
    echo "export LANGUAGE=es_PE.UTF-8" >> /home/pweb/.bashrc

# Crear enlaces simbólicos para acceso rápido a cgi-bin y html
RUN ln -s /usr/lib/cgi-bin /home/pweb/cgi-bin && \
    ln -s /var/www/html /home/pweb/html && \
    ln -s /home/pweb /usr/lib/cgi-bin/toHOME && \
    ln -s /home/pweb /var/www/html/toHOME

# Copiar archivos CGI, HTML y CSS de la aplicación al contenedor
COPY ./scripts/procesar-conversion.pl /usr/lib/cgi-bin/
COPY ./scripts/guardar-configuracion.pl /usr/lib/cgi-bin/
COPY ./configuraciones/configuraciones.csv /usr/lib/cgi-bin/configuraciones.csv
COPY ./publico/index.html /var/www/html/index.html
COPY ./publico/configuraciones.html /var/www/html/configuraciones.html
COPY ./styles/styles.css /var/www/html/css/styles.css

# Habilitar el módulo CGI en Apache
RUN a2enmod cgid

# Configurar Apache para ejecutar scripts CGI
RUN echo '<VirtualHost *:80>\n\
    ServerAdmin webmaster@localhost\n\
    DocumentRoot /var/www/html\n\
    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/\n\
    <Directory "/usr/lib/cgi-bin">\n\
        AllowOverride None\n\
        Options +ExecCGI\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Exponer los puertos 80 (HTTP) y 22 (SSH)
EXPOSE 80
EXPOSE 22

# Comando de inicio para Apache y SSH
CMD ["bash", "-c", "service ssh start && apachectl -D FOREGROUND"]
