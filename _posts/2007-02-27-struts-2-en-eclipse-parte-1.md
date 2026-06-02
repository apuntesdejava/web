---
layout: post
title: "Struts 2 en Eclipse (parte 1)"
date: 2007-02-27T22:28:00Z
last_modified_at: 2009-04-25T21:55:03.247Z
author: "Diego Silva"
permalink: /2007/02/struts-2-en-eclipse-parte-1.html
canonical_url: https://www.apuntesdejava.com/2007/02/struts-2-en-eclipse-parte-1.html
tags:
  - "struts"
---

Pues, no utilizaré Eclipse, sino JBuilder 2007 que es lo mismo (me descepcionó la "mejora" que hizo Borland por este IDE)

## Creando una nueva aplicación

- Descargar el Struts de la web: [http://struts.apache.org/download.cgi](http://struts.apache.org/download.cgi). Preferible si es la distribución completa.
- Descomprimir el archivo en un directorio.

- En el Eclipse (o JB2007), entrar el menú "File | Import...".
- Seleccionar Web > War File:[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhWxGSrnc_07OBR81Xs652fJkXcvRotqER7xMQ7pAa1puyqA4mIm8E4RhwB6bZh1vA_uGZPIQxk1QFL65-HcRZrD-4BoZBJEgp5kBmawaoJxv_x8EjVryfYW2gP8UdkW8l5VsXPSd5vS3H5/s320/import-war.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhWxGSrnc_07OBR81Xs652fJkXcvRotqER7xMQ7pAa1puyqA4mIm8E4RhwB6bZh1vA_uGZPIQxk1QFL65-HcRZrD-4BoZBJEgp5kBmawaoJxv_x8EjVryfYW2gP8UdkW8l5VsXPSd5vS3H5/s1600-h/import-war.jpg)
- Seleccionar el archivo struts2-blank.war que se encuentra en el directorio $STRUTS2/apps/. Además, escribir un nombre para el nombre del proyecto web nuevo:[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBoFfOv89ZofTv2Wyx4KFIlCj9B0TvpebwC8sD2PwsSi8ruHFV4cRbwNXosSU0qVpuD-yltyiPpvyVfSXSAvZBmXOPrGOBguIHk1UrgAC827ye7keqj9Wc6OLQeDnb666cM1AqZ0Km6Rix/s320/import-war1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBoFfOv89ZofTv2Wyx4KFIlCj9B0TvpebwC8sD2PwsSi8ruHFV4cRbwNXosSU0qVpuD-yltyiPpvyVfSXSAvZBmXOPrGOBguIHk1UrgAC827ye7keqj9Wc6OLQeDnb666cM1AqZ0Km6Rix/s1600-h/import-war1.jpg)
- Clic en Finish.

## Examinando el proyecto

El Struts2 viene con mejoras significativas. Prácticamente es otro framework, pero mantiene el espíritu principal de Struts: Actions + Forms.

Ya no usa un Servlet, sino un Filter. Eso lo podemos ver en el archivo web.xml.

El archivo de configuración ya no está en WEB-INF, sino es un recurso del proyecto. Podemos encontrar el archivo struts.xml en el directorio de fuentes .java (src)

Los ActionForms ahora pueden ser cualquier clase, no necesariamente que tenga que ser heredados de un ActionForm. Puede ser cualquier clase JavaBean.

El Validator ya no es un enorme archivo .xml para todas las validaciones. Sino, existe un .xml por cada Action de la aplicación.

Bueno, estos fueron algunas cosas que he encontrado. Pero puedo encontrar más a medida que vaya desarrollando un ejemplo CRUD. (Create Read Update Delete).
