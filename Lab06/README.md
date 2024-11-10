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
<tr><td>TÍTULO DE LA PRÁCTICA:</td><td colspan="5">Git/GitHub CGI/Perl Files</td></tr>
<tr>
<td>NÚMERO DE PRÁCTICA:</td><td>01</td><td>AÑO LECTIVO:</td><td>2024 b</td><td>NRO. SEMESTRE:</td><td>II</td>
</tr>
<tr>
<td>FECHA INICIO::</td><td>04-Nov-2024</td><td>FECHA FIN:</td><td>10-Nov-2024</td><td>DURACIÓN:</td><td>04 horas</td>
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
        ocker run -d -p 8097:80 universidades
        ```

- link de la Pagina
    -   ```sh
        http://localhost:8097/
        ```

## REPOSITORIO EN DONDE SE TRABAJO

- Este trabajo fue grupal por que se acordo trabajar en un solo repositorio y los demas trabajando como colaboradores.
    - GitHub en donde se trabajo
    -   ```sh
        
        ```

    - Aqui se podra ver la lista de commits que se hizo en el repositorio.
    -   ```sh
          
        ```
## COMMITS IMPORTANTES

- En este commit se hizo para solucionar el problema de las tildes(sigono de interrogacion en la letras con tilde).
	- https://github.com/RoEsPa/pw1-24b/compare/7339b0ff0c2df6af82dbb37b002f2e812c3c5568...88d025296e80dd91117ee116422a687cd2374b05

- En este otro se hizo la eliminacion de ciertos apartados innecesarios.
   	 - https://github.com/RoEsPa/pw1-24b/compare/bd273025b849fc56605680d82ef3ecc017cb6715...304c3304b10eeb991d17c8c3c4ba04c5f57624d4

- git push
    - Permite subir archivos al repositorio remoto
    	-   ```sh
        git push -u origin main    
        ```

- git show
    - Muestra detalles del commit actual
    	-   ```sh
        git show
        ```

-   git log
    - Permite ver un resumen de los commit realizados
    -   ```sh
        git log
        git log --pretty=oneline
        git log --graph --pretty=oneline --abbrev-commit --all
        git log --pretty=format:"%h - %an, %ar : %s"
        git log -p -2
        ```
    -   <pre>
        6bb6b6e - Richart Escobedo Quispe, hace 3 minutos : Git - GitHub
        6bb6b6e - Richart Escobedo Quispe, hace 12 minutos : Git - GitHub
        b36a9fd - Richart Escobedo Quispe, hace 14 minutos : Git - GitHub
        e86aac8 - Richart Escobedo Quispe, hace 22 minutos : Git - GitHub
        e58f653 - Richart Escobedo Quispe, hace 31 minutos : first commit
        5747062 - Richart Escobedo Quispe, hace 35 minutos : first commit
        </pre>

- git diff
    - Permite comparar los cambios en los archivos
    -   ```sh
        git diff 6bb6b6e 6bb6b6e
        ```

- git branch
    - Permite ver las ramas existentes o crea una rama alternativa al proyecto principal git branch -a
    -   ```sh
        git branch prueba1
        git branch
        ```
    -   <pre>
        * main
        prueba1
        </pre>

- git checkout
    - Permite regresar a versiones anteriores o saltar a otra rama
    -   ```sh
        git checkout prueba1
        git branch
        ```
    -   <pre>
        main
        * prueba1
        </pre>


- git pull
    - Permite descargar los cambios del repositorio remoto al directorio local
    -   ```sh
        git pull
        ```
    -   ```sh
        git checkout nueva_rama
        git pull <remote repo>
        ```
    -   ```sh
        git checkout main
        git pull --rebase origin
        ```

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

#

## REFERENCIAS
- Uso de commits - https://www.atlassian.com/es/git/tutorials/saving-changes/git-commit
- Creacion de un repositorio - https://docs.github.com/es/repositories/creating-and-managing-repositories/quickstart-for-repositories
- Diferencias entre Get y Post - https://www.ionos.mx/digitalguide/paginas-web/desarrollo-web/get-vs-post/
- Uso del Div - https://developer.mozilla.org/es/docs/Web/HTML/Element/div


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



