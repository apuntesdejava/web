---
layout: post
title: "Cambiando la versión de la aplicación web (de especificación 2.3 a 2.4)"
date: 2007-06-08T19:34:00Z
last_modified_at: 2009-04-25T21:55:03.786Z
author: "Diego Silva"
permalink: /2007/06/cambiando-la-version-de-la-aplicacion.html
canonical_url: https://www.apuntesdejava.com/2007/06/cambiando-la-version-de-la-aplicacion.html
tags:
  - "java"
  - "web"
  - "struts"
---

Recién me doy cuenta.
Resulta que al hacer una aplicación en Eclipse importando el archivo blank.war de Struts 1.x, no podría usar expresiones como *${variable}* si desea mostrar directamente en un .JSP el valor de esa variable de sesión.

El lenguaje de expresiones (más conocido como EL) está disponible recién en la [versión 2.4 de JSP](http://java.sun.com/products/jsp/). La versión que importé del archivo blank.war era la 2.3.

Entonces ¿dónde cambio la versión de la especificación?

Pues en el archivo web.xml El que importé decía esto:

```java
<code><?xml version="1.0" encoding="UTF-8"?><br /><br /><!DOCTYPE web-app PUBLIC<br /> "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"<br /> "http://java.sun.com/dtd/web-app_2_3.dtd"><br /><br /><web-app><br />...<br /></code>
```

Por tanto, para cambiar la versión de la aplicación, debería cambiar con lo siguiente

```java
<code><?xml version="1.0" encoding="UTF-8"?><br /><web-app xmlns="http://java.sun.com/xml/ns/j2ee"<br /> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<br /> xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"<br /> version="2.4"><br />...<br /></code>
```
