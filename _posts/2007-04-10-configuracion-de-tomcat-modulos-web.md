---
layout: post
title: "Configuración de Tomcat (módulos web)"
date: 2007-04-10T19:16:00Z
last_modified_at: 2009-04-25T21:55:03.853Z
author: "Diego Silva"
permalink: /2007/04/configuracion-de-tomcat-modulos-web.html
canonical_url: https://www.apuntesdejava.com/2007/04/configuracion-de-tomcat-modulos-web.html
tags:
  - "tomcat"
  - "web"
---

"Normalmente", cuando un newbie en desarrollo hace su aplicación web y lo quiere publicar, suele colocarlo junto con los documentos del servidor web. Por ejemplo, si se tratase de PHP en Apache, lo coloca dentro de DocumentRoot; y si es Tomcat, en $CATALINA_HOME/webapps. Esto es normal, pero es algo desordenado tener la aplicación dentro del sistema que lo ejecuta. (Recuerdo que los perfiles de usuario en Windows NT estaban dentro del directorio Windows, si se instalaba nuevamente el sistema operativo, todos los perfiles se borraba. A partir del Windows 2K, los perfiles se guardan en un directorio a parte llamado "c:\Document and Settings").

Esto se puede hacer en Tomcat. Si deseamos cambiar de contenedor web (a una versión superior, o cambiar de propietario), los módulos web seguirán en el mismo sitio.

- Lo principal es tener todos los módulos web en un directorio aparte, que lo podamos identificar tan fácilmente como el "Document and Settings" del Windows.
- Crear un archivo .xml en el directorio $CATALINA_HOME/conf/[enginename]/[hostname]/ (generalmente enginename=Catalina y hostname=localhost, se puede crear otros enginename y otros hostname editando el archivo server.xml)

- Este archivo .xml tiene un solo elemento llamado <Context />, el cual tiene los siguientes atributos.

<table border="1"><br /><thead><br /><tr><th>Atributo</th><th>Descripción</th></tr></thead><br /><tbody><br /><tr><td>docBase<br /></td><td>Directorio del módulo web. También conocido como <em>ContextRoot</em>. Es la ruta absoluta o relativa donde se ubica fisicamente los archivos del módulo web.<br /></td></tr><br /><tr><td>path<br /></td><td>Nombre con que se publicará en el contenedor web. Por ejemplo: http://yourdomain.com:8080/<strong>moduloweb</strong>. En mi experiencia, el valor de este atributo debe coincidir con el nombre del archivo .xml<br /></td></tr><br /><tr><td>reloadable<br /></td><td>Si se pone en true, Catalina estará revisando a cada momento los directorios WEB-INF/classes y WEB-INF/lib. Si encuentra un nuevo archivo, se recargará el contexto. Esto es recomendable para la etapa de desarrollo.<br /></td></tr></tbody></table>

Esta sería la configuración principal básica para separar el módulo web del contenedor web.
La relación completa de los atributos para <context /> se encuentra en [http://tomcat.apache.org/tomcat-5.5-doc/config/context.html](http://tomcat.apache.org/tomcat-5.5-doc/config/context.html).
