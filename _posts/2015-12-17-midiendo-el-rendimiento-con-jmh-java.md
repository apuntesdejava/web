---
layout: post
title: "Midiendo el rendimiento con JMH - Java Microbenchmark Harness"
date: 2015-12-17T19:51:00.001Z
last_modified_at: 2015-12-23T04:52:03.187Z
author: "Diego Silva Límaco"
permalink: /2015/12/midiendo-el-rendimiento-con-jmh-java.html
canonical_url: https://www.apuntesdejava.com/2015/12/midiendo-el-rendimiento-con-jmh-java.html
tags:
  - "java"
  - "jmh"
  - "benchmark"
---

![](https://docs.google.com/drawings/d/1CVU0jIwsMggHTIsGI5TCL3W3Agxj3hVmUVxRYiVilFs/pub?w=268&h=209)

JMH es una herramienta tipo arnés de Java que permite medir el rendimiento en la construcción, ejecución, y análisis de aplicaciones hechas Java y otros lenguajes hechos para JVM

El proyecto se encuentra aquí: [http://openjdk.java.net/projects/code-tools/jmh/](http://openjdk.java.net/projects/code-tools/jmh/)

En este post veremos un poco de su funcionamiento

En mis tiempos (cuando se programaba sin mouse, y no habían ventanitas) uno debería hacer el código tan óptimo en el uso de la CPU y la memoria, porque eran recursos escasos. Ahora, la RAM son mínimo 8GB e ignoro cuánto es la velocidad "normal" de los CPU... por lo que la programación "óptima" quedó de lado, pero aún existimos los que consideramos que el código "óptimo" deba existir.

¿Es más rápido declarar una variable local a un bucle que declararlo fuera del bucle? ¿Un `for-each` es más rápido que un `for`? ¿Invocar un método heredado es más lento que volverlo a declarar?. Quizás para algunos no tenga importancia, pero si se juntan esos pequeños "asuntos sin importancia" se puede volver en un "gran asunto con mucha importancia". Así que veremos cómo configurarlo y algunos ejemplos de [Code - Tools: JMH](http://openjdk.java.net/projects/code-tools/jmh/).

## Inicio

Para comenzar, debemos usar Maven. Ahora, la mayoría de los IDEs lo permite (ya saben que mi favorito es NetBeans) pero también se puede usar la línea de comandos.

Así que crearemos nuestro proyecto - siguiendo el manual - utilizando un archetype

[![](https://docs.google.com/drawings/d/1S7HGRF8zcvZn6b6DQgDy6u_cG6mMWav05nQL-_aW5GQ/pub?w=731&h=495)](https://docs.google.com/drawings/d/1S7HGRF8zcvZn6b6DQgDy6u_cG6mMWav05nQL-_aW5GQ/pub?w=731&h=495)

Clic en "Next" y buscamos a JMH, y seleccionamos el correspondiente a Java.

[![](https://docs.google.com/drawings/d/1BP2wVzDxdTjP06sD1xk0Z9lCQGwFL9mgNoneLM0HQQU/pub?w=867&h=577)](https://docs.google.com/drawings/d/1BP2wVzDxdTjP06sD1xk0Z9lCQGwFL9mgNoneLM0HQQU/pub?w=867&h=577)

Clic en "Next", y escribimos lo que será nuestro proyecto.

Yo puse

- Project name: testing-code

- group id: com.apuntesdejava.jmh

[![](https://docs.google.com/drawings/d/1eHWCx_bvQwR6CPl7Qt7FzgTl30bHFy1pBtewr84ZSG4/pub?w=852&h=393)](https://docs.google.com/drawings/d/1eHWCx_bvQwR6CPl7Qt7FzgTl30bHFy1pBtewr84ZSG4/pub?w=852&h=393)

Clic en "Finish". Esto fue equivalente a este comando en la consola del sistema operativo

```java
$ mvn archetype:generate \
          -DinteractiveMode=false \
          -DarchetypeGroupId=org.openjdk.jmh \
          -DarchetypeArtifactId=jmh-java-benchmark-archetype \
          -DgroupId=com.apuntesdejava.jmh \
          -DartifactId=testing-code \
          -Dversion=1.0
```

Esto nos creará un proyecto con la primera clase que usaremos para nuestro prueba de rendimiento.

[![](https://docs.google.com/drawings/d/1W8SuUU2NkQkBMXx9VUmG7vvJcKEnLGXrOQQzYKK662k/pub?w=433&h=339)](https://docs.google.com/drawings/d/1W8SuUU2NkQkBMXx9VUmG7vvJcKEnLGXrOQQzYKK662k/pub?w=433&h=339)

**NOTA**

Por si acaso, es posible que cuando abras el código, la declaración del paquete no concuerde.

![](https://docs.google.com/drawings/d/1lAX7E6oJHt76S7e3BkqT4B9keZEjdTH8fYYyS_0KxHA/pub?w=916&h=366)

Calma, calma, solo hay que cambiarlo al respectivo.

![](https://docs.google.com/drawings/d/18-W2LwTLZSHGg5t7W38siRmxa3azJjrlM_xMI86rCas/pub?w=713&h=287)

## El Primer JMH Benchmark

La clase generada `MyBenchmark` es una clase plantilla para implementar las medidas de rendimientos. Así que editaremos esta clase. Por ejemplo, comencemos desmitificar el asunto de la declaración: ¿Es mejor declarar la variable fuera de un loop o dentro?

```java
package com.apuntesdejava.jmh.testing.code;

import org.openjdk.jmh.annotations.Benchmark;

public class MyBenchmark {

    @Benchmark
    public void testMethod() {
        for (int i = 0; i < 100; i++) {
            Persona p = new Persona("Nombre " + i, i);
        }
    }

    class Persona {

        private final String nombre;
        private final int edad;

        public Persona(String nombre, int edad) {
            this.nombre = nombre;
            this.edad = edad;
        }

        @Override
        public String toString() {
            return "Persona{" + "nombre=" + nombre + ", edad=" + edad + '}';
        }
    }
}
```

### Construyendo la clase

Desde el Proyecto seleccionamos "Build".

![](https://docs.google.com/drawings/d/1s43l9ooJWd_4DO4_X313UZqCbmj76kHF-bnQiutYkd4/pub?w=446&h=314)

Esto es equivalente que hacer el comando en consola:

```java
mvn clean install
```

Al terminar, Maven habrá creado dentro de la carpeta "target" el archivo `benchmarks.jar` además del .jar de nuestro proyecto. Lo que más nos importa en este momento es justamente `benchmarks.jar`

![](https://docs.google.com/drawings/d/1YbU4UGebCkw-H7dNoscNdw4XkN3-Q6CebLefrtkBBrc/pub?w=383&h=409)

### Ejecutando la medición de rendimiento

Como este .jar fue generado fuera del proyecto de NetBeans, este IDE no sabe aún cómo ejecutarlo. Así que lo haremos desde la línea de comandos. Nos debemos ubicar justo en la carpeta "target" que contiene el .jar mencionado. Y ejecutamos el comando

```java
java -jar benchmarks.java
```

![](https://docs.google.com/drawings/d/10ScSKeZdHBi5yhJ6562I5IBRad4ZUbA7qYEjXw7pvNw/pub?w=780&h=253)

Al ejecutarlo, comenzará la medición de tiempo de nuestro código.

Para este ejemplo, estima que tomará 6 minutos.

![](https://docs.google.com/drawings/d/1nEigrU9lLlN2RP-vyIsd5kminiMPb48X1OdNEACC8to/pub?w=787&h=395)

Así que podemos en ir a prepararnos algo de café.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhILMaqJIYtnc_UJ_R3QygHAFGSf_7O_gYjMf7HDv7TMqyB0uxPqI96Qdm89tpS6jbKnb6KA76DD-BJ0Aw8DHy3xgWaiq8EWcIwItF1b5As8_v9oS2cFnWaU0i8hOfu_KykEk5BjF8nnVI/s320/java_scripters_coffee_basic_white_mug-rbde39adb86d441018abf03885a1ee4c8_x7jgr_8byvr_324.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhILMaqJIYtnc_UJ_R3QygHAFGSf_7O_gYjMf7HDv7TMqyB0uxPqI96Qdm89tpS6jbKnb6KA76DD-BJ0Aw8DHy3xgWaiq8EWcIwItF1b5As8_v9oS2cFnWaU0i8hOfu_KykEk5BjF8nnVI/s1600/java_scripters_coffee_basic_white_mug-rbde39adb86d441018abf03885a1ee4c8_x7jgr_8byvr_324.jpg)

### El resultado

Ahora, ya tenemos el resultado. Este es

![](https://docs.google.com/drawings/d/1P24pDXGNp6uw4_0qZE0hchMQHtFUMVGXSMTIGl_peeo/pub?w=672&h=516)

Bueno, no se puede saber mucho ni comparar mucho si es que es solo un método, por lo que vamos a cambiar la clase para que haga las dos comparaciones que necesitamos:

```java
package com.apuntesdejava.jmh.testing.code;

import org.openjdk.jmh.annotations.Benchmark;

public class MyBenchmark {

    @Benchmark
    public void inLoop() {
        for (int i = 0; i %lt; 50; i++) {
            Persona p = new Persona("Nombre " + i, i);
        }
    }
    @Benchmark
    public void outLoop() {
        Persona p;
        for (int i = 0; i < 50; i++) {
             p = new Persona("Nombre " + i, i);
        }
    }

    class Persona {

        private final String nombre;
        private final int edad;

        public Persona(String nombre, int edad) {
            this.nombre = nombre;
            this.edad = edad;
        }

        @Override
        public String toString() {
            return "Persona{" + "nombre=" + nombre + ", edad=" + edad + '}';
        }
    }
}
```

Como son dos métodos, tomará buen tiempo

El resultado será decisivo.

(Después de algunos buenos minutos....)

Los resultados son los siguientes (según mi PC).

Para el método `inLoop`:

```java
Result "inLoop":
  1274926,627 ±(99.9%) 3465,557 ops/s [Average]
  (min, avg, max) = (1194673,444, 1274926,627, 1302669,602), stdev = 14673,385
  CI (99.9%): [1271461,070, 1278392,184] (assumes normal distribution)
```

Mientras para el método `outLoop`

`
`

```java
Result "outLoop":
  1278235,900 ±(99.9%) 4584,189 ops/s [Average]
  (min, avg, max) = (1067676,512, 1278235,900, 1300671,076), stdev = 19409,745
  CI (99.9%): [1273651,711, 1282820,089] (assumes normal distribution)
```

Y el resultado final es:

```java
# Run complete. Total time: 00:13:26

Benchmark             Mode  Cnt        Score      Error  Units
MyBenchmark.inLoop   thrpt  200  1274926,627 ± 3465,557  ops/s
MyBenchmark.outLoop  thrpt  200  1278235,900 ± 4584,189  ops/s
```

inLoop es más rápido (1274926,627) que outLoop (1278235,900), pero con el margen de error (± 3465,557 y ± 4584,189) pues hace pensar que no hay mucha diferencia.

 y es que...

...usar loops para declarar dentro o fuera una variable no tiene ningún efecto,por el mismo JIT es tan inteligente que sabe qué hacer para ciertas circunstancias.

Así que, esta medida de loops para declarar variables no le hace cosquillas.

## Herencia vs. override

Aquí prueba una duda que tuve hace tiempo.

¿Es más rápido llamar al método heredado que crear un método override y llamar al método del padre usando `super.` ?

Con código es más claro: Supongamos que tenemos estas clases

```java
class Persona {

        private final String nombre;
        private final int edad;

        public Persona(String nombre, int edad) {
            this.nombre = nombre;
            this.edad = edad;
        }

        public int getEdad() {
            return edad;
        }
    }

    class Empleado extends Persona {

        public Empleado(String nombre, int edad) {
            super(nombre, edad);
        }

        @Override
        public int getEdad() {
            return super.getEdad(); //To change body of generated methods, choose Tools | Templates.
        }
    }

    class Vecino extends Persona {

        public Vecino(String nombre, int edad) {
            super(nombre, edad);
        }
    }
```

Y quiero saber si el método `getEdad()` es más rápido el de `Empleado` porque hace la llamada a su ancestro con `super`.

Como al método `getEdad()` necesito procesarlo y no solo guardarlo en una variable sin usarla, entonces usamos parámetros de tipo `org.openjdk.jmh.infra.Blackhole` en la clase `MyBenchmark`. Esto es, justamente, un agujero negro para mandar al vacío cualquier valor que no usemos.

Además, le pediremos que calcule solamente la llamada al método `@org.openjdk.jmh.annotations.Mode.SingleShotTime` y que mida por milisegundos `@java.util.concurrent.TimeUnit.MILLISECONDS`, aunque también se puede poner hasta en nanosegundos, ya que una instanciación de objeto es bien minúscula

```java
@Benchmark
    @BenchmarkMode(Mode.SingleShotTime)
    @OutputTimeUnit(TimeUnit.MILLISECONDS)
    public void personaEdad(Blackhole bh) {
        Persona p = new Empleado("Ann", 15);
        bh.consume(p.getEdad());
    }

    @Benchmark
    @BenchmarkMode(Mode.SingleShotTime)
    @OutputTimeUnit(TimeUnit.MILLISECONDS)
    public void empleadoEdad(Blackhole bh) {
        Empleado p = new Empleado("Ann", 15);
        bh.consume(p.getEdad());
    }

    @Benchmark
    @BenchmarkMode(Mode.SingleShotTime)
    @OutputTimeUnit(TimeUnit.MILLISECONDS)
    public void vecinoEdad(Blackhole bh) {
        Vecino p = new Vecino("Ann", 15);
        bh.consume(p.getEdad());
    }
```

El resultado es interesante:

```java
Benchmark                 Mode  Cnt  Score   Error  Units
MyBenchmark.empleadoEdad    ss   10  0,049 ± 0,007  ms/op
MyBenchmark.personaEdad     ss   10  0,050 ± 0,007  ms/op
MyBenchmark.vecinoEdad      ss   10  0,230 ± 0,004  ms/op
```

Esto quiere decir que llamar al método heredado (es decir, un método que no está declarado en la misma clase) como es el caso de la clase `Vecino` es más lento que llamar al método que sí está declarado. Tanto la clase `Empleado` como `Persona` tienen el método declarado allí mismo, aún cuando el contenido se trate de una llamada a `super.`... interesante, muy interesante.

## ¿Más pruebas?

Sí, hay mucho más tipos de mediciones, incluso para llamadas a `@EJB` y demás. Será motivo para hacer otro post, o publicarlo en OTN.

## Bibliografía

Para este post me base de estas páginas:

- JMH - Java Microbenchmark Harness
[http://tutorials.jenkov.com/java-performance/jmh.html](http://tutorials.jenkov.com/java-performance/jmh.html)

- Using JMH for Java Microbenchmarking
[http://nitschinger.at/Using-JMH-for-Java-Microbenchmarking](http://nitschinger.at/Using-JMH-for-Java-Microbenchmarking)

- Introduction to JMH
[http://java-performance.info/jmh/](http://java-performance.info/jmh/)

- JMH: How to setup and run a JMH benchmark
[http://www.javacodegeeks.com/2015/02/jmh-setup-run-jmh-benchmark.html](http://www.javacodegeeks.com/2015/02/jmh-setup-run-jmh-benchmark.html)

- Java 9 Code Tools: A Hands-on Session with the Java Microbenchmarking Harness
[http://blog.takipi.com/java-9-code-tools-a-hands-on-session-with-the-java-microbenchmarking-harness/](http://blog.takipi.com/java-9-code-tools-a-hands-on-session-with-the-java-microbenchmarking-harness/)
