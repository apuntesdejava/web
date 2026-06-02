---
layout: post
title: "Portales en Java"
date: 2010-06-15T16:03:00.002Z
last_modified_at: 2010-06-16T15:00:48.135Z
author: "Diego Silva"
permalink: /2010/06/portales-en-java.html
canonical_url: https://www.apuntesdejava.com/2010/06/portales-en-java.html
tags:
  - "netbeans 6.8"
  - "java"
  - "web"
  - "netbeans"
  - "portlets"
  - "opinion"
  - "off topic"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5FK1UbER5f9_EXmFouZeDtblLXaMXh3gKsnCtc1Ljw-uQG2iLRMcBMScXywFU8ZAxvggNdVFlPHlkUQxmBDQ-udsXqB2XDwZrb-R4mQBZrtIXKFfVHATfeRYq9pXXYVWjNaYwR88o2mT6/s200/cms_templates.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5FK1UbER5f9_EXmFouZeDtblLXaMXh3gKsnCtc1Ljw-uQG2iLRMcBMScXywFU8ZAxvggNdVFlPHlkUQxmBDQ-udsXqB2XDwZrb-R4mQBZrtIXKFfVHATfeRYq9pXXYVWjNaYwR88o2mT6/s1600/cms_templates.png)

Una aplicación web es relativamente fácil de hacer... pero si nuestro cliente quiere que le hagamos un portal para que sea Intranet, Extranet, administración de contenidos, gestor de archivos, foros, chat, wiki y 50 etc. más, podemos decir "sí se puede", y a medida que avanza el proyecto pensamos que se podría vender a otro cliente, tratamos de hacer lo más estándar posible.... y nunca terminamos.

Estos sistemas web que permiten administrar contenidos se llaman [Sistemas de Gestión de Contenidos](http://es.wikipedia.org/wiki/Sistema_de_gesti%C3%B3n_de_contenidos) (En inglés Content Management System - CMS) Estos ya tienen todo, o al menos todo el soporte necesario para gestionar contenidos web. Es una plataforma, y nosotros deberíamos unicamente anexarle las partes que faltan y lo que nuestro cliente necesita.

Los más conocidos en PHP son [Joomla](http://www.joomla.org/), [PHPNuke](http://www.phpnuke.org/), [Drupal](http://drupal.org/).  Estos se encuentran en los hosting que se alquila por US$20 al año. Son simples, y funcionan para todos tipos de usuarios.

Pero ¿y Java?

No pretendo menospreciar a PHP: es rápido, fácil de programar, y todas las cualidades de PHP.

Pero quizás nuestro cliente quiere algo que sea fuera de lo común, que sea seguro y que inspire confianza, además que PHP todos los tienen y nuestro cliente es algo exquisito.

En Java se hizo (hace mucho tiempo) CMS parecidos al PHPNuke, pero más parecían PHP convertidos a JSP. Otros (como Apache) trataron de hacer algo más ordenado (JetSpeed fue el primero). Esto tendía a que hayan varios "estándares" de CMS, como cuando salieron al inicio los JSP+Servlet sin un esquema ordenado de MVC.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLLdgO-MbXF0OBEEDxu1KW2GBOnAGjQTs8-B8dFiPFp58fyeHVkY1D2RlEd0mD8XYv-s90cXlbmwrVZMA_-mjQ1LI1g0MnJAG1L-Mh73QGD9oz-L6DT6GpdzgDGnUqTR5EzSRd3bI7IESS/s200/portlet0.gif)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLLdgO-MbXF0OBEEDxu1KW2GBOnAGjQTs8-B8dFiPFp58fyeHVkY1D2RlEd0mD8XYv-s90cXlbmwrVZMA_-mjQ1LI1g0MnJAG1L-Mh73QGD9oz-L6DT6GpdzgDGnUqTR5EzSRd3bI7IESS/s1600/portlet0.gif)Así que se solicitó al [JCP](http://jcp.org/)un estándar de contenidos web incrustados, al que llamaron [JSR 167 - Java Porlet](http://jcp.org/en/jsr/detail?id=167). Un portal es un gran espacio donde se incrustan elementos pequeños de diferentes lugares, así como el [http://my.yahoo.com](http://my.yahoo.com/) o [www.google.com/ig](http://www.google.com/ig). Pues bien, cada elemento pequeño se denominó Portlet (Portal pequeño). Ese es el estándar, y deberían existir Servidores de Portlet. Estos Servidores serían la plataforma web, y nosotros deberíamos unicamente crear nuestro portlet que correría sobre él.

Actualmente existe la versión [2.0 de Java Portlet - JSR 286](http://jcp.org/en/jsr/detail?id=286).

Y ¿habría que conseguir otro servidor web que no sea Tomcat, WebLogic, GlassFish o Jetty, para implementar nuestros portlets?

Afortunadamente, no.

Cualquier servidor Java web se configura para que sea un Contenedor de Portlets, el gestor de contenidos es un módulo web (war) que se instala en el Servidor Java Web, y los portlets son otros módulos web (war) con algunos cambios y archivos de despliegue adicionales que se instalan sobre el Servidor java Web, y listo... el portlet ya es visible desde el gestor de contenidos.

Algunos de estos contenedores de portlets son los siguientes (sin un orden en especial):

- Jakarta Pluto

- Gridsphere

- OpenPortal

- Jamecs

- Jetspeed

- Liferay

(más de estos en [http://java-source.net/open-source/portals](http://java-source.net/open-source/portals))

Personalmente me gusta [Liferay](http://www.liferay.com/). He probado varios y este es el que más se ajusta a las necesidades de donde trabajo.  Tiene la versión comercial y la versión comunidad. Esta última se puede descargar empaquetada en diferentes servidores: en Tomcat, GlassFish (v2 y v3), Jetty, Resin, JOnAS (con Tomcat o Jetty), Geronimo + Tomcat y JBoss + Tomcat. Y si ya tenemos en producción un servidor web como Tomcat, Jetty, Resin o GlassFish, también se puede descargar el .war, previa configuración del servidor web, se instala el .war y listo... nuestro servidor web se convierte en un Portlet Container sin perder las configuraciones previas. Sus manuales están bien explicados.

Existe un plugin para NetBeans llamado [Portal Pack](http://contrib.netbeans.org/portalpack/) que permite desarrollar Portlets. Este plugin funciona en NetBeans 6.8, y espero que lo adapten para NetBeans 6.9.

Así que, en vez de preocuparnos de la administración de contenidos, permisos, acceso, etc en un portal, mejor desarrollamos un portlet, lo instalamos en el Contenedor de Porlets, y listo... no más preocupaciones.

Mas adelante (ya son varios artículos pendientes) haré un post que explique cómo hacer un portlet. Pero puedes revisar los artículos publicados aquí: [http://contrib.netbeans.org/portalpack/docs.html](http://contrib.netbeans.org/portalpack/docs.html)

**Actualización: El PortalPack sí es compatible con la versión 6.9 de NetBeans IDE.** Los .nbm que están incluidos en el PortalPack son compatibles con la versión 6.9 excepto los relacionados a WebSinergy, CMS y SAW.
