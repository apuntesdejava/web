---
layout: post
title: "Configuración de Tomcat (conectando al Apache utilizando AJP)"
date: 2007-04-10T19:19:00Z
last_modified_at: 2009-04-25T21:55:03.769Z
author: "Diego Silva"
permalink: /2007/04/configuracion-de-tomcat-conectando-al.html
canonical_url: https://www.apuntesdejava.com/2007/04/configuracion-de-tomcat-conectando-al.html
tags:
  - "tomcat"
  - "web"
---

El Tomcat utiliza - por omisión - el puerto 8080 para mostrar los contenidos web. Se puede cambiar el puerto de salida en el archivo $CATALINA_HOME/conf/server.xml de 8080 a 80, para que el acceso sea más simple y evitar escribir un "apellido" como http://midominio:8080/sistemaweb/.

Pero quizás en nuestro host también estemos utilizando el apache para publicar otras aplicaciones que no son necesariamente jsp/servlet.

Es posible hacer que todas las peticiones que reciba el apache a un determinado "directorio" sea redireccionado al tomcat, para que este lo atienda y envie su respueta al cliente através del Apache.

Hay dos maneras para lograr esto: con el ProxyHTTP y con el conector AJP. En este mensaje mostraré cómo se utiliza el AJP.

[![](http://photos1.blogger.com/blogger/1623/1215/320/modelo-ajp.png)](http://photos1.blogger.com/blogger/1623/1215/1600/modelo-ajp.png)En este diagrama se muestra como funciona el AJP. Por omisión utiliza el puerto 8009 localmente.

Paso 0: descargar el conector:
El conector se puede encontrar en el [sitio web de Tomcat](http://tomcat.apache.org/download-connectors.cgi). Debemos escoger el jk1.2( el jk2 es obsoleto). Si el Apache está en Window$ , entraremos al enlace de los binarios compilados y utilizaremos la versión que le corresponda. Tenemos que leer bien las instrucciones que se muestran antes de descargar el archivo.

Paso 1: instalando el módulo jk:
Si estamos en linux necesitaremos el Apache apxs. Si su Apache fue instalado con RPM, necesitará instalar el paquete httpd-devel.
Luego bajaremos el código fuente del conector, lo desempaquetamos, compilamos e instalamos:

$su -
#tar xvzf jakarta-tomcat-connectors-1.2.x-src.tar.gz
#cd jakarta-tomcat-connectors-1.2.x/jk/native
#./configure --with-apxs=`which apxs`
#make
#make install

Esto hará que se cree el módulo mod_jk.so y lo copiará en el directorio respectivo del Apache.

Paso 2: Configurando el apache:
Editaremos el archivo de configuración del apache httpd.conf y agregaremos las siguientes líneas:

# El archivo workers que indica donde estarán los módulos webs del tomcat
JkWorkersFile "/etc/httpd/conf/workers.properties"
# La ruta de un log de actividad
JkLogFile "/etc/httpd/logs/mod_jk.log"
# Qué va a mostrar en el log
JkLogLevel info
#el formato del log
JkLogStampFormat "[%a %b %d %H:%M:%S %Y]"
#El módulo web que deberá cargar
JkMount /sistemaweb/* wrk1

Ahora, crearemos el archivo workers.properties que debe ubicarse en la misma ruta que se especificó en el archivo httpd.conf. Este archivo tendrá lo siguiente:

worker.list=wrk1
worker.wrk1.port=8009
worker.wrk1.host=localhost
worker.wrk1.type=ajp13
worker.wrk1.cachesize=10
worker.wrk1.cache_timeout=600
worker.wrk1.socket_timeout=300

La primera línea es importante, ya que dice cuales son los workers que se van a manejar. Un worker está asociado a un host en particular utilizando un puerto. En este caso buscará un tomcat en el localhost, y utilizará el puerto 8009 para conectarse a su AJP.

Paso 3: configuración el Tomcat:
En este paso no se hace nada, ya que por omisión el tomcat viene activado el AJP en el puerto 8009.

Probaremos llamando a una dirección similiar:
http://midominio.com/sistemaweb/

Nota: aun no sé por qué se tiene que terminar con un signo "/", si se le quita no lo encuentra.

Apache - Tomcat 1:N
En un ambiente óptimo (lo que implica tener más $$), es posible tener un host con el Apache (que podría ser el portal de una organización) y otros hosts por cada oficina. Se puede deducir que en el host del portal de la organización no tiene por qué estar instalado el Tomcat. La figura sería algo como esta:

[![](http://photos1.blogger.com/blogger/1623/1215/320/modelo-ajp2.png)](http://photos1.blogger.com/blogger/1623/1215/1600/modelo-ajp2.png)Supongamos que el área de ventas tenga un módulo web llamado "wventas" en el host con ip 10.1.1.10, y el área de "atención al cliente" tenga un módulo web llamado "wclientes" en el host con ip 10.1.1.11.

Primero debemos editar el archivo workers.properties para que tenga el siguiente contenido:

worker.list=wrk10,wrk11
worker.wrk10.port=8009
worker.wrk10.host=10.1.1.10
worker.wrk10.type=ajp13
worker.wrk10.cachesize=10
worker.wrk10.cache_timeout=600
worker.wrk10.socket_timeout=300

worker.wrk11.port=8009
worker.wrk11.host=10.1.1.11
worker.wrk11.type=ajp13
worker.wrk11.cachesize=10
worker.wrk11.cache_timeout=600
worker.wrk11.socket_timeout=300

(Coloqué el nombre de los workers wrk10 y wrk11 haciendo referencia a los ips de los hosts 10.1.1.10, y 10.1.1.11 respectivamente).

Luego necesitamos editar el archivo httpd.conf para que tenga estas líneas

JkMount /wventas/* wrk10
JkMount /wclientes/* wrk11

Reiniciamos el servicio del apache y podremos entrar a las direcciones:
http://midominio.com/wventas/
http://midominio.com/wclientes/

Nota: Los nombres son tal cual los nombres de los módulos web en el Tomcat.
