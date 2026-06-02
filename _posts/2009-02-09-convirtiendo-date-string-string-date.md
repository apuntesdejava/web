---
layout: post
title: "Convirtiendo Date a String / String a Date"
date: 2009-02-09T15:27:00.001Z
last_modified_at: 2009-06-15T20:55:56.910Z
author: "Diego Silva"
permalink: /2009/02/convirtiendo-date-string-string-date.html
canonical_url: https://www.apuntesdejava.com/2009/02/convirtiendo-date-string-string-date.html
tags:
  - "formateo"
  - "java"
  - "tips"
---

Podemos convertir un objeto fecha a String de varias maneras. Cada manera es un tipo de formato establecido por el JVM instalado en nuestro computador. Consideremos este ejemplo:

```java
<code>        Date d1 = new Date();<br />DateFormat[] dfa = new DateFormat[6];<br />dfa[0] = DateFormat.getInstance();<br />dfa[1] = DateFormat.getDateInstance();<br />dfa[2] = DateFormat.getDateInstance(DateFormat.SHORT);<br />dfa[3] = DateFormat.getDateInstance(DateFormat.MEDIUM);<br />dfa[4] = DateFormat.getDateInstance(DateFormat.LONG);<br />dfa[5] = DateFormat.getDateInstance(DateFormat.FULL);<br /><br />for (DateFormat df : dfa) {<br />System.out.println(df.format(d1));<br />}<br /><br /></code><br />
```

En mi caso, el resultado es:

```java
<code>09/02/09 10:29 AM<br />09/02/2009<br />09/02/09<br />09/02/2009<br />9 de febrero de 2009<br />lunes 9 de febrero de 2009<br /></code>
```

Notemos el resultado del formato obtenido por `DateFormat.getInstance()`. Es toda la fecha en formato corto, además de la hora. Mientras que si obtenemos el formato con `DateFormat.getDateInstance()` la fecha se muestra en formato medio (Podemos consultar la configuración del sistema operativo referido al formato de fechas). También podemos ver los demás formatos: SHORT, MEDIUM, LARGE y FULL.

De la misma manera podemos convertir de `String` a objeto `java.util.Date`. Aquí muestro las diferentes maneras, de diferentes cadenas:

```java
<code><br />DateFormat df = DateFormat.getDateInstance();<br />Date d = df.parse("09/02/2009");<br /><br />DateFormat df = DateFormat.getDateInstance(DateFormat.SHORT);<br />Date d = df.parse("09/02/09");<br /><br />DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM);<br />Date d = df.parse("09/02/09");<br /><br />DateFormat df = DateFormat.getDateInstance(DateFormat.LONG);<br />Date d = df.parse("9 de febrero de 2009");<br /><br />DateFormat df = DateFormat.getDateInstance(DateFormat.FULL);<br />Date d = df.parse("lunes 9 de febrero de 2009");<br /></code>
```
