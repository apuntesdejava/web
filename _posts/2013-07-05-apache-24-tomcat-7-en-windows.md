---
layout: post
title: "Apache 2.4 + Tomcat 7 en Windows"
date: 2013-07-05T16:57:00.001Z
last_modified_at: 2013-09-20T17:22:10.330Z
author: "Diego Silva Límaco"
permalink: /2013/07/apache-24-tomcat-7-en-windows.html
canonical_url: https://www.apuntesdejava.com/2013/07/apache-24-tomcat-7-en-windows.html
tags:
  - "apache"
  - "tomcat"
  - "configuración"
  - "weblogic"
  - "tutorial"
  - "windows"
  - "trucos"
---

[![](/assets/blogger/httpd_tomcat.png)](/assets/blogger/httpd_tomcat.png)

¿Para qué usar Apache con Tomcat si Tomcat ya es un servidor web?

Pues bien, sabemos que el Tomcat utiliza el puerto 8080, y el Apache 80. Bastaría con que cambiemos el puerto del Tomcat a 80 y listo, los url deberían ser de la forma http://midominio.com y ya no http://midominio.com:8080

Sabemos que es más elegante evitar que la dirección no tenga puerto. Pero, si tenemos una aplicación en PHP o Python que necesariamente debe correr en Apache ¿qué hacemos? Creamos un subdominio de la forma http://app1.midominio.com http://app2.midominio.com Pues, no está mal.

Lo pondré más especial: no se van a crear subdominios, sino, que todo debe estar dentro del dominio principal, como sub carpetas.  Así, por ejemplo:

http://midominio.com/app1.python

http://midominio.com/app2.php

http://midominio.com/app3.tomcat

y.. algo más divertido... le agregamos otro contenedor java totalmente diferente

http://midominio.com/app4.weblogic

Entonces, ya tenemos un pequeño problema ¿cómo hacemos para convivir Apache con Tomcat, y, de paso, con otro contenedor?

Y la cereza del helado: que el Apache funcione sobre Windows!!!

Es un entorno bastante caprichoso que he propuesto, pero no es nada fuera de lo normal. En la red siempre encontramos los casos clásicos: todo sobre linux y solo usa Tomcat + Apache.

### El Apache de Windows

En donde trabajo, cuando comento que voy a instalar el Apache sobre Windows, se me quedan mirando como si fuera algo del otro mundo: **sí, existe el Apache para Windows.. no solo es para Linux**! Con esto explicado, vamos a aumentar la complejidad del escenario.

El instalador del Apache para Windows lo podemos descargar desde [http://httpd.apache.org/download.cgi](http://httpd.apache.org/download.cgi) Pero vemos que la **versión más reciente no contempla  Windows**. La versión para Windows se quedó en la serie [2.0](http://httpd.apache.org/download.cgi#apache20). Esto complica las cosas si queremos usar PHP, ya que con esta versión solo podemos usar el **PHP 5.2** (y ni qué decir si es un servidor Windows de 64 bits).

En esta dirección de descarga de PHP para Windows [http://windows.php.net/download](http://windows.php.net/download/) explica otra opción para usar un Apache más reciente que no viene de las canteras de Apache Foundation. Es una versión alterna compilada por entusiastas que nos ayudan con versiones recientes de Apache para Windows y hasta de 64 bits. Se llama Apache Lounge: [http://www.apachelounge.com/](http://www.apachelounge.com/)

La instalación de Apache para Windows lo resumo en lo siguiente:

- Descarga el zip, por ejemplo:

- [http://www.apachelounge.com/download/win32/binaries/httpd-2.4.4-win32.zip](http://www.apachelounge.com/download/win32/binaries/httpd-2.4.4-win32.zip) para  Windows de 32 bits

- [http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.4-win64-VC11.zip](http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.4-win64-VC11.zip) para  Windows de 64 bits

- Descomprimir el contenido en una carpeta nueva

- Entrar al símbolo de sistema como administrador (clic derecho a "cmd" y seleccionar "run as administrator")

- Entrar a la carpeta donde se descomprimió el Apache ($APACHE_HOME) y luego a la subcarpeta **bin**. ($APACHE_HOME/bin)

- Para ejecutar de manera manual, escribir **httpd.exe** y luego presionar enter

- Para instalarlo como servicio de Windows, escribir **httpd.exe -k install** luego presionar Enter. Más opciones de este comando: escribir **httpd.exe /?**

Y listo.

La configuración de Apache con PHP no lo veré aquí, porque no es el objetivo de este post (espero algún día hacerlo, ya que rechazo completamente las versiones empaquetadas tipo WAMP ¿por qué? Porque pienso que una hamburguesa hecha en casa es más rica, más saludable y más económica que las que venden en la calle.. toma más tiempo, pero sabemos de qué está hecho, y lo podemos hacer y modificar a nuestro gusto, hacer el tamaño como lo querramos, darle más sabor, hacerlo a cualquier hora, hacerlo en cualquier lugar.. y por muchas razones más)

### Apache + Tomcat

Aquí viene lo bueno: Hace un tiempo hice un post sobre [configurar Apache con Tomcat](/2007/04/configuracion-de-tomcat-conectando-al.html) usando el protocolo JK. Ese post es antiguo, además que encontré otra manera más nativa de usar la comunicación entre ambos servidores, y no requiere mucha configuración. Se llama el protocolo [AJP](https://httpd.apache.org/docs/2.4/mod/mod_proxy_ajp.html).

En Apache se debe configurar con el módulo Proxy. Viene como parte del instalador, así que no necesitamos bajar algún módulo adicional. Para ello, debemos activar el módulo de la siguiente manera en el Apache:

```java
## Asegurarse que esté activado el módulo Proxy

LoadModule proxy_module modules/mod_proxy.so

## Luego, agregar el módulo de AJP
LoadModule proxy_ajp_module modules/mod_proxy_ajp.so

## Ahora, redireccionamos las peticiones del contexto de nuestra aplicación (en nuestro ejemplo lo mencionamos /app3.tomcat
ProxyPass  /app3.tomcat  ajp://localhost:8009/app3.tomcat

## Y, agregar esto, porque se ponía lento el Apache y lanzaba el error en el log
##       AH00341: winnt_accept: Asynchronous AcceptEx failed
AcceptFilter http none
AcceptFilter https none

####  Ahora, una configuración especial

## Si deseamos configurar que desde la raíz del dominio apunte al tomcat, debemos escribir
ProxyPass  /  ajp://localhost:8009/

## Y para ignorar el AJP en ciertas carpetas porque estará en otro lenguaje, anteponer a la anterior linea lo siguiente:
ProxyPass /app1.python !
ProxyPass /app2.php !

## el signo de admiración indica que no se aplicará el Proxy a esas rutas
```

### Apache + Tomcat + Weblogic (u otro contenedor Java)

El AJP o JK para Weblogic lo encontré un poco pesado de implementar, así que hice una salida bastante útil: usar el Proxy. Para ello, debemos agregar lo siguiente:

```java
ProxyPass /app4.weblogic http://servidor.weblogic:7001/app4.weblogic
ProxyPassReverse /app4.weblogic http://servidor.weblogic:7001/app4.weblogic
```

Y es...  casi todo. Porque tenemos un problema, sea con Weblogic u otro contenedor Java, el manejo de Cookie de sesión es estándar. El cookie se llama **JSESSIONID.** Con este cookie, el contenedor puede saber cuál es el usuario que se está trabajando.  Los cookies se definen por dominio, por ruta, y lo diferencia hasta por puerto.

Ahora bien, si ambos contenedores están bajo el mismo dominio y bajo el mismo puerto, entonces, si en el Tomcat tiene una sesión, cuando el usuario quiere usar la aplicación que está en Weblogic, la sesión se pierde porque el Weblogic creará una nueva sesión, porque el ID de JSESSION no tiene la misma información,  y pensará que se trata de un cookie perdido, por tanto, creará otra sesión. Y cuando el usuario regrese a la sesión del Tomcat, se repite la historia. ¿Qué hacer? ¿Compartir el cookie? Pues, es casi imposible (al menos, no encontré una salida para que el mismo cookie sea manejado por dos diferentes contenedores)

La mejor opción es.... cambiar el nombre del cookie! ¿Cómo? En tomcat es bastante simple: En el archivo **`$TOMCAT_HOME/conf/context.xml`** agregamos el siguiente atributo en la etiqueta `<Context />`

```java
<Context sessionCookieName="MI_SESSION_ID" >

<!--- continua la configuración.....
```

Y listo ¿Cambiar el cookie de sesión del WebLogic? No lo encontré, pero deber una configuración igual de sencilla. Igual si se usara con JBoss, Resine, etc.

###

### Documentación

Para AJP:

- The AJP Connector [http://tomcat.apache.org/tomcat-7.0-doc/config/ajp.html](http://tomcat.apache.org/tomcat-7.0-doc/config/ajp.html)

- Apache Module mod_proxy_ajp [https://httpd.apache.org/docs/2.4/mod/mod_proxy_ajp.html](https://httpd.apache.org/docs/2.4/mod/mod_proxy_ajp.html)

Configuración de Tomcat

- Atributos: [http://tomcat.apache.org/tomcat-7.0-doc/config/context.html#Common_Attributes](http://tomcat.apache.org/tomcat-7.0-doc/config/context.html#Common_Attributes)

Que tengan un buen día!, y si estás leyendo este post en fin de semana.. que tengas un bien fin de semana!
