---
layout: post
title: "¿Qué son los :: en Java?"
date: 2022-11-05T20:40:00Z
last_modified_at: 2022-11-05T20:40:12.270Z
author: "Diego Silva Límaco"
permalink: /2022/11/que-son-los-en-java.html
canonical_url: https://www.apuntesdejava.com/2022/11/que-son-los-en-java.html
description: "Una notación que ya es común en Java, pero que quizás no lo sea para otros. Aquí lo veremos con algunos ejemplos"
tags:
  - "lambda"
  - "java 8"
  - "funcional"
  - "tips"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vTTdTWsCbY5gL_bkGv72Gvc9Jwq4_ogbLt_I-_6D1v-HUR_OELF1iDIZ-xenJljUp85V-pDinDCRCvX/pub?w=960&h=540)](https://docs.google.com/drawings/d/e/2PACX-1vTTdTWsCbY5gL_bkGv72Gvc9Jwq4_ogbLt_I-_6D1v-HUR_OELF1iDIZ-xenJljUp85V-pDinDCRCvX/pub?w=960&h=540)

¿Vas llevando tiempo programando en Java y de repente encuentras que usan esta
  notación?

```java
String::toUpperCase
```

  Y te preguntas ¿Ya parece C++? ¿Qué es eso? ¿Cómo funciona ese `::`

Aquí explicaremos un poco de qué trata.

  Supongamos que tenemos una lista de cadenas y queremos tener otra lista con
  las mismas cadenas pero con el texto en mayúsculas. La manera común es hacer
  lo siguiente:

```java
var names = Arrays.asList("Ann", "Bob", "Carl", "David");
        List<String> namesUpper = new ArrayList<>();
        for (String name : names) {
            namesUpper.add(name.toUpperCase());
        }
```

  Sabemos que funciona, con tres instrucciones, en la 11 declaramos la lista de
  destino, en la 12 comenzamos un bucle, y en la 13 convertimos cada elemento
  del bucle, lo convertimos a mayúscula con el método
  `String.toUpperCase()` (ojo con esto) y lo agregamos a la lista
  declarada en la línea 11.

  Ahora, usando programación funcional que ya está disponible a partir de la
  versión 8 de Java, podemos hacer lo mismo pero usando una sola línea, así:

```java
var names = Arrays.asList("Ann", "Bob", "Carl", "David");
        List<String> namesUpper = names.stream()
                .map((String name) -> {
                    return name.toUpperCase();
                }).toList();
```

  La línea 13 es similar a la versión anterior: cada iteración del metodo
  `map()` tiene como parámetro a `name` y lo devuelve
  invocando al método `String.toUpperCase()`. También se puede
  resumir así:

```java
var names = Arrays.asList("Ann", "Bob", "Carl", "David");
        List<String> namesUpper = names.stream()
                .map(name -> name.toUpperCase())
                .toList();
```

  El mismo parámetro `name` es invocado al método
  `toUpperCase()` y es devuelto en la función Lambda.

  Ahora bien, si ya sabemos que se trata del mismo objeto parámetro del método
  `map` ¿para que mencionarlo nuevamente?. Es algo "redundante", si
  es ese, que solo invoque a SU método. Entonces, aquí viene este anotación
  curiosa: llamamos a la clase del parámetro y al método que queremos invocar.
  El compilador ya sabe que se trata del parámetro.

```java
var names = Arrays.asList("Ann", "Bob", "Carl", "David");
        List<String> namesUpper = names.stream()
                .map(String::toUpperCase)
                .toList();
```

### ¿Podemos pasar parámetros?

  Sí, pero solo uno. Veamos este ejemplo. Consideremos un método que solo
  imprime la longitud de cada cadena, este método es simple:

```java
static void printLength(int size) {
        System.out.println("size:" + size); // muy complejo, XD
    }
```

  Ahora, lo que haremos es, tomar la longitud de cada cadena (usando el método
  `String.length`) similar al ejemplo anterior, y luego invocamos al
  método que acabamos de crear. Así que, primero debemos tomar el valor del
  método, usamos `map` y luego, por cada ejemplo con -
  `forEach` - usamos el método `printLength`. Primero lo
  haremos usando parámetros:

```java
public class Ejemplos {

    public static void main(String[] args) {
        var names = Arrays.asList("Ann", "Bob", "Carl", "David");
        names.stream()
                .map(name -> name.length())
                .forEach( length -> Ejemplos.printLength(length) );
    }

    static void printLength(int size) {
        System.out.println("size:" + size);
    }

}
```

-
    Línea 10: Extraemos la longitud de cada cadena y se lo pasamos al siguiente
    método de la llamada funcional.

-
    Línea 11: Allí llega como parámetro el valor del método anterior, y allí
    invocamos al método `Ejemplos.printLength()`, y como argumento le
    pasamos el parámetro recibido.

Ahora, lo podemos reducir con la notación especial:

```java
var names = Arrays.asList("Ann", "Bob", "Carl", "David");
        names.stream()
                .map(String::length)
                .forEach(Ejemplos::printLength);
```

  La línea 10 ya la conocemos, pero la línea 11 es nueva: La notación sabe que
  el parámetro que está recibiendo (si está llegando) es enviado como argumento
  al método `Ejemplos.printLength`.

  Esta es la explicación y el uso de la misteriosa notación de los dos puntos
  `::`.

Si te gustó y es útil, comparte que es gratis.
