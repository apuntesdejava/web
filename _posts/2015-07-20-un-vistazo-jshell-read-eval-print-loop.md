---
layout: post
title: "Un vistazo a jshell: Read Eval Print Loop (REPL)"
date: 2015-07-20T15:57:00Z
last_modified_at: 2015-09-15T14:30:31.697Z
author: "Diego Silva Límaco"
permalink: /2015/07/un-vistazo-jshell-read-eval-print-loop.html
canonical_url: https://www.apuntesdejava.com/2015/07/un-vistazo-jshell-read-eval-print-loop.html
tags:
  - "jshell"
  - "repl"
  - "java"
  - "java9"
---

[![Un vistazo a jshell: Read Eval Print Loop (REPL)]({{ '/assets/blogger/CJUGdsRVEAALzlm.jpg' | relative_url }})]({{ '/assets/blogger/CJUGdsRVEAALzlm.jpg' | relative_url }})

Una de las novísimas características que tendrá Java 9, es la de permitir evaluar expresiones Java pero como rutinas.

Me explico: Con JavaEE 7 se pueden crear cadenas y permitirlas evaluar y obtener resultados, pero con jshell, se podrán crear rutinas, con for, if, try/catch, import, etc y poderlas ejecutar como si fuera un Java dentro de otro java.

Existe una implementación de Java REPL (Read-Eval-Print Loop) llamada [Proyecto Kulla](http://openjdk.java.net/projects/kulla/).

Podemos ver una implementación en línea de este característica aquí mismo:

<iframe src="http://www.javarepl.com/embed.html" style="border: 0px; height: 350px; width: 720px;"></iframe>

Prueben haciendo las siguientes instrucciones:

```java
import java.util.*;

List<integer> lista=new ArrayList<>();
lista.add(100);
lista.add(200);
lista.add(021);
lista.stream().forEach((item) -> {
    System.out.println(item);
});

</integer>
```

También podemos crear funciones. Escribamos:

```java
double cubo(double x){
   return x*x*x;
}

double volumen(double radio){
  return 4.0 / 30 * PI * cubo(radio);
}

volumen(2); //el resultado aparecerá en pantalla
```

Esto fue un pequeño vistazo de jshell.
