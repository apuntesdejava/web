---
layout: post
title: "Convertir Date a String (y String a Date)"
date: 2009-04-22T16:13:00Z
last_modified_at: 2009-04-22T16:13:22.243Z
author: "Diego Silva"
permalink: /2009/04/convertir-date-string-y-string-date.html
canonical_url: https://www.apuntesdejava.com/2009/04/convertir-date-string-y-string-date.html
tags:
  - "java"
---

Java almacena las fechas en un objeto llamado `java.util.Date`. Si se imprime o se usa como cadena, el resultado no es nada agradable ya que no se entiende: `Sat Mar 27 00:00:00 COT 1976`

Pues bien, existe una clase llamada `java.text.DateFormat` que permite convertir de Date a String (bajo un formato en especial) y visceversa (también usando el mismo formato).

Aquí dejo un pequeño código (adaptado del libro de certificación SCJP 5.0 de Katty Sierra - Página 464) donde se muestra los diferentes formatos que maneja la clase `java.text.DateFormat`. Si necesitas convertir una cadena (String) a Date, primero prueba este código, analízalo y luego piensa cómo lo puedes usar.

```java
<span class="keyword-directive">import</span> java.text.DateFormat;

<span class="keyword-directive">import</span> java.text.ParseException;
<span class="keyword-directive">import</span> java.util.Date;

<span class="keyword-directive">public</span> <span class="keyword-directive">class</span> Main {

    <span class="keyword-directive">public</span> <span class="keyword-directive">static</span> <span class="keyword-directive">void</span> main(String[] args) {
        Date fecha = <span class="keyword-directive">ne</span><span class="keyword-directive">w</span> Date();
        DateFormat dfDefault = DateFormat.getInstance();
        DateFormat dfDateInstance = DateFormat.getDateInstance();
        DateFormat dfDateShort = DateFormat.getDateInstance(DateFormat.SHORT);
        DateFormat dfDateMedium = DateFormat.getDateInstance(DateFormat.MEDIUM);
        DateFormat dfDateLong = DateFormat.getDateInstance(DateFormat.LONG);
        DateFormat dfDateFull = DateFormat.getDateInstance(DateFormat.FULL);

        System.out.println(<span class="character">"</span><span class="character">getInstance()=</span><span class="character">"</span> + dfDefault.format(fecha));
        System.out.println(<span class="character">"</span><span class="character">getDateInstance()=</span><span class="character">"</span> + dfDateInstance.format(fecha));
        System.out.println(<span class="character">"</span><span class="character">getDateInstance(DateFormat.SHORT)=</span><span class="character">"</span> + dfDateShort.format(fecha));
        System.out.println(<span class="character">"</span><span class="character">getDateInstance(DateFormat.MEDIUM)=</span><span class="character">"</span> + dfDateMedium.format(fecha));
        System.out.println(<span class="character">"</span><span class="character">getDateInstance(DateFormat.LONG)=</span><span class="character">"</span> + dfDateLong.format(fecha));
        System.out.println(<span class="character">"</span><span class="character">getDateInstance(DateFormat.FULL)=</span><span class="character">"</span> + dfDateFull.format(fecha));
        <span class="keyword-directive">try</span> {
            Date fecha2 = dfDateMedium.parse(<span class="character">"</span><span class="character">27/03/1976</span><span class="character">"</span>);
            System.out.println(<span class="character">"</span><span class="character">Parsed:</span><span class="character">"</span> + fecha2);
        } <span class="keyword-directive">catch</span> (ParseException ex) {
            ex.printStackTrace();
        }
    }
}
```

El resultado para este código, en mi caso, es el siguiente:

`

```java
getInstance()=22/04/09 11:12 AM
getDateInstance()=22/04/2009
getDateInstance(DateFormat.SHORT)=22/04/09
getDateInstance(DateFormat.MEDIUM)=22/04/2009
getDateInstance(DateFormat.LONG)=22 de abril de 2009
getDateInstance(DateFormat.FULL)=miércoles 22 de abril de 2009
Parsed:Sat Mar 27 00:00:00 COT 1976
```

`
