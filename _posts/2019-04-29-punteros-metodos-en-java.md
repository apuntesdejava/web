---
layout: post
title: "\"Punteros a métodos\" en Java"
date: 2019-04-29T19:02:00.001Z
last_modified_at: 2019-04-29T19:02:21.845Z
author: "Diego Silva Límaco"
permalink: /2019/04/punteros-metodos-en-java.html
canonical_url: https://www.apuntesdejava.com/2019/04/punteros-metodos-en-java.html
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vR_HKAKi1u9CnAipqFSkLFYQe-_a5-wbQ4kINFRL-hHy2cfZunJtOcPiDMpxLhnqs5zU4Iq1E3yr24v/pub?w=960&h=600)](https://docs.google.com/drawings/d/e/2PACX-1vR_HKAKi1u9CnAipqFSkLFYQe-_a5-wbQ4kINFRL-hHy2cfZunJtOcPiDMpxLhnqs5zU4Iq1E3yr24v/pub?w=960&h=600)

Una de las cosas que extrañaba de C en Java es la capacidad de apuntar a una función. En lugar de invocar a una función directamente, podía hacerlo a través de una variable. Esto es: no importa a qué apunta a esa variable, cuando se invoca con los parámetros correctos, lo ejecutará.

En Java lo más cercano que se podía hacer era usando polimorfismo. A partir de Java 8 apareció lo que veremos en este post.

Consideremos este pequeño código en C.

<script src="https://gist.github.com/diegosilval/ec1d94ce19ad73a352cf089a3eac9fcb.js"></script>

Al ejecutarse esta es la salida:

[![](/assets/blogger/2019-04-29_12-57-31.png)](/assets/blogger/2019-04-29_12-57-31.png)

La misma invocación, pero ejecuciones diferentes.

Si lo pensamos en Java, lo más parecido sería tener un método `abstract` (como de interface o de una clase abstracta) y dependiendo de su instanciación podremos tener el resultado diferente:

<script src="https://gist.github.com/diegosilval/6f49e0166f3e8d324844b2d371531a2b.js"></script>

(Sí, mucho código para hacer lo mismo). La ejecución muestra el mismo resultado.

Ahora bien, se puede hasta reducir un poco más el código evitando crear las clases, solo implementamos la interfaz directamente:

<script src="https://gist.github.com/diegosilval/267e4219312e5dad63b6b2dd1c04c716.js"></script>

Ya, tenemos menos código... pero aún estamos dependiendo de una interfaz. La cuestión es que, si quiero ejecutar un método que lo definí en alguna clase y no necesito crear una interfaz para ejecutar dependiendo de la implementación... ¿cómo lo hago?

## Dos clases diferentes, dos métodos diferentes

Supongamos que tengamos dos clases, que en lo único que coinciden es un método que tienen la misma cantidad de parámetros. No tienen los mismos nombres, porque el diseño de mi aplicación funciona así (así que implementar una interfaz queda fuera). Estas clases son:

<script src="https://gist.github.com/diegosilval/3da8ccb924574abb4a118212b2f3817d.js"></script>

<script src="https://gist.github.com/diegosilval/dd3e3a37d500897894514f04207506fe.js"></script>

Ahora, vamos a instanciar esas dos clases, serán dos objetos diferentes. Pero queremos, por alguna razón de nuestra lógica, invocar a esos métodos, pero el que lo invoca no sabrá a quién está ejecutando.

Para poder implementar, debemos utilizar la interfaz [Consumer](https://docs.oracle.com/javase/8/docs/api/java/util/function/Consumer.html), y le decimos cuál es el parámetro que va a tener:

```java
static void run(Consumer<Integer> c) {
        c.accept(10); //invoca el método, con el mismo parámetro
    }
```

Y, para ejecutarlo, debemos pasarle la variable seguido de un par de dos puntos `::` y seguido el nombre del método:
<script src="https://gist.github.com/diegosilval/9d2489bef4e704f9a8a8f0b94750e87e.js"></script>

## Quiero obtener un valor

Hasta aquí fue un ejemplo invocando un método con un parámetro... pero ahora solo quiero invocar un método que me devuelva un valor. Vamos, tenemos estás clases:
<script src="https://gist.github.com/diegosilval/e5900332f820ae45c17f30f62a23d05b.js"></script><script src="https://gist.github.com/diegosilval/732983765013fdb1c4e795c884eecaf8.js"></script>

Ahora bien, para ejecutar el método podría ser así:

```java
static String run(Supplier<string> m) {
        return m.get(); //ejecuta el método cuando se le pasa
    }

</string>
```

Ahora bien, ejecutemos el código, le pasamos el método de la misma manera.<script src="https://gist.github.com/diegosilval/ad14f4fa74235b6140a4664f47e35f52.js"></script>

## Pasar parámetro, obtener resultado

Ahora se pone interesante: pasarle un parámetro, y obtener un valor. Para eso usaremos [Function](https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html)

Nuestras clases a probar:

<script src="https://gist.github.com/diegosilval/441cf8eac291929ed1832b00f64bb248.js"></script><script src="https://gist.github.com/diegosilval/8d1f2820df4b6776fd5c2f18dae846d2.js"></script>

Ahora, ejecutaremos para ejecutar será:

```java
static String run(Function<String, String> f, String p) {
        return f.apply(p); //ejecuta la funcion con el parametro y lo devuelve
    }
```

y la ejecución será así:<script src="https://gist.github.com/diegosilval/1b23f2b8551b2f367fff1c3888cb893e.js"></script>

## Documentación

Para más detalle, revisar la documentación [Package java.util.function](https://docs.oracle.com/javase/8/docs/api/index.html?java/util/function/package-summary.html)
