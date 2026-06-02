---
layout: post
title: "Comparable y Comparator"
date: 2009-04-25T17:42:00.003Z
last_modified_at: 2016-04-13T22:52:43.026Z
author: "Diego Silva"
permalink: /2009/04/comparable-y-comparator.html
canonical_url: https://www.apuntesdejava.com/2009/04/comparable-y-comparator.html
description: "Tenemos una lista de objetos como Persona, o Producto, pero necesitamos ordenarlo ¿Cómo lo hacemos?  Aquí veremos, en un pequeño tutorial, cómo ordenar colecciones en Java.  Olvídense del ordenamiento de búrbuja, quickSort... java lo tiene todo."
tags:
  - "java"
  - "tutorial"
---

[![Comparable y Comparator](https://docs.google.com/drawings/d/1zlLHDKY9_zpr6ply-Ej_nf32JZEEzftpSODHmV9KGug/pub?w=1054&h=1080)](https://docs.google.com/drawings/d/1zlLHDKY9_zpr6ply-Ej_nf32JZEEzftpSODHmV9KGug/pub?w=1054&h=1080)

Tenemos una lista de objetos como Persona, o Producto, pero necesitamos ordenarlo ¿Cómo lo hacemos?

Aquí veremos, en un pequeño tutorial, cómo ordenar colecciones en Java.

Olvídense del ordenamiento de búrbuja, quickSort... java lo tiene todo.

Una colección en Java puede tener sus elementos ordenados.

Consideremos el siguiente código:

```java
List<String> nombres=Arrays.asList("Carlos","Ana","Dionisio","Bernardo");
       System.out.println("lista original:"+nombres);

       Collections.sort(nombres);
       System.out.println("lista ordenada:"+nombres);
```

La función `Collections.sort()` nos ordena una lista cualquiera.

Ahora bien, consideremos el siguiente código, donde se agregan elementos a un conjunto (`java.util.Set`). El conjunto será uno ordenado de por sí, sin necesidad de llamar a un método en especial:

```java
Set<String> otrosNombres = new TreeSet<>();
        otrosNombres.add("Mario");
        otrosNombres.add("Fernando");
        otrosNombres.add("Omar");
        otrosNombres.add("Juana");

        System.out.println("conjunto ordenado:" + otrosNombres);
```

Funcionan correctamente, porque **cada elemento de las colecciones son comparables entre sí**.  Para que un objeto sea comparable, su clase debe implementar la interfaz `java.lang.Comparable`.

Esto quiere decir, que si queremos que una lista de objetos - o un conjunto - tenga sus elementos ordenados, y esos objetos son de una clase que hemos hecho, es necesario que nuestra clase implemente la interfaz `java.lang.Comparable`

Consideremos, entonces, una clase `Persona`, que tiene algunas propiedades:

```java
class Persona {

    private int idPersona;
    private String nombre;
    private java.util.Date fechaNacimiento;

    public Persona() {
    }

    public Persona(int idPersona, String nombre) {
        this.idPersona = idPersona;
        this.nombre = nombre;

    }

    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public java.util.Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(java.util.Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    @Override
    public String toString() {
        return String.format("persona{idPersona:%1s,nombre:%2s}", idPersona, nombre);
    }
}
```

Entonces, si queremos que **los objetos que al guardarse en una colección (`java.util.Set` o `java.util.List`) estén ordenados  por el campo nombre**, debemos (primero) implementar la interfaz `Comparable`.

```java
//...
class Persona implements Comparable<Persona> {
//...
```

Y Segundo, implementar su método de comparación, aquí es donde definimos qué campo vamos a utilizar para ordenar:

```java
//...
    @Override
    public int compareTo(Persona o) {
        return this.nombre.compareTo(o.nombre);
    }
//...
```

Ahora, cuando usemos una colección para ordenar, el ordenamiento será automático:

```java
Set<Persona> personas = new TreeSet<>();
        personas.add(new Persona(1, "Mario"));
        personas.add(new Persona(2, "Fernando"));
        personas.add(new Persona(3, "Omar"));
        personas.add(new Persona(4, "Juana"));

        System.out.println("conjunto ordenado de personas: " + personas);
```

Ahora, **siempre será ordenado por `nombre`.** Pero, ¿si en otro momento deseamos que sea ordenado por fecha de nacimiento u otro campo sin afectar el campo de ordenamiento predeterminado?

Para ello **debemos utilizar un comparador de elementos**. Un comparador es **una clase de apoyo que será utilizada para los métodos de ordenamiento**. Esto se logra implementando la interfaz `java.util.Comparator`

Para continuar con nuestro ejemplo, creemos la siguiente clase que implemente la interfaz mencionada

```java
class OrdenarPersonaPorId implements Comparator<Persona> {

    @Override
    public int compare(Persona o1, Persona o2) {
        return o1.getIdPersona() - o2.getIdPersona();
    }
}
```

El método `compare()` debe devolver lo siguiente:

<table class="table">
<tbody>
<tr><th>Condición</th><th>Valor que debe devolver</th></tr>
<tr><td>o1 &lt; o2</td><td>un número menor a cero</td></tr>
<tr><td>o1 == o2</td><td>cero</td></tr>
<tr><td>o1 &gt; o2</td><td>un mayor menor a cero</td></tr>
</tbody></table>

Ahora bien, para utilizar este comparador, debemos usar el parámetro adicional de `Collections.sort()`.

```java
List<Persona> otrasPersonas = Arrays.asList(new Persona(4, "Juana"),
                new Persona(2, "Fernando"),
                new Persona(1, "Mario"),
                new Persona(3, "Omar"));
        Collections.sort(otrasPersonas, new OrdenarPersonaPorId());
        System.out.println("lista de personas ordenadas por ID:" + otrasPersonas);
```

... o el  parámetro del constructor de `java.util.TreeSet`.

```java
Set<Persona> conjuntoPersonas = new TreeSet<>(new OrdenarPersonaPorId());
        conjuntoPersonas.add(new Persona(3, "Omar"));
        conjuntoPersonas.add(new Persona(4, "Juana"));
        conjuntoPersonas.add(new Persona(2, "Fernando"));
        conjuntoPersonas.add(new Persona(1, "Mario"));

        System.out.println("conjunto de personas ordenadas por ID:" + conjuntoPersonas);
```

El código completo para este ejemplo lo podemos ver aquí:
<script src="https://gist.github.com/apuntesdejava/3a5a56ccf4d9d7ea7f60.js"></script>

#### Facebook

<iframe src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1151592681518695&width=500" width="500" height="282" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>

#### Twitter

>

¿Cómo ordenar una colección [#Java](https://twitter.com/hashtag/Java?src=hash)?
Aquí un pequeño tutorial del uso de las interfaces Comparable y Comparator[https://t.co/L0oFRl21JU](https://t.co/L0oFRl21JU)

&mdash; Apuntes de Java (@apuntesdejava) [4 de abril de 2016](https://twitter.com/apuntesdejava/status/717003754520838144)

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
