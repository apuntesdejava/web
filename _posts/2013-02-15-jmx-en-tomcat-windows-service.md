---
layout: post
title: "JMX en Tomcat Windows Service"
date: 2013-02-15T05:01:00Z
last_modified_at: 2013-02-15T05:01:01.074Z
author: "Diego Silva Límaco"
permalink: /2013/02/jmx-en-tomcat-windows-service.html
canonical_url: https://www.apuntesdejava.com/2013/02/jmx-en-tomcat-windows-service.html
tags:
  - "jdk"
  - "jvisualvm"
  - "windows"
  - "jmx"
  - "tomcat"
---

[JMX](http://www.oracle.com/technetwork/java/javase/tech/javamanagement-140525.html)es una tecnología que permite la administración y monitoreo de aplicaciones Java. A partir de la versión 6, en el JDK viene incluido el [Java VisualVM](http://visualvm.java.net/) que es una herramienta que permite monitorear visualmente las aplicaciones Java en la máquina virtual. Lo pueden encontrar dentro de la carpeta bin del JDK.

Cuando lo ejecutan, pueden ver como se está ejecutando las aplicaciones en Java, sus clases, qué tipo de objeto es el que está usándose más, etc. Es muy recomendable usarlo para mejorar el rendimientos de las aplicaciones.

Tomcat también puede ser monitoreado desde Java VisualVM, pero encontré un detalle si ejecuto el Tomcat en modo servicio de Windows: no puedo conectarme desde el Java VisualVM.

La solución es simple: modificar la configuración del servicio de Tomcat.

Ejecutamos el tomcat7w.exe desde el servidores, y nos mostrará la configuración del servicio Tomcat. En la sección "Java" agregar estas líneas en la sección "Java options"

```java
-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.port=1001
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.authenticate=false
```

[![]({{ '/assets/blogger/tomcat7w.exe.png' | relative_url }})]({{ '/assets/blogger/tomcat7w.exe.png' | relative_url }})

Luego, reiniciamos el servicio y listo.

Ahora, desde el Java VisualVM, entramos a File > Add JMX Connection y agregamos el IP del servidor a monitorear, y el puerto, que en este caso, es 1001 (porque así lo pusimos en el Java Options)

[![]({{ '/assets/blogger/add-jmx.png' | relative_url }})]({{ '/assets/blogger/add-jmx.png' | relative_url }})

 y listo, a comenzar a monitorear!

[![]({{ '/assets/blogger/jvisualvm.png' | relative_url }})]({{ '/assets/blogger/jvisualvm.png' | relative_url }})
