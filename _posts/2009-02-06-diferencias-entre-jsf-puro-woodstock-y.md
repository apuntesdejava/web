---
layout: post
title: "Diferencias entre JSF puro, Woodstock y ICEfaces en NetBeans"
date: 2009-02-06T19:31:00Z
last_modified_at: 2009-04-25T21:55:03.177Z
author: "Diego Silva"
permalink: /2009/02/diferencias-entre-jsf-puro-woodstock-y.html
canonical_url: https://www.apuntesdejava.com/2009/02/diferencias-entre-jsf-puro-woodstock-y.html
tags:
  - "netbeans"
  - "jsf"
  - "web"
  - "netbeans 6.5"
  - "opinion"
---

Soy sincero
para mi el mejor framework para web que conocí y trabajé era Struts 1, y no me quería pasar a JSF porque lo veía igual que Struts.

NetBeans sacó su Visual Web que es un editor visual pero con JSF. Los componentes adicionales son del framework Woodstock. Aún así, no me atraía, porque no tenía el mismo control que lo tenia en Struts.

Pero con la moda y ventajas de AJAX, mi pobre Struts me estaba dando algunos problemas, por lo que tuve que poner DWR, Dojo, y demás bibliotecas que hacían más pesada mi aplicación.

Hace poco NetBeans anunció el cambio de Woodstock a ICEfaces. Así que, me aventuré a usarlo.

La verdad lo veo mucho más sencillo, más ligero, y más completo.

Con JSF, las aplicaciones son tan clásicas como los request/response en servlets y jsp, solo que le da un toque especial. El desarrollo de la aplicación web parece ser de una de escritorio, ya que se pueden  acceder a los controles como si fueran variables. Una diferencia bastante notable comparada a Struts. En Struts todo está basado en request, session, variables de sesión y demás dolores de cabeza.

Woodstock es lo mismo que JSF puro, pero el diseño es más visual. Pero es lo mismo que el JSF.

ICEfaces cambia el panorama: Se programa como JSF, con ese toque de manejo de variables sobre controles como en una aplicación JSF, pero la visualización, la presentación de los resultados es con AJAX. Me he quedado realmente sorprendido.

Para ver mejor esto, he creado tres proyectos que hace el cálculo de fibonnaci:

- Usando [JSF puro](http://diesil-java.googlecode.com/files/FibonacciJSF.tar.gz).
- Usando [woodstock](http://diesil-java.googlecode.com/files/FibonacciWoodstock.tar.gz).
- Usando [ICEfaces](http://diesil-java.googlecode.com/files/FibonacciICEfaces.tar.gz).
En JSF puro, diseño la aplicación todo a mano. Al ejecutarse, me da el resultado, y si presiono F5 para volver hacer "submit", el navegador siempre me pregunta que si quiero volver a enviar los datos.

Con Woodstock, el diseño es más fácil, más visual (justamente), pero cuando presiono F5, el navegador me pregunta que si deseo volver a enviar los datos. Esto realmente puede ser una confusión para un usuario final, ¿no?

Pero con ICEfaces, el diseño es visual y rápido como en Woodstock, pero al ejecutarlo y presionar F5 para volver a calcular el resultado, no me pide que si deseo volver a enviar los datos ¿por qué? porque es AJAX.

Ahora ¿qué framework usarías para tu proyecto?
