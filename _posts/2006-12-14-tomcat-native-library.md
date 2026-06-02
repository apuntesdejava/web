---
layout: post
title: "Tomcat Native Library"
date: 2006-12-14T21:33:00Z
last_modified_at: 2009-04-25T21:55:03.867Z
author: "Diego Silva"
permalink: /2006/12/tomcat-native-library.html
canonical_url: https://www.apuntesdejava.com/2006/12/tomcat-native-library.html
tags:
  - "tomcat"
  - "apache"
---

La [documentación del Tomcat Native](http://tomcat.apache.org/tomcat-5.5-doc/apr.html#Linux) dice que se puede encontrar esa biblioteca en el directorio $TOMCAT_HOME/bin.. pero cada vez que inicio el tomcat me aparece la advertencia "se encontró la versión 1.1.3, considere actualizarlo a una versión superior al 1.1.4"... pero debería venir eso con el tomcat!.. je, encontré un servidor mirror con esos archivos:

[http://tomcat.heanet.ie/](http://tomcat.heanet.ie/)

Aunque ahora que lo pienso... creo que debí examinar su sección "[browse download area](http://apache.ziply.com/tomcat/tomcat-connectors/native/)" de la sección "[Tomcat connectors downloads](http://tomcat.apache.org/download-connectors.cgi)".

¡AH! no olvidar bajar el APR ([Apache Portable Runtime](http://apr.apache.org/)) y compilarlo antes de compilar el Tomcat Native Library. Asegurarse que sea la última versión. Si viene el APR de un RPM (como en CentOS o Fedora), desinstalarlo antes.
