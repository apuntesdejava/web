---
layout: post
title: "Generar XLS"
date: 2007-04-10T19:20:00Z
last_modified_at: 2009-04-25T21:55:03.847Z
author: "Diego Silva"
permalink: /2007/04/generar-xls.html
canonical_url: https://www.apuntesdejava.com/2007/04/generar-xls.html
tags:
  - "tomcat"
  - "web"
---

Para generar XLS generalmente se usa el Jakarta POI (en java), pero para web es mejor engañar al navegador.

El navegador recibe como cabecera el tipo del archivo (mime-type) que está recibiendo y sabrá qué programa abrir. Si es de tipo text/html, abrirá el mismo navegador, pero si es un video tendrá otro tipo y le pedirá al sistema operativo abrir el reproductor de vídeo correspondiente.

Para el caso de XLS es lo mismo, y como el Excel puede abrir hasta html, entonces lo engañaremos con más facilidad:

Al inicio del JSP colocaremos esta línea:

```java
<br /><%@page contentType="application/vnd.ms-excel"%>
```

Con esto, cuando se acceda al .jsp abrirá el contenido con el excel. Pero si se estuviese usando el Internet Explorer, el xls saldrá incrustado en el navegador. Esto puede ser molestoso.

Lo que podemos hacer es que se le pregunte al navegador si desea abrirlo o descargarlo. Colocaremos las siguientes líneas:

```java
<br /><%@page contentType="application/vnd.ms-excel"%><br /><%response.setHeader("Content-Disposition",<br />"attachment; filename=\"Archivo.xls\""); %>
```

Luego, en el contenido del jsp pondremos tablas y eso se mostrará en el excel.
