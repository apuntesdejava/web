---
layout: post
title: "Instalación de Liferay en un servidor GlassFish v3 para producción"
date: 2010-07-06T05:00:00.231Z
last_modified_at: 2011-02-19T23:03:35.149Z
author: "Diego Silva"
permalink: /2010/07/instalacion-de-liferay-en-un-servidor.html
canonical_url: https://www.apuntesdejava.com/2010/07/instalacion-de-liferay-en-un-servidor.html
tags:
  - "glassfish"
  - "glassfish v3"
  - "liferay"
  - "web"
  - "tutorial"
  - "portlets"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)

En un [anterior post]({{ '/2010/06/portales-en-java.html' | relative_url }}) mencioné los Portales en Java, y la facilidad que nos da el utilizar una plataforma con muchas funcionalidades, y nosotros simplemente deberíamos hacer los componentes que faltan. Estos componentes se llaman Portlets.

Ahora mencionaré uno de los gestores de Portlets en Java que, según mi opinión, es bastante útil. Su nombre LIFERAY. Pero no hablaré de sus cualidades, ni todo lo que puede hacer.. eso ya lo hizo [Pedro Edison en su blog](http://periospino.blogspot.com/2010/03/gestor-de-contenidos-java-el-poderoso.html) `:)`, y como no hay que amontonar la red con lo mismo, esta vez mostraré cómo instalar el LIFERAY desde cero. No desde la instalación de un .exe, sino desde un archivo .war y sobre GlassFish v3 usando MySQL como gestor de base de datos.

Esto no lo he inventado, sino lo tomé del [tutorial mismo](http://docs.liferay.com/portal/5.2/official/liferay-administration-guide.pdf) de Liferay... pero como está en inglés, y el lector promedio de este blog busca más información en castellano, quiero hacer un aporte a la comunidad con este post.

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=21819929363501961)

### Recursos

Para esta tarea necesitamos lo siguiente:

- **Sistema operativo**, cualquiera compatible con Java. Aunque estos pasos funcionan en todos los sistemas operativos con Java SE 6, en este post lo orientaré más a Windows... porque el lector promedio de este blog busca más información en Windows... etc etc etc.
- **JDK 6.** El cual lo puedes descargar desde aquí: [http://java.sun.com/javase/downloads/widget/jdk6.jsp](http://java.sun.com/javase/downloads/widget/jdk6.jsp)
- **GlassFish v3**. Si no lo has instalado, aquí lo mostraremos de la manera más fácil. Puedes descargar la versión .zip desde aquí: [http://download.java.net/glassfish/3.0.1/release/glassfish-3.0.1-ml.zip](http://download.java.net/glassfish/3.0.1/release/glassfish-3.0.1-ml.zip). Esta es la versión multilingual, es decir, nos aparecerá en castellano los textos para entendernos mejor.
- El .**war de Liferay**: [http://downloads.sourceforge.net/lportal/liferay-portal-5.2.3.war](http://downloads.sourceforge.net/lportal/liferay-portal-5.2.3.war)
- **Archivos adicionales** para preconfigurar el Contenedor Web: [http://downloads.sourceforge.net/lportal/liferay-portal-dependencies-5.2.3.zip](http://downloads.sourceforge.net/lportal/liferay-portal-dependencies-5.2.3.zip)
- **MySQL **instalado ya sea localmente o en otro host, pero que tengamos acceso a ese computador. Pude haber hecho con PostgreSQL, pero tengo un par de inconvenientes: me han bloqueado todo tipo de instalación en el computador de donde trabajo, y... conozco casi nada sobre PostgreSQL.. así que mis disculpas a los amigos del elefantito. Pero si sois curiosos, sabréis como acomodar esto.
**OJO**: que sea el MySQL puro, no uno de esos que vienen enlatados con Apache + PHP + PHPMyAdmin. Ya hablaré de este paquetito *AMP en otro post, que para unos es un alivio, pero puede ser un dolor de cabeza si no se usa con prudencia. El MySQL se puede descargar desde aquí: [http://dev.mysql.com/downloads/mysql/](http://dev.mysql.com/downloads/mysql/)
- El **JDBC** de la base de datos que vamos a utilizar. Cómo estamos en MySQL, este se puede descargar desde aquí: [http://dev.mysql.com/downloads/connector/j/](http://dev.mysql.com/downloads/connector/j/) Si decides usar otro motor de base de datos, pues no te olvides de conseguir el JDBC correspondiente.

Hasta aquí es lo necesario para una instalación básica. Pero quiero compartir mi experiencia de esta instalación:

- **Usar el JDK de Sun.** Toda esta instalación funciona bien con OpenJDK sobre un Ubuntu, CentOS, etc... pero el Captcha para autenticación no funciona correctamente sobre OpenJDK, por tanto usar el JDK de Sun.
- **Descargar el [Xerces-J](http://xerces.apache.org/xerces-j/).** La instalación descrita aquí funciona correctamente, pero cuando se agregan nuevos portlets, el Contenedor Web no es capaz de interpretar los archivos de despliegue de ellos. Para este ejemplo usaremos la versión 2.9.0: [http://archive.apache.org/dist/xml/xerces-j/Xerces-J-bin.2.9.0.zip](http://archive.apache.org/dist/xml/xerces-j/Xerces-J-bin.2.9.0.zip)
[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=21819929363501961)

### Instalación y preconfiguración de GlassFish v3

La instalación de GlassFish v3 es bastante simple, más aún si es un .zip como el que sugerí para descargar: Solo hay que descomprimirlo. Por ejemplo, lo descomprimiremos en la raíz de C: Y tendrá una estructura como esta.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwcp_ce-LHvdhV3wNjJKt9Q8NUwpKE81_6XcJ8xdIdCiq_6cxU5g9epbZl5qs-1yCWF9e-CAyXC9MAVXIV90c0kH9KqnWImcC4n_N5nViDOCgqpsmnAMtDB6uuTSeEzo0N2MJEiNsMGmrn/s320/gf1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwcp_ce-LHvdhV3wNjJKt9Q8NUwpKE81_6XcJ8xdIdCiq_6cxU5g9epbZl5qs-1yCWF9e-CAyXC9MAVXIV90c0kH9KqnWImcC4n_N5nViDOCgqpsmnAMtDB6uuTSeEzo0N2MJEiNsMGmrn/s1600/gf1.jpg)

A partir de este momento, cada vez que mencione `%GLASSFISH_HOME%` se entenderá al directorio del GlassFish que se descomprimió. Es decir `c:\glassfishv3`

**Importante:** Mucho se acostumbra crear una carpeta con el mismo nombre del archivo comprimido, lo cual es una práctica no recomendada aquí, ya que el comprimido ya tiene una carpeta. Si se hace eso, se tendría una carpeta llamada glassfishv3, y dentro otra vez glassfishv3, y ocasionará confusión. Por tanto, no usar la opción "crear una carpeta con el nombre del archivo .zip". Simplemente descomprimirlo directamente a la raíz de "C:". Ojo que ya lo advertí `:P`.

Ahora, extraemos el contenido del archivo liferay-portal-dependencies-5.2.3.zip en cualquier carpeta, luego tomamos los archivos .jar que se obtuvieron   y los pondremos dentro de `%GLASSFISH%\glassfish\domains\domain1\lib`. En esta misma carpeta ponemos el .jar del JDBC de MySQL, y los archivos `xercesImpl.jar` y `xml-apis.jar` de Xerces

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhVIAXWFuTUKO6NTTbIFpl1td_WIfDCg7RIa9D3mo9Y4rp8wa1WisStqmR8bnu2hvkn8GB5UG8N4_UVqYI65myYjm0emDgxX1J-F1lnAnIShy0rnQlrMOVuz_VldE6TEXZoKFBiQQIW2gUD/s400/web-gf-files.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhVIAXWFuTUKO6NTTbIFpl1td_WIfDCg7RIa9D3mo9Y4rp8wa1WisStqmR8bnu2hvkn8GB5UG8N4_UVqYI65myYjm0emDgxX1J-F1lnAnIShy0rnQlrMOVuz_VldE6TEXZoKFBiQQIW2gUD/s1600/web-gf-files.jpg)

Después de esto, iniciamos el GlassFish v3...

```java
<code>%GLASSFISH_HOME%\bin\asadmin start-domain</code>
```

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFkGQ1hMXxm0KY4HSrgxFJOtSjP8kz-8YzpGyiCewpqd6-PpgaXPLkorrmVEKHsMmWDo3M8c2nsISPUyktPVaBJvUXF2SmjqiQy_K2pIBKQ8aPZitzMUNLr_b7eZBi4bTW5tn1JUKl8KJD/s400/gf3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFkGQ1hMXxm0KY4HSrgxFJOtSjP8kz-8YzpGyiCewpqd6-PpgaXPLkorrmVEKHsMmWDo3M8c2nsISPUyktPVaBJvUXF2SmjqiQy_K2pIBKQ8aPZitzMUNLr_b7eZBi4bTW5tn1JUKl8KJD/s1600/gf3.jpg)

...  para continuar con el siguiente paso.

Debemos modificar las propiedades de la máquina virtual donde se ejecutará el Liferay. Para ello seleccionamos del menú de la izquierda: Configuration > JVM Settings.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOoogdDxwCfePJbra4LfUaeSSUdPWNLJ3IZR8a7g85p9mf0orkSE0tlorpac8ITw_O8M7hNQhhE2a8pu7hB0luLM6kKlbZS7t3ua3c2jH_fNngpf21NDDB8OjQwi1ZVM3vT4YIsncXCHqT/s1600/glassfish_jvm_liferay.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOoogdDxwCfePJbra4LfUaeSSUdPWNLJ3IZR8a7g85p9mf0orkSE0tlorpac8ITw_O8M7hNQhhE2a8pu7hB0luLM6kKlbZS7t3ua3c2jH_fNngpf21NDDB8OjQwi1ZVM3vT4YIsncXCHqT/s1600/glassfish_jvm_liferay.jpg)

Y cambiamos los valores de MaxPermSize y Xmx a los siguientes:

- -XX:MaxPermSize=256m
- -Xmx1024m

Clic en "Save". Detenemos el GlassFish, y lo volvemos a iniciar.

```java
<code>%GLASSFISH_HOME%\bin\asadmin stop-domain%GLASSFISH_HOME%\bin\asadmin start-domain</code>
```

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=21819929363501961)

### Preparación de la base de datos

El Liferay utiliza una base de datos por omisión llamada [HSQLDB](http://hsqldb.org/), pero podemos configurarlo para que funcione con cualquier otra base de datos. En este caso veremos con MySQL. En sí, se necesita crear una base de datos en MySQL, configurar un Pool de Conexiones, y ajustar un poco el .war para que utilice este Pool.

**Sugerencia:** Antes de hacer esto, recomiendo siempre crear un usuario que acceda a esta base de datos, y no usar el root para tal fin. ¿Cómo crear ese usuario?.
Desde una ventana del símbolo del sistema, ejecutar

```java
<code>mysql -u root -p</code>
```

Con esto se ejecutará el cliente de MySQL con el usuario root y pedirá la contraseña. Bueno, le ponemos y nos mostrará el prompt `mysql>`.

Escribimos lo siguiente para crear la base de datos `lportal`:

```java
<code>create database lportal;</code>
```

y luego escribimos lo siguiente para el usuario `lportal` que accederá a esa base de datos:

```java
<code>grant all on lportal.* to lportal@localhost identified by "lportal";</code>
```

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhE8cvH5r5bjXdWGGqE_UG1uVTsS5Rv81rK_GRycVPGShFelrR8kznKOyQ86Im_GA4Q3ouXH7bK3Yi1Sg1UcMv2BS6yey_8Tm_u_peUp7MfWlg8KZUd5AE5h96P5swe_f-hFsLh_JfJnYuT/s400/liferay-mysql.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhE8cvH5r5bjXdWGGqE_UG1uVTsS5Rv81rK_GRycVPGShFelrR8kznKOyQ86Im_GA4Q3ouXH7bK3Yi1Sg1UcMv2BS6yey_8Tm_u_peUp7MfWlg8KZUd5AE5h96P5swe_f-hFsLh_JfJnYuT/s1600/liferay-mysql.jpg)

Más sobre los permisos en MySQL, aquí: [http://dev.mysql.com/doc/refman/5.1/en/grant.html](http://dev.mysql.com/doc/refman/5.1/en/grant.html)

Ahora sí, seguimos...
[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=21819929363501961)

### Configuración del pool de conexiones en GFv3 para Liferay

Entramos a la consola web de GFv3 (http://localhost:4848) y seleccionamos del árbol de la izquierda Resources > JDBC > Connections Pool

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhwdnetIgEHX83I6tVUGHdOsYF6HqCHNi7A8AlLHxCU8vorwFPZl8BQFhii85fA7Y77NNbg7LF026IqMrL9vQO5XxBnX1yrwoDVwVZimXpd6wFVAPNR5wnzU-B0YW2kce0j5GX4XbIlOdiU/s320/gf4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhwdnetIgEHX83I6tVUGHdOsYF6HqCHNi7A8AlLHxCU8vorwFPZl8BQFhii85fA7Y77NNbg7LF026IqMrL9vQO5XxBnX1yrwoDVwVZimXpd6wFVAPNR5wnzU-B0YW2kce0j5GX4XbIlOdiU/s1600/gf4.jpg)

 Hacemos clic en el botón "New..." para crear una nuevo Pool de Conexiones. Escribimos:

- Name: **LiferayPool**
- Resource Type: **javax.sql.ConnectionPoolDataSource**
- Database vendor: **MySQL**

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgeFxC6GiFV6Zo64lOkZrjKirPLSipDgDGyG6y7ryH7nHY3SD6fNRPfrS8HaOTZV5y13CGkkwhteqhTtzTtbs60eCRolcJLuNUx_KQY3dfrNqOhuzbp3A7lGDHWVTxXxo8I7d1-cBcq4T7P/s400/gf5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgeFxC6GiFV6Zo64lOkZrjKirPLSipDgDGyG6y7ryH7nHY3SD6fNRPfrS8HaOTZV5y13CGkkwhteqhTtzTtbs60eCRolcJLuNUx_KQY3dfrNqOhuzbp3A7lGDHWVTxXxo8I7d1-cBcq4T7P/s1600/gf5.jpg)

 Clic en Next.
Ahora, se mostrarán todas las propiedades de la conexión a la base de datos. Activamos el primer check llamado Ping: Enabled. Esto nos permitirá verificar si la conexión fue correcta después de crear el pool de conexiones. Luego buscamos las siguientes propiedades, y ponemos los valores que se muestran a continuación:

- URL:**jdbc:mysql://localhost/lportal**
- User: **lportal**
- Password: **lportal**
- UseUnicode: **true**
- CharacterEncoding:**UTF-8**
- EmulateLocators: **true**

Hacemos clic en el botón "Save", y si todo está correcto, se creará sin problema.

Con esto solo hemos creado un Pool de Conexión, ahora necesitamos registrarlo en el JNDI del Servidor. Para ello, seleccionamos la opción Resources > JDBC > JDBC Resources

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHvQd9ihb8J4Sxkq7CHWtjoXHIX0Sl1z6fgexThTaUFBwiyF9iTThzRA8W2QYmWzfc_n-tLKQ3IAKu1oWnERXfg11EHBhEpFyE8pxOzwVQ282ewxvaituL2iqyv-Q42DXdpFPN6Xh97L8V/s1600/liferay-jndi.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHvQd9ihb8J4Sxkq7CHWtjoXHIX0Sl1z6fgexThTaUFBwiyF9iTThzRA8W2QYmWzfc_n-tLKQ3IAKu1oWnERXfg11EHBhEpFyE8pxOzwVQ282ewxvaituL2iqyv-Q42DXdpFPN6Xh97L8V/s1600/liferay-jndi.jpg)

Hacemos clic en "New..." y escribimos los siguientes valores en los campos:
JNDI Name: **jdbc/****L****iferay****P****ool**
Pool Name: **LiferayPool**

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgrmnB_Rg-ahRKhO_c1GwnjVqaZcAUUvpvs8RzYnBGvXGl5xUm0qS7wLEgn92jrZWEnSpn7N3IqppRAsef80dJOC4J9916MXCo7pk6M6OnDgMtyeZHte43mpogGTebxJHwrGsx9qgxBj1-_/s400/liferay-jndi2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgrmnB_Rg-ahRKhO_c1GwnjVqaZcAUUvpvs8RzYnBGvXGl5xUm0qS7wLEgn92jrZWEnSpn7N3IqppRAsef80dJOC4J9916MXCo7pk6M6OnDgMtyeZHte43mpogGTebxJHwrGsx9qgxBj1-_/s1600/liferay-jndi2.jpg)

¡¡El nombre del recurso es importante!! Debe estar en mayúsculas y minúsculas.

Clic en OK y listo. Seguimos con el siguiente paso.

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=21819929363501961)

### Despliegue del .war

Como comenté hace un momento, el .war de liferay está preparado para funcionar con una base de datos incrustada llamada HSQLDB. Lo que necesitamos es que se conecte a nuestro MySQL. Por algo hemos preparado el Pool de conexiones. Así que necesitamos editar un archivo llamado `portal-ext.properties`, adjuntarle el atributo:

```java
<code>jdbc.default.jndi.name=jdbc/LiferayPool </code>
```

... y luego ponerlo dentro del .war (en el directorio WEB-INF/classes dentro del .war) antes de desplegarlo.

Notar que el nombre del JNDI (jdbc/**LiferayPool**)  debe ser exacto cómo se configuró en GlassFish en el paso anterior.

Si te es complicado crear el archivo, aquí puedes descargarlo: [http://java.net/downloads/apuntes/resources/liferay/portal-ext.properties](http://java.net/downloads/apuntes/resources/liferay/portal-ext.properties)

Y si te es complicado poner el .properties dentro del .war, aquí ya tengo un .war preparado (que es el que uso en las instalaciones de Liferay)
[http://java.net/downloads/apuntes/resources/liferay/liferay-portal-5.2.3.war](http://java.net/downloads/apuntes/resources/liferay/liferay-portal-5.2.3.war)

**Ahora sí, tomar mucho cuidado con lo siguiente que se va a explicar respecto al despliegue del .war**

En la consola del GlassFish, ir a la opción "Applications" del menú izquierdo, y hacemos clic en el botón "Deploy...". En la opción "Location", seleccionamos el archivo .war que de liferay. Al hacer esto, se mostrarán más opciones que corresponden a la configuración del despliegue del .war.

En la casilla llamada "Context Root:" aparecerá el nombre del archivo .war. **Borrar este nombre y poner el signo "/".**

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhu3rxpnbmO_EK7XXahSFd1Cqc8O1m4Fn4r2ZXIix6xsJLm79OuJHycnTHN_w7gJQR_0B7GqiIjBodO_akKUh9BtbnMqOgYOPFOzohOxaStIGqMU6zErQDxQi5PqyetQg2B1wCnuS4sHEto/s400/liferay-war.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhu3rxpnbmO_EK7XXahSFd1Cqc8O1m4Fn4r2ZXIix6xsJLm79OuJHycnTHN_w7gJQR_0B7GqiIjBodO_akKUh9BtbnMqOgYOPFOzohOxaStIGqMU6zErQDxQi5PqyetQg2B1wCnuS4sHEto/s1600/liferay-war.jpg)

Ahora, clic en "OK".

Esto tomará un tiempo procesar. Aún cuando ya se haya mostrado el mensaje en GlassFish que fue desplegado correctamente, no necesariamente habrá terminado, porque estará configurando archivos, bibliotecas, creando las tablas de la base de datos, preparando otros recurso, etc etc etc. Así que en esta parte tener paciencia. Se puede revisar el log para ver en qué está. `%GLASSFISH_HOME%\glassfish\domains\domain1\logs\server.log`.

La Ruta del contexto (Context Root) es importante porque la aplicación se mostrará en la raiz del host, y varios componentes de la aplicación se ubicarán en la misma ubicación, como "/c" y "/widgets".
[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=21819929363501961)

### Ejecutando el Liferay

Después del despliegue, ya podemos verlo en funcionamiento abriendo la siguiente dirección: [http://localhost:8080](http://localhost:8080/) Sin ruta de contexto, ya que (como acabo de mencionar) está en la raíz del host.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQcrXrebhf9h-Cam49iq-IhbTvrKBosTOlp-eL1wQnXM4CKt_FD4FgQqU2dUtsbYbVOfXFCMn2OzQwMDIrd-go5r6j7f21zJgH5dfCprK9zaEUtEKvZ_Yez0cUPIkQOl-KtrLHobBVeWP_/s400/liferay-prod.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQcrXrebhf9h-Cam49iq-IhbTvrKBosTOlp-eL1wQnXM4CKt_FD4FgQqU2dUtsbYbVOfXFCMn2OzQwMDIrd-go5r6j7f21zJgH5dfCprK9zaEUtEKvZ_Yez0cUPIkQOl-KtrLHobBVeWP_/s1600/liferay-prod.jpg)

El usuario creado por omisión para administrar este Portal es **test@liferay.com **y su contraseña es **test**.

### Conclusión

Y esto sería todo para tener en producción un Contenedor de Portlets sobre GlassFish v3. De por sí el GFv3 es pesado para manejar en desarrollo, más aún si se utiliza con Liferay, así que hay que considerarlo si se utiliza en un computador de desarrollo con pocos recursos (entiéndase, no usar Pentium D.. sino algo muy superior, ni menos con 2GB de RAM).

En un siguiente Post veremos (ahora sí) cómo configurar NetBeans 6.9 con un servidor liferay y haremos nuestro primer portlet.

Hasta el siguiente post!
