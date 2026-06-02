---
layout: post
title: "Resumen: Conferencia Buenas Prácticas en Desarrollo de Software No more mocks!!! Move on to Real Testing on JEE"
date: 2013-11-07T22:50:00.001Z
last_modified_at: 2013-11-07T22:50:04.105Z
author: "Diego Silva Límaco"
permalink: /2013/11/resumen-conferencia-buenas-practicas-en.html
canonical_url: https://www.apuntesdejava.com/2013/11/resumen-conferencia-buenas-practicas-en.html
---

[![](/assets/blogger/arquillian-icon-s.png)](/assets/blogger/arquillian-icon-s.png)

El día de ayer (06/11/2013) se realizó en el "Hotel Sonesta El Olivar" de San Isidro (Lima - Perú) una charla sobre las [buenas prácticas en desarrollo de aplicaciones JavaEE](http://comunicaciones.cibertec.edu.pe/dat/buenas-practicas-en-desarrollo-de-software/move-on-to-real-testing-on-JEE/informes/?utm_source=195_descubre-la&utm_medium=email&utm_campaign=mailerball) a cargo del **Ing Carlos Echevarría**. El tema principal fue la implementación de pruebas reales de una aplicación en lugar de hacer pruebas unitarias autónomas y evitando el uso de MockObjetos 'inanimados'.

Carlos desarrolló un ejemplo de una aplicación RESTful y realizó las pruebas de todas las funcionalidades al mismo tiempo, en un escenario posible, y no en pruebas independientes.

Me explico mejor: Él realizó los servicios de una calculadora que suma, resta, multiplica y divide (¿por qué siempre hacemos ese tipo de ejemplos? No tengo idea `:)` )

Un test unitario común sería:

- Probar el operador "suma" con el valor "2" y "3" y el resultado debe ser "5"

- Probar el operador "resta" con el valor "3" y "2" y el resultado debe ser "1"

- Probar el operador "multiplicación" con el valor "2" y "3" y el resultado debe ser "6"

- Probar el operador "división" con el valor "6" y "3" y el resultado debe ser "2"

Todos estamos de acuerdo que esto es lo normal. Pero en la vida real, no se hacen operaciones independientes, sino que puede haber una resta después de una multiplicación, y seguido de otra resta o de otra multiplicación, etc, en cualquier orden y con cualquier operación. Las Pruebas Reales consiste justamente en este tipo de pruebas.

Para ello utilizó una clase intermedia que contendría el valor de la última operación, y sobre ella se hacen las operaciones. Entonces, las pruebas se realizarían de la siguiente manera

- Sumo "3", el valor actual debería ser "3"

- Resto "2", el valor actual debería ser "1"

- Multiplico "10", el valor actual debería "10"

- Divido "5", el valor actual debería ser "2"

- Multiplico "20", el valor actual debería ser "40"

- ...

El enfoque es real y práctico, ya que cada servicio de la aplicación (que son las operaciones) funcionan dentro de un ambiente posible de operaciones (que es la clase intermedia).

La exposición lo hizo usando:

- NetBeans 7.4

- JBoss AS 7

- Maven

- Arquillian (este es el que crea el escenario de la aplicación)

Carlos explicó que podría usarse con cualquier otro contenedor Java EE, por ejemplo GlassFish, Tomcat + Geronimo, etc (aunque lo que mencionó de WebLogic no era muy alentador para los seguidores de ese producto de Oracle, je).

También prometió que subiría el código de su ejemplo.. y no lo hizo! :) Bueno, seguiré esperando su código aquí:

[https://github.com/egcarlos?tab=repositories](https://github.com/egcarlos?tab=repositories)

Seguiremos revisando un poco más de esta nueva tendencia de Pruebas.
