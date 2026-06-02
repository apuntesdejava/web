---
layout: post
title: "RESTful Tomcat + Jersey: org.glassfish.jersey.message.internal.WriterInterceptorExecutor$TerminalWriterInterceptor.aroundWriteTo MessageBodyWriter not found for media type=application/json, type=class"
date: 2016-02-26T22:22:00.001Z
last_modified_at: 2016-02-26T22:22:53.779Z
author: "Diego Silva Límaco"
permalink: /2016/02/restful-tomcat-jersey.html
canonical_url: https://www.apuntesdejava.com/2016/02/restful-tomcat-jersey.html
description: "Si estás tratando de programar RESTful con Jersey sobre Tomcat  y justo cuando quieres probar que devuelva un objeto simple que has creado, lanza el siguiente error:"
tags:
  - "restful"
  - "error"
  - "tomcat"
  - "jersey"
  - "tips"
---

[![](https://docs.google.com/drawings/d/18zUbSRqEg6V8G8JbGmdtJxpNlbPwhMaTGePsqfOsNk0/pub?w=488&h=315)](https://docs.google.com/drawings/d/18zUbSRqEg6V8G8JbGmdtJxpNlbPwhMaTGePsqfOsNk0/pub?w=488&h=315)

Si estás tratando de programar RESTful con Jersey sobre Tomcat (porque el Tomcat es más fácil de desplegar y más ligero, Jersey es el más recomendado por Oracle, y RESTful luce bien) y justo cuando quieres probar que devuelva un objeto simple que has creado, lanza el siguiente error:

26-Feb-2016 16:54:00.889 SEVERE [http-nio-18080-exec-2] org.glassfish.jersey.message.internal.WriterInterceptorExecutor$TerminalWriterInterceptor.aroundWriteTo MessageBodyWriter not found for media type=application/json, type=class...

Optas por alguna de estas opciones:

- Dejas Tomcat porque sabes que, como no es un JavaEE Container, migras a JBoss, Wildfly o lo que sea.. pero Tomcat no lo vuelves a usar porque solo es para web.

- Ya no usas Jersey, y cuando migras usas algo como SimpleREST de JBoss

- O usas Spring y te llenas de documentación solo para montar un RESTful simple.

Por lo que finalmente dejas de lado tu primera motivación: Tomcat + Jersey.

Ahora bien, vamos a revisar qué ocurre.

Lo que sucede es que, si bien el Jersey crea un servicio bien implementado, falta decirle que tus objetos necesitan convertirse en un formato json (en este caso). Así que, si declarado en el archivo `pom.xml` lo siguiente:

```java
<dependency>
            <groupId>org.glassfish.jersey.containers</groupId>
            <artifactId>jersey-container-servlet</artifactId>
            <version>2.22.1</version>
        </dependency>
```

Deberías considerar agregar la siguiente dependencia

```java
<dependency>
            <groupId>org.glassfish.jersey.media</groupId>
            <artifactId>jersey-media-json-jackson</artifactId>
            <version>2.22.1</version>
        </dependency>
```

Es la dependencia faltante para que pueda convertir cualquier objeto que creemos en formato JSON.

Espero que te sea de utilidad.
