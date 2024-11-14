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
<tr><td>TÍTULO DE LA PRÁCTICA:</td><td colspan="5">Ejemplo Unificado y Archivo de Universidades Licenciadas
</td></tr>
<tr>
<td>NÚMERO DE PRÁCTICA:</td><td>01</td><td>AÑO LECTIVO:</td><td>2024 b</td><td>NRO. SEMESTRE:</td><td>II</td>
</tr>
<tr>
<td>FECHA INICIO:</td><td>04-Nov-2024</td><td>FECHA FIN:</td><td>10-Nov-2024</td><td>DURACIÓN:</td><td>04 horas</td>
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

- Aprender a manejar el sistema de control de versiones Git y utilizar GitHub para trabajar de manera colaborativa.
- Hacer el uso de commits para observar las modificaciones.

### TEMAS
- Docker
- Git
- GitHub
- Perl
- Expresiones Regulares
- 
## CONTENIDO DE LA GUÍA

### MARCO CONCEPTUAL

- Docker
    - Docker es una plataforma que permite empaquetar, distribuir y ejecutar aplicaciones en contenedores aislados.
    
- Instalar Docker en:

    - GNU/Linux
        - Para instalar Vim en cualquier distribución GNU/Linux use sus mismos repositorios
        - ```sh
          sudo apt install docker-ce
          ```

	- MS Windows
        - Para descarga en sistemas MS Windows: https://www.docker.com/products/docker-desktop

	- MacOS
        - Para instalar Docker en sistemas MacOS puede usar brew
        -   ```sh
            brew install --cask docker
            ```

#

- Perl
    - Perl es un lenguaje de programación usado principalmente para la manipulación de texto y desarrollo web.
  
    - Instalar Perl

        - GNU/Linux
            - Para descarga en sistemas GNU/Linux puede usar OpenJDK
            -   ```sh
                sudo apt install perl
                ```
            
        - MS Windows
            - Para descarga en sistemas Windows: https://www.perl.org/get.html
        
        - MacOS
            - Para descarga en sistemas macOS: https://www.perl.org/get.html


#

- Git
    - Git es un sistema de control de versiones creado por Linus Torvalds. Es eficiente, confiable. 

- Instalar Git

	- GNU/Linux
        - Para descarga en sistemas GNU/Linux desde https://git-scm.com/download/linux
        -   ```sh
            apt-get install git
            ```
        
	- MS Windows
        - Para descarga en sistemas MS Windows https://git-scm.com/download/win
    
    - MacOS
        - Para descarga en sistemas MacOS https://git-scm.com/download/mac
        -   ```sh
            brew install git
            ```

## EJECUCION DE LA PAGINA
       
- Contruccion de la imagen 
    -   ```sh
        docker build -t universidades .
        ```

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

### 1. Solución de Problemas de Tildes
- **Descripción:** Este commit corrige los signos de interrogación en las letras con tilde.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/7339b0ff0c2df6af82dbb37b002f2e812c3c5568...88d025296e80dd91117ee116422a687cd2374b05)


### 2. Eliminación de Apartados Innecesarios
- **Descripción:** Se eliminaron secciones del código que ya no eran necesarias, optimizando el proyecto.
- **Enlace:** [Ver Cambios](https://github.com/RoEsPa/pw1-24b/compare/bd273025b849fc56605680d82ef3ecc017cb6715...304c3304b10eeb991d17c8c3c4ba04c5f57624d4)


### 3. Actualización de Estructura de Carpetas
- **Descripción:** Reorganización de archivos y carpetas para una mejor estructuración del proyecto.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)


### 4. Mejora de la Documentación
- **Descripción:** Se agregó información adicional a la documentación para facilitar la comprensión del proyecto.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



### 5. Optimización del Código CSS
- **Descripción:** Se realizaron ajustes en el código CSS para mejorar el diseño y el rendimiento.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



### 6. Refactorización del Código Perl
- **Descripción:** Se limpiaron y optimizaron funciones en Perl para mejorar la eficiencia del script.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



### 7. Corrección de Errores en la Lógica de Cálculo
- **Descripción:** Corrección de errores detectados en la lógica de operaciones matemáticas.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



### 8. Implementación de Pruebas Automatizadas
- **Descripción:** Se añadieron pruebas automatizadas para validar el funcionamiento de las operaciones.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



### 9. Mejoras de Seguridad
- **Descripción:** Se implementaron medidas de seguridad para evitar inyecciones y otros riesgos.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



### 10. Últimos Ajustes y Preparación para Entrega
- **Descripción:** Ajustes finales y verificación de compatibilidad antes de la entrega del proyecto.
- **Enlace:** [Ver Cambios](URL_DEL_COMMIT)



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
                <td align="center">2</td>
                <td align="center">1</td>
            </tr>
            <tr>
                <td><strong>Ejecución</strong></td>
                <td>Se incluyen ejecuciones/pruebas del código fuente explicadas gradualmente hasta llegar al código final del requerimiento del laboratorio.</td>
                <td align="center">4</td>
                <td align="center">2</td>
                <td align="center">1</td>
            </tr>
            <tr>
                <td><strong>Pregunta</strong></td>
                <td>Se responde con completitud a la pregunta formulada en la tarea. (El profesor puede preguntar para refrendar calificación). Si no se le entregó pregunta, usted recopile información relevante para el laboratorio desde diferentes medios, referenciada correctamente (máximo 2 caras).</td>
                <td align="center">4</td>
                <td align="center">2</td>
                <td align="center">1</td>
            </tr>
            <tr>
                <td><strong>Ortografía</strong></td>
                <td>El documento no muestra errores ortográficos.</td>
                <td align="center">4</td>
                <td align="center">2</td>
                <td align="center">1</td>
            </tr>
            <tr>
                <td><strong>Madurez</strong></td>
                <td>El Informe muestra de manera general una evolución de la madurez del código fuente, explicaciones puntuales pero precisas y un acabado impecable. (El profesor puede preguntar para refrendar calificación).</td>
                <td align="center">4</td>
                <td align="center">2</td>
                <td align="center">1</td>
            </tr>
            <tr>
                <td colspan="2" align="center"><strong>CALIFICACIÓN</strong></td>
                <td align="center"><strong>20</strong></td>
                <td align="center"><strong>10</strong></td>
                <td align="center"><strong>5</strong></td>
            </tr>
        </tbody>
    </table>
</div>

- NOTA TOTAL:


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



