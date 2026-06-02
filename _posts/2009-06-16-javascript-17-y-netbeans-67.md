---
layout: post
title: "JavaScript 1.7 y NetBeans 6.7"
date: 2009-06-16T19:12:00.002Z
last_modified_at: 2009-06-17T14:34:51.161Z
author: "Diego Silva"
permalink: /2009/06/javascript-17-y-netbeans-67.html
canonical_url: https://www.apuntesdejava.com/2009/06/javascript-17-y-netbeans-67.html
tags:
  - "netbeans 6.7"
  - "netbeans"
  - "web"
  - "javascript"
---

Estaba revisando las característica de NetBeans 6.7 y he visto que ahora permite el autocompletar para [ECMA for Script](http://en.wikipedia.org/wiki/E4X) (o conocido como E4X).
El E4X consiste en una extensión a los lenguajes soportados por [ECMAScript](http://en.wikipedia.org/wiki/ECMAScript)  para que puedan manejar XML
JavaScript es parte de ECMAScript. Así que podríamos declarar variables javascript así:

```java
<br />var ventas=<ventas><br />       <producto tipo="teclado" precio="10" cantidad="3"/><br />       <producto tipo="monitor" precio="20" cantidad="2"/><br />       <producto tipo="raton" precio="30" cantidad="1"/><br />    </ventas>;<br />
```

Y desde NetBeans, podemos acceder a sus nodos como si fuera un objeto más en javascript:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRGQj4Yy8R1PtvrYmSNKQdJS6Nm7_EVAVAFOI-rs3bpfksY_RxiM__-Y6n4LOG0DRI9z5d5kZXOnVl199iyzpuCHYV5KT23lgt0fOzh9iOW6msgWC-EWZ28_6t_dDesyPZAC-QJhrxhOe8/s400/javascript17-nb.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRGQj4Yy8R1PtvrYmSNKQdJS6Nm7_EVAVAFOI-rs3bpfksY_RxiM__-Y6n4LOG0DRI9z5d5kZXOnVl199iyzpuCHYV5KT23lgt0fOzh9iOW6msgWC-EWZ28_6t_dDesyPZAC-QJhrxhOe8/s1600-h/javascript17-nb.jpg)

wow!! Se ve todo bonito!!... pero esto funciona en Firefox, Safari y Chrome... y no está incluido por nada en la versión de nuestros amigos de las ventanitas coloridas.

[http://en.wikipedia.org/wiki/JavaScript#Versions](http://en.wikipedia.org/wiki/JavaScript#Versions)

Así que, tendremos que seguir usando el formato [json](http://www.json.org/) que, de hecho, no tiene nada de malo.
