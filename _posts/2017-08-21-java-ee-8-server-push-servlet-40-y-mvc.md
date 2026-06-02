---
layout: post
title: "Java EE 8 | Server Push (Servlet 4.0) y MVC"
date: 2017-08-21T19:15:00.001Z
last_modified_at: 2017-08-21T19:15:38.316Z
author: "Diego Silva Límaco"
permalink: /2017/08/java-ee-8-server-push-servlet-40-y-mvc.html
canonical_url: https://www.apuntesdejava.com/2017/08/java-ee-8-server-push-servlet-40-y-mvc.html
description: "En el anterior post habíamos visto un resumen de todas las nuevas características que tendrá Java EE 8. Aquí detallaremos un poco de Servlet 4.0 que consiste básicamente en la funcionalidad Server Push."
tags:
  - "servlets"
  - "server push"
  - "java ee 8"
---

[![](/assets/blogger/FJ81A7LFJNELA37.LARGE.jpg)](/assets/blogger/FJ81A7LFJNELA37.LARGE.jpg)

En el anterior post habíamos visto un resumen de todas las nuevas características que tendrá Java EE 8. Aquí detallaremos un poco de Servlet 4.0 que consiste básicamente en la funcionalidad Server Push.

## Servlet 4.0 Server Push

[HTTP/2](https://es.wikipedia.org/wiki/HTTP/2) viene con muchas características nuevas, y una de ellas es la que permite, con una sola petición, recibir todas las peticiones necesarias.

Por ejemplo, un HTML llama a varios .js y varias imágenes. Por cada tag que invoca a esos recursos (href o src) corresponda a una nueva petición que se hace desde el cliente al servidor web. Esto hace que el navegador trabaje más y que hayan más peticiones por cada página cargada. Se han intentando varias maneras de agilizar las peticiones por ejemplo usando caché, minimizando los .js o hasta hacer sprites de imágenes (una gran imagen se carga una vez y luego se usan pedazos para mostrar lo necesario).

Con HTTP/2 se puede hacer que: a una sola llamada al HTML, el servidor devuelva todas las peticiones necesarias.

Aquí tengo un ejemplo en ejecución. (Clic para ampliar la imagen)

[![](/assets/blogger/serverpush.png)](/assets/blogger/serverpush.png)

Es un HTML que invoca a una imagen y a un javascript. En el lado izquierdo es la manera tradicional: tres peticiones realizadas por el navegador.

A la derecha se ve la petición usando Server Push: una petición, pero los dos recursos son devueltos como "regalo".

Ojo: El Server Push funciona sobre HTTPS. Así que asegúrense de que esté funcionando el protocolo respectivo.

Para este ejemplo lo ejecuté sobre GlassFish 5.0, y utilicé su protocolo preconfigurado https (puerto 8181)

El código fuente para generar el Server Push es el que sigue:

<script src="https://bitbucket.org/apuntesdejava/javaee8-push-web/src/master/src/main/java/com/apuntesdejava/javaee8/push/ServerPushServlet.java?embed=t"></script>

El HTML es simple. Lo que hago en este servlet es redireccionar la petición al HTML necesario.

## MVC 1.0

Esta nueva característica ya fue hablada anteriormente. Consiste en separar en capas MVC una aplicación Web. Lo genial de esto es que no se necesitará conocer más tags o clases. Estará basado en la arquitectura JAX-RS. Esto también nos permitirá tener una misma clase endpoint de RESTful como controlador de MVC.

Más detalle de esto está en el post [Java EE 8 - MVC 1.0](/2016/01/java-ee-8-mvc-10.html) Allí hay ejemplos para ver con más detalle

## Código fuente

El código fuente de esta ejemplo se encuentra aquí para que lo disfruten, bajo repositorio Git:

- [https://bitbucket.org/apuntesdejava/javaee8-push-web](https://bitbucket.org/apuntesdejava/javaee8-push-web)

## Bibliografía adicional

Considero que debemos revisar material adicional que nos ayude a entender más de todo esto:

- Introducción a HTTP/2 [https://developers.google.com/web/fundamentals/performance/http2/](https://developers.google.com/web/fundamentals/performance/http2/)

- HTTP/2 [https://es.wikipedia.org/wiki/HTTP/2](https://es.wikipedia.org/wiki/HTTP/2)

Este post está basado en las publicaciones de [Elder Moraes](http://eldermoraes.com/).
