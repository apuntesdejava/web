---
layout: post
title: "Instalación de Liferay 6.2 en GlassFish 4.0"
date: 2014-01-30T17:11:00Z
last_modified_at: 2014-01-30T17:13:07.237Z
author: "Diego Silva Límaco"
permalink: /2014/01/instalacion-de-liferay-62-en-glassfish.html
canonical_url: https://www.apuntesdejava.com/2014/01/instalacion-de-liferay-62-en-glassfish.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "tutorial"
  - "liferay"
---

[![Instalación de Liferay 6.2 en GlassFish 4.0]({{ '/assets/blogger/heading.png' | relative_url }})]({{ '/assets/blogger/heading.png' | relative_url }})

Aquí un nuevo tutorial sobre la instalación de la última versión de [Liferay](http://www.liferay.com/)(6.2) sobre la última versión de [GlassFish](https://glassfish.java.net/) 4.0.

Uno puede descargar la versión empaquetada de [Liferay + GlassFish](http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.0%20GA1/liferay-portal-glassfish-6.2.0-ce-ga1-20131101192857659.zip/download) desde [SourceForge](http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.0%20GA1/). Pero solo incluye la versión 3 del contenedor. Así que, les comparto mi experiencia en la instalación de ese CRM, guiándome de la documentación de Liferay: [Installing Liferay on GlassFish 4](http://www.liferay.com/documentation/liferay-portal/6.2/user-guide/-/ai/installing-liferay-on-glassfish-3-liferay-portal-6-2-user-guide-15-en).

Para esto vamos a necesitar:

- El archivo .war de liferay:
[http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.0%20GA1/liferay-portal-6.2.0-ce-ga1-20131101192857659.war/download](http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.0%20GA1/liferay-portal-6.2.0-ce-ga1-20131101192857659.war/download)

- Las dependencias de liferay:
[http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.0%20GA1/liferay-portal-dependencies-6.2.0-ce-ga1-20131101192857659.zip/download](http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.0%20GA1/liferay-portal-dependencies-6.2.0-ce-ga1-20131101192857659.zip/download)

- El contenedor GlassFish 4.0. Se puede usar la versión [web profile](http://download.java.net/glassfish/4.0/release/glassfish-4.0-web.zip), pero yo voy a utilizar la versión completa: [http://download.java.net/glassfish/4.0/release/glassfish-4.0.zip](http://download.java.net/glassfish/4.0/release/glassfish-4.0.zip)

- El conector a la base de datos. Yo voy a usar MySQL [http://dev.mysql.com/downloads/connector/j/](http://dev.mysql.com/downloads/connector/j/)

- Y la base de datos.

***Advertencia**: Este tutorial utiliza comandos de consola, aunque también se puede realizar desde la web.*

*
*

### 1. Base de datos

Primero, debemos crear la base de datos. Pero, por fines de seguridad y buenas prácticas NO USEMOS EL USUARIO ROOT para conectarnos al liferay. Debemos crear un usuario exclusivo para el liferay.

Desde la consola de MySQL hagamos esto:

```java
-- Creando la base de datos
CREATE DATABASE lportal;
-- Creando usuario con permiso para la base de datos
GRANT ALL ON lportal.* TO lportal@localhost IDENTIFIED BY "lportal"; -- solo si la base de datos está en el mismo equipo del GlassFish
-- Si van a estar separados en equipos diferentes la base de datos de la aplicación (que es una buena práctica) debemos darle el acceso remoto
GRANT ALL ON lportal.* TO lportal@hostappliferay IDENTIFIED BY "lportal"; -- donde hostappliferay es el nombre del host del glassfish, o podemos poner el IP pero entre comillas dobles
```

Por seguridad y buena práctica, no debemos hacer que la contraseña sea la misma del usuario. Sugiero este enlace que permite crear contraseñas de manera aleatoria: [https://identitysafe.norton.com/password-generator/](https://identitysafe.norton.com/password-generator/)

### 2. Preparando el GlassFish

Crearemos una carpeta donde se colocará el liferay, y dentro debemos descomprimir el glassfish. Por ejemplo, crearé la carpeta:

```java
/opt/liferay
```

Y dentro descomprimiré el glassfish, y tendré lo siguiente:

```java
/opt/liferay/glassfish4
```

De aquí en adelante, voy a mencionar la carpeta de liferay (`/opt/liferay`) como `$LIFERAY_HOME` y la de glassfish `/opt/liferay/glassfish4` como `$GLASSFISH_HOME`.

Descomprimos el contenido del archivo de dependencias de Liferay (va a crear una subcarpeta) y copiamos los .jars dentro de la carpeta `$GLASSFISH_HOME/glassfish/domains/domain1/lib`. Además, copiamos el archivo conector de MySQL en la misma carpeta.

#### 2.1 Preparando seguridad de GlassFish

Vamos a iniciar el contenedor de manera local:

```java
$GLASSFISH_HOME/bin/asadmin start-domain
```

Por omisión, la seguridad de GlassFish es así:

- El usuario admin no tiene contraseña

- Para acceder a la consola web solo se puede hacer desde el mismo computador.

Entonces, ni bien hemos iniciado el contenedor, debemos crearle una contraseña de la siguiente manera:

```java
$GLASSFISH_HOME/bin/asadmin change-admin-password
```

Va a pedir el nombre del usuario (admin, por omisión), la contraseña actual (nada, la primera vez) y escribimos y rectificamos la nueva contraseña. Y listo. Ahora debemos activar la seguridad.

```java
$GLASSFISH_HOME/bin/asadmin enable-secure-admin
```

Nos pedirá usuario (admin) y la contraseña que acabamos de colocarle. Y listo. Ahora, debemos reiniciar el glassfish.

```java
$GLASSFISH_HOME/bin/asadmin stop-domain
$GLASSFISH_HOME/bin/asadmin start-domain
```

Ahora sí, podemos entrar desde un navegador como https://hostappliferay:4848 y, de hecho, como no tiene certificado, el navegador nos preguntará si deseamos acceder de todas maneras.. y le decimos que sí. Ingresamos el usuario y contraseña creados, y listo.

#### 2.2 Configurando opciones de JVM para GlassFish

Liferay necesita algunas configuraciones del JVM para que funcione correctamente. Esto se hace desde el panel Configurations > server-config > JVM Settings > JVM Options

Debemos agregar / modificar las siguientes variables:

```java
-Dfile.encoding=UTF8
-Djava.net.preferIPv4Stack=true
-Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false
-Duser.timezone=America/Lima
-Xmx3072m
-XX:MaxPermSize=512m
```

Yo estoy colocando el TimeZone de la ciudad de donde estoy. La memoria máxima recomiendo 3GB, aunque puede ser el 75% de la memoria total, dejando el 15% para el SO. Esto se puede ir ajustando a medida que veamos la necesidad, ya que todos tenemos diferentes aplicaciones con funcionalidades diferentes.

Para crear estas opciones del JVM, debemos asegurarnos de que no existan. Si existen, deberíamos modificarlos en vez de agregarlos.

Tengo una manera más práctica de agregar estas variables de JVM. Como yo soy de la escuela de las pantallas sin mouse (pura consola) hago lo siguiente:

Primero, listo las opciones existentes:

```java
$GLASSFISH_HOME/bin/asadmin list-jvm-options
```

Segundo, elimino las que voy a reemplazar. En este caso son `-Xmx512m` y `-XX\:MaxPermSize=192m`:

```java
$GLASSFISH_HOME/bin/asadmin delete-jvm-options "-Xmx512m:-XX\:MaxPermSize=192m"
```

Y para terminar, agrego todas las opciones.

*El separador de propiedades son los dos puntos (:), y el caracter de escape es el backslash (\) :
*

```java
$GLASSFISH_HOME/bin/asadmin create-jvm-options "-Dfile.encoding=UTF8:-Djava.net.preferIPv4Stack=true:-Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false:-Duser.timezone=America\/Lima:-Xmx3072m:-XX\:MaxPermSize=512m"
```

Y listo. Ahora debemos reiniciar el contenedor.

#### 2.3 Creando el Pool de Conexiones

Tenemos la base de datos creada, y ahora necesitamos preparar el Pool de Conexiones hacia la base de datos, de tal manera que Liferay lo use para manejar su contenido.

En GlassFish  - a diferencia de otros contenedores - se debe crear un Pool de Conexiones, y luego crear el Recurso JDBC. Otros contenedores el nombre del Recurso JDBC es parte de la creación del Pool de conexiones.

Desde la consola web, esto se encuentra en Resources > JDBC > JDBC Connection Pools

Desde la línea de comandos escribimos:

*El caracter de escape son es el doble backslash (\\) y el separador de propiedades son los dos puntos (:)*

```java
$GLASSFIS_HOME/bin/asadmin create-jdbc-connection-pool  \
   --datasourceclassname com.mysql.jdbc.jdbc2.optional.MysqlConnectionPoolDataSource \
   --restype javax.sql.ConnectionPoolDataSource \
   --property UseUnicode=true:CharacterEncoding=UTF-8:EmulateLocators=true:User=lportal:Password=lportal:Url=jdbc\\:mysql\\://host-mysql/lportal \
   LiferayPool
```

Se puede conocer todos los parámetros con el comando `help create-jdbc-connection-pool` del `asadmin`.

Con esto ya hemos creado nuestro Pool de Conexiones llamado `LiferayPool`. El valor de `host-mysql` es donde se encuentra el MySQL. Es decir, o localhost o en otro equipo.

Para terminar con la configuración del recurso, debemos darle un nombre. Desde la consola web es entrando a Resources > JDBC > JDBC Resources. El nombre del Recurso debe ser `jdbc/LiferayPool` y que esté asociado al Pool de Conexiones `LiferayPool`.  Desde la línea de comandos se hace así:

```java
$GLASSFISH_HOME/admin/asadmin create-jdbc-resource --connectionpoolid LiferayPool jdbc/LiferayPool
```

Y Listo.

Más opciones de la administración de la consola de GlassFish, aquí [https://glassfish.java.net/docs/4.0/administration-guide.pdf](https://glassfish.java.net/docs/4.0/administration-guide.pdf)

### 3. Desplegando el .war de Liferay

Como tercer paso, debemos desplegar la aplicación web. Recomiendo que esté en el mismo computador del liferay, así evitamos el upload de 200MB. El despliegue desde la consola web es entrando a Applications, y seleccionamos el botón "Deploy" y luego la opción "Local packaged File or Directory That is Accesible from GlassFish Server".

El Context Root debe ser "/" sin las comillas dobles (es decir, la raíz)

Y el campo Application Name debe ser: **liferay-portal**

En línea de comandos se hace de la siguiente manera:

```java
$GLASSFISH_HOME/bin/asadmin deploy --contextroot "/" --name liferay-portal ~/Downloads/liferay-portal-6.2.0-ce-ga1-20131101192857659.war
```

*Nota: El último parámetro (el que comienza don ~/Downloads..) es la ubicación del .war del liferay. El usado en este post es el mostrado, ya que es el más reciente disponible.
*

Esperamos a que termine la carga.. y listo. Ya está desplegado el liferay en el GlassFish. Falta el último paso, que es asociar el Liferay con la base de datos.

### 4. Asociando el Liferay desplegado con la base de datos.

Debemos crear un archivo properties en la ubicación desplegada el liferay dentro del GlassFish. Antes de hacer esto, debemos detener el Glassfish.

Luego crearemos el archivo `$GLASSFISH_HOME/glassfish/domains/domain1/applications/liferay-portal/WEB-INF/classes/portal-ext.properties` con el siguiente contenido:

```java
jdbc.default.jndi.name=jdbc/LiferayPool
```

Iniciamos el GlassFish.. y listo! La primera vez tomará algo de tiempo porque creará las tablas en MySQL. Podemos ver el estado del GlassFish en `$GLASSFISH/glassfish/domains/domain1/logs/server.log`

Entramos a http://hostappliferay:8080 y podemos terminar de configurar el Liferay colocando el nombre de nuestro CRM.

Espero que les sea de utilidad.
