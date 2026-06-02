---
layout: post
title: "Convertir String a Date"
date: 2007-05-23T18:26:00Z
last_modified_at: 2009-04-25T21:55:03.736Z
author: "Diego Silva"
permalink: /2007/05/convertir-string-date.html
canonical_url: https://www.apuntesdejava.com/2007/05/convertir-string-date.html
tags:
  - "formateo"
---

Hice una vez un algoritmo para extraer pedazos de una cadena y pasarlo por la clase Calendar para obtener la fecha. Pero creo que son muchos pasos.
Pues bien, creo que la siguiente manera deberá ser la más sencilla.
Supongamos que tenemos la cadena "1976/03/27" y queremos convertirlo a java.util.Date.
Pues este será el código:
`
          DateFormat df=DateFormat.getDateInstance(DateFormat.SHORT,Locale.JAPAN);
          Date d=df.parse("1976/03/27");
`
Uso el Locale.JAPAN por qué sé que ellos usan ese formato (yyyy/mm/dd) para las fechas.
