---
layout: post
title: "Revisión Libro: Wildfly Performance Tuning"
date: 2014-09-25T17:40:00Z
last_modified_at: 2014-09-25T17:40:14.449Z
author: "Diego Silva Límaco"
permalink: /2014/09/revision-libro-wildfly-performance.html
canonical_url: https://www.apuntesdejava.com/2014/09/revision-libro-wildfly-performance.html
tags:
  - "libros"
  - "java ee"
  - "wildfly"
  - "rendimiento"
  - "comentarios"
---

[![Wildfly Performance Tuning](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjeO8qgUM8zBRTftfXctiXNyd0DMkALMhhJUCO_aznLelqkiJcwwbqTffWZOTNKkX21_WXNBRAJu4bPsTbqOqoV2cAoCatZTMJeNjEfdBW6WE7P91ULWnyEhyWoYpHwKwffJAU2U0WHZw0/s1600/0567OS_WildFly+Performance+Tuning.jpg.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjeO8qgUM8zBRTftfXctiXNyd0DMkALMhhJUCO_aznLelqkiJcwwbqTffWZOTNKkX21_WXNBRAJu4bPsTbqOqoV2cAoCatZTMJeNjEfdBW6WE7P91ULWnyEhyWoYpHwKwffJAU2U0WHZw0/s1600/0567OS_WildFly+Performance+Tuning.jpg.png)

He estado el libro de Arnold Johansson y Anders Welen llamado "[WildFly Performance Tunning](http://t.co/F3ifon3Jg2)"

Solo son tres capítulos bastante útiles desde el inicio.

El primer capítulo habla sobre la Ciencia del Rendimiento. De una manera objetiva menciona todos los aspectos que se deben considerar para realizar un buen afinamiento del rendimiento. Explica en qué consiste la escalabilidad, los "antisocios" que no ayudan para un afinamiento, así como las pruebas que se debe considerar para un buen trabajo. Este es un capítulo muy útil y general, que se puede aplicar para cualquier software, y no necesariamente WildFly o que sea Java.

El segundo capítulo comprende sobre las herramientas que permiten un buen afinamiento, profiling (no sé cómo se traduciría en español), muestras de memoria y cpu, VisualVM, monitoreo, herramientas del sistema operativo como `top`,`vmstat`,`netstat` de Linux/Unix, `vm_stat` de OS X, y el Administrador de tareas y el comando `ntstat` de Windows. También explica el uso de las mismas herramientas de WildFly, y el bastante bien usado generador de stress de [Apache JMeter](http://jmeter.apache.org/).

Una vez que se reunió todo el concepto necesario, y todas las herramientas necesarias, llegamos al capítulo tres para describir cómo realizar un afinamiento en la JVM, comenzando por la teoría de las áreas de memoria del JVM (heap, stack nativo y stack de JVM) y conocer el GC. Probamos los posibles escenarios en que se enfrenta la JVM, así como qué hacer para evitar que se *caiga* la memoria  (el temible `java.lang.OutOfMemoryError`). Y finaliza cómo y qué se debería monitorear la JVM en un ambiente de producción.

Realmente es un gran libro necesario para realizar afinamientos de rendimiento. No es necesario que se aplique a WildFly, porque hay muchos conceptos que se pueden aplicar en cualquier contenedor JavaEE, y da buenas luces para darse cuenta de la memoria al momento de desarrollar una aplicación Java cualquiera. Realmente lo recomiendo.

Si desean el libro, lo pueden adquirir en [http://t.co/F3ifon3Jg2](http://t.co/F3ifon3Jg2)
