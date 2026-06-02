---
layout: post
title: "seleccionar / deseleccionar todos los checkbox (con JQuery)"
date: 2009-09-12T00:14:00.006Z
last_modified_at: 2009-10-07T22:29:54.689Z
author: "Diego Silva"
permalink: /2009/09/seleccionar-deseleccionar-todos-los.html
canonical_url: https://www.apuntesdejava.com/2009/09/seleccionar-deseleccionar-todos-los.html
tags:
  - "ajax"
  - "web"
  - "javascript"
  - "jquery"
---

[JQuery](http://docs.jquery.com/) es un framework en JavaScript que realmente hace maravillas.

Aparte de AJAX, la manera como maneja los objetos DOM es impresionante.

En este post haré un ejemplo de cómo marcar varios  checkbox usando otro checkbox (check all), y si se desmarca este checkbox, todos los checkbox se desmarcan... y cómo bonus, si se marcan todos los checks uno por uno, el checkbox general se marcará automáticamente.

A medida que desarrollaré el ejemplo, también explicaré cómo funciona JQuery.

Cómo obtener el JQuery

Hay dos maneras:

- descargándolo desde [http://jquery.com/](http://jquery.com/), y agregándolo a nuestro proyecto como un .js más (sólo pesa 55.9KB!)

- Usando el [API de Bibliotecas AJAX de Google](http://code.google.com/intl/es-ES/apis/ajaxlibs/).

Los pro/contra son

- Lo bueno que si se descarga el jquery y está integrado a nuestro proyecto,  tendremos la certeza de que está en nuestra aplicación. Lo malo es que si sale una nueva versión, tendremos que actualizarlo nosotros mismos, y revisar en todos los proyectos donde se utiliza.

- Lo bueno de usar el API de Google, es que siempre podemos tener la ultima versión ([o una versión específica si así lo queremos](http://code.google.com/intl/es-ES/apis/ajaxlibs/documentation/index.html)), ya no se formaría un cuello de botella para descargarlo desde nuestra aplicación hacia el cliente (aunque 55.9 KB no se sienten). Pero lo malo es que debemos asegurarnos que el usuario final tenga internet.

Para nuestro ejemplo, usaremos el API de Google. Porque si has podido leer este blog es porque tienes internet :).

Instalándolo en nuestra página

La instalación es fácil. Basta agregar un .js de Google, que se encuentra en la misma página de Google, y luego pedimos que cargue el framework jquery.

```java
<code class="prettyprint">        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("jquery", "1");

        </script>
</code>
```

Nuestro formulario

Ahora, debemos ver nuestro formulario que tendrá los checkboxes.

```java
<code class="prettyprint">        <input id="chk_all" type="checkbox"/>Marcar / desmarcar todos<br/>
        <hr/>
        <input id="chk1" name="chk1" type="checkbox"/> Opción 1<br/>
        <input id="chk2" name="chk2" type="checkbox"/> Opción 2<br/>
        <input id="chk3" name="chk3" type="checkbox"/> Opción 3<br/>
        <input id="chk4" name="chk4" type="checkbox"/> Opción 4<br/>
</code>
```

Notemos que los checks "dependientes" tienen el nombre chk1, chk2, etc. Es decir, tienen nombres parecidos, al igual que sus IDs.

**Importante:** se recomienda que cada tag que vamos a manipular, ya sea por jquery, otro framework javascript o javascript puro, debe **tener un ID único**. Esto será más fácil de manipular entre los objetos DOM de html. Ahora lo veremos.

Programando el "check all"

 También notemos que ningún checkbox tiene programado el onclick. Los eventos lo podemos agregar en grupo.

Ahora, el JQuery ya se está cargando... y es posible que nuestra página ya cargó pero el jquery aún no haya terminado de descargarse en el cliente (por la red, vamos). Así que Google nos da una biblioteca que permite ejecutar una función JavaScript solo cuando se ha terminado de cargar. Esta función se llama `google.setOnLoadCallback(fun)` y tiene como parámetro una función cualquiera.

```java
<code class="prettyprint">        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("jquery", "1");

            google.setOnLoadCallback(function(){ // se ejecuta cuando se cargó la biblioteca

            }
        </script>
</code>
```

La filosofía de JQuery es que se ejecutan consultas a manera de SQL, y lo que devuelve es un conjunto de objetos DOM que cumplen la consulta o un conjunto vacío. Luego, se puede aplicar modificaciones a ese conjunto de objetos, recorrer todos, tomar uno.. etc.

Volviendo al ejemplo, primero debemos obtener el objeto con id="chk_all". Por regla, para identificar un objeto por un ID se antepone el signo #, si se quiere seleccionar por sus clases, se antepone el punto (.) ¿Te recuerda a la hoja de estilos?

Para obtener el conjuno de objetos con id="chk_all" basta con hacer esto

```java
<code class="prettyprint">$("#chk_all")
</code>
```

Ahora, a todo este conjunto (que solo tiene un elemento) vamos a programar su evento onclick. Pero JQuery lo maneja usando el metodo [click()](http://docs.jquery.com/Events/click#fn).

```java
<code class="prettyprint">$("#chk_all").click(function(){
//esta es la funcion que se asignará al evento onclick() de los objetos de la consulta
})
</code>
```

Ahora, necesitamos obtener todos los input del html.

```java
<code class="prettyprint">var chks=$("input");
</code>
```

Pero, no, queremos ser más específicos, porque pueden haber hasta input-text. Así que lo filtramos solo los [checkbox](http://docs.jquery.com/Selectors/checkbox).

```java
<code class="prettyprint">var chks=$("input:checkbox");
</code>
```

Uhm, necesitamos ser más específicos... solo queremos los que su[nombre comience con "chk"](http://docs.jquery.com/Selectors/attributeStartsWith#attributevalue)

```java
<code class="prettyprint">var chks=$("input:checkbox[name^='chk']");
</code>
```

Bien, ya lo tenemos en una variable chks. Se puede omitir, pero mejor así para saber qué le hacemos.

Ahora, debemos modificar el [atributo](http://docs.jquery.com/Attributes/attr#keyvalue)"checked" de todos estos objetos y ponerlo en **true** si el "check_all" está seleccionado, y **false** si no lo está.

Recordemos que aún estamos dentro del evento click() del conjunto de un elemento #chk_all. Así que podemos acceder a las propiedades de los elementos del conjunto usando la palabra reservada "this".

```java
<code class="prettyprint">chks.attr("checked",this.checked)
</code>
```

Lo malo es que si ese atributo no existe (por algun problema de versión de navegador o quizás un error en la programación nos olvidamos qué objeto estamos manipulando), podría lanzar un error de javascript de que ese atributo no existe.

Pero podemos usar la función [$](http://docs.jquery.com/%24) para manejar el objeto this como si fuera un objeto jquery.

Al usar la función JQuery ($) nos da una gama increible de funciones que nos hace la vida de programador más fácil. En este caso, si queremos saber si el atributo checked está activado (y si no existe el atributo, no devuelve nada) podemos usar una funcion llamada [is()](http://docs.jquery.com/Is) y poner como argumento si coincide con el atributo [checked](http://docs.jquery.com/Selectors/checked). Devolverá true si está checked y false si no lo está.

```java
<code class="prettyprint">chks.attr("checked",$(this).is(":checked"))
</code>
```

Por tanto, nuestro código final será el siguiente:

```java
<code class="prettyprint">        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("jquery", "1");

            google.setOnLoadCallback(function(){ // se ejecuta cuando se cargó la biblioteca
                $("#chk_all").click(function(){ //aplica en el evento onclick a todos los objetos de la consulta
                    var chks=$("input:checkbox[name^='chk']"); //obtiene todos los objetos checkbox con nombre chk
                    chks.attr("checked",$(this).is(":checked")) //a TODOS los objetos obtenidos, lo marca si esta marcado el #chk_all
                })
            }
            }
        </script>
</code>
```

Es más, la función attr() se puede aplicar sobre el mismo conjunto de objetos jquery.

```java
<code class="prettyprint">$("input:checkbox[name^='chk']").attr("checked",$(this).is(":checked"))
</code>
```

Ahi hace todo en una sola fila: selecciona los checkboxes con nombre que comience con "chk", y les modifica el atributo "checked" dependiendo si el check_all esta seleccionado o no.

Que se marque el "check all"  si todos los checks se marcan uno por uno.

Esta opción es la más interesante: si el usuario marca uno por los checks y logra marcar todos, el "check all" se debe activar, y si basta que uno check no esté marcado, se tiene que desactivar el "check all".

Para ello, debemos asignarle una función en el evento onclick() de todos los checkboxes con name^="chk"

Primero, debemos seleccionarlos

```java
<code class="prettyprint">$("input[name^='chk']").click(function(){
//aqui se pone la funcion para todos los check boxes.
})
</code>
```

Haremos una formula simple: obtendremos todos los checkboxes existentes, y luego los que checkboxes que estén seleccionados.

```java
<code class="prettyprint">$("input[name^='chk']").click(function(){
   var todos=$("input:checkbox[name^='chk']")
   var activos=$("input:checked[name^='chk']")

})
</code>
```

Si tienen la misma cantidad, entonces activamos el #check_all

```java
<code class="prettyprint">    $("#chk_all").attr("checked",todos.length==activos.length)
</code>
```

Y listo.

El código completo:

Y aquí, el código completo

```java
<code class="prettyprint"><html>
    <head>
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("jquery", "1");
            google.setOnLoadCallback(function(){
                $("#chk_all").click(function(){
                    var chks=$("input:checkbox[name^='chk']");
                    chks.attr("checked",$(this).is(":checked"))
                })
                $("input[name^='chk']").click(function(){
                    var todos=$("input:checkbox[name^='chk']")
                    var activos=$("input:checked[name^='chk']")
                    $("#chk_all").attr("checked",todos.length==activos.length)
                })
            })
        </script>
    </head>
    <body>
        <input id="chk_all" type="checkbox"/>Marcar / desmarcar todos<br/>
        <hr/>
        <input id="chk1" name="chk1" type="checkbox"/> Opción 1<br/>
        <input id="chk2" name="chk2" type="checkbox"/> Opción 2<br/>
        <input id="chk3" name="chk3" type="checkbox"/> Opción 3<br/>
        <input id="chk4" name="chk4" type="checkbox"/> Opción 4<br/>
    </body>
</html>
</code>
```

No tomó ni dos líneas para estas funcionalidades.

Si deseas descargar este ejemplo ya hecho, haz [clic aquí](http://diesil-java.googlecode.com/files/demo-jquery%28checks%29.html).

Salve JQuery :)

y aquí, en caliente:

Marcar / desmarcar todos

 Opción 1

 Opción 2

 Opción 3

 Opción 4

<script type="text/javascript">
$("#demo_jquery").ready(function(){
 $("#chk_all").click(function(){
                    var chks=$("input:checkbox[name^='chk']");
                    chks.attr("checked",$(this).is(":checked"))
                })
                $("input[name^='chk']").click(function(){
                    var todos=$("input:checkbox[name^='chk']")
                    var activos=$("input:checked[name^='chk']")
                    $("#chk_all").attr("checked",todos.length==activos.length)
                })
})
</script>
