# Usar una imagen base de Ubuntu 22.04
FROM ubuntu:22.04

# Actualizar el sistema e instalar Apache2, MySQL, Perl y otros paquetes necesarios
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    libcgi-pm-perl \
    libdbi-perl \
    libdbd-mysql-perl \
    libtext-csv-perl \
    libapache2-mod-perl2 \
    libfcgi-perl \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    cpanminus \
    tree && \
    apt-get clean

# Instalar módulos Perl adicionales
RUN cpanm DBI Digest::SHA CGI CGI::Carp JSON CGI::Session

# Copiar todos los archivos y directorios al directorio de Apache
COPY . /var/www/html/

# Copiar el archivo de configuración de Apache
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilitar el módulo CGI de Apache
RUN a2enmod cgid

# Dar privilegios a los directorios y archivos de Apache
RUN chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/cgi-bin/*.pl && \
    chmod -R 755 /var/www/html/cgi-bin/*.pl

# Configurar MySQL y crear las tablas necesarias
RUN service mysql start && sleep 5 &&\
    mysql -e "CREATE DATABASE IF NOT EXISTS login_db;" && \
    mysql -e "CREATE USER IF NOT EXISTS 'pw'@'localhost' IDENTIFIED BY 'rep';" && \
    mysql -e "GRANT ALL PRIVILEGES ON login_db.* TO 'pw'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;" && \
    mysql -D login_db -e "CREATE TABLE IF NOT EXISTS encuestas (id INT AUTO_INCREMENT PRIMARY KEY, id_profesor INT NOT NULL, calidad_ensenanza INT NOT NULL, recomendacion INT NOT NULL, descripcion_clases INT NOT NULL, probabilidad_extra INT NOT NULL, opinion TEXT, fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP);" && \
    mysql -D login_db -e "CREATE TABLE IF NOT EXISTS listas_encuestas (id INT AUTO_INCREMENT PRIMARY KEY, nombre_lista VARCHAR(255) NOT NULL, profesores_seleccionados TEXT NOT NULL);" && \
    mysql -D login_db -e "CREATE TABLE IF NOT EXISTS usuarios (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(255) NOT NULL UNIQUE, password VARCHAR(255) NOT NULL);"

# Iniciar Apache y MySQL en modo foreground
CMD ["bash", "-c", "service mysql start && \
    mysql -u pw -prep -h 127.0.0.1 login_db && \
    apachectl -D FOREGROUND"]
