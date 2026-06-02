---
layout: post
title: "JSON WebService Liferay  6.1 (GA2) (Queja)"
date: 2013-03-27T18:10:00.003Z
last_modified_at: 2013-03-27T18:10:44.916Z
author: "Diego Silva Límaco"
permalink: /2013/03/json-webservice-liferay-61-ga2-queja.html
canonical_url: https://www.apuntesdejava.com/2013/03/json-webservice-liferay-61-ga2-queja.html
tags:
  - "glassfish"
  - "webservices"
  - "liferay"
  - "tomcat"
  - "json"
  - "opinion"
---

Este es un post pequeño, y quizás un poco fastidiado por algo que encontré en esta nueva versión de Liferay 6.1 GA2 (es decir, la 6.1.1)

Para crear un JSON WebService, basta con crear un Service en el Portlet y ya está publicado. (Leer aquí [http://www.liferay.com/community/wiki/-/wiki/Main/JSON+Web+Services](http://www.liferay.com/community/wiki/-/wiki/Main/JSON+Web+Services))

Si usamos Tomcat, no existe ningún problema. Es más, podemos ver el API WebService en una web para hacer las pruebas desde la misma web. Por ejemplo: si creamos un portlet llamado "Test-portlet" y creamos un servicio llamado "Calc", podemos entrar a http://localhost:8080/Test-portlet/api/jsonws y vemos todo el API.

Pero... si usamos el GlassFish, no aparecerá la página. Según la gente de LR, cada contenedor tiene manera diferente de reconocer su contexto. Me consta: depuré el código fuente, y desde GlassFish devuelve el contexto "null" mientras que con tomcat devuelve el contexto (o sea, Test-portlet) Y la salida que me dan es llamar a un URL con un formato especial para poder usar el servicio.

Es decir, así

http://localhost:8080/api/secure/jsonws/Test-portlet.calc/sumar/a/3/b/4

Ver: [http://issues.liferay.com/browse/LPS-33791](http://issues.liferay.com/browse/LPS-33791)

En fin, es opensource, así que quiero darme un tiempo para corregir este problema. Porque si uno necesita implementar liferay en un contenedor que no sea Tomcat - por politicas de la empresa - entonces, tendremos serios problemas.
