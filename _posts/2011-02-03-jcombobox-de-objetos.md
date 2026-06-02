---
layout: post
title: "JComboBox de Objetos"
date: 2011-02-03T18:48:00Z
last_modified_at: 2011-02-03T18:48:19.932Z
author: "Diego Silva Límaco"
permalink: /2011/02/jcombobox-de-objetos.html
canonical_url: https://www.apuntesdejava.com/2011/02/jcombobox-de-objetos.html
tags:
  - "swing"
  - "java"
  - "tips"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimaqbYmU_Xfzc2X-4K_x1Non6_1pVO5CftXqL-aDeRHSBDUKsFKw9esQEkymwKKWCeiJKO3lMCXqnhxv-2a1lGE0wpGXWC0jLVu2S6Nd0tPK863I66eZJrEf4JEsxbeG8KhGNRj03zC58/s1600/java+swing+gui.gif)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimaqbYmU_Xfzc2X-4K_x1Non6_1pVO5CftXqL-aDeRHSBDUKsFKw9esQEkymwKKWCeiJKO3lMCXqnhxv-2a1lGE0wpGXWC0jLVu2S6Nd0tPK863I66eZJrEf4JEsxbeG8KhGNRj03zC58/s1600/java+swing+gui.gif)

Cuando se usa Swing, el problema más común es mostrar elementos en un JComboBox. Lo que "normalmente" hacen es agregar cadenas a los elementos del JCB (JComboBox), pero para obtener el elemento seleccionado, se obtendría solo el valor puestos. Algunos hasta colocan el ID del elemento a mostrar, y luego buscan el elemento seleccionado en la colección. Toda una jarana... pero ¿han notado que para obtener el elemento seleccionado se utiliza el método `getSelectedItem()` que devuelve un objeto? Si debería mostrar String, entonces, debería devolver un String, ¿cierto? En este post explicaremos como utilizar correctamente el JCB.

Bien, supongamos que tenemos la clase `Persona` como el que sigue:

```java
<code>//...
public class Persona {

    private int idPersona;
    private String nombre;
    private int edad;

    public Persona() {
    }

    public Persona(int idPersona, String nombre, int edad) {
        this.idPersona = idPersona;
        this.nombre = nombre;
        this.edad = edad;
    }
//.. sus get y sets
//...</code>
```

Y lo tenemos en una colección, o un arreglo, con elementos.. así:

```java
<code>//...
        Persona[] personas=new Persona[]{
            new Persona(10, "Albert", 20),
            new Persona(15, "Bernard", 21),
            new Persona(20, "Carl", 22),
        };
//...</code>
```

Ahora, para crear un JCB con estos elementos, la manera rápida es así: pasando el arreglo como constructor:

```java
<code>//...
personasCB = new JComboBox(personas);
//...</code>
```

Pueden usar cualquier forma, como addItem(), pero lo que quiero dejar en claro, es que no se agregan String, sino los mismos objetos.

Ahora, para obtener el objeto seleccionado, bastará con hacer esto:

```java
<code>//...
Persona p = (Persona) personasCB.getSelectedItem();
//...</code>
```

Y listo!!!

**Un momento, pero los elementos del combo me parecen cosas raras!! quiero que me devuelvan mi dinero!**

Aún no terminé de explicar. El JCB convierte cada elemento del arreglo a String, si ponemos un arreglo de Long, lo vuelve a arreglo de String, un Double lo vuelve String.. y un objeto Persona también lo vuelve a String.

¿Sabes dónde se tiene que indicar como debe ser convertido a String un Objeto?

Respuesta: redefine el método `toString()` que es heredado de la clase Object... es decir, sobreescribimos el método toString() de la clase `Persona`.

```java
<code>//...
public class Persona {

    private int idPersona;
    private String nombre;
    private int edad;
//...
    @Override
    public String toString() {
        return nombre;
    }

}
//...</code>
```

Si quieres que aparezca con ID, cambia lo que devuelve el método toString.. si quiers un formato especial.. igual.. todo es en el método `toString()`

El código fuente de este ejemplo se puede obtener de aquí:

[http://java.net/projects/apuntes/downloads/download/Swing%252FJComboBoxObjetos.tar.gz](http://java.net/projects/apuntes/downloads/download/Swing%252FJComboBoxObjetos.tar.gz)
