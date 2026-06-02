---
layout: post
title: "Symfony en NetBeans 6.8"
date: 2009-10-08T00:12:00.002Z
last_modified_at: 2010-07-20T17:13:21.012Z
author: "Diego Silva"
permalink: /2009/10/symfony-en-netbeans-68.html
canonical_url: https://www.apuntesdejava.com/2009/10/symfony-en-netbeans-68.html
tags:
  - "php"
  - "netbeans 6.8"
  - "tutorial"
  - "netbeans"
---

Ya sé que este blog se llama "Apuntes de **Java**", pero el objetivo es también dar apuntes sobre NetBeans (ya que también fue hecho en Java... y apoyo al proyecto)

Así que este post está referido al framework para PHP Symfony. Espero que les agrade

# Symfony en NetBeans 6.8

(También se encuentra en la documentación de NetBeans: [http://wiki.netbeans.org/NB68symfony_es](http://wiki.netbeans.org/NB68symfony_es))

[Symfony](http://www.symfony-project.org/) es uno de los mejores frameworks para PHP que permite desarrollar aplicaciones web basado en MVC. Ayuda enormemente en la construcción de aplicaciones web complejas en PHP.

Aunque Symfony fue ideado para trabajar desde la línea de comandos, NetBeans 6.8 lo incluye dentro sus complementos a fin de ayudar al desarrollador en la elaboración de aplicaciones complejas.

### Instalación del componente Symfony

La instalación es bastante simple. Se puede descargar desde el centro de actualización (Herramientas > Complementos). Debemos tener instalado el complemento para PHP. Si no lo tenemos instalado, este es el mejor momento para hacerlo.

[![](http://wiki.netbeans.org/wiki/images/c/c6/Symfony-01_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/c/c6/Symfony-01_NB68symfony_es.jpg)

... y si es la primera vez que instala el PHP, es probable que le pida la instalación del JavaScript Debugger

[![](http://wiki.netbeans.org/wiki/images/8/86/Symfony-01a_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/8/86/Symfony-01a_NB68symfony_es.jpg)

Lo dejamos que cocine, y cuando termine nos preguntará que si deseamos reiniciar el IDE. Y eso haremos: reiniciar el IDE.

### Instalando Symfony

Ahora bien, lo que hemos instalado solo fue el complemento de NB para Symfony. Lo que debemos es instalar el mismo framework. Para ello debemos hacer lo siguiente

-  Descargar symfony desde aquí [http://www.symfony-project.org/installation/1_2](http://www.symfony-project.org/installation/1_2)

-  Aunque existan las [instrucciones de instalación que explica Symfony](http://www.symfony-project.org/getting-started/1_2/en/04-Symfony-Installation) nosotros seguiremos nuestro propio rumbo. Extraeremos el **contenido** del .zip en c:\ de tal manera que se haya creado una carpeta llamada c:

symfony-1.2.9. Cuando digo "**contenido**" me refiero a **no usar** la opción "descomprimir en symfony-1.2.9..." que consiste en crear una carpeta con el mismo nombre del .zip y dentro descomprimir el contenido del .zip. En su lugar, usar "descromprimir aquí..." (desde c:\).

Listo, eso es todo referente al Symfony.

Si ya has tenido instalado el Symfony en otro lado, no importa, igual sirve. Lo importante es recordar donde está.

### Configurando el componente Symfony

Ahora, en el NetBeans entremos a Herramientas > Opciones y seleccionemos la opción "PHP". Luego, abrimos la ficha "Symfony".  Lo que debemos hacer aquí es seleccionar el script principal de Symfony.

[![](http://wiki.netbeans.org/wiki/images/a/a7/Symfony-02_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/a/a7/Symfony-02_NB68symfony_es.jpg)

Notemos que es el archivo que no tiene extensión. Realmente (si lo abrimos desde un editor de texto) es un archivo .php, solo que no tiene extensión.

### Creando un proyecto

Ahora, crearemos un nuevo proyecto PHP usando el Symfony. Presionemos Mayus+Ctrl+N (Archivo > Nuevo proyecto)

[![](http://wiki.netbeans.org/wiki/images/d/db/Symfony-03a_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/d/db/Symfony-03a_NB68symfony_es.jpg)

Clic en Siguiente. Establecemos el nombre del proyecto. Para nuestro ejemplo será MiApp

[![](http://wiki.netbeans.org/wiki/images/8/83/Symfony-03b_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/8/83/Symfony-03b_NB68symfony_es.jpg)

Dejamos las demás opciones por omisión. Clic en Siguiente

Establecemos la ruta que se mostrará en el navegador cuando ejecutemos la aplicación.

Clic en Siguiente.

Ahora, seleccionamos el framework "Symfony"

[![](http://wiki.netbeans.org/wiki/images/f/f0/Symfony-03d_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/f/f0/Symfony-03d_NB68symfony_es.jpg)

Notemos que está pidiendo una clave especial, por fines de seguridad para evitar ataques [CSRF](http://en.wikipedia.org/wiki/CSRF) con tokens en formularios. Para fines de este tutorial, usaremos la misma clave propuesta: UniqueSecret.

Clic en finish

Dejemos que cocine nuevamente, y listo. Ya tenemos nuestro proyecto.

### Preparando el proyecto

#### Configurando el Apache

Esta aplicación debe ejecutarse en el [Apache Web Server](http://httpd.apache.org/) que deberiamos tenerlo instalado. Lo que [recomienda Symfony es ejecutar la aplicación de desarrollo en otro host](http://www.symfony-project.org/jobeet/1_2/Propel/es/01#chapter_01_configuracion_del_servidor_web_la_forma_segura). Este host será local y virtual, de tal manera que se ejecute bajo otro nombre de host y en otro puerto. En nuestro caso lo ejecutaremos en el puerto 9090 En el margen izquierdo de nuestro proyecto, abramos el archivo config/vhost.sample el cual tendrá un código similar a este:

```java
<code># Be sure to only have this line once in your configuration
    NameVirtualHost 127.0.0.1:80

    # This is the configuration for MiApp
    Listen 127.0.0.1:80

    <virtualhost 127.0.0.1:80="">
      ServerName MiApp.localhost
      DocumentRoot "D:\home\DSILVA\Mis documentos\NetBeansProjects\MiApp\web"
      DirectoryIndex index.php
      <directory d:\home\dsilva\mis="" documentos\netbeansprojects\miapp\web="">
        AllowOverride All
        Allow from All
      </directory>

      Alias /sf "C:\symfony-1.2.9\data\web\sf"
      <directory c:\symfony-1.2.9\data\web\sf="">
        AllowOverride All
        Allow from All
      </directory>
    </virtualhost>
</code>
```

Pues, lo que haremos primero será editar este archivo para que ejecute se ejecute en el archivo 9090, de la siguiente manera:

```java
<code># Be sure to only have this line once in your configuration
    NameVirtualHost 127.0.0.1:9090

    # This is the configuration for MiApp
    Listen 127.0.0.1:9090

    <virtualhost 127.0.0.1:9090="">
      ServerName MiApp.localhost
      DocumentRoot "D:\home\DSILVA\Mis documentos\NetBeansProjects\MiApp\web"
      DirectoryIndex index.php
      <directory d:\home\dsilva\mis="" documentos\netbeansprojects\miapp\web="">
        AllowOverride All
        Allow from All
      </directory>

      Alias /sf "C:\symfony-1.2.9\data\web\sf"
      <directory c:\symfony-1.2.9\data\web\sf="">
        AllowOverride All
        Allow from All
      </directory>
    </virtualhost>
</code>
```

Las rutas de la carpeta del proyecto ya han sido establecidas por el Symfony. Ahora,

-  copiemos este contenido,

-  abramos el archivo httpd.conf  que se encuentra en el directorio $APACHE_HOME\conf,

-  pegamos,

-  lo guardamos,

-  y reiniciamos el servicio de Apache.

Para ver si se ha configurado correctamente el Apache, abramos el navegador en [http://localhost:9090](http://localhost:9090/), o ejecutemos el proyecto con la tecla F6.

[![](http://wiki.netbeans.org/wiki/images/d/d5/Symfony-04_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/d/d5/Symfony-04_NB68symfony_es.jpg)

#### Configurando la base de datos

Ahora, nos toca crear la base de datos. Desde una consola de MySQL (puede ser útil el de la línea de comandos, o el más sofisticados que uses) ejecutemos (como root) lo siguiente:

```java
<code>create database tienda_virtual; #crea la base de datos
grant all on tienda_virtual.* to tienda_virtual@localhost identified by "tienda_virtual"; #crea un usuario con acceso a esa base de datos
</code>
```

Ejecutarlo desde el NetBeans también es más que suficiente.

Recomiendo que no se use el usuario root para acceder a una base de datos desde la aplicación. Por ello recomiendo crear un usuario por cada base de datos que se va a crear. Es por fines de seguridad.

A continuación, debemos establecer la configuración de nuestra aplicación con la base de datos. Para ello, hagamos clic derecho sobre el ícono del proyecto y seleccionemos Symfony > Run command...

[![](http://wiki.netbeans.org/wiki/images/2/22/Symfony-05_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/2/22/Symfony-05_NB68symfony_es.jpg)

Nos mostrará una consola especial para ejecutar los comandos de Symfony. En la entrada del filtro escribiremos "config" y se mostrarán los comandos asociados a configure. Seleccionamos de la lista a configure:database y escribimos como argumentos "mysql:host=localhost;dbname=tienda" tienda tienda

[![](http://wiki.netbeans.org/wiki/images/6/6e/Symfony-05a_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/6/6e/Symfony-05a_NB68symfony_es.jpg)

Luego, clic en "Run"

Podremos ver que se ha actualizado el archivo config/databases.yml

#### Creando las tablas

Las tablas se pueden crear desde el archivo config/schema.yml. Un archivo [.yml](http://yaml.org/) es una serialización estándar y amigable para los lenguajes de programación.  Tendremos dos tablas: tipo_producto y producto. Para ello, editaremos el archivo config/schema.yml con lo siguiente:

```java
<code>propel:
  tipo_producto:
    id_tipo: ~
    nombre_tipo: {type: varchar(255)}
  producto:
    id_producto: ~
    id_tipo: {type: integer,foreignTable: tipo_producto, foreignReference: id_tipo,required: true}
    nombre_producto: {type: varchar(255)}
    stock: {type: integer}
    precio: {type: double(10,5)}
</code>
```

Notar los espacios que hay entre cada declaración, tipo y el valor.

Ahora, haremos que el symfony cree las tablas. Para ello, desde la consola de symfony, buscamos filtramos los comandos propel:, seleccionamos propel:insert-sql

[![](http://wiki.netbeans.org/wiki/images/7/7e/Symfony-05b_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/7/7e/Symfony-05b_NB68symfony_es.jpg)

Con esto, creará el esquema para nuestra aplicación y también las tablas en nuestra base de datos

[![](http://wiki.netbeans.org/wiki/images/2/22/Symfony-05c_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/2/22/Symfony-05c_NB68symfony_es.jpg)

Si ya tienes una base de datos creadas, ignora la edición de config/schema.yml y ejecuta desde el symfony el comando  propel:build-squema

Y para finalizar con la base de datos, debemos crear el modelo de datos, que consiste en un mapeo entre clases php con las tablas de nuestra base de datos. Para ello ejecutemos el comando propel:build-model

Después de ello, veremos el resultado en la carpeta lib

[![](http://wiki.netbeans.org/wiki/images/8/89/Symfony-05d_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/8/89/Symfony-05d_NB68symfony_es.jpg)

Vaya, hasta ahora no hemos escrito ni un archivo .php.

#### Ejecutando la aplicación

La aplicación no está del todo terminada. Faltan los estilos, colores, etc. Pero ya se puede ver algo. Antes de eso, debemos construir la aplicación. Para ello ejecutemos el comando propel:build-all. Con esto construye todo lo referente al esquema, hasta los formularios.

[![](http://wiki.netbeans.org/wiki/images/e/e3/Symfony-06a_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/e/e3/Symfony-06a_NB68symfony_es.jpg)

Luego, ejecutamos propel:generate-module con los parámetros como se ven en la imagen.

[![](http://wiki.netbeans.org/wiki/images/1/1f/Symfony-06b_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/1/1f/Symfony-06b_NB68symfony_es.jpg)

Y así tendremos el mantenimiento para la tabla "tipo_producto". Clic aquí para ver [http://localhost:9090/frontend_dev.php/tipo](http://localhost:9090/frontend_dev.php/tipo)

[![](http://wiki.netbeans.org/wiki/images/5/5c/Symfony-06c_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/5/5c/Symfony-06c_NB68symfony_es.jpg)

[![](http://wiki.netbeans.org/wiki/images/b/b7/Symfony-06d_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/b/b7/Symfony-06d_NB68symfony_es.jpg)

[![](http://wiki.netbeans.org/wiki/images/0/0c/Symfony-06e_NB68symfony_es.jpg)](http://wiki.netbeans.org/wiki/images/0/0c/Symfony-06e_NB68symfony_es.jpg)

### Finalmente

Como el fin de este tutorial no era un curso de Symfony, sugiero leer el manual práctico [http://www.symfony-project.org/jobeet/1_2/Propel/es/](http://www.symfony-project.org/jobeet/1_2/Propel/es/) que en 24 dias (a razón de una hora cada día) uno puede hacer un proyecto funcional con Symfony.
