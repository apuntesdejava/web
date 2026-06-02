---
layout: post
title: "Java EE 8 - GlassFish 5.0"
date: 2017-07-26T20:30:00.001Z
last_modified_at: 2017-07-26T20:30:30.015Z
author: "Diego Silva Límaco"
permalink: /2017/07/java-ee-8-glassfish-50.html
canonical_url: https://www.apuntesdejava.com/2017/07/java-ee-8-glassfish-50.html
description: "A partir de hoy y en los siguientes posts comenzaremos a ver y revisar lo que será el Java EE 8.  Para ello utilizaremos GlassFish con la versión 5.0."
tags:
  - "java ee"
  - "javaee8"
  - "glassfish"
  - "glassfish v5"
---

![](/assets/blogger/glassfish_logo.png)

A partir de hoy y en los siguientes posts comenzaremos a ver y revisar lo que **será **el [Java EE](http://www.oracle.com/technetwork/java/javaee/overview/index.html) 8.

Para ello utilizaremos [GlassFish](https://javaee.github.io/glassfish/) con la versión 5.0.

En este post veremos dos puntos:

- Obtener el GlassFish 5.0

- Usar la imagen de Docker.

## Obtener el GlassFish 5.0

En este enlace obtendremos el GlassFish 5.0

[http://download.oracle.com/glassfish/5.0/promoted/latest-glassfish.zip](https://goo.gl/dbqXXb)

Este URL es la versión más reciente (aunque no definitiva) del software.

Y para ejecutarlo, tal como lo hemos estado haciendo desde la primera versión

Linux:

```java
$GLASSFISH_HOME/bin/asadmin start-domain
```

Windows:

```java
%GLASSFISH_HOME%\bin\asadmin.bat start-domain
```

Y al entrar a la consola web: http://localhost:4848

Esta es la página de carga

[![](/assets/blogger/glassfish-splash.png)](/assets/blogger/glassfish-splash.png)

y finalmente obtendremos la consola de administración:

[![](/assets/blogger/glassfish-consola.png)](/assets/blogger/glassfish-consola.png)

Básicamente luce igual a la versión 4.0

## Imagen de Docker

Otra manera de obtener el GlassFish es usando el ya famoso Docker.

Bastaría con ejecutar este comando desde la consola

```java
docker run -d --name glassfish5 -p 8080:8080 oracle/glassfish:nightly
```

Y tendremos nuestro contenedor listo para operar.

## Desplegando una aplicación

Podemos probar desplegando una aplicación Java EE que ya tengamos, o una que ya tenga las características de Java EE 8, como este código que está disponible en otro Post [Java EE 8 - MVC 1.0](https://goo.gl/QCU4LF):

[https://bitbucket.org/apuntesdejava/java-ee-8-demo-mvc-jpa/](https://goo.gl/KF3hqA)

Empaquetamos el .war y lo desplegamos en `$GLASSFISH_HOME/glassfish/domains/domain1/autodeploy` y listo. Igual de simple.

Eso es todo por hoy, en el siguiente post veremos más detalles para explorar.
