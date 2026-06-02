---
layout: post
title: "Desarrollo evolutivo"
date: 2010-06-23T15:45:00Z
last_modified_at: 2010-06-23T15:45:31.196Z
author: "Diego Silva"
permalink: /2010/06/desarrollo-evolutivo.html
canonical_url: https://www.apuntesdejava.com/2010/06/desarrollo-evolutivo.html
tags:
  - "opinion"
  - "off topic"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhg-TbF3DHux3E5dXTuf9U99O2mfYqTL4W8rCRXRuFkEhxMfuYeLWh7lLwqst1e1eMEOa34Vp39qC2m6MM8C6TKI7-6gHenuTYtaW5RSII8zNrMml0yR5dnDhPU_fVpfxUQJiYevvC9BhJ7/s200/turismo_y_tecnologia.gif)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhg-TbF3DHux3E5dXTuf9U99O2mfYqTL4W8rCRXRuFkEhxMfuYeLWh7lLwqst1e1eMEOa34Vp39qC2m6MM8C6TKI7-6gHenuTYtaW5RSII8zNrMml0yR5dnDhPU_fVpfxUQJiYevvC9BhJ7/s1600/turismo_y_tecnologia.gif)

Yo creo que lo único que es evolutivo es el conocimiento humano, por eso antes existían los TV de tubo y ahora están apunto de salir los TV LED 3D `:)`.

Y es porque a medida que se desarrolla una nueva tecnología, el humano descubre que se puede hacer algo mejor, y por tanto lo deja para la siguiente versión.

¿Y que pasa con nosotros los programadores/desarrolladores de aplicaciones?

Es mi opinión, por tanto no quiero que lo tomen como si fuera la última palabra.

Como comenté en un anterior post [Portales de Java](/2010/06/portales-en-java.html), cuando hacemos un proyecto, por más que decimos "sí se puede", vemos que es demasiado grande y terminamos tomándonos más tiempo, y lo que es peor, abandonar el proyecto... si no es que el proyecto pierda el foco y se hagan partes en hard-code sin opción a actualización posterior. Es mejor - pienso yo - usar una plataforma que ya existe y desarrollar sobre ella.

Voy a hacer un ejemplo un poco grosero: Si un cliente nos pide una solución, nosotros hacemos nuestro análisis de requerimientos, análisis de sus procesos, identificación de los puntos donde habría una aplicación, etc (y todos los etcs de RUP, Scrum o de la metodología que usemos). Y al momento de desarrollar, no creo que vayamos a comenzar por construir el computador donde va a ir nuestra aplicación, ni menos en crear un nuevo lenguaje de programación (solo si el cliente quiere que hagamos eso). Tampoco creo que vayamos a crear un sistema operativo, un motor de base de datos... ¿por qué? Porque *alguien ya lo hizo*. Solo debemos escoger cuál de esas tecnologías se ajustan a las necesidades de la solución al cliente. Debemos escoger si es Linux, Solaris, Windows, o si usamos Java, C#, C/C++, o SQL Server, MySQL, Oracle, etc...

Ahora, escalemos un poco más en este mismo pensamiento.

Si la solución para el cliente es una aplicación web ¿tendríamos que construir nuestro propio servidor web basado en Threads y Sockets? Creo que no (a menos que sea una tarea de un profesor o que el cliente sigue siendo exquisito). Utilizaríamos lo que sabemos usar y que se ajusta a la solución: GlassFish, Tomcat, Jetty, IIS, Apache... etc. Sigamos escalando.

Lo mismo para la conexión a la base de datos: usaremos un driver existente y ni pensemos en crear un protocolo nuevo... (sigamos escalando un poco más).. y para manejar la persistencia tenemos el SQL (el lenguaje, no el servidor), ya que la [Normalización de Base de datos](http://es.wikipedia.org/wiki/Normalizaci%C3%B3n_de_bases_de_datos) es la más efectiva para representar una realidad en tablas relacionales. Pero cuando tratamos de manejarlo desde objetos, tenemos algunos problemas ya que la herencia, y asociaciones bidireccionales no se puede representar físicamente en tablas. Nos aventuraríamos a crear nuestro propio "framework" para manejar clases entidades con su imagen representada en tablas relacionales. Pero.. psssst!... *alguien ya lo hizo*. Podemos usar Hibernate (o su versión en .Net  llamado Nibernate)... o usamos el reciente [JPA](http://en.wikipedia.org/wiki/Java_Persistence_API). Este API crea las tablas no existentes e incluso les pone sus foreign key, por lo que nos podríamos olvidarnos de la normalización de base de datos. (El DBA sólo se encargaría de asegurar que el servidor no se caiga, jeje )

Sigamos escalando...

Y si nuestra aplicación web necesita tener autenticación de usuarios, tendríamos que hacer todo este módulo de seguridad, que limite a ciertos usuarios de acuerdo al rol que tiene para que ingrese a ciertas partes de la aplicación... psst! *alguien ya lo hizo*. El [Tomcat tiene su propio sistema de autenticación](http://tomcat.apache.org/tomcat-6.0-doc/realm-howto.html) que está basado en un estándar ([http://tomcat.apache.org/tomcat-6.0-doc/realm-howto.html](http://tomcat.apache.org/tomcat-6.0-doc/realm-howto.html)). Puede manejar base de datos, de archivo, de LDAP, etc. [Java EE 6 también tiene todo una plataforma de Seguridad](http://download.oracle.com/docs/cd/E17410_01/javaee/6/tutorial/doc/gijrp.html) basada en ese estándar ([http://download.oracle.com/docs/cd/E17410_01/javaee/6/tutorial/doc/gijrp.html](http://download.oracle.com/docs/cd/E17410_01/javaee/6/tutorial/doc/gijrp.html))

También podemos pensar en los protocolos de comunicación entre aplicaciones heterogéneas, al inicio fue CORBA, luego DCOM (solo en MS) y RMI (solo en Java).. pero ahora es  [WebServices](http://es.wikipedia.org/wiki/Servicio_web).. ahora hay otro nuevo llamado [RESTful](http://es.wikipedia.org/wiki/Representational_State_Transfer)que hasta podemos manejarlo desde JavaScript.

Sigamos escalando...

Si la aplicación para el cliente es todo un portal, con wiki, con noticias, archivos, chat, que funcione como intranet, extranet, que comparta recursos, con web 2.0 etc etc etc.... creo que nos deberíamos de olvidar de llano hacer uno nuevo.. usemos Portlets!! Usemos un portal existente y programemos sobre él, ya sea PHP, ASP o Java. Esos portales existentes deben tener su propia API para poder programar componentes sobre él.

Si la aplicación para el cliente es una aplicación desktop, usemos un Platform!! y hagamos módulos sobre él. El Eclipse es uno de los primeros IDEs en los que se podían hacer componentes, y hasta hay otros IDEs basados sobre la Plataforma de Eclipse: IBM RAD, JBuilder, MyEclipse, Spring IDE, JBoss IDE, Oracle BPM, etc etc. [NetBeans Platform](http://netbeans.org/kb/docs/ide/platform-screencast.html?utm_source=netbeans&utm_campaign=welcomepage) también tiene lo suyo, aunque salió algo tarde, está también tomando terreno: el [iReport](http://jasperforge.org/projects/ireport)es un IDE hecho sobre NetBeans Platform, y hay muchas aplicaciones - que no necesariamente son IDEs - desarrollados sobre NetBeans Platforma. Aquí una pequeña lista: [http://goo.gl/PNB3](http://goo.gl/PNB3)

**Conclusión:**

- Si queremos ahorrar tiempo en el desarrollo de una solución, usemos una plataforma o framework.

- Si deseamos que nuestra aplicación tenga un valor agregado, usemos las características de una plataforma o un framework.

- Si deseamos estar dentro de un estándar, usemos una plataforma o un framework.

- No crees algo nuevo, busca si existe y úsalo. Es muy posible que alguien ya lo hizo antes que tú.
