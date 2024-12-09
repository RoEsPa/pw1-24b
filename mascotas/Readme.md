##Proceso de construcción:

#Construye la imagen:

docker build -t mascotas-app .

#Ejecuta el contenedor:

docker run -p 8080:80 -d mascotas-app

#Abre en tu navegador:

http://localhost:8080/echo.pl