---
layout: post
title: "AJAX con DWR en NetBeans 6.1"
date: 2008-06-20T05:00:00Z
last_modified_at: 2009-04-25T21:55:03.363Z
author: "Diego Silva"
permalink: /2008/06/ajax-con-dwr-en-netbeans-61.html
canonical_url: https://www.apuntesdejava.com/2008/06/ajax-con-dwr-en-netbeans-61.html
tags:
  - "java"
  - "web"
  - "jpa"
  - "netbeans 6.1"
  - "netbeans"
  - "ajax"
---

Una de las bibliotecas más fáciles que he visto para programar en AJAX es el Direct Web Remoting - DWR.
En este post veremos algunas de sus características que nos ayudará a tener aplicaciones enriquecidas con ajax. Para ello usaremos:

- [NetBeans 6.1](http://download.netbeans.org/netbeans/6.1/final/)
- [DWR](http://getahead.org/dwr)

Si deseas saber lo que es AJAX, puedes revisar mi anterior post llamado (justamente) [AJAX](http://diesil-java.blogspot.com/2006/04/ajax.html).

## Instalando DWR en NetBeans

 La biblioteca  DWR consta únicamente de un archivo .jar. Este lo podemos descargar de aquí: [http://getahead.org/dwr/download.](http://getahead.org/dwr/download)  A la fecha de este post la versión del DWR es la 2.0.4.

Guardaremos el archivo en una carpeta que será destinada para las bibliotecas de los proyectos. Yo, en Windows, lo guardo en d:\proys\lib\DWR, y en Linux lo guardo en ~/proys/lib

Adicionalmente DWR necesita de la biblioteca commons-logging. Esta la puedes descargar de aquí:  [http://commons.apache.org/downloads/download_logging.cgi](http://commons.apache.org/downloads/download_logging.cgi)

Descomprimamos el archivo descargado de commons-logging en la misma carpeta lib.

Entramos a la opción Tools > Libraries:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi25mIY6WS7Oe7IGAodpI7QrTyCELqaeBTGjT9bZ8KO22WbBe2XdTtMJ0XnX-5uNVRuQiSm2RbiD7ll3SVr1oZ3jqZc30Zz2Or0uOFGY_zMD2to4LWb0qysc2db4rDYoO2O_1cKrTNjsDCh/s320/Pantallazo-Library+Manager.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi25mIY6WS7Oe7IGAodpI7QrTyCELqaeBTGjT9bZ8KO22WbBe2XdTtMJ0XnX-5uNVRuQiSm2RbiD7ll3SVr1oZ3jqZc30Zz2Or0uOFGY_zMD2to4LWb0qysc2db4rDYoO2O_1cKrTNjsDCh/s1600-h/Pantallazo-Library+Manager.png)
Hacemos clic en "New Library" para crear una nueva biblioteca, y llamaremos DWR.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgqj8Nh7tdHW57pBLrA2kCGa28Lr_dibre8Hgu4sGaAb39Ns1Em1pft_HdtdzitqOt1t4EPSAzr3IQu6VMz6MONOe6EJPAd4X2vJIEIOgDzhEkHKq4QRKbBckkkAMh1sqx7u9yVhWu_Msok/s320/Pantallazo-New+Library.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgqj8Nh7tdHW57pBLrA2kCGa28Lr_dibre8Hgu4sGaAb39Ns1Em1pft_HdtdzitqOt1t4EPSAzr3IQu6VMz6MONOe6EJPAd4X2vJIEIOgDzhEkHKq4QRKbBckkkAMh1sqx7u9yVhWu_Msok/s1600-h/Pantallazo-New+Library.png)Clic en OK. Ahora agregamos los archivos .jar correspondientes. Hacemos clic en Add Jar/Folder y seleccionamos el archivo commons-logging-1.1.1.jar y dwr.jar

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjpMIKMuMO9CLVBE8-1eR4wbePe3SJrNHvFfiyKjScl1avN7LDizRVRG8tNjr2i2_bveRIdPtGw4DP3iZY_pe4Wv5F1FarCYhhVbxOelH3UBI8inInNI2WEyXgX7K54XV66eBjLoSwrVp6/s320/Pantallazo-Library+Manager-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjpMIKMuMO9CLVBE8-1eR4wbePe3SJrNHvFfiyKjScl1avN7LDizRVRG8tNjr2i2_bveRIdPtGw4DP3iZY_pe4Wv5F1FarCYhhVbxOelH3UBI8inInNI2WEyXgX7K54XV66eBjLoSwrVp6/s1600-h/Pantallazo-Library+Manager-1.png)Clic en OK parar cerrar la ventana.

## El proyecto Web

 Ahora crearemos un aplicación web, que no usará ningún framework. Será una aplicación totalmente "simple". La llamaremos DwrSamples.

En las propiedades del proyecto web creado, entramos a sus propiedades haciendo clic derecho sobre el ícono del proyecto, y seleccionamos"Properties". En esta ventana seleccionamos del margen izquierdo la categoría "Libraries". Luego agregamos la biblioteca DWR haciendo clic en el botón "Add Library". Después de esto, deberá lucir así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRqiqp2SNXkhWLmI9fmmkJnTKrQylrOdywREo6fQaztrTLNnPtTa_bcR7lqUIBa3Yu_J0JBwidibE7Wk3Ev9ckJLN-9-tyDEN64XEOVKdlBZHrxv6WecEFUBGgntWn_-H_PZe_CpncDzH0/s320/Pantallazo-Project+Properties+-+DwrSamples.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRqiqp2SNXkhWLmI9fmmkJnTKrQylrOdywREo6fQaztrTLNnPtTa_bcR7lqUIBa3Yu_J0JBwidibE7Wk3Ev9ckJLN-9-tyDEN64XEOVKdlBZHrxv6WecEFUBGgntWn_-H_PZe_CpncDzH0/s1600-h/Pantallazo-Project+Properties+-+DwrSamples.png)

Crearemos una clase a la que llamaremos Calculadora y estará en el paquete logica. Esta clase, básicamente, tendrá los métodos que realizarán las operaciones de manera asíncrona.

```java
<code>package logica;<br />public class Calculadora {<br /><br />public int sumar(int a, int b) {<br />return a + b;<br />}<br /><br />public int restar(int a, int b) {<br />return a - b;<br />}<br />}<br /><br /></code>
```

Ahora, necesitamos que esta clase sea leíble por DWR, por lo que usaremos anotaciones para "publicar" la clase como objeto javascript, pero sólo publicaremos el método sumar() para que sea ajax. Usaremos la anotación de DWR @RemoteProxy para la clase Calculadora, y @RemoteMethod para el método sumar(). Deberá lucir así:

```java
<code>package logica;<br /><br />import org.directwebremoting.annotations.RemoteMethod;<br />import org.directwebremoting.annotations.RemoteProxy;<br /><br />@RemoteProxy<br />public class Calculadora {<br /><br />@RemoteMethod<br />public int sumar(int a, int b) {<br />return a + b;<br />}<br /><br />public int restar(int a, int b) {<br />return a - b;<br />}<br />}<br /><br /></code>
```

Ahora, abrirmos el archivo web.xml (podemos presionar  Shift + Alt + O para abrir el buscador de archivos y escribir web para que nos seleccione el archivo que estamos buscando). En la barra superior hacemos clic en el botón "Servlets" para visualizar los servlets de nuestra aplicación. Una vez allí, hacemos clic en el botón "Add Servlet".
El nuevo servlet que crearemos, le pondremos el nombre "DWR", la clase del servlet será "org.directwebremoting.servlet.DwrServlet", y el patrón URL será "/dwr/*", es decir, este serlet responderá las peticiones en la dirección "/dwr/". Deberá lucir esta ventana así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjlulKVd9_BQz6cQC19FxIXCrb2JR-4fdsFpQY9SNVV0OHgHI2n0wS_CaQHBwH5leiqYnIvXrl2ecTDAIdCBJNE0gmk41fV5CAJ0X0CJpyGijQLae8mxIn5gzSpU7ZjI5Rb10lzx-eHur6/s320/Pantallazo-Add+Servlet.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjlulKVd9_BQz6cQC19FxIXCrb2JR-4fdsFpQY9SNVV0OHgHI2n0wS_CaQHBwH5leiqYnIvXrl2ecTDAIdCBJNE0gmk41fV5CAJ0X0CJpyGijQLae8mxIn5gzSpU7ZjI5Rb10lzx-eHur6/s1600-h/Pantallazo-Add+Servlet.png)
Hacemos clic en "OK". Luego, agregaremos un parámetro de inicio. Hacemos clic en el botón "Add.." de la sección "Initialization Parameter".

El parámetro de inicio lo llamaremos classes, y tendrá una clase llamada logica.Calculadora.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFUk544SkZbllNSKzuqbRf1lQS0GQlhoJrxbPELAUyEP2rPj50Fiy8JPtXu-flD2uz8B8tDHzMDs5GYvZqv0trycdJRqoXdCOq8WOOdVM97GC0XGzjMAojf6ryabmRHskKGDaygNYk0qpi/s320/Pantallazo-Add+Initialization+Parameter.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFUk544SkZbllNSKzuqbRf1lQS0GQlhoJrxbPELAUyEP2rPj50Fiy8JPtXu-flD2uz8B8tDHzMDs5GYvZqv0trycdJRqoXdCOq8WOOdVM97GC0XGzjMAojf6ryabmRHskKGDaygNYk0qpi/s1600-h/Pantallazo-Add+Initialization+Parameter.png)Clic en OK, y deberá lucir así la ventana de los servlets.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj3rlC-X7rs0tJdmPzn9ev5egE0W7wBvVck6lE-UTKb_zGiNwv1Sq8udtP0EC5g8c-IbtaGdLR14eXuJUmvalkxD8c5yxQfMFqXUOb4r7egh4sMfYTWbnLETgxvwWL97CyjOc68vohjWcj9/s320/Pantallazo-DwrSamples+-+NetBeans+IDE+6.1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj3rlC-X7rs0tJdmPzn9ev5egE0W7wBvVck6lE-UTKb_zGiNwv1Sq8udtP0EC5g8c-IbtaGdLR14eXuJUmvalkxD8c5yxQfMFqXUOb4r7egh4sMfYTWbnLETgxvwWL97CyjOc68vohjWcj9/s1600-h/Pantallazo-DwrSamples+-+NetBeans+IDE+6.1.png)O si lo prefieres en xml, el archivo web.xml deberá lucir así.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjUrbst0U7gZntQdh-nlfrRhXOTZjhI59dbFBjF1ErF71-W3Px6JPFypYldUzbO1iXFqXhFapW1LDpoLrnsTWhJ0a2V3knHgs5No_5Lrsgm2jvpmNmRcCW0la1ftHzNR44-BgIfH4fhzZJ/s320/Pantallazo-DwrSamples+-+NetBeans+IDE+6.1-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjUrbst0U7gZntQdh-nlfrRhXOTZjhI59dbFBjF1ErF71-W3Px6JPFypYldUzbO1iXFqXhFapW1LDpoLrnsTWhJ0a2V3knHgs5No_5Lrsgm2jvpmNmRcCW0la1ftHzNR44-BgIfH4fhzZJ/s1600-h/Pantallazo-DwrSamples+-+NetBeans+IDE+6.1-1.png)Ahora, crearemos nuestra interfaz. Abrimos el archivo index.jsp, le pondremos un formulario:

```java
<code>        <h2>Calculadora</h2><br /><form action=""><br />Valor 1: <input type="text" name="valor1" id="valor1"/><br/><br />Valor 2: <input type="text" name="valor2" id="valor2"/><br/><br /><input type="button" value="Sumar" onclick="sumar()"/><br/><br />Resultado:<div id="suma"></div><br /></form><br /></code>
```

Nota que el botón no es un submit, sino un tipo "button". Tampoco olvidar los atributos id de los tags. Estos nos ayudará a identificar un tag en toda la página.

Ahora, necesitamos importar las bibliotecas de DWR. Para ello, agregamos las siguientes lineas en la cabecera del jsp.

```java
<code>        <script type="text/javascript" src="<%=pageContext.getServletContext().getContextPath()  %>/dwr/interface/Calculadora.js"></script><br /><script type="text/javascript" src="<%=pageContext.getServletContext().getContextPath()  %>/dwr/engine.js"></script><br /><script type="text/javascript" src="<%=pageContext.getServletContext().getContextPath()  %>/dwr/util.js"></script><br /><br /></code>
```

Nota que estos javascript están bajo la carpeta /dwr, que es el servlet que hemos creado párrafos arriba. Además, hay un Calculadora.js, que tiene el mismo nombre de nuestra clase java que hemos creado.

Crearemos la función sumar() que es llamada desde el botón "sumar" de nuestro formulario:

```java
<code>            function sumar(){<br /> var valor1=dwr.util.getValue("valor1");<br /> var valor2=dwr.util.getValue("valor2");<br /> Calculadora.sumar(valor1,valor2,mostrarSuma);<br />}<br /><br /></code>
```

En las dos primeras líneas estamos obteniendo los valores de los tag "valor1" y "valor2". Este nombre es el nombrado en los atributos id de los input:text. Por ello es importante que los ID identifiquen a un único tag en toda la página.

La tercera linea llama al objeto Calculadora. Este objeto es el que DWR creó como contraparte a nuestra clase java Calculadora.

Nota que llama al método sumar() y recibe tres parámetros. Los dos primeros son los mismos parámetros que hemos declarado en nuestra clase java Calculadora. Pero el tercer parámetro, que  se llama mostrarSuma, es el nombre de una función en javascript que se encargará de recibir y manejar el resultado que devuelto por el método sumar() de java. Así es la convención de DWR. Notar que se le está pasando solo el nombre, sin paréntesis.

La función javascript mostrarSuma() será la siguiente:

```java
<code>            function mostrarSuma(resultado){<br />  dwr.util.setValue("suma",resultado);  <br />}<br /><br /></code>
```

Vemos que el resultado devuelto por el método de java sumar() es el parámetro de esta función javascript. Tomamos el valor y lo mostramos en el tag que tiene nombre "suma" (que es un <div>).

El index.jsp completo es el siguiente:

```java
<code><%@page contentType="text/html" pageEncoding="UTF-8"%><br /><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"<br />"http://www.w3.org/TR/html4/loose.dtd"><br /><br /><html><br /><head><br /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><br /><title>JSP Page</title><br /><br /><script type="text/javascript" src="<%=pageContext.getServletContext().getContextPath()  %>/dwr/interface/Calculadora.js"></script><br /><script type="text/javascript" src="<%=pageContext.getServletContext().getContextPath()  %>/dwr/engine.js"></script><br /><script type="text/javascript" src="<%=pageContext.getServletContext().getContextPath()  %>/dwr/util.js"></script><br /><script type="text/javascript"><br />function sumar(){<br />  var valor1=dwr.util.getValue("valor1");<br />  var valor2=dwr.util.getValue("valor2");<br />  Calculadora.sumar(valor1,valor2,mostrarSuma);<br />}<br />function mostrarSuma(resultado){<br />  dwr.util.setValue("suma",resultado);  <br />}<br /></script><br /></head><br /><body><br /><br /><h2>Calculadora</h2><br /><form action=""><br />Valor 1: <input type="text" name="valor1" id="valor1"/><br/><br />Valor 2: <input type="text" name="valor2" id="valor2"/><br/><br /><input type="button" value="Sumar" onclick="sumar()"/><br/><br />Resultado:<div id="suma"></div><br /></form><br /></body><br /></html><br /><br /></code>
```

Lo corremos y probamos:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjXR0LMHPsONJLtKgO5kV7z5JWf2k4bjTUBxcq1cg9I7XqUbZbDxp-s931r62w3Ag-bG1-wUkcYrt_jVBYhkjZc2xVvEeRX8RJ4xrJIU57FDFVfZdhxDZr2Ns_LSgBvy_0WXN4_WhMuF1MZ/s320/Pantallazo-JSP+Page+-+Mozilla+Firefox.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjXR0LMHPsONJLtKgO5kV7z5JWf2k4bjTUBxcq1cg9I7XqUbZbDxp-s931r62w3Ag-bG1-wUkcYrt_jVBYhkjZc2xVvEeRX8RJ4xrJIU57FDFVfZdhxDZr2Ns_LSgBvy_0WXN4_WhMuF1MZ/s1600-h/Pantallazo-JSP+Page+-+Mozilla+Firefox.png)

¡Magia!

## Con base de datos

 A esta altura verás la simpleza del DWR, y que una aplicación con base  de datos no sería de lo más difícil. Haríamos una clase que accede la base de datos y lo muestre en la web. Pero ¿cómo lo mostramos en una tabla?. Aquí mostraremos el ejemplo:

Crearemos una clase llamada PersonasService y lo guardaremos en el paquete logica. Esta clase tendrá la anotación @RemoteProxy pero con un parámetro que cambiará el nombre del objeto javascript. Es decir, no se llamará PersonasService en javascript, sino, se llamará solamente Personas.

```java
<code>package logica;<br /><br />import org.directwebremoting.annotations.RemoteProxy;<br />@RemoteProxy(name = "Personas")<br />public class PersonasService {<br /><br /><br />}<br /><br /></code>
```

Ahora, crearemos un método llamado getLista() que devolverá una lista de objetos Persona que tendrá los registros de la base de datos. Para ello, primero crearemos la clase beans.Persona.

```java
<code>package beans;<br /><br />import java.util.Date;<br /><br /><br />public class Persona {<br /><br /><br />private int id;<br /><br />private String nombre;<br /><br />private String titulo;<br /><br />private boolean viajeroFrecuente;<br /><br />private Date ultimaActualizacion;<br /><br />public int getId() {<br /> return id;<br />}<br /><br />public void setId(int id) {<br /> this.id = id;<br />}<br /><br />public String getNombre() {<br /> return nombre;<br />}<br /><br />public void setNombre(String nombre) {<br /> this.nombre = nombre;<br />}<br /><br />public String getTitulo() {<br /> return titulo;<br />}<br /><br />public void setTitulo(String titulo) {<br /> this.titulo = titulo;<br />}<br /><br />public Date getUltimaActualizacion() {<br /> return ultimaActualizacion;<br />}<br /><br />public void setUltimaActualizacion(Date ultimaActualizacion) {<br /> this.ultimaActualizacion = ultimaActualizacion;<br />}<br /><br />public boolean isViajeroFrecuente() {<br /> return viajeroFrecuente;<br />}<br /><br />public void setViajeroFrecuente(boolean viajeroFrecuente) {<br /> this.viajeroFrecuente = viajeroFrecuente;<br />}<br />}<br /><br /></code>
```

Por alguna razón, los beans con anotaciones no son convertidos por DWR a objetos JavaScript. Al menos con esta versión. He seguido la documentación que indica cómo usar un bean con @DataTransferObject y nada. Si alguien lo puede lograr, lo agradeceré un montón.

Pero para poder enviar beans en DWR, crearemos un archivo llamado dwr.xml y lo guardamos dentro del directorio WEB-INF (en la misma ubicación del archivo web.xml). En ese archivo colocaremos lo siguiente:

```java
<code><?xml version="1.0" encoding="UTF-8"?><br /><!DOCTYPE dwr PUBLIC<br /> "-//GetAhead Limited//DTD Direct Web Remoting 2.0//EN"<br /> "http://directwebremoting.org/schema/dwr20.dtd"><br /><dwr><br /> <allow><br />  <br />     <convert converter="bean" match="beans.Persona"><br />     </convert><br /> </allow><br /></dwr><br /><br /></code>
```

Ahora, volvemos a la clase PersonasService. Hacemos clic derecho sobre el fondo del código fuente, y seleccionamos Enterprise Resource > Use Database.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjVdxNEUZ-5V6HSYdfRyxRHHzbpBGzdcOjT5M5nIJitcGsLs8FUD_EWf8IsxAEHnMhDhH_j3qjaLX35V2dGrQ6ujPrkwtoZXD3Cqo-QHo3VTKrLIxBNaGUTpS3Snz9zKpQyJuQq6_8eGWhC/s320/Pantallazo-Choose+Database.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjVdxNEUZ-5V6HSYdfRyxRHHzbpBGzdcOjT5M5nIJitcGsLs8FUD_EWf8IsxAEHnMhDhH_j3qjaLX35V2dGrQ6ujPrkwtoZXD3Cqo-QHo3VTKrLIxBNaGUTpS3Snz9zKpQyJuQq6_8eGWhC/s1600-h/Pantallazo-Choose+Database.png)
Hacemos clic en el botón "Add"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEglLXqDN5z2BEn_DsO5JFInak3I1mYQRCEjbwIutPF2r2wnMGmM9EAA88rq1KusEg-fJSf3jl64uKeBfkKkOEQxiMzoAk4jxbyvFPvRSL8IQBhMjY3m8J_Ex34JH2VGWB6u5Jl3jQZszdZh/s320/Pantallazo-Add+Data+Source+Reference.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEglLXqDN5z2BEn_DsO5JFInak3I1mYQRCEjbwIutPF2r2wnMGmM9EAA88rq1KusEg-fJSf3jl64uKeBfkKkOEQxiMzoAk4jxbyvFPvRSL8IQBhMjY3m8J_Ex34JH2VGWB6u5Jl3jQZszdZh/s1600-h/Pantallazo-Add+Data+Source+Reference.png)
Pondremos como nombre de la referencia, el valor de travelDS. Además, hacemos clic en el botón "Add" de "Project Data sources",  escribimos el nombre del JNDI jdbc/travel y seleccionamos de la lista el URL del JDBC referido a la base de datos travel.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiNuKwrh163kEgTeNFia8Bj_53tcxeqGCzZYyjxWQWtj_9WAB0ny-70idAlfpd9Uqm4C7dJiKYKel7CBp_wlu8MCG0BIhqnQWSgiOuGHhzu2vNzzcAo6ptRcHf_NuBuj90x96VIkcXpWPRK/s320/Pantallazo-Create+Data+Source.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiNuKwrh163kEgTeNFia8Bj_53tcxeqGCzZYyjxWQWtj_9WAB0ny-70idAlfpd9Uqm4C7dJiKYKel7CBp_wlu8MCG0BIhqnQWSgiOuGHhzu2vNzzcAo6ptRcHf_NuBuj90x96VIkcXpWPRK/s1600-h/Pantallazo-Create+Data+Source.png)
Clic en OK
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjy0OL20kit6kxX0j_w7zEWOVDkQey-sS6KNaZXOQdvA44HUZPUvot6J13zjPtbS0io2gZOtJiN6vx3YZwrLfRVHP0M_azqs-bZPGjxoPCBcwXolGOmckByinHd-aFf7dt3KBw1c0Qj3xm1/s320/Pantallazo-Add+Data+Source+Reference-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjy0OL20kit6kxX0j_w7zEWOVDkQey-sS6KNaZXOQdvA44HUZPUvot6J13zjPtbS0io2gZOtJiN6vx3YZwrLfRVHP0M_azqs-bZPGjxoPCBcwXolGOmckByinHd-aFf7dt3KBw1c0Qj3xm1/s1600-h/Pantallazo-Add+Data+Source+Reference-1.png)
Clic en OK
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiIndOjPwCzlBmWrNm23moZKKFIPimgzJPWVaQX6IjbfuloTeZrK7G9pYG9-xuYdf1qhb0xt_LFA3A-xN6E6l31izbVzdmYtpnu4ToLUCujjZpTVxeASI7U-gdDn2EwBvFL51Uo1Dd0Ow0S/s320/Pantallazo-Choose+Database-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiIndOjPwCzlBmWrNm23moZKKFIPimgzJPWVaQX6IjbfuloTeZrK7G9pYG9-xuYdf1qhb0xt_LFA3A-xN6E6l31izbVzdmYtpnu4ToLUCujjZpTVxeASI7U-gdDn2EwBvFL51Uo1Dd0Ow0S/s1600-h/Pantallazo-Choose+Database-1.png)
Clic en OK

Veremos que NetBeans nos ha creado un método llamado getTravelDS()

```java
<code>    private DataSource getTravelDS() throws NamingException {<br />  Context c = new InitialContext();<br />  return (DataSource) c.lookup("java:comp/env/travelDS");<br />}<br /><br /></code>
```

Pues ya con esto, podemos hacer nuestro manejo a la base de datos.

Ahora sí, crearemos el método getLista():

```java
<code>    @RemoteMethod<br />public List<Persona> getLista() {<br />    try {<br />        DataSource ds = getTravelDS();<br />        Connection conn = ds.getConnection();<br />        Statement stmt = conn.createStatement();<br />        ResultSet rs = stmt.executeQuery("SELECT * FROM person");<br />        List<Persona> lista = new ArrayList<Persona>();<br />        while (rs.next()) {<br />            Persona p = new Persona();<br />            p.setId(rs.getInt("PERSONID"));<br />            p.setNombre(rs.getString("NAME"));<br />            p.setTitulo(rs.getString("JOBTITLE"));<br />            p.setViajeroFrecuente(rs.getBoolean("FREQUENTFLYER"));<br />            p.setUltimaActualizacion(rs.getDate("LASTUPDATED"));<br />            lista.add(p);<br />        }<br />        return lista;<br />    <br />    } catch (SQLException ex) {<br />        Logger.getLogger(PersonasService.class.getName()).log(Level.SEVERE, null, ex);<br />    } catch (NamingException ex) {<br />        Logger.getLogger(PersonasService.class.getName()).log(Level.SEVERE, null, ex);<br />    }<br />    return null;<br />}<br /><br /></code>
```

### La interfaz web

Ahora, para terminar, lo más importante de una aplicación: la interfaz web.
Crearemos una tabla donde se colocarán los datos de los registros obtenidos de la base de datos. Esta tabla será así:

```java
<code>        <input type="button" onclick="mostrarPersonas()" value="Mostrar personas"/><br />       <input type="button" onclick="limpiarCuadro()" value="Limpiar cuadro"/><br />       <table border="1"><br />           <thead><br />               <tr><br />                   <th>ID</th><br />                   <th>Nombre</th><br />                   <th>Cargo</th><br />                  <br />               </tr><br />           </thead><br />          <br />           <tbody id="personas"><br />               <tr id="pattern" style="display:none"><br />                   <td id="id"></td><br />                   <td id="nombre"></td><br />                   <td id="titulo"></td>                  <br />               </tr><br />           </tbody><br />       </table><br /><br /></code>
```

Nota que hay una fila que está invisible (style="display:none"). Esta será nuestra plantilla llamada "pattern". Cuando llenemos los datos de la base de datos, lo que haremos será duplicar esta fila por cada registro.

Vemos también que hay un botón que se llama "Mostrar Personas" que llama a la función JavaScript mostrarPersonas(), que es la está aquí:

```java
<code>            function mostrarPersonas(){<br />               Personas.getLista(listarPersonas);<br />           }<br /><br /></code>
```

Es decir, estamos llamando al método getLista() del objeto JavaScript Personas  que el DWR creó. El método correspondiente en java no tiene parámetros, pero aquí estamos pasándole un argumento. Este argumento es el nombre de la función JavaScript que procesará el resultado devuelto por el método java. Y la función listarPersonas() está aquí:

```java
<code>            function listarPersonas(data){<br />               limpiarCuadro();<br />               for(var i=0;i<data.length;i++){                   <br />                   fila=data[i];                   <br />                   var $id=fila.id;                   <br />                  <br />                   dwr.util.cloneNode("pattern",{idSuffix:$id});<br />                   dwr.util.setValue("id"+$id,fila.id);<br />                   dwr.util.setValue("nombre"+$id,fila.nombre);<br />                   dwr.util.setValue("titulo"+$id,fila.titulo);                  <br />                   $("pattern"+$id).style.display="";<br />               }<br />           }<br /><br /></code>
```

Lo que primero hace es limpiar el cuadro (luego presento la función que limpia la tabla). Vemos también que está recibiendo un parámetro. Como vimos en el ejemplo anterior, este es el resultado que está devolviendo el objeto java.
Lo que hacemos es recorrer todas filas de la lista, tomamos una fila y obtenemos el ID de ese objeto.
Este ID nos permitirá identificar a esa única fila, porque sabemos que cada ID de la tabla es única.
Luego clonamos la plantilla:

```java
<code>dwr.util.cloneNode("pattern",{idSuffix:$id});</code>
```

Al clonarla, hacemos que el ID de la fila creada tenga como subfijo el ID del objeto java. Es decir, al clonar una fila, toda la fila queda idéntica al patrón, incluyendo los nombres de los ID, que según el patrón es "pattern". Si el primero registro de la tabla tiene el valor "1" en el campo "ID", cuando clone la fila pondrá como nombre del ID "pattern" y terminará con el valor "1", o sea, se llamará finalmente "pattern1", y las celdas "nombre1", "titulo1" . Para la segunda fila será "pattern2" y las celdas "nombre2","titulo2"... y así sucesivamente.
Ya clonamos la fila *pattern*, ahora colocaremos los valores a cada celda. Como ya tenemos el ID unico de cada celda, simplemente colocaremos el valor en ellas

```java
<code>dwr.util.setValue("id"+$id,fila.id);<br />dwr.util.setValue("nombre"+$id,fila.nombre);<br />dwr.util.setValue("titulo"+$id,fila.titulo);                  <br /></code>
```

Pero como también se clonó el estilo - que indica que debe estar oculto - le indicamos que se muestre.

```java
<code>$("pattern"+$id).style.display="";</code>
```

...y listo.
A continuación las funciones que borran el contenido de la tabla:

```java
<code>            function limpiarCuadro(){<br />               dwr.util.removeAllRows("personas",{filter:filtroBorrado});<br />           }<br /><br />           function filtroBorrado(tr){<br />               return (tr.id!="pattern");<br />           }<br /><br /></code>
```

Existe la función filtroBorrado() para evitar que la fila "pattern" sea borrada. Sino, ¿como hacemos la clonación?
Y el resultado es el ya esperado...
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjiR12TX1HXWfy2Vi9XjhY6-FKr5DLxbVwLMks8S3LSM4TRBljFYrbNfkitL0EPs_JzgFgs12fyjYpgqzWB4DDVJqtuxAMzumAHDCiyvRdqFAsF1-oabVTNsd7di8bL0cOqE2JnYjiS8-74/s400/ajax_dwr.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjiR12TX1HXWfy2Vi9XjhY6-FKr5DLxbVwLMks8S3LSM4TRBljFYrbNfkitL0EPs_JzgFgs12fyjYpgqzWB4DDVJqtuxAMzumAHDCiyvRdqFAsF1-oabVTNsd7di8bL0cOqE2JnYjiS8-74/s1600-h/ajax_dwr.jpg)

## Para terminar...

 Revisa la [documentación](http://getahead.org/dwr/documentation) de [DWR](http://getahead.org/dwr), ahí encontrarás muchas cosas muy interesantes.

## Recursos

 El proyecto utilizado para este post lo puedes descargar de aquí [http://diesil-java.googlecode.com/files/dwrsamples.tar.gz](http://diesil-java.googlecode.com/files/dwrsamples.tar.gz).
