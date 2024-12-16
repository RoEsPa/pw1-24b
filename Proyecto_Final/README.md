<div align="center">
<table>
    <theader>
        <tr>
            <td><img src="https://github.com/rescobedoq/pw2/blob/main/epis.png?raw=true" alt="EPIS" style="width:50%; height:auto"/></td>
            <th>
                <span style="font-weight:bold;">UNIVERSIDAD NACIONAL DE SAN AGUSTIN</span><br />
                <span style="font-weight:bold;">FACULTAD DE INGENIERÍA DE PRODUCCIÓN Y SERVICIOS</span><br />
                <span style="font-weight:bold;">DEPARTAMENTO ACADÉMICO DE INGENIERÍA DE SISTEMAS E INFORMÁTICA</span><br />
                <span style="font-weight:bold;">ESCUELA PROFESIONAL DE INGENIERÍA DE SISTEMAS</span>
            </th>
            <td><img src="https://github.com/rescobedoq/pw2/blob/main/abet.png?raw=true" alt="ABET" style="width:50%; height:auto"/></td>
        </tr>
    </theader>
    <tbody>
        <tr><td colspan="3"><span style="font-weight:bold;">Formato</span>: Guía de Práctica de Laboratorio</td></tr>
        <tr><td><span style="font-weight:bold;">Aprobación</span>:  2022/03/01</td><td><span style="font-weight:bold;">Código</span>: GUIA-PRLD-001</td><td><span style="font-weight:bold;">Página</span>: 1</td></tr>
    </tbody>
</table>
</div>

<div align="center">
<span style="font-weight:bold;">GUÍA DE LABORATORIO</span><br />
</div>


<table>
<theader>
<tr><th colspan="6">INFORMACIÓN BÁSICA</th></tr>
</theader>
<tbody>
<tr><td>ASIGNATURA:</td><td colspan="5">Programación Web 1</td></tr>
<tr><td>TÍTULO DEL PROYECTO:</td><td colspan="5">ENCUEST
</td></tr>
<tr>
<td>PROYECTO:</td><td>01</td><td>AÑO LECTIVO:</td><td>2024 b</td><td>NRO. SEMESTRE:</td><td>II</td>
</tr>
<tr>
<td>FECHA INICIO:</td><td>12-Nov-2024</td><td>FECHA FIN:</td><td>16-Dic-2024</td><td>DURACIÓN:</td><td>04 horas</td>
</tr>
<tr><td colspan="6">RECURSOS:
    <ul>
        <li><a href="https://git-scm.com/book/es/v2">https://git-scm.com/book/es/v2</a></li>
        <li><a href="https://guides.github.com/">https://guides.github.com/</a></li>        
        <li><a href="https://www.perl.org/get.html">https://www.perl.org/get.html</a></li>
    </ul>
</td>
</<tr>
<tr><td colspan="6">DOCENTES:
<ul>
<li>Richart Smith Escobedo Quispe - rescobedoq@unsa.edu.pe</li>
 </ul>
      </td>
    </tr>
    <tr>
      <td colspan="6">
        <strong>INTEGRANTES DEL GRUPO:</strong>
        <ul>
          <li>Estefanero Palma Rodrigo - restefanerop@unsa.edu.pe</li>
          <li>Quispe Mamani Jose Gabriel - josquispem@unsa.edu.pe</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

# Git - GitHub - Perl


[![Git][Git]][git-site]
[![GitHub][GitHub]][github-site]
[![Perl][Perl]][perl-site]

#

## OBJETIVOS TEMAS Y COMPETENCIAS

### OBJETIVOS

- Poner en practica lo aprendido tanto las clases de laboratorio como las de teoria.
- Tener la capacidad de dominar los temas avanzados para realizar el proyecto.

### TEMAS Y HERRAMIENTAS
- Docker
- Git
- GitHub
- Perl
- JavaScript
- AYAX
- CRUD
- Base de Datos
## CONTENIDO DE LA GUÍA

### EXPLICACION DEL PROYECTO
- El proyecto trata de un apartado de encuesta que va dirigido hacia los estudiantes, el cual falicitara la encuesta que se realiza cada que se finaliiza el semestre,
  esta pagina tendra los siguientes apartados:
  ### 1. INGRESO CON EL CORREO INSTITUCIONAL
  - Esto se podra hacer de manera que garantize el anonimato del que realizara la encuesta, esto por el temor a que se pueda detectar al encuestador por el solo ingreso de su correo.
  ![Ingreso](img/AparienciaFinal.png)
  ### 2. APARTADO DE LOS DOCENTE
  - Aqui se mostraran los Docentes de la Escuela, se podra vizualizar al docente y para la realizacion de la encuesta, solo se debera hacer click a la fotografia del docente.
  ![Plana](img/AparienciaFinal.png)
  ### 3. ENCUESTA
  - En este aparatado se mostrara la encuesta que constara de 5 preguntas que se podran calificar con una escala del 1 al 5, tambien como ultimo apartado se podra dar una opinion del docente encuestado.
  ![Encuesta](img/AparienciaFinal.png)
  ### 4. ESCALA GENERAL DE CALIFICACION
  - Al culminar la encuesta, se mostrara una pequeña calificación genral de todos los docentes, desde el menor calificado hasta el mayor calificado.
  ![Escala](img/AparienciaFinal.png)

## OBEJTIVO DEL PROYECTO
### 1. BIRNDAR FACILIDAD
  - Este proyecto tiene como objetivo ayudar a la Escuela y tambien a la casa Agustin.
    
### 2. TRANSPARENCIA
  - Esto se refiere a que se podra garantizar si el docente con mayor espectativas se vea reflejado en la escala general de todos los docentes.
    
### 3. FLEXIBILIDAD 
  - Este proyecto tambien podra ayudar a los administradores, a que solo se cambie cierto apartado donde se podran ver la lista de docentes y el cual se podra modificar conforme pasen los semestres y existan cambio de la plana de docentes, esto con el objetivo de que el administrador no tenga dificultades al momento de actualizar la pagina.

- Creacion del contenedor en el puerto 8097
    -   ```sh
        docker run -d -p 8097:80 universidades
        ```

- link de la Pagina
    -   ```sh
        http://localhost:8097/
        ```

## REPOSITORIO EN DONDE SE TRABAJO

- Este trabajo fue grupal por que se acordo trabajar en un solo repositorio y los demas trabajando como colaboradores.
    - GitHub en donde se trabajo
    -   ```sh
        https://github.com/RoEsPa/pw1-24b.git
        ```

    - Aqui se podra ver la lista de commits que se hizo en el repositorio.
    -   ```sh
          https://github.com/RoEsPa/pw1-24b/commits/main/
        ```
## COMMITS IMPORTANTES
### Registro de Commits del Proyecto

Aquí se documentan los principales commits realizados en el proyecto, con una breve descripción de los cambios implementados en cada uno.

---

### 1. Script de búsqueda en Perl y archivo CSV
- **Descripción:** Se da la agregación del archivo csv y del script de búsqueda en el repositorio.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/6ebe40147752c3c310fb0af1ae8c97979db2f3cf...71d15810af22143bde7fb96041a1ba2bc856d4e3)


### 2. Búsqueda por el tipo de gestión
- **Descripción:** Se agrega un perl para la "Búsqueda por el tipo de gestión".
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/92be900d3fcc4ecf3f3239dd4097352165723619...31e1f33d5b755bd324ff587710700b997443bb8a)


### 3. Búsqueda por Fechas
- **Descripción:** Se agrega un perl para la "Búsqueda por fecha".
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/c0721a24a9bafed5ee236482446a05ac0501328c...a52092806683d73194992da22c96b6d67255b947)


### 4. Búsqueda por el Lugar
- **Descripción:** Se agrega un perl para la "Búsqueda por Departamento-Provincia-Distrito".
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/a52092806683d73194992da22c96b6d67255b947...839abbb25032cdeb98c5b07f13cb4025db1b689a)


### 5. Creación del css y html
- **Descripción:** Se crea la primera base de lo que es la página web.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/839abbb25032cdeb98c5b07f13cb4025db1b689a...8538ed60783510b2faaa607da30763016c656939)
- **Este seria la primera vista de ella...**
![Captura de pantalla](codigoprevio/Captura%20desde%202024-11-06%2023-49-41.png)

### 6. Correción en el cgi-bin
- **Descripción:** El cambio principal es la validación de las entradas del formulario para garantizar la seguridad y prevenir inyecciones de código, mejorando la confiabilidad del script.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/commit/8aa645d64db2deafcb8cef97e48abafc01fbd5d1#diff-059487c65404d3f4bb56b6a5aae79908b897b829ff1564b9246f0e34c682a635R1-R3)



### 7. Corrección en las Tildes
- **Descripción:** En este commit, se hicieron cambios para que el programa pueda mostrar correctamente letras con tildes y otros caracteres especiales.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/7339b0ff0c2df6af82dbb37b002f2e812c3c5568...88d025296e80dd91117ee116422a687cd2374b05)



### 8. Mejora visual de la Página Web
- **Descripción:** Aqui se da las ultimas modificaciones al css y al html para el apartado de la Página Web.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/76988d4b7e170712e35924e5777b72446635fdc4...bc6ac06ee33c91430a5696da3860527e1d270b0c)

## APARIENCIA FINAL DE LA PAGINA WEB
![Apariencia Final](img/AparienciaFinal.png)


## RUBRICA DE CALIFICACIÓN

- En esta rubrica el alumno debe autocalificarse de manera consciente.
  
<div align="center">
    <table border="1" cellspacing="0" cellpadding="5">
        <thead>
            <tr>
                <th>ITEM</th>
                <th>DESCRIPCIÓN</th>
                <th>EXCELENTE</th>
                <th>PROCESO</th>
                <th>DEFICIENTE</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Código fuente</strong></td>
                <td>Hay porciones de código fuente importantes con numeración y explicaciones detalladas de sus funciones.</td>
                <td align="center">4</td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            <tr>
                <td><strong>Ejecución</strong></td>
                <td>Se incluyen ejecuciones/pruebas del código fuente explicadas gradualmente hasta llegar al código final del requerimiento del laboratorio.</td>
                <td align="center">4</td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            <tr>
                <td><strong>Pregunta</strong></td>
                <td>Se responde con completitud a la pregunta formulada en la tarea. (El profesor puede preguntar para refrendar calificación). Si no se le entregó pregunta, usted recopile información relevante para el laboratorio desde diferentes medios, referenciada correctamente (máximo 2 caras).</td>
                <td align="center"></td>
                <td align="center">2</td>
                <td align="center"></td>
            </tr>
            <tr>
                <td><strong>Ortografía</strong></td>
                <td>El documento no muestra errores ortográficos.</td>
                <td align="center">4</td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            <tr>
                <td><strong>Madurez</strong></td>
                <td>El Informe muestra de manera general una evolución de la madurez del código fuente, explicaciones puntuales pero precisas y un acabado impecable. (El profesor puede preguntar para refrendar calificación).</td>
                <td align="center"></td>
                <td align="center">2</td>
                <td align="center"></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><strong>CALIFICACIÓN</strong></td>
                <td align="center"><strong>12</strong></td>
                <td align="center"><strong>4</strong></td>
                <td align="center"><strong></strong></td>
            </tr>
        </tbody>
    </table>
</div>

- NOTA TOTAL: 16


## REFERENCIAS

- [Documentación de Perl](https://perldoc.perl.org/) - Guía completa de la sintaxis, funciones y módulos de Perl.
- [Expresiones regulares en Perl](https://perldoc.perl.org/perlre) - Detalles sobre el uso de expresiones regulares en Perl.
- [Introducción a CGI en Perl](https://www.tutorialspoint.com/perl/perl_cgi.htm) - Tutorial sobre cómo crear scripts CGI en Perl para desarrollo web.
- [Uso de Docker para entornos Perl](https://docs.docker.com/samples/perl/) - Documentación oficial de Docker para la configuración de entornos Perl.
- [Creación de archivos Dockerfile](https://docs.docker.com/engine/reference/builder/) - Documentación para configurar y escribir un Dockerfile.
- [Métodos HTTP GET y POST](https://www.ionos.mx/digitalguide/paginas-web/desarrollo-web/get-vs-post/) - Explicación de la diferencia entre métodos HTTP GET y POST.
- [Uso del elemento `<div>` en HTML](https://developer.mozilla.org/es/docs/Web/HTML/Element/div) - Guía sobre el uso del elemento `<div>` para estructurar el contenido en HTML.
- [Estilos modernos con CSS](https://developer.mozilla.org/es/docs/Web/CSS) - Documentación para crear estilos CSS modernos.
- [Configuración de un servidor web Apache en Docker](https://hub.docker.com/_/httpd) - Información para ejecutar un servidor web Apache en Docker.



#

[Git]: https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white
[git-site]: https://git-scm.com/

[GitHub]: https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white
[github-site]: https://github.com/

[Perl]: https://img.shields.io/badge/Perl-%23345B91.svg?style=for-the-badge&logo=perl&logoColor=white
[perl-site]: https://www.perl.org/get.html


[![Git][Git]][git-site]
[![GitHub][GitHub]][github-site]
[![Perl][Perl]][perl-site]



