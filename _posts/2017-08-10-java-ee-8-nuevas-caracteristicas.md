---
layout: post
title: "Java EE 8 - Nuevas características"
date: 2017-08-10T19:01:00.002Z
last_modified_at: 2017-08-10T19:01:27.780Z
author: "Diego Silva Límaco"
permalink: /2017/08/java-ee-8-nuevas-caracteristicas.html
canonical_url: https://www.apuntesdejava.com/2017/08/java-ee-8-nuevas-caracteristicas.html
description: "Sigamos explorando lo nuevo que viene en el Java EE 8. En este post veremos las características que esta nueva actualización."
tags:
  - "java ee"
  - "java ee 8"
---

Sigamos explorando lo nuevo que viene en el Java EE 8. En este post veremos las características que esta nueva actualización.

Y como una imagen vale más que mil palabras, aquí una imagen... luego vienen las palabras.

[![](/assets/blogger/javaee8-features.png)](/assets/blogger/javaee8-features.png)

Esta imagen fue presentada por *David Delabassée * ([@delabassee](https://twitter.com/delabassee)) el año pasado en el JavaOne y resalta los cambios y adiciones para Java EE 8.

Ahora veamos un poco más en detalle.

## Bean Validation 2.0

Esta es una especificación de java el cual nos permita expresar restricciones en los objetos usando anotaciones, además de crear nuestras propias restricciones. También proporciona las APIs para validar objetos así como su representación, y también valida los parámetros recibidos y los valores devueltos de los métodos y los constructores.

## CDI 2.0

Inyección de Contexto y Dependencia (Contexts and Dependency Injection) para  Java EE define un potente conjunto de servicios complementarios que nos ayudarán a mejorar la estructura del código de una aplicación.

## JAX-RS 2.1

Eventos enviados por Servidor (del inglés [Server-Sent Events (SSE)](https://www.w3schools.com/html/html5_serversentevents.asp)) es una tecnología nueva definida como parte de HTML 5 que establece recomendaciones para que un cliente obtenga actualizaciones desde el servidor HTTP de manera automática.

Es comúnmente empleado para transmisiones de data streaming de un sentido, en el que el servidor actualiza su información y le notifica al cliente periódicamente, o cada vez que sucede un evento.

JAX-RS 2.0 presenta APIS  de procesamiento asíncrono tanto para cliente como para servidor.

## JSF 2.3

La tecnología JSF simplica la construcciones de interfaces para aplicaciones JavaServer. Los desarrolladores pueden construir rápidamente aplicaciones web para: ensamblar componentes UI reutilizables en una página, conectar estos componentes a una fuente de datos y conectar eventos en el cliente a los eventos del servidor. Ahora tenemos una característica llamada invocación Ajax que permite invocar métodos de un Managed Bean (CDI) directamente desde Ajax, permitiendo responder usando el estándar JSON.  Esta versión también permite validaciones en varios campos, @Inject FacesContext, rendimiento optimizado en EL, y aclaraciones Ajax cruzadas. Además, es compatible como MVC 1.0.

## JSON-P 1.1

Esta versión ofrece   JSON Patch, JSON Merge y JSON Pointer. También usa los streams y lambdas de Java SE 8.

## Servlet 4.0

Una de las características más esperadas para Java EE8 es HTTP/2.0 y Server Push, el cual  trae un aumento de rendimiento para las aplicaciones JSF. Solo basta con migrar a un servidor que sea compatible con Java EE 8.

## JSON-B 1.0

Es una capa de unión estándar para convertir objetos Java hacia y desde mensajes JSON. Define un algoritmo de mapeo por omisión para convertir clases Java existentes a JSON, y también permite al desarrolladores personalizar el proceso de mapeo a traves de anotaciones Java. Esto ya lo vimos en un post anterior: [Un vistazo a JSON-B de Java EE8](/2017/04/un-vistazo-json-b-de-java-ee8.html)

## Security API

Este API es muy usado en el moderno paradigma de aplicaciones en la nube/PaaS. Promueve portabilidad en aplicaciones autocontenidas para todos los servidores Java EE, y promueve el uso de modernos conceptos de programación tales como lenguajes de expresión, e inyección de depedencia y contexto.

## Fuente

Tomado de las publicaciones de  Elder Moraes (@elderjava)
