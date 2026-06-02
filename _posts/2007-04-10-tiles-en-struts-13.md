---
layout: post
title: "Tiles en Struts 1.3"
date: 2007-04-10T18:48:00Z
last_modified_at: 2009-04-25T21:55:03.860Z
author: "Diego Silva"
permalink: /2007/04/tiles-en-struts-13.html
canonical_url: https://www.apuntesdejava.com/2007/04/tiles-en-struts-13.html
tags:
  - "tiles"
  - "web"
  - "struts"
---

Comencé a migrar una aplicación hecha con Struts 1.2  para que utilizará Struts 1.3
Simplemente (pensé) sería copiar el contenido del struts-config.xls (manteniendo el DTD), obviamente usar los .jar respectivos, utilizar el mismo tiles-defs.xml, pero... no funcionó. Respondía el error 404 (no encuentra página).

Después de un día perdido,revisé la documentación

[http://struts.apache.org/1.3.8/struts-tiles/installation.html](http://struts.apache.org/1.3.8/struts-tiles/installation.html)

y pues la solución era sencilla (algo nuevo con respecto al struts 1.2):
Agregar el siguiente parámetro de inicialización del Action Servlet.

```java
<init-param><br />     <param-name>chainConfig</param-name><br />     <param-value>org/apache/struts/tiles/chain-config.xml</param-value><br /></init-param>
```

hora, todo funciona como debería ser.
... no olvidar, siempre leer la documentación.
