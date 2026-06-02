---
layout: post
title: "JPA con Stored Procedures"
date: 2015-06-10T00:30:00Z
last_modified_at: 2018-01-10T23:43:09.536Z
author: "Diego Silva Límaco"
permalink: /2015/06/jpa-con-stored-procedures.html
canonical_url: https://www.apuntesdejava.com/2015/06/jpa-con-stored-procedures.html
tags:
  - "java ee"
  - "java ee 7"
  - "jpa"
  - "netbeans"
  - "video"
---

[![JPA con Stored Procedures](/assets/blogger/javaee1_large.png)](/assets/blogger/javaee1_large.png)

JPA es el API que nos permite manejar la persistencia en Java de una manera transparente. No debemos preocuparnos cuál es el DBMS que está guardando los registros, simplemente lo invocamos como si fueran objetos en Java.

En la versión 2.1 de JPA, dentro el JavaEE 7, se puso una nueva característica que es la de invocar Stored Procedures.

Hice un pequeño tutorial, y aquí lo muestro el código fuente, y la ejecución en un vídeo.

Para nuestro ejemplo, la unidad de persistencia es una declaración normal. En este ejemplo declaramos explícitamente la conexión a la base de datos.

Aquí uso MySQL, pero puede ser cualquier base de datos que permita stored procedures.

<script src="https://bitbucket.org/apuntesdejava/jpa-storedprocedures-demo/src/d96b1533dc18ed2faf92c854f52cf1f80c986796/src/main/resources/META-INF/persistence.xml?embed=t"></script>

Nuestro stored procedure es uno llamado `p` que tendrá dos parámetros: uno de salida y otro de entrada y salida

<script src="https://bitbucket.org/apuntesdejava/jpa-storedprocedures-demo/src/d96b1533dc18ed2faf92c854f52cf1f80c986796/src/main/resources/scripts/create-storedprocedure.sql?embed=t"></script>

La llamada al stored procedure es bastante simple. Aquí el código de ejemplo:

<script src="https://bitbucket.org/apuntesdejava/jpa-storedprocedures-demo/src/d96b1533dc18ed2faf92c854f52cf1f80c986796/src/main/java/com/apuntesdejava/jpa/storedprocedures/demo/App.java?embed=t"></script>

Y para verlo en acción, aquí les dejo el vídeo:

<iframe allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/B2gEndps4rc" width="560"></iframe>

El código fuente lo puedes descargar por git desde estas direcciones:

- [https://bitbucket.org/apuntesdejava/jpa-storedprocedures-demo/src/](https://bitbucket.org/apuntesdejava/jpa-storedprocedures-demo/src/)

- [https://github.com/apuntesdejava/jpa-storedprocedures-demo](https://github.com/apuntesdejava/jpa-storedprocedures-demo)

#### Facebook

<iframe allowtransparency="true" frameborder="0" height="269" scrolling="no" src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1152370284774268&amp;width=500" style="border: none; overflow: hidden;" width="500"></iframe>

#### Twitter

>

Ejecutando Stored Procedures en [#JPA](https://twitter.com/hashtag/JPA?src=hash)

Like si te gustó, compártelo si te es útil... sí, es gratis :)[https://t.co/6MyNCjeJMa](https://t.co/6MyNCjeJMa)

— Apuntes de Java (@apuntesdejava) [5 de abril de 2016](https://twitter.com/apuntesdejava/status/717474439315734528)

<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>
