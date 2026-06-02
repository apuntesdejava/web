---
layout: post
title: "Opinión: La alternativa de Java EE"
date: 2017-09-15T18:07:00Z
last_modified_at: 2017-09-15T18:11:59.244Z
author: "Diego Silva Límaco"
permalink: /2017/09/opinion-la-alternativa-de-java-ee.html
canonical_url: https://www.apuntesdejava.com/2017/09/opinion-la-alternativa-de-java-ee.html
description: "Una opinión personal sobre Java EE."
tags:
  - "java ee"
  - "oracle"
  - "opinion"
  - "eclipse"
---

Si vamos a usar un servidor Java EE (perfil completo) para implementar una solución, recomiendo utilizar todas las funcionalidades que vienen en la especificación: EJB, JPA, JMS, etc. Pero hay veces que no podemos contar con un servidor de ese tipo ya que, por ejemplo, el cliente no conoce más allá del Tomcat, o no exista gente que podría administrar un servidor como GlassFish, Payara, Weblogic, etc.

![](https://docs.google.com/drawings/d/e/2PACX-1vSEYCwYftJ3Kly-6_Q-Gncn2yk9NObG-TOrSr6HQNkFTGdKO9PX7DOEt9i_hUohAB3Oy0t29wjk23u-/pub?w=884&h=439)

Entonces, llegamos a extrañar las funcionalidades dadas por Java EE, y optamos por otros frameworks que sí nos ayudan en nuestros momentos de limitaciones de servidor.

Spring ayudó mucho desde un inicio cuando no se contaba con servidores Java EE OpenSource completos. Caló tan fuerte entre los desarrolladores, que practicamente se ha hecho un "estándar" alterno a Java EE. Cuando los arquitectos de Java EE "despertó" y mejoró las especificaciones en la versión 5, pienso yo, ya era muy tarde. Tomcat siguió siendo el servidor "estándar" para aplicaciones "Java EE", con Spring (y de paso Hibernate) ya que el Tomcat no podía ejecutar EJB. Nadie extrañó (ni se enteró) de JPA 1.0, EJB 3.0, JSF 2.0 (que el ambiente MVC fue tomado por Apache con su framework Struts)

Ahora, esta nueva generación que aprende a programar en Java web, lo hace fuera del estándar oficial, solo usando el "estándar" Spring.

Aún así, agradecemos a los ingenieros de Spring por dar alternativas a desarrollar aplicaciones Java.

Esta semana Oracle decidió liberar a Java EE y entregárselo a Eclipse Foundation ([Opening Up Java EE - An Update](https://blogs.oracle.com/theaquarium/opening-up-ee-update)) y esto permitirá sacar de sus goznes a la versión 8 que tantos estamos esperando.

¿qué opino? No soy partidiario de Spring ni de Eclipse, pero - por el bien de los desarrolladores de Java - es mejor esto que seguir estancados con Oracle después que compró Sun Microsystems.

Java es un lenguaje y plataforma que tiene más de 20 años en el mercado... y con estas liberaciones (ah! NetBeans ya está en el Github bajo Apache Foundation) creo que seguiremos teniendo a Java para rato.

Finalmente, mi pregunta es: ¿Oracle aún emitirá certificaciones para Java EE?
