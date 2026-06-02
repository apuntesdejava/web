---
layout: post
title: "Convirtiendo Aplicaciones Java EE monolíticos a Microservicios"
date: 2015-09-14T17:28:00.001Z
last_modified_at: 2018-01-10T23:42:42.647Z
author: "Diego Silva Límaco"
permalink: /2015/09/convirtiendo-aplicaciones-java-ee.html
canonical_url: https://www.apuntesdejava.com/2015/09/convirtiendo-aplicaciones-java-ee.html
tags:
  - "microservicios"
  - "java ee"
---

[![Convirtiendo Aplicaciones Java EE monolíticos a Microservicios]({{ '/assets/blogger/micro-service-architecture.png' | relative_url }})]({{ '/assets/blogger/micro-service-architecture.png' | relative_url }})

(Traducción libre de [Monolithic to Microservices Refactoring for Java EE Applications](https://dzone.com/articles/monolithic-to-microservices-refactoring-for-java-e?oid=top_cta) de  [+Arun Gupta](https://plus.google.com/101195212405190467512) )

¿Te has preguntado qué se necesita para convertir una aplicación Java EE monolítica a uno basado en microservicios?

Este post explica cómo hacerlo usando un ejemplo trivial de carrito de compras, y cuáles son algunas de las preocupaciones el hacer utilizar microservicios.

## Java EE Monolítico

Una aplicación Java EE monolítica se define normalmente en una archivo .war o .ear. Toda la funcionalidad de la aplicación se concentra y empaqueta en una sola unidad. Por ejemplo, un carrito de compras en línea puede tener funciones de usuarios, catálogos de productos y las órdenes de compra. Todas las páginas web están la raíz de la aplicación, todas las clases Java se encuentran dentro de `WEB-INF/classes` y los recursos dentro de `/META-INF`

Asumamos que  su aplicación monolítica no está diseñada como una gran bola de barro distribuida (esto es,  distribuir la misma aplicación en pedazos y alegar que con solo eso ya es un SOA sin el mejor criterio de reutilización) y está construida siguiendo al mejor arquitectura de software. Algunas de las reglas en común son:

- Separación de los aspectos de funcionalidad, por ejemplo utilizando MVC.

- Alta cohesión y bajo acoplamiento utilizando APIs bien definidas.

- No repetirse así mismo (DRY - Don't Repeat Yourself)

- API de Interfaces e implementaciones por separados y aplicando la [Ley de Deméter](https://es.wikipedia.org/wiki/Ley_de_Demeter), Las clases no llaman a otras clases directamente, ya que se encuentran en el mismo archivo.

- El uso de [Diseño Guiado por Dominio](https://es.wikipedia.org/wiki/Dise%C3%B1o_guiado_por_el_dominio) para mantener objetos relacionados entre dominio y componente.

- [YAGNI](https://es.wikipedia.org/wiki/YAGNI) o: No **hacer **algo que no se necesita ahora.

Aquí una aplicación WAR típica monolítica:

[![]({{ '/assets/blogger/javaee-monolithic.png' | relative_url }})]({{ '/assets/blogger/javaee-monolithic.png' | relative_url }})

Esta aplicación monolítica tiene:

- Páginas web, como archivos .xhtml para los componentes de Usuario, Catálogo y Órdenes, empaquetados en la raíz del archivo.

- Las clases para los tres componentes están en paquetes diferentes dentro del directorio `/WEB/classes`. Si hay clases de uso común, irán en otro paquete común que se puede acceder desde la raiz. Por ejemplo, `com.apuntesdejava.util`.

- Los archivos de configuración de cada componente se encuentran en /META-INF y /WEB-INF. Además de cualquier archivo de configuración adicional como persistence.xml, spring.xml etc. Todo eso están en un solo archivo .war.

Las ventajas son conocidas: Se tiene en un IDE amigable, fácil de compartir, pruebas simples de hacer, fácil despliegue y otras tantas como imagines.

Pero también existen desventajas: No se puede hacer entrega contínua por partes, por lo que afecta el desarrollo ágil (a veces llega a que solo uno puede desarrollar la aplicación web a la vez, no dos o más), todos los componentes deben utilizar la misma tecnología, y otras más.

Aunque los microservicios están de moda estos días, no significa que los monolíticos sean malos. Incluso hay aplicaciones que no tiene mucho beneficio inmediato el convertirlos a microservicios.

Implementar los microservicios no es algo inmediato, ni menos algo tan costoso como para tener una significativa inversión para lograr la implementación.

## Arquitectura Microservicio para Java EE

Bien, ya hemos visto todo, pero me gustaría ver cómo convertir un código monolítico a microservicios.

En primer lugar, echemos un vistazo a la estructura general.

[![]({{ '/assets/blogger/javaee-microservices.png' | relative_url }})]({{ '/assets/blogger/javaee-microservices.png' | relative_url }})

Aquí las piezas claves son:

- La aplicación debe estar descompuesto **funcionalmente**, donde los componentes Usuario, Orden y Catálogo se **empaquetan en .WAR separadas**. Cada archivo debe tener sus propias páginas web, clases y arvhivos de configuración relevantes.

- Java EE es utilizado para implementar cada componente. Cada componente con API bien definido ayudará a que se comuniquen bien entre sí.

- Las clases de cada componente pertenece al mismo dominio, y el código es más fácil de escribir y mantener

- Cada .war tiene su propia base de datos, es decir, lo cual no estará amarrado únicamente a una base de datos y que se necesite alternar entre una u otra. Además, se puede tener que un componente use MySQL o algún relacional, otro XMLy el tercero con NoSQL. Eso lo maneja cada componente.

- Cada componente deberá registrarse en un Service Registry. Eso se necesita porque varias instancias sin estado de cada servicio pueden estar en ejecución en un momento dado y debe conocerse su estado actual en el tiempo de ejecución. Algunos de estos Service Registry pueden ser Netflix Eureka, ETCD, Zookeeper.

- Si los componentes tienen que hablar entre sí, lo cuál es común, lo harían utilizando el API definido. Invocaciones REST o Pub/Sub son lo más comunes utilizados. En nuestro caso el componente Órdenes descubre los servicios Usuario y Catálogo y conversa con ellos usando el API REST.

- La interacción con el cliente se define en otra aplicación. Para nuestro ejemplo será Compras IU. Esta aplicación descubre los servicios desde el Service Registry y los reúne para trabajar con todos los componentes a la vez. Principalmente debe ser un proxy mudo, que solo le pase las peticiones a las páginas web de cada componente. Y aplicando CDN (propio o externo) se puede hacer que las páginas web compartan un mismo CSS y Javascript.

Aunque es una aplicación bastante trivial, al menos podemos identificar las diferencias de arquitectura básica

## Monolítico y Microservicios

Aquí algunas estadísticas para las aplicaciones monolíticos y basadas en microservicios:

![](https://i.imgur.com/a78b6yr.png)

El código ejemplo para una aplicación monolítica se encuentra aquí en el github del autor de este post: [https://github.com/arun-gupta/microservices/tree/master/monolith/everest](https://github.com/arun-gupta/microservices/tree/master/monolith/everest)

Y el ejemplo de una aplicación basada en microservicios está aquí: [https://github.com/arun-gupta/microservices/tree/master/microservice](https://github.com/arun-gupta/microservices/tree/master/microservice)

## Problemas y pendientes

Aquí hay algunos problemas encontrados y tareas pendientes para implementar completamente una aplicación basada en microservicios a partir de una monolítica.

- Java EE  ya permite la descomposición funcional de una aplicación utilizando archivos .EAR. Cada componente de una aplicación ser empaquetado como un archivo WAR y se incluye dentro de un archivo EAR. Incluso pueden compartir recursos entre ellos dentro del mismo EAR. Claro, no es una buena manera del estilo microservicios, ya que aún está dentro de un mismo archivo EAR.

- La IU aún está dentro de una aplicación única. Lo ideal sería tener un WAR descompuesto.... como portlets.

- Cada microservicio debe ser capaz de implementarse con solo invocar a un .jar

- Se tiene que crear tantas persistence.xml por cada componente, así como los comandos DDL y DML.

## Códigos de ejemplo

El ejemplo completo de microservicios se puede encontrar aquí [http://github.com/arun-gupta/microservices](http://github.com/arun-gupta/microservices)
