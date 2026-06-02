---
layout: post
title: "Lenya en Tomcat 6.0"
date: 2009-04-24T22:32:00.004Z
last_modified_at: 2009-04-25T22:03:41.841Z
author: "Diego Silva"
permalink: /2009/04/lenya-en-tomcat-60.html
canonical_url: https://www.apuntesdejava.com/2009/04/lenya-en-tomcat-60.html
tags:
  - "server"
  - "apache"
  - "web"
---

Existe un CMS de apache llamado [Lenya](http://lenya.apache.or/).

En las instrucciones de compilación está para Tomcat 5.5.

Al compilarlo y después ejecutarlo, no funciona.

Esto es por algo importante que dice en las instrucciones y podría pasar por alto.

En resumen. Se debe editar el archivo `local.build.properties` y modificar la línea siguiente

```java
<code>tomcat.endorsed.dir=${tomcat.home.dir}/lib</code>
```

 Ya que la estructura predeterminada se usa en Tomcat 5.

Compilar, y servir
