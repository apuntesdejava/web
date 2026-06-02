---
layout: post
title: "¿Por valor o por referencia?"
date: 2013-05-06T22:13:00.002Z
last_modified_at: 2016-01-08T21:03:07.357Z
author: "Diego Silva Límaco"
permalink: /2013/05/por-valor-o-por-referencia.html
canonical_url: https://www.apuntesdejava.com/2013/05/por-valor-o-por-referencia.html
tags:
  - "libros"
  - "java"
  - "tutorial java"
  - "documentacion"
  - "tips"
  - "trucos"
---

[![](https://docs.google.com/drawings/d/1oOR8amKrHW45QgeBpeZT2mRn1Iqbmob9dQbcn2usFfM/pub?w=470&h=246)](https://docs.google.com/drawings/d/1oOR8amKrHW45QgeBpeZT2mRn1Iqbmob9dQbcn2usFfM/pub?w=470&h=246)

Esta es una pregunta existencial para todo programador Java. Cada uno encuentra una respuesta satisfactoria. Pero ahora veremos, basándonos en el libro para Certificación SCJP 1.5 de Katty Sierra, sobre la respuesta correcta.

Me diréis:  pero ahora estamos en Java 7, casi la 8.. y ese libro habla de una versión antigua. Cierto, pero la esencia de Java no ha cambiado.

#### Variables por valor

Entendemos como asignación de variables por valor cuando se hace **una copia del valor** de una variable a otra. Esto lo vemos así:

```java
public static void main(String[] args) {
        int a = 10; //es una variable
        int b = 20; //es otra variable
        int c = a;  //la variable "c" tiene la copia del valor de "a"
        a = 30; //"a" tiene otro valor
        System.out.format("a=%d, b=%d, c=%d", a, b, c); //imprime a=30, b=20, c=10
    }
```

Esta asignación también aplica para los parámetros de funciones.

<iframe src="http://pastebin.com/embed_iframe.php?i=T8BAsFui" style="border: none; width: 100%;"></iframe>

El resultado es:

```java
Valores antes de cambiar
a=10, b=20, c=30
Valores cambiados en el método
a=100, b=200, c=300
Valores después de cambiar
a=10, b=20, c=30
```

Entonces, estamos claros que, **si se asigna otro valor a las variables desde dentro de un método, estos nuevos valores no afectan a las variables originales** ¿cierto? Por tanto, estamos casi asegurando de que los parámetros son pasados por valor.

#### Variables por referencia

¿Qué pasa con los objetos? Revisemos este código:

<iframe src="http://pastebin.com/embed_iframe.php?i=ABdS77jC" style="border: none; width: 100%;"></iframe>

Entonces... podemos concluir que** cuando son objetos, los parámetros son por referencia.. porque hemos demostrado que cuando se cambia el valor desde dentro de un método afecta a la variable original**.

Listo, terminó mi apunte, y todos estamos satisfechos ¿Verdad que es bonito haber demostrado que los parámetros de tipo nativo son por valor y los de tipo objeto son por referencia?

[![](/assets/blogger/3566373.jpg)](/assets/blogger/3566373.jpg)

¿por qué? Porque el código no es el mismo. Lo que hemos cambiado es valor de una variable que pertenece a otra variable.

Me explico.

En el primer ejemplo, se cambió el valor de la variable directamente.. es decir:

```java
private static void cambiandoValores(int a, int b, int c) {
        a = 100; //se le asigna un nuevo valor...
        b = 200; //... aquí tambien se le asigna un nuevo valor
        c = 300; //... idem... notemos que es a la misma variable
//....
```

Por tanto, si fuera con objetos... y para ser más justos... deberíamos cambiar directamente a la variable:

```java
//...
    private static void cambiarNombre(Persona p) {
        p=new Persona(); //aqui se le está asignado un nuevo valor (objeto) al mismo parámetro recibido
        p.setNombre("Santiago"); //y...aqui tendrá otro valor
    }
//...
```

Entonces, otra sería la historia. Probemos este último código completo:
<iframe src="http://pastebin.com/embed_iframe.php?i=5yN6ks3S" style="border: none; width: 100%;"></iframe>

El resultado será:

```java
El nombre antes del método es:Diego
El nombre en el método es:Santiago
El nombre después del método es:Diego
```

Es lo más justo, es exacto decir: `p=new Persona()` luce igual que `a=100`

Entonces.. los parámetros son por valor o por referencia?

#### La respuesta es:

**Es por valor**.. son copias del valor ¿qué guarda la variable de tipo de objeto? Guarda la dirección de la memoria del objeto creado en el heap. No hace diferencia si es tipo nativo o tipo objeto.. siempre es por valor. [Kathy Sierra](https://www.coderanch.com/how-to/java/ActiveStaff#kathysierra) lo describe así en el libro "[SCJP Sun Certified Programmer for Java 5 Study Guide](http://www.amazon.com/Certified-Programmer-Study-310-055-Certification/dp/0072253606/ref=sr_1_3?s=books&ie=UTF8&qid=1367876920&sr=1-3)"

(Traducción libre:)

> "Si Java pasa objetos al pasar la referencia a la variable en su lugar, ¿significa que  Java utiliza el pase por referencia de los objetos? No exactamente, aunque a menudo se escucha y se lee que así lo hace. Realmente, Java  pasa  por  valor todas las variables que se ejecutan en una sola máquina virtual. Pasar por valor significa pasar el valor de la variable. Y eso significa, pasar la copia de la variable! (Hay esa palabra 'copia' de nuevo!)

"No importa si estás pasando una variable primitiva o variables de referencia, siempre estás pasando una copia de los bits de la variable. Así que para una variable primitiva, estás pasando una copia de los bits que representan el valor. Por ejemplo, si se pasa una variable `int` con el valor de 3,  está pasando una copia de los bits que representan 3. La  llamada al método  obtiene su propia copia del valor, para hacer con ella lo que quiera.

"Y si estás pasando una variable de referencia a objeto, lo que está pasando es una copia de los bits que representan la referencia a un objeto. La llamada al método, entonces, obtiene su propia copia de la variable de referencia, para hacer con ella lo que quiera. Pero debido a que dos variables de referencia idénticas se refieren al mismo objeto, si el método llamado modifica el objeto (mediante la invocación de los métodos setter, por ejemplo), el objeto variable original del llamante ha sido modificado."

**Capítulo 3: Asignaciones. Sección "Java usa semánticas por valor?"**

Espero que con esto se tenga más claro el uso de las variables en Java.

Con lo expuesto aquí.. la siguiente pregunta es.. ¿Existen punteros en Java?

Que tengan un buen día :)

### Actualización (2016-01-08):

Aquí tengo dos ejemplos donde se implementa el mismo ejemplo pero usando los parámetros por valor o por referencia explícitamente. En Pascal se necesita de la instrucción `var` para que sea por referencia. En C se utiliza con `&` y `*`

- En Pascal: [https://bitbucket.org/snippets/apuntesdejava/Rnxyr](https://bitbucket.org/snippets/apuntesdejava/Rnxyr)

- En C: [https://bitbucket.org/snippets/apuntesdejava/dnxyb](https://bitbucket.org/snippets/apuntesdejava/dnxyb)
