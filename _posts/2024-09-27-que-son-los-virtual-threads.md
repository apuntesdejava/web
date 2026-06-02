---
layout: post
title: "¿Qué son los Virtual Threads ?"
date: 2024-09-27T21:16:00.004Z
last_modified_at: 2024-09-27T21:30:59.950Z
author: "Diego Silva Límaco"
permalink: /2024/09/que-son-los-virtual-threads.html
canonical_url: https://www.apuntesdejava.com/2024/09/que-son-los-virtual-threads.html
description: "En este post trataré de explicar su definición, por qué deberíamos usarlos y cómo podríamos ir cambiando nuestros proyectos a los Virtual Threads."
tags:
  - "Threads"
  - "java"
  - "Java 19"
---

![](https://docs.google.com/drawings/d/e/2PACX-1vSmki-T5saRkjeE2c37K1onXlc5irF3ojHnFcryQypBGZsX2taKZj9IziNa8rnFlwmE9BPIxYyc7IuI/pub?w=1200&h=675)

Ya se ha leído "Virtual Threads" por aquí y por allá desde Java 19, pero
  ¿realmente, qué son?

  En este post trataré de explicar su definición, por qué deberíamos usarlos y
  cómo podríamos ir cambiando nuestros proyectos a los Virtual Threads.

Vamos a ello

## ¿Qué son los Virtual Threads?

  Para comenzar a definirlo, vamos a recordar lo que son los Threads o hilos en
  Java. ¿Recuerdas cuando hacíamos esto?

```java
public class ThreadsExaple {
  public static void main(String[] args) {
    Runnable task = new Runnable() {
      @Override
      public void run() {
        System.out.println("Hola, soy una tarea");
      }
    };

    new Thread(task).start();
  }
}
```

Qué, aplicando lambdas de Java 8, podemos reducirlo así

```java
public class ThreadsExaple {
  public static void main(String[] args) {
    Runnable task = () -> System.out.println("Hola, soy una tarea");

    new Thread(task).start();
  }
}
```

  Ahora, ¿qué sucede con este tipo de hilos? Lo que pasa es que estos hilos
  utiliza los procesos disponibles del Sistema Operativos. Es decir, van hasta
  la plataforma para poder ejecutarlos. Dependiendo de la disponibilidad del
  CPU, se ejecutan tantos hilos como se pidan. Entonces, tenemos una limitación
  a nivel de Sistema Operativo y hasta de Hardware. Este tipo de hilos se llama
  **Platform Threads**.

  Los **Virtual Threads** son una nueva implementación de hilos ligeros en
  Java, que permiten crear millones de ellos sin el coste de los tradicionales
  **Platform Threads** (hilos del sistema operativo).

### Diferencias clave:

-
    Platform Threads: Hilos tradicionales, pesados y limitados por el sistema
    operativo.

-
    Virtual Threads: Ligeros, gestionados por la JVM, y casi ilimitados en
    cantidad.

### Ejemplos básico de Virtual Thread

```java
public class ThreadsExaple {
  public static void main(String[] args) {

    //Platform Thread
    new Thread(() -> System.out.println("Hola, soy una tarea"))
      .start();

    //Virtual Thread Java 19+
    Thread.startVirtualThread(() ->
      System.out.println("Hola, soy un Virtual Thread")
    );

  }
}
```

## ¿Por qué usar Virtual Threads?

  Con los Virtual Threads, puedes manejar grandes volúmenes de tareas
  concurrentes sin preocuparte por los recursos del sistema. Esto es
  especialmente útil en aplicaciones de alto rendimiento, como servidores web o
  procesamiento paralelo masivo.

Ventajas clave:

- Escalabilidad: Millones de hilos simultáneos sin sobrecargar la CPU.

-
    Simplicidad: Puedes usar las mismas herramientas y APIs que con los Platform
    Threads, pero con mejor rendimiento.

-
    Reducción de Bloqueos: Al no depender tanto de los recursos del sistema, las
    operaciones bloqueantes afectan menos al rendimiento.

## Usando Virtual Threads

  Veamos cómo usar un Virtual Thread muy básico. Es decir, si antes usábamos los
  Threads clásicos, ahora deberíamos usar así:

```java
public class ThreadsExaple {
  public static void main(String[] args) {
    try {
      Thread.startVirtualThread(() -> {
          //Aquí ponemos el proceso que queremos que se ejecute de manera asíncrona
          System.out.println("Hola, soy un Virtual Thread");
        }
      ).join();
    } catch (InterruptedException e) {
      throw new RuntimeException(e);
    }

  }
}
```

  Ahora bien, si queremos usar un Pool de Virtual Threads (es decir, usando un
  `Executor`), usamos esta manera:

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class VirtualThreadPool {
  public static void main(String[] args) {
    // el método newVirtualThreadPerTaskExecutor es la novedad
    try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {

      for (int i = 0; i < 10; i++) {
        int taskId = i;
        executor.submit(() -> {
          System.out.println("Ejecutando tarea " + taskId);
        });
      }

      executor.shutdown();
    }
  }
}
```

## Mejoras en Java 21

Java 21 trae mejoras significativas en el manejo de Virtual Threads. Algunas de
las novedades incluyen:

- Optimización del scheduler de hilos.

- Mejoras en el soporte de depuración y perfiles.

-
    Compatibilidad con bibliotecas y frameworks populares (como Spring y
    Quarkus).

## Casos de uso reales

¿Dónde puedes aprovechar los Virtual Threads? Aquí algunos ejemplos:

- Servidores web: Manejo eficiente de miles de peticiones concurrentes.

-
    Procesamiento en segundo plano: Tareas como análisis de datos o indexación.

-
    Aplicaciones distribuidas: Manejo de múltiples tareas concurrentes sin
    saturar recursos del sistema.

## Conclusión

Los Virtual Threads son un cambio de juego en el mundo de la concurrencia en Java. Gracias a su naturaleza liviana y su compatibilidad con las herramientas actuales, puedes mejorar significativamente el rendimiento y escalabilidad de tus aplicaciones sin tener que reinventar la rueda.

¡Es momento de que empieces a experimentar con Virtual Threads en tu próximo proyecto!

## Llamado a la acción

Si te ha interesado este artículo, ¡no dudes en probar los Virtual Threads en tu propio código! Y si tienes dudas, deja un comentario abajo o ponte en contacto conmigo. ¡Estoy aquí para ayudarte!
