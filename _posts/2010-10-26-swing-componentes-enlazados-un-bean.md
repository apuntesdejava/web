---
layout: post
title: "Swing: Componentes enlazados a un bean"
date: 2010-10-26T05:00:00.074Z
last_modified_at: 2010-11-04T17:58:56.618Z
author: "Diego Silva"
permalink: /2010/10/swing-componentes-enlazados-un-bean.html
canonical_url: https://www.apuntesdejava.com/2010/10/swing-componentes-enlazados-un-bean.html
tags:
  - "swing"
  - "java"
  - "netbeans"
  - "tips"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBkJ2P_Eu__q7HtwqCz2gKZReaxCfvpQ1LR39VRa4bj1d2qGKii3mbzJaqWA3FtW97Ill291mz7Me-v96Tftt4s2gfHu1fKRME4IcPzwRop-w2XnWGitpri8GV8LMTEYF_qgL833aMHWr_/s1600/java_beans.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBkJ2P_Eu__q7HtwqCz2gKZReaxCfvpQ1LR39VRa4bj1d2qGKii3mbzJaqWA3FtW97Ill291mz7Me-v96Tftt4s2gfHu1fKRME4IcPzwRop-w2XnWGitpri8GV8LMTEYF_qgL833aMHWr_/s1600/java_beans.jpg)

La mejor manera de tener sincronizado un control swing con un javabean es utilizando enlaces (binding). La manera común y poco profesional es utilizar los set  y gets de cada atributo de un bean para asociar a cada componente.

```java
<code>//...
nombreTF.setValue(persona.getNombre());
edadTF.setValue(persona.getEdad());
//... etc</code>
```

y si son 80 campos, nadie querra hacerle mantenimiento.

Aquí es donde entran los enlaces. Mostraremos un ejemplo con NetBeans para enlazar los componentes de un formulario con un JavaBean.

Este tip es aporte de Fernando Rodelo Mármol, seguidor de este blog, y amigo.

## Creando el JavaBean

Primero debemos crear una clase Java. La llamaremos `Persona`.

Luego, crearemos tres propiedades llamadas `nombre`, `edad` y `sexo`. Pero lo haremos utilizando NetBeans de la siguiente manera.

- Clic derecho sobre el código del editor, justo dentro de la clase `Persona` y seleccionar "Insert code"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh5H0xKBGM5EuUfAFqDX0NaYFJBXcJOQns2_DpwYCNF4YXEEUA1S2JeyRUU5T2FKT4HGAnZ426McHmJph3epU18KUuv_OErr6R5_SFlXpHoriOGFfB-9PBqKInf6XScYEcV4PuIe7gZX65L/s320/props-swing01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh5H0xKBGM5EuUfAFqDX0NaYFJBXcJOQns2_DpwYCNF4YXEEUA1S2JeyRUU5T2FKT4HGAnZ426McHmJph3epU18KUuv_OErr6R5_SFlXpHoriOGFfB-9PBqKInf6XScYEcV4PuIe7gZX65L/s1600/props-swing01.jpg)

- Seleccionar "Add property".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhzmMNQh6pNjLoFhuh81sXa2WywknCNEjNc_MI8MzmJKmLZui2mIk00_xvaGmFPvq7xuZE_9ZRRCR9ZAtPnv-gQExxCcvZq9xA_5XMjzRqTk_tDV3ORku5K_wu_GwvYLUD0Pd3AkDdY1Wym/s1600/props-swing02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhzmMNQh6pNjLoFhuh81sXa2WywknCNEjNc_MI8MzmJKmLZui2mIk00_xvaGmFPvq7xuZE_9ZRRCR9ZAtPnv-gQExxCcvZq9xA_5XMjzRqTk_tDV3ORku5K_wu_GwvYLUD0Pd3AkDdY1Wym/s1600/props-swing02.jpg)

- Con esto se mostrará un editor para crear una nueva propiedad, al cual haremos los siguientes cambios

- En el campo **name** escribimos el nombre de la nueva propiedad: nombre

- En el campo **type** indicamos el tipo de la propiedad: String

- Activamos la opción "Bound". En ese momento se mostrará el campo la declaración de una constante llamada `PROP_NOMBRE` con el valor "nombre". Esto es para asociar la variable "nombre" con el escuchador (listener) del JavaBean.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDz7cbaWW-nTz64yIbF1n97MR-Ko3sP0W7WO3fNXCZIVKtIs4lmdTLcIwEsM_3oiKQODqTkfCMbLTtRmeEZnnLOcB_FkHHKj5-xUnOg-LkXFK2ABY6xId3xP07HDirWqOLigvjjjo1yv80/s400/props-swing03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDz7cbaWW-nTz64yIbF1n97MR-Ko3sP0W7WO3fNXCZIVKtIs4lmdTLcIwEsM_3oiKQODqTkfCMbLTtRmeEZnnLOcB_FkHHKj5-xUnOg-LkXFK2ABY6xId3xP07HDirWqOLigvjjjo1yv80/s1600/props-swing03.jpg)

- Clic en "ok" para aceptar esta propiedad. Repetir la misma operación con los demás campos.

Para el caso de la propiedad "sexo", consideremos utilizar dos propiedades de tipo boolean llamadas "hombre" y "mujer".

Veamos el código generado. De no existir el IDE, deberiamos escribir todo el código. Bastante ¿no?

## Enlazando JavaBean con formulario swing

Ahora que ya tenemos el JavaBean con su respectivo manejador de cambios de propiedades, debemos crear en el formulario swing una propiedad de tipo Persona. Además, esta propiedad debe tener sus respectivos get/set.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEguEMMpVYC5R0OGM57lhryYKCuae_8mCXN-vwVaiJ4KzzczXT16YTyV8D6UMv5VeRYM9A3e6ikV95cRyj35xxUhdBvPswbLICNKOc97pwmcXxukcPKyA8xLZVKN6gbZNkEvPi1l0B1b8PkU/s320/swing-listener00.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEguEMMpVYC5R0OGM57lhryYKCuae_8mCXN-vwVaiJ4KzzczXT16YTyV8D6UMv5VeRYM9A3e6ikV95cRyj35xxUhdBvPswbLICNKOc97pwmcXxukcPKyA8xLZVKN6gbZNkEvPi1l0B1b8PkU/s1600/swing-listener00.jpg)

En el panel de diseño del formulario vamos a enlazar cada control con cada propiedad de la propiedad persona.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgF_CvkUpCryx1wD8llQRGLJwwU-G0oksdAheSZgx2DvTidfnFEORnMa0DA-ss1qOpRhyphenhyphenxKfaPI_DkoxEqKDte4KbFVoX2qProVqtVlAGB554utDHfxk_2kzRR2jMBu0595YPM2HGu9a5Wv/s400/swing-listener01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgF_CvkUpCryx1wD8llQRGLJwwU-G0oksdAheSZgx2DvTidfnFEORnMa0DA-ss1qOpRhyphenhyphenxKfaPI_DkoxEqKDte4KbFVoX2qProVqtVlAGB554utDHfxk_2kzRR2jMBu0595YPM2HGu9a5Wv/s1600/swing-listener01.jpg)

Hacemos clic-derecho en el control donde irá el nombre, y seleccionamos "bind > Text" que significa "enlazar el texto del control"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjaddHbG1mMJQDAKxq53DztG3XIgNTUCLOcapGss6GxUq9cX_4mpsX_1oUdx40BsvR3qKl5XrD1Pu3E1tEOFM38a9R7K_E65KlNTiU7dBRE_2SzdN2TmzOrHb8IZEfJLm9HRn4Eiltjzh9s/s400/swing-listener02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjaddHbG1mMJQDAKxq53DztG3XIgNTUCLOcapGss6GxUq9cX_4mpsX_1oUdx40BsvR3qKl5XrD1Pu3E1tEOFM38a9R7K_E65KlNTiU7dBRE_2SzdN2TmzOrHb8IZEfJLm9HRn4Eiltjzh9s/s1600/swing-listener02.jpg)

El IDE nos mostrará una ventana de diálogo para configurar el enlace del control. Aquí primero seleccionamos en la opción "Binding Source" de dónde se va a tomar el campo a enlazar. Como hemos declarado nuestra propiedad "persona" dentro del formulario, entonces seleccionamos "Form"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh9Izx7gU8h8Lp8Q_vxkNP3ckDeBJakdBn1nGK3_0iWgl6Y4KhIXBveF8l7WhiO00WMo14Mvmze1bZhJHh6Bxy-HkCnUJaMWExQb9aNIHybReY2rbD5cAtbyECf2J83b_4GLhuMJf9I75eZ/s400/swing-listener03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh9Izx7gU8h8Lp8Q_vxkNP3ckDeBJakdBn1nGK3_0iWgl6Y4KhIXBveF8l7WhiO00WMo14Mvmze1bZhJHh6Bxy-HkCnUJaMWExQb9aNIHybReY2rbD5cAtbyECf2J83b_4GLhuMJf9I75eZ/s1600/swing-listener03.jpg)

En la parte inferior se mostrará un listado de los componentes del formulario. Buscamos a "persona", abrimos el nodo y seleccionamos (en este caso) la propiedad "nombre".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgqTzvYWTxnp3KzpJdqw3enVTMa0LHSYYV-yDeF-ysIVCNFJroddML-TN8J7bhokhJbo5OI98euPN5QHhvhMjUbE9S55n2C0OvqPCPDe50DLV8tPxrYAO_PzEn4p3BhFv8aXVQAsnCZXjk6/s400/swing-listener04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgqTzvYWTxnp3KzpJdqw3enVTMa0LHSYYV-yDeF-ysIVCNFJroddML-TN8J7bhokhJbo5OI98euPN5QHhvhMjUbE9S55n2C0OvqPCPDe50DLV8tPxrYAO_PzEn4p3BhFv8aXVQAsnCZXjk6/s1600/swing-listener04.jpg)

Hacemos clic en "OK" y repetimos la acción en las demás propiedades.

Es importante recalcar que la propiedad del JavaBean debe tener el mismo tipo del que maneja el control. El tipo de control lo podemos ver en la parte superior de la ventana de diálogo. Por ejemplo, el del JTextField dice "Bind property **text **(*java.lang.String*) to:"

## Probando guardar el JavaBean

Ahora, cada vez que escribamos algo en los controles, se guardarán directamente en el JavaBean. ¿No me creen? Bueno, hagamos la siguiente prueba: después de escribir los valores, guardemos los valores del JavaBean en un archivo XML.

Para ello, programaremos el siguiente código en el botón "Guardar".

```java
<code>
XMLEncoder encoder = new XMLEncoder(
                         new BufferedOutputStream(
                             new FileOutputStream(ARCHIVO_XML)));
encoder.writeObject(persona);
encoder.close();

</code>
```

Donde la variable `ARCHIVO_XML` es un String que contiene el nombre del archivo a guardar.

Ahora, hagamos la prueba: llenemos el formulario, y hagamos clic en Guardar.

Y veamos el archivo XML que guardó.

Usé el [XMLEncoder](http://download.oracle.com/javase/6/docs/api/java/beans/XMLEncoder.html) para evitar todo un manejo de base de datos para este ejemplo.

## Probando mostrar controles actualizados

Me dirán "ok Diego, ya sé que el bean está asociado a los controles.. escribo en el control y lo guarda en el JavaBean.. hice hasta  un debug y me funciona.. pero si modifico el JavaBean ¿cómo refresco el contenido de los controles? "

Bueno, esto es automático. Basta que se haga un cambio en el JavaBean Persona, los controles se actualizan automáticamente.

Hagamos esta prueba: en el botón "Nuevo" escribimos el siguiente código:

```java
<code>
persona.setNombre("");
persona.setEdad(0);
persona.setMujer(false);
persona.setHombre(false);
buttonGroup1.clearSelection();

</code>
```

Funciona...!!

**Nota**: no intentar hacer

```java
<code>persona=new Persona();</code>
```

porque se crearía otro objeto y el enlace con el control se pierde. Entonces, si hay 80 campos ¿tengo que hacer esto por todos los campos? Uhmm.... sí.

Cuando usamos enlaces (bindings) debemos considerar que el formulario tiene un objeto JavaBean asociado al mismo formulario... es como el "alma" del formulario.... funciona como el "objeto actual" del formulario. Lo que podemos hacer es usar una variable temporal para copiar sus valores al JavaBean del formulario. Así manejamos el temporal, creamos, alteramos etc.. pero solo le damos una copia de este temporal al JavaBean.

## Cargando el JavaBean guardado

Volviendo a nuestro ejemplo.. si ya hemos guardado el JavaBean en un XML, hemos cerrado y volvemos a ejecutar el formulario... y ahora queremos cargar lo que hemos guardado ¿qué hacemos? Bueno, usamos el [XMLDecoder](http://download.oracle.com/javase/6/docs/api/java/beans/XMLDecoder.html), cargamos el valor en un objeto temporal y copiamos los valores al JavaBean persona.

"Pero Diego.. ¿si son 80 campos?" Ok ok.. vamos a valernos de una biblioteca de [Apache Commons](http://commons.apache.org/) para copiar las propiedades de un objeto a otro. Esta biblioteca se llama [BeanUtils](http://commons.apache.org/beanutils/) y el método se llama [BeanUtils.copyProperties()](http://commons.apache.org/beanutils/v1.8.3/apidocs/org/apache/commons/beanutils/BeanUtils.html#copyProperties%28java.lang.Object,%20java.lang.Object%29).

```java
<code>
XMLDecoder decoder = new XMLDecoder(
                         new BufferedInputStream(
                             new FileInputStream(ARCHIVO_XML)));
Persona $persona = (Persona) decoder.readObject();
decoder.close();
BeanUtils.copyProperties(persona, $persona);

</code>
```

Ahora sí.. ya funciona....

¿Y para el botón "Nuevo"?.. lo mismo, solo que no cargaremos un XML, sino copiaremos las propiedades de un objeto nuevo.

```java
<code>
Persona $persona = new Persona();
BeanUtils.copyProperties(persona, $persona);
buttonGroup1.clearSelection();

</code>
```

## Proyecto de ejemplo

Y no iba a faltar el proyecto utilizado en este post.

[http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fswing%252FSwingListenerApp.tar.gz](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fswing%252FSwingListenerApp.tar.gz)

Espero que les sea de utilidad.
