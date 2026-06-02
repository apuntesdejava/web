---
layout: post
title: "Conociendo RegEx (Parte 2/2)"
date: 2015-12-07T21:32:00.002Z
last_modified_at: 2015-12-07T21:32:18.753Z
author: "Diego Silva Límaco"
permalink: /2015/12/conociendo-regex-parte-22.html
canonical_url: https://www.apuntesdejava.com/2015/12/conociendo-regex-parte-22.html
---

[![Conociendo RegEx (Parte 2/2)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiylzY2nVccmL7hu61RuTEfww496oNZaCFEhDDaPt5i2HS8Vo0mfENutLY-AJRFOhwoovvzi6HtxGAMitbwa0O4szsAlofi-uD3ik5W3GfDWzSniodReavUGYetag-Ao8kTsopIfACHKPU/s1600/Egyptian+Regexp.jpeg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiylzY2nVccmL7hu61RuTEfww496oNZaCFEhDDaPt5i2HS8Vo0mfENutLY-AJRFOhwoovvzi6HtxGAMitbwa0O4szsAlofi-uD3ik5W3GfDWzSniodReavUGYetag-Ao8kTsopIfACHKPU/s1600/Egyptian+Regexp.jpeg)

Continuamos con las Expresiones Regulares, esta vez veremos ejemplos un poco más complejo.

El anterior post lo puedes ver aquí [Conociendo RegEx (Parte 1/2)]({{ '/2015/02/conociendo-regex-parte-12.html' | relative_url }})

## Extrayendo subcadenas

Aquí tenemos un caso un poco más complejo.

Imaginemos que tenemos en un cadena un listado separado por comas de todos los archivos que tenemos en una carpeta, y necesitamos tener los archivos que su nombre comience con `proj1`.

La cadena es como esta:

`proj3.txt,proj1sched.pdf,proj1,proj2,proj1.java`

Sabemos que, como comienza con `proj1`, entonces nuestro patrón deberá tener esa cadena

Patrón: `proj1`

Ahora, el siguiente caracter puede ser cualquier caracter menos la coma, porque será nuestro separador ¿cierto?. Entonces, usaremos el caracter ^ para negar la coma, y puede tener lo que sea: otros caracteres, u otros simbolos.. pero debemos cortar hasta que encuentre otro `proj1`. Entonces, el patrón será así:

Patrón: `proj1([^,])*`

Nuestro código completo sería algo así

```java
String nombres = "proj1.xls,proj3.txt,proj1sched.pdf,proj1,proj2,proj1.java";

        String expression = "proj1([^,])*",
                source = nombres;
        Pattern p = Pattern.compile(expression);
        Matcher m = p.matcher(source);
        System.out.println("expression:" + m.pattern());
        System.out.println("source:" + source);
        System.out.println(" index:01234567890123456789012345678901234567890");
        System.out.println("       0         1         2         3         4\n");
        System.out.println("pos  grupo:");
        while (m.find()) {
            System.out.println(m.start() + "    " + m.group());
        }
```

El resultado será este:

```java
expression:proj1([^,])*
source:proj1.xls,proj3.txt,proj1sched.pdf,proj1,proj2,proj1.java
 index:01234567890123456789012345678901234567890
       0         1         2         3         4

pos  grupo:
0    proj1.xls
20    proj1sched.pdf
35    proj1
47    proj1.java
```

Ahora, vayamos un poco más complejo: Necesito extraer de una cadena todos los numéricos telefónicos que sean de siete dígitos, pero:

- Los 7 dígitos pueden estar contínuos. Ejemplo: 1234567

- Esté separado por un espacio entre la zona y el número: Ejemplo 123 4567

- O, tenga un guión: Ejemplo 123-4567

Calma, calma. Este es el patrón:

Patrón: `\d\d\d([-\s])?\d\d\d\d`

Quiere decir: Que comience con tres dígitos (`\d` tres veces) luego que sea ninguno o solo uno (`?`) del caracter guión (`-`) o espacio en blanco (`\s`), y al final cuatro dígitos (`\d` cuatro veces).

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody>
<tr><td style="text-align: center;"><a href="https://docs.google.com/drawings/d/1tdaWthGocbJu3ZiI8vi-URSH20wMi0WhAjJjRTK7VX4/pub?w=342&amp;h=171" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="160" src="https://docs.google.com/drawings/d/1tdaWthGocbJu3ZiI8vi-URSH20wMi0WhAjJjRTK7VX4/pub?w=342&amp;h=171" width="320" /></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">¿Se ve mejor?</td></tr>
</tbody></table>

### El punto

Otro caracter especial es el punto que significa: "cualquier caracter que este aquí, el que sea, ".

Por ejemplo:

Fuente: `ac abc a `

Patrón: `a.c`

Resultado

```java
expression:a.c
source:ac abc a c
 index:01234567890123456789012345678901234567890
       0         1         2         3         4

pos  grupo:
3    abc
7    a c
```

Noten que hasta el espacio fue considerado como caracter.

## Greedy Quantifiers

No he encontrado alguna traducción correcta al español de este tipo de calificadores. ¿"Greedy" se podría traducir como *goloso?*. Bueno, ya lo veremos.

Cuando usamos los cuantificadores `*`, `+` y `?`, podemos ajustar un poco su comportamiento llamados "greedy" (goloso), "reluctant" (sin ánimo) o "possessive" (posesivo). [Me recuerda al término *Lazy* para cargar datos]. Veamos un poco la sintaxis:

- `?` es *greedy*, `??` es *reluctant*, para ninguna o una vez

- `*` es *greedy*, `*?` es *reluctant*, para ninguna o una vez

- `+` es *greedy*, `+?` es *reluctant*, para ninguna o una vez

Analícemos lo que sucede con este juego de caracteres:

Fuente: `yyxxxxyxx`

Patrón: `.*xx`

Antes de realizar el código, analicemos qué va a pasar con los caracteres "xx".

Podemos suponer que buscará todas cadenas que terminan en "xx". Pero realmente tenemos dos posibles resultados. ¿cuáles? Recordemos que regex trabaja de izquierda a derecha y los caracteres leídos ya no son considerados. Por tanto, trabajando de izquierda a derecha, podemos predecir que el motor primero examina los primeros cuatro caracteres (del 0 al 3), encuentra los caracteres "xx" que están en la posición 2 y es considerado como el final de la primera cadena a extraer. Luego sigue hasta la otra posición xx que está en la posición 6.

[![](https://docs.google.com/drawings/d/1WIRYOiNntc2EvkM6O-mKkKPU2Ia0_9VYMaYEPQhHsAU/pub?w=456&h=380)](https://docs.google.com/drawings/d/1WIRYOiNntc2EvkM6O-mKkKPU2Ia0_9VYMaYEPQhHsAU/pub?w=456&h=380)

¿está claro?

Ahora, existe otra posible solución si es que queremos buscar todas las cadenas que terminan con "xx", y es que puede ser este el resultado:

[![](https://docs.google.com/drawings/d/12xYccFU9oFsAN37OL7PeQ_i2QbH9hYeHsDc_cDQY3sE/pub?w=456&h=380)](https://docs.google.com/drawings/d/12xYccFU9oFsAN37OL7PeQ_i2QbH9hYeHsDc_cDQY3sE/pub?w=456&h=380)

A esto es lo que se le llama *greedy* (o *goloso*). Para que la segunda respuesta se la correcta, el motor regex debe buscar la cadena de una manera golosa en toda la cadena antes de determinar cuál "xx" es el final. Por tanto, el segundo resultado es el correo.

Esta es el resultado de la ejecución con ese patrón

```java
expression:.*xx
source:yyxxxyxx
 index:01234567

pos  grupo:
0    yyxxxyxx
```

Si vemos la tabla anterior, para hacer que el caracter `*` no sean tan *goloso*, debemos usar el cualificador  `*?` para que sea una búsqueda*reluctant* o *reacia*.

```java
expression:.*?xx
source:yyxxxyxx
 index:01234567
       0

pos  grupo:
0    yyxx
4    xyxx
```

**Esto es todo por ahora. **

**Si te gustó, dale Like o +1; **

**si te es útil, compártelo. Es gratis**
