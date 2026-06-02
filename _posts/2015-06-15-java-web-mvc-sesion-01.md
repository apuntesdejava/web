---
layout: post
title: "Java Web MVC - Sesión 01"
date: 2015-06-15T18:40:00Z
last_modified_at: 2018-01-10T23:49:27.579Z
author: "Diego Silva Límaco"
permalink: /2015/06/java-web-mvc-sesion-01.html
canonical_url: https://www.apuntesdejava.com/2015/06/java-web-mvc-sesion-01.html
tags:
  - "glassfish v4"
  - "java"
  - "netbeans 8"
  - "web"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "tutorial"
---

![Java Web MVC - Sesión 01](/assets/blogger/javaee1_large.png)

Con este tutorial comienzo una nueva serie en este humilde blog.

Aprenderemos a conocer todas las funcionalidades de Java EE en una aplicación.

En este primer post haremos una aplicación MVC básico, usando las siguientes tecnologías de Java EE7:

- JSP (para la capa de presentación)

- Servlet (para la controladora)

- EJB (Para el manejo del modelo)

- JPA (La persistencia de datos)

La base de datos es indiferente, podemos usar PostgreSQL, MySQL, Oracle, etc. Pero para este ejemplo estoy usando Apache Derby.

Orientado a todo programador Java que se inicia en la programación web.

He colgado un vídeo aquí, un poco largo ([http://youtu.be/9JwXoL0FSBs](http://youtu.be/9JwXoL0FSBs)), pero trata lo mismo que está en este tutorial.

<iframe allowfullscreen="" class="YOUTUBE-iframe-video" frameborder="0" height="410" src="https://www.youtube.com/embed/9JwXoL0FSBs?feature=player_embedded" width="730"></iframe>

## Lo que vamos a ver

Aquí tengo una presentación que resume lo que veremos en este tutorial

<iframe allowfullscreen="true" frameborder="0" height="299" mozallowfullscreen="true" src="https://docs.google.com/presentation/d/1BPNwwUSKSH70xthG0W7ISrR01K_Lv4tU375KDktaZH0/embed?start=false&amp;loop=false&amp;delayms=3000" webkitallowfullscreen="true" width="480"></iframe>

## El caso

Consiste en simular una aplicación de Aula Virtual. En esta aplicación cualquier usuario puede registrarse en la aplicación, además que el administrador puede registrar y gestionar los alumnos.

Además, un profesor puede registrar sus cursos, y eventualmente puede asignar alumnos a los cursos. Y, los alumnos pueden registrarse en un curso.

Aquí el diagrama de Caso de Uso.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjY41Kw6wja8eOFtJntgMuCauPUXT4d3eebMnYyOqlGysyprNXAnh359nKuLBKYIFQLSInIrk-1IUsRCTai1B17tLPYJeSLbiwPESO5fOhI2GRgiWQb5WYZlAE1QWZYApt4uapmyuWfMEY/s640/15-06-2015+01-52-40+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjY41Kw6wja8eOFtJntgMuCauPUXT4d3eebMnYyOqlGysyprNXAnh359nKuLBKYIFQLSInIrk-1IUsRCTai1B17tLPYJeSLbiwPESO5fOhI2GRgiWQb5WYZlAE1QWZYApt4uapmyuWfMEY/s1600/15-06-2015+01-52-40+p.m..png)

Como desarrollar todo es largo, lo haremos por partes. Por ello, solo en este tutorial haremos el caso de uso que corresponde a registrar al alumno (qué fácil, no?), y en los siguientes tutoriales haremos los siguientes casos de uso (Ahí viene lo más interesante).

### Modelo: La Unidad de Persistencia

Necesitamos conectar nuestra aplicación a la base de datos, pero dejaremos que el JPA (Java Persistence API) se encargue de conectarse a ella.

La Unidad de Persistencia consiste en un archivo de configuración donde se indica las persistencia que tendrá la aplicación. Debe tener un nombre y la conexión en sí.

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/resources/META-INF/persistence.xml?embed=t"></script>

Esta Unidad de Persistencia apunta al JNDI `jdbc/aulavirtual` que es un DataSource. Este datasource fue configurado en el contenedor Java, en nuestro caso es GlassFish.

### Modelo: La entidad

Ya que conocemos cómo debería lucir la pantalla de registro, haremos la Entidad que registrará todos estos datos. Una entidad es análoga a una tabla en la base de datos, de tal manera que cada registro en la tabla es una instancia en la clase.

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/entities/Alumno.java?embed=t"></script>

En esta misma clase podemos definir el ID que es el campo clave. El IDE nos ha creado la manera como se autoincrementará el valor. Además, también podemos definir el tamaño de cada columna.

No olvidar poner los métodos set y get, ya que una entidad debe tener el patrón [Java Bean](https://docs.oracle.com/javase/tutorial/javabeans/writing/index.html).

### Modelo: EJB

Tendremos un EJB que se encargará de manejar los objetos de la entidad en la persistencia. Usando el IDE, nos creará una clase abstracta que tendrá todo lo necesario para manejar los objetos.

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/ejb/AbstractFacade.java?embed=t"></script>

Y nos creará una clase concreta (el EJB en sí) que se le indicará cuál es entidad que deberá manejar.

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/ejb/AlumnoFacade.java?embed=t"></script>

Utilizando el polimorfismo, y la herencia, tendremos este EJB con los métodos para Crear, Modificar, Actualizar y Eliminar (CRUD)

### Vista: El formulario

Ya que tenemos definido los campos que vamos a tener, necesitamos crear el formulario. Esto lo haremos con JSP, y usaremos tags HTML5

Algo importante: para evitar confusiones en adelante, debamos poner el mismo nombre de las propiedades iguales.

Aquí estamos usando [Bootstrap](http://getbootstrap.com/) para que luzca mejor. Además, si seguimos las directrices que indica, se podrá tener el formulario en modo responsive.

El campo para la fecha era de tipo date `<input type="date" />, p`ero en Firefox no funciona, por lo que hemos usado el selector de fecha de JQueryUI: [https://jqueryui.com/datepicker/](https://jqueryui.com/datepicker/)

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/webapp/alumno_form.jsp?embed=t"></script>

Además, tendremos una página JSP que nos mostrará que el registro se ha guardado correctamente, y mostrará un enlace para que se pueda editar los datos del usuario.

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/webapp/alumno_reg_success.jsp?embed=t"></script>

### Controlador: Los Servlets

El formulario apunta a un servlet ([línea 28](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/webapp/alumno_form.jsp?at=master#cl-28)) que recibirá los datos puestos en el formulario. En este servlet se podrá leer los campos uno por uno (Líneas 60 al 65)

Con estos datos, crearemos un objeto (Línea 74) para guardar los datos recibidos en cada propiedad del objeto (Línea 76 al 79).

Como el campo "fechaNacimiento" es enviado como una cadena, necesitamos convertirlo a un tipo Fecha real (Líneas 45 y 65). Es importante guardarlo como fecha para poder hacer manipulaciones con el valor, lo cual no se podría hacer usando una cadena en sí.

Para guardarlo en la base de datos, necesitamos del EJB creado hace un momento (Línea 43). Basta con llamar a su método respectivo, se tendrá el objeto guardado en la base de datos (Líneas 81 y 83).

Si estamos usando un mismo formulario ¿Cómo diferenciar que se trata de un nuevo registro y no de una modificación de datos? Por el ID. Si se está recibiendo el ID, entonces se ha cargado los datos, y lo que se está recibiendo son para guardar los nuevos datos. Pero si no tiene valor el parámetro ID, entonces consiste en un registro nuevo (Línea 72).

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/servlet/RegistroAlumnoServlet.java?embed=t"></script>

Adicionalmente, existe otro servlet...

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/servlet/CargarAlumnoServlet.java?embed=t"></script>

... que recibirá como parámetro el ID del registro ([Línea 50](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/servlet/CargarAlumnoServlet.java?at=master#cl-50)). Este se encargará de buscar en la base de datos ([Línea 52](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/servlet/CargarAlumnoServlet.java?at=master#cl-52)), y lo guarda como variable de sesión ([Línea 53](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/servlet/CargarAlumnoServlet.java?at=master#cl-53)), redirecciona la página a el formulario ([Línea 54](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/a6b2cb05d458178372d43ec951e33904c01614b1/src/main/java/com/apuntesdejava/aulavirtual/servlet/CargarAlumnoServlet.java?at=master#cl-54)) **¿Para qué lo guarda como variable de sesión?** Para que pueda ser usado en el formulario. Noten que en el formulario se hace referencia al objeto `${alumno.nombre}`, `${alumno.sexo}` etc

### Código fuente

El código fuente está disponible aquí:

- [https://bitbucket.org/apuntesdejava/aulavirtual-web/](https://bitbucket.org/apuntesdejava/aulavirtual-web/)

- [http://github.com/apuntesdejava/aulavirtual-web](http://github.com/apuntesdejava/aulavirtual-web)
