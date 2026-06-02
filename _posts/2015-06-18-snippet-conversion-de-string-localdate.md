---
layout: post
title: "Snippet: Conversión de String a LocalDate y a Date, y viceversa"
date: 2015-06-18T18:23:00.001Z
last_modified_at: 2018-01-10T23:47:21.032Z
author: "Diego Silva Límaco"
permalink: /2015/06/snippet-conversion-de-string-localdate.html
canonical_url: https://www.apuntesdejava.com/2015/06/snippet-conversion-de-string-localdate.html
tags:
  - "date"
  - "snippet"
  - "java"
  - "string"
  - "java 8"
  - "localdate"
---

Aquí dejo un snippet que me sirve y también les podrá ser de ayuda para manipular Cadenas con Fechas.

![Snippet: Conversión de String a LocalDate y a Date, y visceversa]({{ '/assets/blogger/Duke_8-copy-300x196.png' | relative_url }})

Resulta que, por cosas de la vida, es necesario agregar días o meses a una fecha que fue ingresada en una cadena, y que debe ser guardada como tipo [java.util.Date](http://docs.oracle.com/javase/8/docs/api/java/util/Date.html) ¡A que no te pasa lo mismo!

Pues bien, la manipulación de días, meses, semanas, etc es más efectivo y cómodo con el nuevo tipo de Java 8 llamado [java.time.LocalDate](http://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html) como lo mencioné en un post anterior: [Paquete java.time de Java 8: Fechas y Horas]({{ '/2014/09/paquete-javatime-de-java8-fechas-y-horas.html' | relative_url }}).

En este snippet (fragmento de código) hice un pequeño ejemplo de cómo convertir desde una cadena, a un tipo `java.time.LocalDate`. Una vez en este tipo, se puede manipular las fechas como mayor se plazca, y luego se puede convertir a `java.util.Date`.

La segunda parte del código es al revés: se tiene un objeto `java.util.Date`, y queremos convertirlo a  `java.time.LocalDate` para poderlo manipular, y luego lo convertimos a cadena para mostrárselo al usuario.

<script src="https://gist.github.com/apuntesdejava/b2df27114cfe500170e9.js"></script>

Si te gustó, dale un +1.

Si te es útil, compártelo... es gratis
