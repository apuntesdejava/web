---
layout: post
title: "Compilando y ejecutando una clase java.... desde java"
date: 2010-10-19T05:00:00.005Z
last_modified_at: 2010-11-03T23:12:31.806Z
author: "Diego Silva"
permalink: /2010/10/compilando-y-ejecutando-una-clase-java.html
canonical_url: https://www.apuntesdejava.com/2010/10/compilando-y-ejecutando-una-clase-java.html
tags:
  - "java se6"
  - "java"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSbnhBfmQhoSyL2feTa0bbHu8MHNIjEzZlU68lFaV_E_7KT-I3uHWRf222MvYQH1YoeVNGOSK84Rh6BLas-y8VBZvqmQ2th3wNIVsLlJY5JPcdJtK2Eu-eGd2GlTUfcXKGNFSoqmtRGkgW/s1600/SwingingDuke.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSbnhBfmQhoSyL2feTa0bbHu8MHNIjEzZlU68lFaV_E_7KT-I3uHWRf222MvYQH1YoeVNGOSK84Rh6BLas-y8VBZvqmQ2th3wNIVsLlJY5JPcdJtK2Eu-eGd2GlTUfcXKGNFSoqmtRGkgW/s1600/SwingingDuke.png)

El JDK 6 viene con varias funcionalidades interesantes, entre ellas la compilación de clases java desde el mismo java.

La instancia que se encarga de tal tarea es [JavaCompiler](http://download.oracle.com/javase/6/docs/api/javax/tools/JavaCompiler.html) pero su instancia se obtiene desde el método [ToolProvider.getSystemJavaCompiler()](http://download.oracle.com/javase/6/docs/api/javax/tools/ToolProvider.html#getSystemJavaCompiler%28%29).

La compilación se resume a una simple instrucción:

```java
<code>JavaCompiler javaCompiler = ToolProvider.getSystemJavaCompiler();
int resultado = javaCompiler.run(null, null, null, "Factorial.java");
</code>
```

Hay más opciones de compilación, como por ejemplo obtener los errores de compilación, y compilación en memoria. Para más opciones de la clase, revisar el API de [javax.tools.JavaCompiler](http://download.oracle.com/javase/6/docs/api/javax/tools/JavaCompiler.html).

Ahora bien, ¿cómo se puede ejecutar una clase compilada? Pues se necesita cargarlo en la memoria del JVM. Fácil.... pero el reto es hacerlo en ejecución, ya que si no está en el classpath de la aplicación nunca se podrá ejecutar. Y como sabía que alguien me haría esta pregunta, hice aquí un ejemplo de ello: compilar y luego ejecutar el compilado.

Lo que hice fue redefinir el método `loadClass()` de la clase `[java.lang.ClassLoader](http://download.oracle.com/javase/6/docs/api/java/lang/ClassLoader.html)`, cargarlo en bytes el archivo binario .class y luego convertirlo en una clase java.

Aquí les dejo el ejemplo para que se diviertan un rato.

**Código ejemplo**

[http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fjdk%252FCompilandoJava.tar.gz](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fjdk%252FCompilandoJava.tar.gz)
