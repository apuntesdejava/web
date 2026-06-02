---
layout: post
title: "Java SE 6 Update 15 disponible (y cómo revivir a Glassfish con una nueva version de Java)"
date: 2009-08-05T15:13:00Z
last_modified_at: 2009-08-05T15:13:40.105Z
author: "Diego Silva"
permalink: /2009/08/java-se-6-update-15-disponible-y-como.html
canonical_url: https://www.apuntesdejava.com/2009/08/java-se-6-update-15-disponible-y-como.html
tags:
  - "glassfish"
  - "java"
  - "tips"
---

Ya está disponible la actualización 15 de Java SE 6. Incluye mejoras de seguridad, rendimiento y el nuevo colector de basura [G1](http://java.sun.com/javase/technologies/hotspot/gc/g1_intro.jsp).

Lo pueden descargar desde aquí [http://java.sun.com/javase/downloads/index.jsp](http://java.sun.com/javase/downloads/index.jsp).

**¿Y si malogro mi Glassfish?**

Quizás te pasó esto: tienes tu GF funcionando de las mil maravillas, y quieres actualizar tu JDK. Luego, tratas de ejecutar el GF nuevamente (ya sea directamente desde asadmin o desde el NB) y no funciona. Y lo que puedes  hacer es reinstalar todo el GF... o peor aún: regresar a la versión anterior del JDK.

la solución:

- Si estás en Windows

- Edita el archivo `%GLASSFISH_HOME%\config\asenv.bat`

- busca la línea que comienza con set AS_JAVA=

- Cambia la ruta para que apunte a la dirección del JDK que acabas de instalar. Por ejemplo, si acabas de instalar el JDK 6u15, escribe así

`set AS_JAVA=c:\Archivos de programa\Java\jdk1.6.0_15`

- Guardas e inicias el GF.

`%GLASSFISH_HOME%` es el directorio donde instalaste el GF, ya sea el que vino con el NB (por lo general, está en C:\Sun), o el que instalaste independientemente (por ejemplo,  c:\glassfish)
