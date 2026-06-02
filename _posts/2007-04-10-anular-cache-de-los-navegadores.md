---
layout: post
title: "Anular caché de los navegadores"
date: 2007-04-10T19:21:00Z
last_modified_at: 2009-04-25T21:55:03.840Z
author: "Diego Silva"
permalink: /2007/04/anular-cache-de-los-navegadores.html
canonical_url: https://www.apuntesdejava.com/2007/04/anular-cache-de-los-navegadores.html
tags:
  - "web"
---

Los navegadores guardan todos los archivos que se han accedido. En internet explorer se llama "archivos temporales de internet"... lo cuál se refiere al caché de internet. (tanto nombre!)

Pero si estamos  en una página que requiere autenticarse, y al deslogear regresa a la página autenticada, pues el navegador mostrará la página por más que  el usuario haya cerrado la sesión. Lo mejor es que cada página que el navegador  no se guarde en el caché.

Para ello colocaremos las siguientes sentencias (ya sea en jsp o en un servlet):

```java
<br />response.setHeader("Cache-control","no-cache");<br />response.setHeader("Pragma","no-cache");<br />response.setDateHeader ("Expires", 0);
```

Y Listo
