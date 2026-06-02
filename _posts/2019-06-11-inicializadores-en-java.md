---
layout: post
title: "Inicializadores en Java"
date: 2019-06-11T19:24:00.001Z
last_modified_at: 2019-06-11T19:24:31.338Z
author: "Diego Silva Límaco"
permalink: /2019/06/inicializadores-en-java.html
canonical_url: https://www.apuntesdejava.com/2019/06/inicializadores-en-java.html
tags:
  - "java"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSyYr1YbDix95CAmeOehepXMsPZvTqMhpRVRSWAqb0BWhK4_BZnxsDBYbNfqA0PgLyFKkg9NYvgJ4gU/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vSyYr1YbDix95CAmeOehepXMsPZvTqMhpRVRSWAqb0BWhK4_BZnxsDBYbNfqA0PgLyFKkg9NYvgJ4gU/pub?w=1440&h=810)

La *inicialización* es el asignar un valor inicial cuando se declara una variable. Esto se puede poner en los atributos de las clases:

```java
//...
public class OrdenCompra{
    private java.util.Date fecha=new java.util.Date();
//...
```

Este ejemplo clásico, significa que cuando se instancie un nuevo objeto de `OrdenCompra` se le asignará un valor inicial (la fecha y hora actual) a la propiedad `fecha`.

De eso estamos de acuerdo todos. Pero un inicializador va más allá de una simple asignación en tiempo de ejecución.

## Orden de inicialización

El orden de la inicialización es de arriba a abajo:

```java
class A {
    int a = 0;
    public A() {
        System.out.println("valor de b:"+b);
    }
    char b = 'X';
}
```

En este ejemplo, hay dos variables: `a` y `b`. Cuando se instancia un objeto, PRIMERO se ejecutan los inicializadores de arriba a abajo, y DESPUÉS el constructor.

Por ello, cuando se instancia este objeto, mostrará:

```java
valor de b:X
```

No importa si el inicializador está después de un constructor.

## Bloques de inicialización

¿Se puede inicializar una variable aplicando alguna condición, algún bucle o algo que necesita de programación?

Pues sí. Consideremos este código - un código nada complejo:

```java
class B {
    int a = 15;
    int b = 10;
    int c;
    public B() {
        System.out.println("Valor de c:" + c);
    }

    { //bloque de inicialización
        c = a + b;
    }
}
```

Otra forma de inicializar las propiedades de un objeto es usando el bloque de inicialización. Es un bloque pero sin nombre. Si se dice que un constructor es como un método sin tipo, un inicializador es un bloque sin nombre.

Cuando instanciamos este objeto, el resultado será.

```java
valor de c:25
```

Recordemos que los inicializadores se ejecutar de ARRIBA A ABAJO, y ANTES del Constructor.

Por tanto, el orden de los inicializadores es importante. Por ejemplo, si modificamos la clase B de la siguiente manera:

```java
class B {
    int a = 15;
    int c;
    public B() {
        System.out.println("Valor de c:" + c);
    }
    { //bloque de inicialización
        c = a + b; //error de compilación
    }
    int b = 10;
}
```

Aquí hay un error de compilación, ya que en el bloque de inicialización se está haciendo a una variable que AÚN no se ha declarado. (¡Pero está más abajo!) Sí. Pero recordemos que se ejecuta de ARRIBA-A-ABAJO. Es exactamente como hacer esto:

```java
//...
int a = 15;
int c = b + a;
int b = 10;
//...
```

Algo más. Así como pueden haber varios inicializadores de varias variables, también pueden haber varios bloques de inicialización. Y cumplen la misma regla: Se ejecutan de arriba a abajo.

## Inicializadores de clase

Así como hay miembros (propiedades y métodos) de clase [static], también existen los inicializadores static. Cumplen las mismas reglas, pero se ejecutan solo cuando la clase se carga en la memoria del JVM.

```java
class C {

    static int a; //1
    int b; //2

    public C() {
        System.out.printf("Valor de a:%1s\nValor de b:%2s\n", a, b);
    }

    { //2
        b = a * 2;
    }

    static { //1
        a = 15;
    }
}
```

Primero se ejecutarán los inicializadores de clase (01), los de instancia (02) y al final el constructor.
