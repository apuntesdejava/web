---
layout: post
title: "NetBeans Portable + Java Portable [+ GlassFish Portable + Tomcat Portable...]"
date: 2015-08-23T01:07:00Z
last_modified_at: 2015-08-23T02:35:17.279Z
author: "Diego Silva Límaco"
permalink: /2015/08/netbeans-portable-java-portable.html
canonical_url: https://www.apuntesdejava.com/2015/08/netbeans-portable-java-portable.html
tags:
  - "netbeans"
  - "portable"
  - "tips"
  - "trucos"
---

Lo más requerido de una aplicación es que sea portable, y - según viendo algunas estadísticas - existen programadores que quieren tener el NetBeans también portable.

Qué significa que una aplicación sea portable? Bueno, que se pueda ejecutar sin que se instale en el sistema operativo.

Así que en este post explicaré un truco para que tengas tu NetBeans IDE de manera portable.

### NetBeans Portable

- Primero, te vas a la página de descarga de NetBeans [[https://netbeans.org/downloads/](https://netbeans.org/downloads/)]

- Luego, selecciona en el "Plataform"la opción "OS Independent zip". Ya que NetBeans está hecho 99.99% en Java, entonces, no es necesario instalarlo. Así que aquí nos proporcionan el mismo IDE de manera comprimida.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiJSgkrFcslj-QIV_iNR7O_REkr7T52lSd8siox4VdCPXN22H9zptL1jam7gIplaFEoZIAuc1yVgpfbS1qVjpBjPGPYtvoodH3EAQJJMKXOHJGFnPWf0b71OMCLirJ0vSz6lehoqNmOzWs/s320/Captura+de+pantalla+2015-08-22+a+la%2528s%2529+18.38.01.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiJSgkrFcslj-QIV_iNR7O_REkr7T52lSd8siox4VdCPXN22H9zptL1jam7gIplaFEoZIAuc1yVgpfbS1qVjpBjPGPYtvoodH3EAQJJMKXOHJGFnPWf0b71OMCLirJ0vSz6lehoqNmOzWs/s1600/Captura+de+pantalla+2015-08-22+a+la%2528s%2529+18.38.01.png)

- Seleccionamos que edición queremos: Java SE, Java EE... y le hacemos clic en el botón Download que se encuentra en la parte inferior de la columna respectiva.

**Pero OJO!!!!!!**

Solo estamos bajando el IDE. Y, nuevamente, como está hecho en Java, necesitamos tener el Java instalado para poderlo ejecutar.  Así que aquí viene la segunda parte del tip.

### Java Portable

En Mac y Linux no tenemos ningún problema de instalar el Java, ya que podemos tener más de un JDK instalado: Podemos tener el Java7 y Java8 y eso no afecta al funcionamiento de nuestras aplicaciones (además que el tema de portabilidad es más aplicado para Windows).

Así que.. cómo podemos tener el Java portable para Windows? Es relativamente fácil. Pero quiero advertirles que solo funciona en Windows de 64 bits. Aunque a esta altura de la evolución tecnológica ya casi nadie tiene de 32 bits.

En fin, vayamos a la página de descarga de Java Oracle en la siguiente dirección: [http://www.oracle.com/technetwork/java/javase/downloads/index.html](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

Y, hagan clic en la opción "Server JRE [Download]", acepten la licencia y descarguen el indicado para Windows.

Por qué "Server" si es solo JRE?. Bueno, por definición, JRE es únicamente para ejecutar aplicaciones compiladas, por tanto no tiene el comando "javac" que sirve para compilar. Pero el caso de las aplicaciones web, existen archivos que necesitan ser compilados, como los archivos ".jsp". Por tanto, esta "edición"de Server JRE está orientado para los servidores como un contenedor Java server, como Tomcat, GlassFish, JBoss, etc.... por tanto necesita de algunos comandos que son propios de SDK pero que sirven para ejecutar. Sin tanto rollo, descarga no más ese .zip y listo, ya tienes tu JDK portable.

Solo que al ejecutarlo, asegúrate que exista la variable de entorno JAVA_HOME apuntando al directorio donde tienes descomprimido el Java. (Sí, debes descomprimirlo.. al igual que el IDE)

**Segundo OJO!!!!!!**

Si se dieron cuenta al descargar el IDE, las filas respectivas para Tomcat o GlassFish no están activadas. Esto es natural, ya que el zip solo tiene el IDE. Por tanto, debemos bajar por nuestra propia cuenta las plataformas Tomcat y/o Glassfish. Aquí están las direcciones de descarga.

- GlassFish [https://glassfish.java.net/](https://glassfish.java.net/)

- Tomcat (Nota: elegir los archivos tipo .zip o .tar.gz, están al inicio)

- 8 [http://tomcat.apache.org/download-80.cgi](http://tomcat.apache.org/download-80.cgi)

- 7 [http://tomcat.apache.org/download-70.cgi](http://tomcat.apache.org/download-70.cgi)

Descompriman los servidores respectivos, y al ejecutar el IDE, ir a la ventana "Services"...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjaTrEtw8SNKI-P7Dtf2kHG36BXvcbsLd9PJ_TrM3pDnbCe3hLcdPtVENEqEse4aSvhW57ZQUqRoQ661DLL_wdPJQZ1_Uhtl-4ekDRpbeXvTsoMYM6EiEJc0pq2K7D9sedNMdbCOWOLFiY/s320/Captura+de+pantalla+2015-08-22+a+la%2528s%2529+18.37.02.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjaTrEtw8SNKI-P7Dtf2kHG36BXvcbsLd9PJ_TrM3pDnbCe3hLcdPtVENEqEse4aSvhW57ZQUqRoQ661DLL_wdPJQZ1_Uhtl-4ekDRpbeXvTsoMYM6EiEJc0pq2K7D9sedNMdbCOWOLFiY/s1600/Captura+de+pantalla+2015-08-22+a+la%2528s%2529+18.37.02.png)

... hacer clic derecho sobre el nodo "Servers"y seleccionar "Add Server...". Seleccionar el servidor, y seguir los pasos que se le indican

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSOKAIaWL-fQV1n56l3Dfz-4dWpvkpe6Xu09iieuUYzRgI3lM52OX9PHvH1qZyZDoVor6iYD7PQFOmcbowEg8RhKLA9_8ttFIs_aOLEoZZ7RhgILImwdFZ9VHV81EiAAPwSiXe2n72mFo/s400/Captura+de+pantalla+2015-08-22+a+la%2528s%2529+18.37.18.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSOKAIaWL-fQV1n56l3Dfz-4dWpvkpe6Xu09iieuUYzRgI3lM52OX9PHvH1qZyZDoVor6iYD7PQFOmcbowEg8RhKLA9_8ttFIs_aOLEoZZ7RhgILImwdFZ9VHV81EiAAPwSiXe2n72mFo/s1600/Captura+de+pantalla+2015-08-22+a+la%2528s%2529+18.37.18.png)

**Tercer ojo..!!!!!**

... no, no hay tercer ojo.. sino seríamos fenómenos más de lo que ya somos.

Eso es todo. Espero que les sea de utilidad.

**Si te gustó, dale pulgar arriba... y si te es útil, compártelo... es gratis.**
