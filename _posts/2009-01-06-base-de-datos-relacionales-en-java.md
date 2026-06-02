---
layout: post
title: "Base de datos relacionales en Java: HSQLDB y Apache Derby (Parte 1)"
date: 2009-01-06T16:51:00Z
last_modified_at: 2009-04-25T21:55:03.205Z
author: "Diego Silva"
permalink: /2009/01/base-de-datos-relacionales-en-java.html
canonical_url: https://www.apuntesdejava.com/2009/01/base-de-datos-relacionales-en-java.html
tags:
  - "apache"
  - "java"
  - "netbeans 6.5"
  - "jdbc"
  - "netbeans 6.1"
  - "netbeans"
---

Hola a todos
comenzaré este año con un post que quizás para algunos sea aburrido. Base de datos relacionales 100% Java.

Ojo, no estoy diciendo que sean bases de datos orientados a objetos. Eso es otro tema. Sino, que son bases de datos relacionales (esos de Entidad-relación, tuplas, relaciones, columnas, claves foráneas, etc.) cuyo motor está hecho en Java. Por tanto, si queremos modificar algo de su funcionamiento, pues encontraremos el código en Java. No en C, ni C++, ni C#, sino en Java.

Sabemos que los drivers de [tipo 4 de JDBC](http://java.sun.com/docs/books/tutorial/jdbc/basics/gettingstarted.html#pgfId=1006632) se conectan directamente a la base de datos usando protocolos de red en java puro. Entonces, podemos suponer que usando bases de datos en java con jdbc en java, la conexión es mucho más directa, y se accede a los datos sin intermediarios. Bueno, es solo una suposición personal.

En este post comentaré de dos RBDMS en Java muy conocidos y usados: [HSQLDB](http://www.hsqldb.org/) y [Apache Derby](http://db.apache.org/derby/). Haremos ejemplos usando NetBeans 6.5, aunque también funcionará en NetBeans 6.1.

Comenzaré con el que más me gusta y más conozco:

## HSQLDB

Es la continuación del proyecto HypersonicSQL desde 2001. Permite varias sentencias [SQL - ANSI92](http://www.contrib.andrew.cmu.edu/%7Eshadow/sql/sql1992.txt).

Descargaremos la biblioteca JDBC, que a su vez también es el RDBMS, de aquí:

[http://downloads.sourceforge.net/hsqldb/hsqldb_1_8_0_10.zip](http://downloads.sourceforge.net/hsqldb/hsqldb_1_8_0_10.zip)

(La versión utilizada en este post es la 1.8.0.10)

Solo pesa 3.6 MB

Al descomprimirlo encontraremos varias carpetas. La carpeta lib contiene el driver hsqldb.jar y este .jar es el más importante para todo el HSQLDB, ya que es el JDBC y a su vez el motor de la base de datos.

### Modos de uso

HSQLDB tiene los siguientes modos de uso:

#### HSQLDB Server

Es un modo cliente-servidor. Es decir, de la manera común que siempre hemos visto como operan los RBDMS como Oracle, MySQL, Firebird, PostgreSQL, etc. Esto es: se ejecuta la aplicación desde cualquier host quedando en espera (servidor), y desde cualquier otro host puede acceder como cliente al servidor.

**Hagamos un ejemplo:** Desde una ventana de la consola del Sistema Operativo, vayamos a la carpeta que se descomprimió el contenido del archivo .zip. En mi caso es **d:\proys\lib\hsqldb**. (Nota: el directorio *hsqldb* debe contener el directorio *lib *para poder realizar lo siguiente) Una vez allí ejecutamos lo siguiente:

```java
<code>java -cp lib/hsqldb.jar org.hsqldb.Server <span style="color: #38761d;">-database.0 file:data/demo_db</span> <span style="color: blue;">-dbname.0 xdb</span></code>
```

Al ejecutar esto, la ventana de consola muestra lo siguiente:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi_LNvZ0mDymtdvzX74Sjlum5epK6cBUmMTkEhXEMe0F7oCBdfB7l9LRlkdrl6rZwluTIdVUwtvD_xhwAxDSfIa19ePVJyUdQ80RbyVTyfnPssoWMZjc7uDlQ8Fvo1qnPKtiNB3BowJMPHL/s400/cmd-hsqldb.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi_LNvZ0mDymtdvzX74Sjlum5epK6cBUmMTkEhXEMe0F7oCBdfB7l9LRlkdrl6rZwluTIdVUwtvD_xhwAxDSfIa19ePVJyUdQ80RbyVTyfnPssoWMZjc7uDlQ8Fvo1qnPKtiNB3BowJMPHL/s1600-h/cmd-hsqldb.jpg)

Ya sabemos qué significa java -cp y su argumento lib/hsqldb.jar.

Pero nuestra clase org.hsqldb.Server tiene cuatro argumentos importantes. Estos argumentos son realmente dos importantes:

-database.0 file:data/demo_db: Este parámetro indica cual es la base de datos que se va a crear físicamente. Como pueden crearse varias bases de datos, debemos diferenciar cada una usando un número después del parámetro *-database.*. Es decir, en este caso, nuestra base de datos tiene el número 0 (-database.**0**). Luego con el parámetro *file:* se especifíca  dónde se va a ubicar físicamente el archivo de la base de datos. En este caso se creará el archivo *demo_db* dentro de la carpeta *data*. Puede ser una ruta relativa o absoluta de disco. (file:data/demo_db)

-dbname.0 **xdb**** **Indica el nombre de la base de datos. También se tiene que especificar el número de la base de datos que debe coincidir con el argumento -database. En este ejemplo, el nombre de la base de datos es xdb. Esto es que para acceder desde Java debemos indicar el nombre xdb y no el archivo físico.

Esto quiere decir que si deseamos tener otra base de datos adicional llamada *clientes*, debemos escribir todo esto:

```java
<code>java -cp lib/hsqldb.jar org.hsqldb.Server <span style="color: #38761d;">-database.0 file:data/demo_db</span> <span style="color: blue;">-dbname.0 xdb </span> <b><span style="color: #38761d;">-database.1 file:data/clientes_db</span> <span style="color: blue;">-dbname.1 clientes</span></b></code>
```

Ahora bien, ¿cómo se accede desde java? Bien, usaremos el NetBeans, en el panel de "Prestaciones" (Ctrl+5). En el nodo "Controladores" hagamos clic derecho y seleccionamos "Nuevo controlador..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjmda2mqkdXD1aqhoQtQdsEfQ1_U1VILG9LUOONHhPU8zouCoZFYdJ9aHLElrzQ3MEgXZX1Ow6T3BdADCuuyKul0nwvyS2LOtJCYZiykpY2FkqzZbsjxNYYx3IvO_kXKoauWCPqRJ3Z_c0a/s320/hsqldb-2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjmda2mqkdXD1aqhoQtQdsEfQ1_U1VILG9LUOONHhPU8zouCoZFYdJ9aHLElrzQ3MEgXZX1Ow6T3BdADCuuyKul0nwvyS2LOtJCYZiykpY2FkqzZbsjxNYYx3IvO_kXKoauWCPqRJ3Z_c0a/s1600-h/hsqldb-2.jpg)

Con esto se abrirá una ventana de diálogo "Nuevo Driver JDBC". Hacemos clic en el botón "Agregar..." y buscamos el archivo hsqldb.jar (Sí, el mismo que usamos para ejecutar nuestro servidor... como dije antes: ese mismo archivo es el motor y el driver)

Una vez seleccionado, el NetBeans encontrará la clase controladora de la base de datos:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjiDq1bwVsP7buZahb0_znougZi9pIGCVV5mJsa7lUIpBFFfHXP7i5aWAr6-YAxYECyhlykOQzzvmir2LzYq9Er8ZAz18EqdCXzDdlD85GPOzC3oQH6yE-C5-wutHQB-2nWN-u9_ZcZ3cTJ/s400/hsqldb-3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjiDq1bwVsP7buZahb0_znougZi9pIGCVV5mJsa7lUIpBFFfHXP7i5aWAr6-YAxYECyhlykOQzzvmir2LzYq9Er8ZAz18EqdCXzDdlD85GPOzC3oQH6yE-C5-wutHQB-2nWN-u9_ZcZ3cTJ/s1600-h/hsqldb-3.jpg)

Clic en "Aceptar". Y se agregará un nuevo elemento bajo el nodo "Controladores" llamado "HSQLDB". Hacemos clic derecho sobre este nodo creado y seleccionamos "Conectar usando..." para crear una conexión usando este controlador. Se presentará la ventana de diálogo "nueva coneixón de base de datos...". Escribimos lo siguiente:

- nombre de usuario: sa
- password: (nada)
- JDBC URL: **jdbc:hsqldb:hsql://localhost/xdb**

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhocv6sb7mspGxIO5OncpsH6dfeMXy7acYbM3MNwXGSncjpptDsLuHrQJilnvKZifxtMY_OHNL2L92cQwn-Qh6VPNlPXVtpv_9BbdVG6JlwB2YKmhAIAmX2TEFdyMVYYquSRkIcVUcb-1Ox/s400/hsqldb-4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhocv6sb7mspGxIO5OncpsH6dfeMXy7acYbM3MNwXGSncjpptDsLuHrQJilnvKZifxtMY_OHNL2L92cQwn-Qh6VPNlPXVtpv_9BbdVG6JlwB2YKmhAIAmX2TEFdyMVYYquSRkIcVUcb-1Ox/s1600-h/hsqldb-4.jpg)

Note que el nombre de la base de datos es **xbd** tal como lo especificamos cuando ejecutamos el servidor. Clic en Aceptar, y al mostrarse el esquema que debemos seleccionar, dejamos la opción predeterminada  "INFORMATION_SCHEMA". Se creará un nuevo nodo de conexión, y al abrirlo podemos ver su contenido. Claro, en este momento no hay ninguna tabla creada.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiP1tUkgpKW5qhu_ZuqMw-vJZylautRh2GbQS5FNJN5-yxb7j7Crd2G0ifqENEzLMj8a8LfHLphtsrIxVOwO55UoflWA1W7ySXGGl0Xfkv399VZ4MKxxsYH1nTCWeX0Slj1ag1zh23JF2iT/s320/hsqldb-5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiP1tUkgpKW5qhu_ZuqMw-vJZylautRh2GbQS5FNJN5-yxb7j7Crd2G0ifqENEzLMj8a8LfHLphtsrIxVOwO55UoflWA1W7ySXGGl0Xfkv399VZ4MKxxsYH1nTCWeX0Slj1ag1zh23JF2iT/s1600-h/hsqldb-5.jpg)

Pero como podemos ver, es como cualquier otra conexión a base de datos.
Desde el IDE podemos crear tablas, usando sentencias SQL.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgp3oyfK3JBQ-cjNC-0wEohqnqgp0e0esxaGgLfsANPdwVUfVdN2L5aS3SORPp_PnUj6ouA3oE5rH_3R3QM_sSSyzxzCElBpIo04cM3YCa0De7udOd11iEwwYTwpmd9w9Oo_5-4CDZOfJIi/s320/hsqldb-7.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgp3oyfK3JBQ-cjNC-0wEohqnqgp0e0esxaGgLfsANPdwVUfVdN2L5aS3SORPp_PnUj6ouA3oE5rH_3R3QM_sSSyzxzCElBpIo04cM3YCa0De7udOd11iEwwYTwpmd9w9Oo_5-4CDZOfJIi/s1600-h/hsqldb-7.jpg)

Es posible que las tablas creadas no se visualicen en el IDE de NetBeans. Pero sí podemos ejecutar sentencias SQL DDL o DML con total normalidad:

Ahora, podemos visualizar la carpeta *hsqldb/data*.Vemos que se ha creado al menos dos archivos por cada base de datos. Todas nuestras sentencias DDL (create, drop, alter, etc) y DML (select, insert, update, etc) se registrarán en el archivo de extensión .script. Es decir, que podemos modificar estos archivos manualmente para crear nuestras tablas y los datos que contendrán. Para poder modificar este archivo, debemos detener la base de datos.

También podemos acceder a las tablas de la base de datos utilizando una herramienta propia del hsqldb. Regresemos nuevamente a nuestra consola y ejecutemos lo siguiente (el servidor deberá aún estar en ejecución, asi que es necesario abrir una nueva ventana de consola)

```java
<code>java -cp lib/hsqldb.jar <b>org.hsqldb.util.DatabaseManager</b></code>
```

En la ventana de diálogo "Connect" que aparece escribimos el mismo URL que escribimos párrafos arriba, el mismo usuario y nada en la contraseña. El driver y el tipo son opcionales.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0vJrEk28yJE7ZgmM89YHwWu7NNMUNOjtgYfmAkVFepT1SlXEQFsjk-9ubZPmKw2YXbK2iqXhpZtOqrN4a1zajK5ZYMnfeo-c5iVwZNGLrosX3rKciMM1iz9HN2-Wm-t9tVXkc1BPqyme-/s320/hsqldb-8.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0vJrEk28yJE7ZgmM89YHwWu7NNMUNOjtgYfmAkVFepT1SlXEQFsjk-9ubZPmKw2YXbK2iqXhpZtOqrN4a1zajK5ZYMnfeo-c5iVwZNGLrosX3rKciMM1iz9HN2-Wm-t9tVXkc1BPqyme-/s1600-h/hsqldb-8.jpg)

Clic en OK y listo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjnIEUGNYWY8Be1Enwy2j1Tqs3ELnZFsVBzlnMGIEcev58r_VOYV0-AE548WD9Vz6AsnqXBmxtqLyNK_-5V-BF6jF-7STRsPLWsQjmOruQV3sMTi_GyLQywu3BH73G-YBN1XDlb-SJSqMCI/s320/hsqldb-9.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjnIEUGNYWY8Be1Enwy2j1Tqs3ELnZFsVBzlnMGIEcev58r_VOYV0-AE548WD9Vz6AsnqXBmxtqLyNK_-5V-BF6jF-7STRsPLWsQjmOruQV3sMTi_GyLQywu3BH73G-YBN1XDlb-SJSqMCI/s1600-h/hsqldb-9.jpg)

Este manejador de base de datos es muy interesante, simple y efectivo. No detallaré esta herramienta ya que no es el motivo de este post.

Así pues, ya tenemos el servidor, y sabemos como conectarnos con él.

¿y cómo puede conectarse desde un programa java? Pues ya se puede imaginar:

```java
<code>Class.forName("org.hsqldb.jdbcDriver");<br />Connection conn = DriverManager.getConnection("jdbc:hsqldb:hsql://localhost/xdb", "sa", "");<br /></code>
```

#### Hsqldb Web Server

Este modo es muy interesante.Todos sabemos que por seguridad de redes los firewall evitan el uso de puertos adicionales a los permitidos. Los puertos por omisión del HSQLDB Server es el  9001 y el 544. Pero HSQLDB nos da la posibilidad de usar el puerto 80 como si fuera un servidor web.

Se ejecuta de la misma manera que el modo Server, pero se usa la clase WebServer. Es decir, debe ejecutarse de la siguiente manera:

```java
<code>java -cp lib/hsqldb.jar <b>org.hsqldb.WebServer</b> <span style="color: #38761d;">-database.0 file:data/demo_db</span> <span style="color: blue;">-dbname.0 xdb</span></code>
```

Ahora el URL del JDBC es: jdbc:hsqldb:**httpd**://localhost/xdb

Y todo funcionará igual.

#### Hsqldb Servlet

Es el modo servlet, es decir, debe estar ejecutado en una aplicación web y crear un servlet desde web.xml

```java
<code>    <servlet><br />        <servlet-name>hsqldb-servlet</servlet-name><br />        <servlet-class>org.hsqldb.Servlet</servlet-class><br />    </servlet><br />    <servlet-mapping><br />        <servlet-name>hsqldb-servlet</servlet-name><br />        <url-pattern>/hsqldb/*</url-pattern><br />    </servlet-mapping><br /></code>
```

No detallaré este modo ya que es mejor usar el modo servidor y no crear una aplicación web para crear un servidor.

#### Modo aislado (stand-alone)

Este modo es uno de los más útiles cuando se hace aplicaciones portables. Además, este modo permite tener una aplicación con la base de datos incrustada a ella sin necesidad de instalar alguna biblioteca adicional.

No requiere un servidor, simplemente al crear una conexión JDBC, ya se creó la base de datos.

Es decir, en nuestra aplicación usaremos el mismo driver `org.hsqldb.jdbcDriver` y el url que usaremos será `jdbc:hsqldb:**file****:**d:/hsqldb/clientes`.

```java
<code>Connection conn = DriverManager.getConnection("jdbc:hsqldb:file:d:/proys/lib/hsqldb/data/demo_db", "sa", "");<br /></code>
```

La misma base de datos que hemos usado en el modo servidor, web server, es también usado en el modo stand-alone, y usando el mismo driver! Solo difiere el url.

**Nota**: solo se debe usar un modo a la vez, o es server, web server o stand-alone. Ya que necesita de bloqueos de archivo a nivel de sistema operativo.

#### Modo memoria

Es un modo muy interesante para ser usado en aplicaciones demo, que no se necesita guardar la información en un archivo físico. Si no que se crea la base de datos en memoria mientras dura la conexión. Naturalmente se tendrían que crear las tablas inmediatamente después de establecer la conexión.

Solo se debe cambiar el URL a: `jdbc:hsqldb:**mem****:**clientes`.

y todo sigue igual

## Final parte 1

Vemos que este driver/rdbms puede ser usado en dos modos marcados: servidor (server) y aislado (stand-alone). También podemos usar la misma base de datos en ambos modos. Esto también nos puede permitir trabajar en dos modos: standalone para desarrollo, y server para producción.

Se puede usar también en Hibernate, JPA, Spring, iBatis y cualquier framework que maneje base de datos. ya que cumple con las especificaciones de JDBC.
En la segunda parte hablaremos sobre Apache Derby.
