---
layout: post
title: "Tutorial JSF 2.2 - Sesión 9: Lenguaje de expresiones"
date: 2014-10-27T22:59:00.001Z
last_modified_at: 2018-01-10T23:49:47.580Z
author: "Diego Silva Límaco"
permalink: /2014/10/tutorial-jsf-22-sesion-9-lenguaje-de.html
canonical_url: https://www.apuntesdejava.com/2014/10/tutorial-jsf-22-sesion-9-lenguaje-de.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "jsf 2.2"
---

[![Tutorial JSF 2.2 - Sesión 9: Lenguaje de expresiones](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQqvSkHQ9C3pbu6ERpO7C58172oXyB8AB7Uygs8F8DJIGFmM2Y1IWL-ui-siZfRnVtstM5H41q-qQRcQJiGZUCxjgqIA4KmFIuhoBdWKYKXPyJEY-RRti4YvqHKpVSXAqyjxrV6oeMDs8/s1600/mi+expresion.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQqvSkHQ9C3pbu6ERpO7C58172oXyB8AB7Uygs8F8DJIGFmM2Y1IWL-ui-siZfRnVtstM5H41q-qQRcQJiGZUCxjgqIA4KmFIuhoBdWKYKXPyJEY-RRti4YvqHKpVSXAqyjxrV6oeMDs8/s1600/mi+expresion.png)

Seguimos con nuestro recorrido por las características de JSF 2.2 . Esta vez veremos el Lenguaje de Expresiones, o también conocido como EL (Expression Language).

El EL es usado en varias tecnologías de JavaEE, tales como JSF, JSP y CDI. Además lo podemos encontrar en entornos stand-alone. Lo que veremos ahora solo es cuando se ejecuta en contenedores Java EE.

Las expresiones nos permite acceder a los datos de los componentes JavaBean. Como sabemos, un JavaBean (no confundir con Enterprise JavaBean) debe tener el siguiente formato:

- Las propiedades deben accederse usando los métodos con prefijo `set` para poner un valor y `get` para obtener un valor. Para los valores boolean se puede utilizar `get` o `is`, el resultado es el mismo.

- Después del prefijo, debe comenzar el nombre con mayúscula

- Los métodos `set` solo deben tener un único parámetro

- Los métodos `get` no deben tener ningún parámetro.

- Los métodos son `public`

Ejemplo:

```java
public void setNombre(String nombre){
 //...
}
public String getNombre(){
 //...
}
public boolean isActivo(){
  //...
}
```

Y para accederlo desde un EL, simplemente se utiliza el nombre sin el prefijo, pero comenzando con minúsculas

```java
<c:if test="#{sessionScope.persona.activo}">
   Hola #{sessionScope.persona.nombre}
...
</c:if>
```

Para abreviar, el EL proporciona una manera simple - usando expresiones - para realizar las siguientes tareas:

- Leer dinámicamente datos almacenados en los componentes JavaBeans, diversas estructuras de datos y objetos implícitos

- Escribir dinámicamente datos, tales como entradas de formularios a componentes JavaBeans.

- Invocar arbitrariamente métodos públicos y estáticos.

- Realizar operaciones aritméticas, lógicas y de cadena.

- Construir colecciones de objetos y realizar operaciones en colecciones.

### Sintaxis de evaluación de expresiones

Existen dos maneras para evaluar una expresión:

- De manera inmediata

- De manera diferida.

La manera inmediata se hace cuando se necesita que el valor del componente bean se escriba directamente cuando construye la página. Para ello se utiliza la sintaxis `${}`

```java
<c:out value="${persona.nombre}" />
```

La manera diferida se utiliza cuando el valor a obtener debe pasar por todo el ciclo de vida. Se pueden utilizar para:

- Leer y escribir datos

- Utilizar expresiones de método

```java
<h:inputText value="#{persona.nombre}" />
<h:outputText value="#{persona.calcularRenta(tasa.ingreso)}" />
```

### Referenciando expresiones

Para mostrar o manejar las expresiones de objetos, se hace simplemente (como se vió hasta ahora) con  la declaración tal cual

```java
#{persona.nombre}
```

también podemos invocar a la misma propiedad usando corchetes:

```java
#{persona["nombre"]}
```

Con esto, como podrás imaginar, podrías invocar a cada propiedad de una manera dinámica

```java
#{persona[campoActual]}
```

Donde `campoActual` es una variable de tipo String que contiene el nombre del campo a mostrar.

```java
#{ valor == objeto.campo }
```

Si tenemos una clase enum:

```java
public enum Estado {
   activo,enProceso,suspendido,terminado
}
```

.. también podemos invocarlo desde la expresión:

```java
#{ estado == estado.activo }
```

Los arreglos  también se pueden acceder usando un índice entre corchetes

```java
#{cliente.pedidos[1]}
```

También podemos manipular mapas (`java.util.Map`). Supongamos que la propiedad `pedidos` es un `java.util.Map` con el key de tipo String, y queremos acceder al pedido con key "teclado". Estas dos líneas hacen lo mismo:

```java
#{cliente.pedido["teclado"]}
#{cliente.pedido.teclado}
```

Es decir, manipula los maps como si fueran propiedades de un objeto.

#### Lambda

También podemos usar las expresiones Lambda. A pesar que son parte de Java SE 8, se pueden usar en expresiones EL de Java EE 7 con Java SE 7.

Para probar las expresiones lambda en Java SE debemos agregar la biblioteca respectiva a nuestro proyecto. Por ello - para efectos de este ejemplo - agregaremos la siguiente dependencia a nuestro proyecto Maven.

```java
<dependency>
            <groupId>org.glassfish</groupId>
            <artifactId>javax.el</artifactId>
            <version>[3.0-b03,)</version>
        </dependency>
        <dependency>
            <groupId>javax</groupId>
            <artifactId>javaee-api</artifactId>
            <version>7.0</version>
            <scope>provided</scope>
        </dependency>
```

Y usaremos el paquete `javax.el.*`. Para nuestro ejemplo usaremos el siguiente código:

```java
void eval(String input) {
        System.out.println("\n====");
        System.out.println("Cadena EL: " + input);
        Object ret = elp.eval(input); //aquí evaluamos el contenido
        System.out.println("Valor obtenido: " + ret);
    }
```

Las expresiones Lambda usan el operador flecha (`->`). Los identificadores que se encuentran a la izquierda del operador son llamados parámetros lambda. El cuerpo, que se encuentra a la derecha del operador, pueden ser expresiones EL. Los parámetros lambda pueden estar envueltos en signos de paréntesis, y pueden ser omitidos si solo tienen un parámetro.

```java
x -> x+1
(x,y) -> x + y
() -> 64
```

Las expresiones lambda pueden ser utilizadas como una función, y se pueden invocar inmediatamente:

```java
((x,y)-> x + y)(3,4)
```

.. e imprime 7

También se pueden usar en conjunción con un asignamiento, separados por un punto y coma (;)

```java
v = (x,y) -> x + y; v(3,4)
```

`v` es la función lambda creada, y después se invoca con `v(3,4)`

`
`

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj5w665AEUqkRvLxLZrlWtXSlfg0ykMz3szIoLQ-hFTmN70oTkjKcgr1WKB76VXwfXNxsyNQrAv-89nIJ3dlW07N5W_7prWCN6L227HuL2wUo-jjRXO0Ga4EypYu0kMNKKpQ4g4H4P-NzU/s1600/27-10-2014+05-27-33+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj5w665AEUqkRvLxLZrlWtXSlfg0ykMz3szIoLQ-hFTmN70oTkjKcgr1WKB76VXwfXNxsyNQrAv-89nIJ3dlW07N5W_7prWCN6L227HuL2wUo-jjRXO0Ga4EypYu0kMNKKpQ4g4H4P-NzU/s1600/27-10-2014+05-27-33+p.m..png)

`
`

### Operaciones con colecciones

EL permite operaciones de colecciones de objetos: conjuntos (set), listas y mapas. Permite la creación dinámica de colecciones de objetos, los cuales pueden ser manipulados por *streams *y *pipelines*.

Al igual que las expresiones lambda, las operaciones sobre colecciones de objetos son parte de Java SE 8, pero podemos usar estas expresiones EL en Java EE 7 sobre Java SE 7.

Veamos: así creamos un par de conjuntos (set):

```java
{1,2,3}
{"Ana","Beto","Carlos"}
```

Para construir una lista, es como sigue... además podemos hacer que una lista contenga diferentes tipos:

```java
["Abraham","Bart","Carl"]
[1,"dos",[tres,cuatro]]
```

Las variables `tres` y `cuatro` deben existir

```java
void run() {
        eval("nums={1,2,3}");
        eval("noms={'Ana','Beto','Carlos'}");
        eval("noms2=['Abraham','Bart','Carl']");
        eval("tres=3;cuatro='4'");
        eval("lista=['Abraham','Bart','Carl']");
        eval("lista2=[1,'dos',[tres,cuatro]]");

    }
```

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCiAgLmva4sXM1U84AcgSBTCe856DfXk0T8y0sRYTiMlhvCDZJpuc25QOtLz8SIrLCWZGv9wc1tgJ5ibUXmUF-F6fi7aUPiXKEXsC4_5bNz8VwuQ1SUQ-kbSDCzqo2SG8CPHYSrWVAkus/s1600/27-10-2014+05-33-14+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCiAgLmva4sXM1U84AcgSBTCe856DfXk0T8y0sRYTiMlhvCDZJpuc25QOtLz8SIrLCWZGv9wc1tgJ5ibUXmUF-F6fi7aUPiXKEXsC4_5bNz8VwuQ1SUQ-kbSDCzqo2SG8CPHYSrWVAkus/s1600/27-10-2014+05-33-14+p.m..png)

Ok, ok, he mostrado el EL en un Java SE, pero la idea es mostrar en un JSF. Aquí va el ejemplo. Primer código:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html">
    <h:head>
        <title>Ejemplos de EL</title>
    </h:head>
    <h:body>
        <h1>Ejemplos de EL</h1>
        ${lista= [512,128,65] }
    </h:body>
</html>
```

Y cuando se ejecuta, aparece...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSCMjkk4vtZdTlqOcKU3qa-LKdiyc73k-fKHQXV84gn4A4qFZJB8GO-qlwk2TfaWYJ8rJW9MlGeQILanMPSMwLPz09zGwXCKMfRc9Hu7_mMpSgAX6WSnsCY7g19A4GR31EAjmBb9LeqnM/s1600/27-10-2014+05-45-06+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSCMjkk4vtZdTlqOcKU3qa-LKdiyc73k-fKHQXV84gn4A4qFZJB8GO-qlwk2TfaWYJ8rJW9MlGeQILanMPSMwLPz09zGwXCKMfRc9Hu7_mMpSgAX6WSnsCY7g19A4GR31EAjmBb9LeqnM/s1600/27-10-2014+05-45-06+p.m..png)

Todo bien, todo normal. Ahora con la ayuda de nuestro super IDE NetBeans, a la variable que acabamos de crear vamos a ordenarlo. Vean qué pasa cuando escribimos el nombre de la variable `lista` seguido del punto (.)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhMc7VQ7suRaNPBHiPnFLFlwZcorztnFnhxvJlxmXHxU5aZq5XUnW1IoyQWm1EFWgX4Xt-6Nocf9oh2jizQOh8FRNe3E2lTvycyUGDH-x6JLrlG6oQjl03JJTt-VIgR8CR8pPDhACIp1MA/s1600/27-10-2014+05-47-24+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhMc7VQ7suRaNPBHiPnFLFlwZcorztnFnhxvJlxmXHxU5aZq5XUnW1IoyQWm1EFWgX4Xt-6Nocf9oh2jizQOh8FRNe3E2lTvycyUGDH-x6JLrlG6oQjl03JJTt-VIgR8CR8pPDhACIp1MA/s1600/27-10-2014+05-47-24+p.m..png)

Automáticamente, el IDE sabe que ese objeto es una lista y nos mostrará las propiedades de esa lista.... y de sus objetos

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgfSR-Sooawb-3AIfZylmG0DRAGiC8BfPUqUTgOWGv6S_MEqjVCKPJ4MXL1faqv9053QltnDUUTRv6v1tylvZUwHdhu5pWnFR-9brmN1tmipH3JcO4B9eITsiGXVCGpysdWxoLVWznE_qk/s1600/27-10-2014+05-48-38+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgfSR-Sooawb-3AIfZylmG0DRAGiC8BfPUqUTgOWGv6S_MEqjVCKPJ4MXL1faqv9053QltnDUUTRv6v1tylvZUwHdhu5pWnFR-9brmN1tmipH3JcO4B9eITsiGXVCGpysdWxoLVWznE_qk/s1600/27-10-2014+05-48-38+p.m..png)

Por tanto, ejecutamos el código:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html">
    <h:head>
        <title>Ejemplos de EL</title>
    </h:head>
    <h:body>
        <h1>Ejemplos de EL</h1>
        ${lista= [512,128,65].stream().sorted().toList() }
    </h:body>
</html>
```

Y el resultado es lo esperado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgpHyBbUc7uLvCcLPCAFfdC75sGCNyMBrFkN7ViJubVvZG85pGXZtlnkfT7gi0Tu851TEldgTFmLHlfSy5VSzpL8VKUik1knHOPCwivJfZFMyd1YhnnS_zezUci-TnX67BsA3r8bdONSZ8/s1600/27-10-2014+05-50-36+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgpHyBbUc7uLvCcLPCAFfdC75sGCNyMBrFkN7ViJubVvZG85pGXZtlnkfT7gi0Tu851TEldgTFmLHlfSy5VSzpL8VKUik1knHOPCwivJfZFMyd1YhnnS_zezUci-TnX67BsA3r8bdONSZ8/s1600/27-10-2014+05-50-36+p.m..png)

### Operadores

Son los clásicos que conocemos

- Aritméticos: `+, -, *, /, div, %, mod, -` (signo negativo)

- Concatenación de cadenas: `+=`

- Lógicos: `and, &&, or, ||, not, !`

- Relacional: `==, eq, !=, ne, <, lt, >, gt, <=, ge, >=, le`

- Si es vacío: El operador `empty` determina si una lista está vacía o un objeto es nulo

- Condicional: `A ? B : C` (Lo mismo que en Java SE)

- Lambda: `->`(ya lo conocemos)

- Asignación: `=`

- Punto y coma: `;`

En esta página podremos encontrar varios ejemplos de expresiones EL [http://docs.oracle.com/javaee/7/tutorial/doc/jsf-el007.htm](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-el007.htm)

### Bibliografía

Me basé en el siguiente tutorial [9 Expression Language](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-el.htm), y para más detalle sobre esta especificación, visitar la página del JSR 341 [http://www.jcp.org/en/jsr/detail?id=341](http://www.jcp.org/en/jsr/detail?id=341)

*Si te gustó, hazlo saber.. y si crees que es útil, compártelo. Es gratis*
