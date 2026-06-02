---
layout: post
title: "Vergüenza de programador"
date: 2006-10-01T05:19:00Z
last_modified_at: 2009-04-25T21:55:03.927Z
author: "Diego Silva"
permalink: /2006/10/verguenza-de-programador.html
canonical_url: https://www.apuntesdejava.com/2006/10/verguenza-de-programador.html
tags:
  - "bug"
---

Para el escale utilicé al principio Hibernate, pero me fue pesado aprender HQL, y los reportes que emitia se cortaban. Así que pasé a iBatis  Mapper y me fue más fácil, flexible y rápido.. incluso usé iBatis DAO por su idependencia de implementación DAO.

Pero desde que lo puse, no recuerdo qué mes, el procesador se satura con el java... llegaba a ocupar casi el 100% del procesador... y mandaba error de Java Heap Memory (no indicaba la línea)

Continuamente reiniciaba el tomcat, modifiqué el pool de conexiones, aligeré código de consultas... y nada. Incluso puse en un cron para que se reinicié el tomcat cada 2 horas..... y nada.

Encontré  en la web que el kernel de linux que usaba (2.4) provocaba ese error con java.. así que cambié a CentOS 4.4

Y nada.

Prácticament al día tenía que reiniciarlo manualmente 6 veces.

Supuse que el diseño de la página estaba mal, xq hacia llamadas recursivas para mostrar el menú de opciones.. así que con mi compañero nos pusimos a pasar todas las páginas a tiles. Cambié la biblioteca de ajax (usaba ajaxtaga y lo modifiqué para usar DWR), y cuando estaba haciendo las pruebas (demasiadas) con DWR.. volvió el mismo problema.

"Afortunadamente" tenía el log al detalle,  y el error ocurría cuando hacía una consulta... y antes de hacer una consulta le pedía la conexión al iBatis DAO... y cada vez que hacía esta llamada, volvía abrir el archivo dao.xm y procesaba el stream para obtener el daoManager... siempre.

Así que cambié esa línea: colocar el daoManager como static y que se cargué sus valores en el static{} de la clase. Es decir, solo una vez.

Ya van más de 24 horas contínuas y no ha vuelto a dispararse el procesador.

Así que creo que tendrá para muchas horas más... y días.

Solo fue una línea mal programada que dió un dolor de cabeza por varias semanas.
