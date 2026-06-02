---
layout: post
title: "Tutorial JSF 2.2 - Sesión 4: Facelets (Parte I)"
date: 2013-12-02T19:27:00.002Z
last_modified_at: 2018-01-10T23:46:17.579Z
author: "Diego Silva Límaco"
permalink: /2013/12/tutorial-jsf-22-sesion-4-facelets-parte.html
canonical_url: https://www.apuntesdejava.com/2013/12/tutorial-jsf-22-sesion-4-facelets-parte.html
tags:
  - "facelets"
  - "java"
  - "web"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "tutorial"
  - "jsf"
  - "jsf 2.2"
---

[![Tutorial JSF 2.2 - Sesión 4: Facelets (Parte I)](/assets/blogger/jsf-logo.png)](/assets/blogger/jsf-logo.png)

Los facelets es una declaración bastante ligera de declaración de páginas web. En los JSP, el lenguaje era Java dentro de los JSP, y estos fragmentos se llamaban scriptlets. En cambio, en JSF, se llama facelets.

Los facelets son un tema extenso, así que - como no va a entrar todo en un post - lo haré por partes. No tengo idea de cuantas partes tomará, creo que serán algo de diez. Glup! Pero veremos todo lo que concierne al JSF 2.2, incluyendo al HTML5.

Comencemos...

El formato por omisión de los facelets es XHTML. Así, las extensiones de los archivos son de extensión .xhtml.

Como todo xhtml, tiene etiquetas que definen el contenido, pero no cualquier etiqueta. Estas se obtienen de una biblioteca de etiquetas. Aquí menciono el conjunto de etiquetas, y las rutas de cada una de ellas.

<table>
<thead>
<tr>
<th>Biblioteca de etiqueta</th>
<th>URI</th><th>Prefijo</th><th>Ejemplo</th><th>Contenido</th>
</tr>
</thead>
<tbody>
<tr class="border-bottom:1px solid black">
<td>Biblioteca de Facelets</td> <td>http://xmlns.jcp.org/jsf/facelets</td>
<td><code>ui:</code></td>
<td><code>ui:component<br />ui:insert</code></td>
<td>Etiquetas para plantillas</td>
</tr>
<tr class="border-bottom:1px solid black">
<td>Biblioteca de HTML</td> <td>http://xmlns.jcp.org/jsf/html</td>
<td><code>h:</code></td>
<td><code>h:head<br />
h:body<br />

h:outputText

h:inputText</code></td>
<td>Etiquetas para todos los componentes de tipo UIComponent</td>
</tr>
<tr class="border-bottom:1px solid black">
<td>Biblioteca para elementos compatibles</td> <td>http://xmlns.jcp.org/jsf</td>
<td><code>p:</code></td>
<td><code>p:type</code></td>
<td>Etiquetas JSF compatibles para HTML5</td>
</tr>
<tr class="border-bottom:1px solid black">
<td>Biblioteca para atributos compatibles</td> <td>http://xmlns.jcp.org/jsf/passthrough</td>
<td><code>jsf:</code></td>
<td><code>jsf:id</code></td>
<td>Atributos JSF compatibles para HTML5</td>
</tr>
<tr class="border-bottom:1px solid black">
<td>Biblioteca JSTL Core</td> <td>http://xmlns.jcp.org/jsp/jstl/core</td>
<td><code>c:</code></td>
<td><code>c:forEach<br />
c:catch</code></td>
<td>Etiquetas de Core JSTL 1.2</td>
</tr>
<tr class="border-bottom:1px solid black">
<td>Biblioteca de funciones JSTL </td> <td>http://xmlns.jcp.org/jsp/jstl/functions
</td>
<td><code>fn:</code></td>
<td><code>fn:toUpperCase<br />
fn:toLowerCase</code></td>
<td>Etiquetas de Funciones JSTL 1.2</td>
</tr>
</tbody>
</table>

## Plantillas con Facelets

Los que hemos desarrollado aplicaciones web vemos que la necesidad de que todas las páginas luzcan igual (con la misma cabecera, mismo menú y mismo pie) es algo obligatorio. Y repetir constantemente la misma declaración en cada página es una mala práctica que es castigado con pena de muerte. Hacer fragmentos de las partes repetibles y llamarlas en cada página es una salida, pero no es muy práctica; ya que se tiene (igual) repetir la inclusión de esos archivos en cada página, y si falta una sola invocación, ya no es lo mismo.

[![](/assets/blogger/Plantillas.png)](/assets/blogger/Plantillas.png)

En el viejo Struts, incluía el framework **Tiles** que permitía crear plantillas generales, y cuando se invocaba a esa declaración, ya incorporaba las partes que se deseaban añadir.

Pero ahora, con los Facelets, será mucho más rápido e intuitiva la implementación de las plantillas.

Así que haremos nuestro primer ejemplo de plantillas con facelets, pero para hacerlo más interesante, usaremos una plantilla muy útil: BootStrap.com

## Utilizando bootstrap.com en una aplicación JavaServer Faces

Comenzaremos por crear una aplicación JSF común y corriente usando nuestro NetBeans IDE. Ahora, vamos a agregar el bootstrap a nuestra aplicación de la siguiente manera:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRD_l3VFJu6wRHR8JGR__bDaiNbIFtTjunyAABtMz7PAsCsH16gj8jQxtEK2_0Wv1klsTavLiy0u0PDO2XkJyTbgbp1BKkiVriEbEV680UtRNkLMKtm_HuGA8GlzV_Sx91D_FbHD9Kol0/s1600/28-11-2013+12-27-36+a-m-.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRD_l3VFJu6wRHR8JGR__bDaiNbIFtTjunyAABtMz7PAsCsH16gj8jQxtEK2_0Wv1klsTavLiy0u0PDO2XkJyTbgbp1BKkiVriEbEV680UtRNkLMKtm_HuGA8GlzV_Sx91D_FbHD9Kol0/s1600/28-11-2013+12-27-36+a-m-.png)

- Hacemos clic derecho en el ícono del proyecto y seleccionamos "Properties".

- En el margen izquierdo seleccionamos "JavaScript Files"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmcNIEM6ztGi8ACBzN8009HccMPGRs5rrX25W536LymHgFFUWn6QZKc20M4aEyZVvknjzVOUKXzowyrVsL3-ptdhMSfDSpa-YrpMYsWRQT6cIQDJK5IAEfzq8cacngWN3Uaoc7qVq2ls0/s1600/28-11-2013+12-17-19+a-m-.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmcNIEM6ztGi8ACBzN8009HccMPGRs5rrX25W536LymHgFFUWn6QZKc20M4aEyZVvknjzVOUKXzowyrVsL3-ptdhMSfDSpa-YrpMYsWRQT6cIQDJK5IAEfzq8cacngWN3Uaoc7qVq2ls0/s1600/28-11-2013+12-17-19+a-m-.png)

- Escribimos en la casilla "Available" el texto **twi**. Con esto, aparecerá una lista filtrada de todas las bibliotecas JavaScript que tengan ese nombre. Seleccionamos el twitter-bootstrap.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiF2ST8Pc5MAQhVWKjND8s3yyiq8zTffaNavMoO7FIti2P708euGnHocH2PewNzzt-IkYc0xfw9N3egzjUsyX9MOyoguCWWkg0lDspzSGNkln0PkkCS4ds8-yivoSCshnl7CcWNuM6MyNo/s1600/28-11-2013+12-23-57+a-m-.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiF2ST8Pc5MAQhVWKjND8s3yyiq8zTffaNavMoO7FIti2P708euGnHocH2PewNzzt-IkYc0xfw9N3egzjUsyX9MOyoguCWWkg0lDspzSGNkln0PkkCS4ds8-yivoSCshnl7CcWNuM6MyNo/s1600/28-11-2013+12-23-57+a-m-.png)

- Lo agregamos a la lista de seleccionados, y le damos clic en "ok".
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjQu4Qbpf1AwHzWnM9mDBXOxCbM2NchW0MpJvV1uypYPOafOeXfKOrV7G6HJFJeqJEI1HU5_30hCJkfoPHJ1YL2sy_aI6VF_upbZO6lQkpJ7Vbia4UmH-DRbOMqp1IKWO9y3lyeBe5Kwi0/s1600/28-11-2013+12-25-36+a-m-.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjQu4Qbpf1AwHzWnM9mDBXOxCbM2NchW0MpJvV1uypYPOafOeXfKOrV7G6HJFJeqJEI1HU5_30hCJkfoPHJ1YL2sy_aI6VF_upbZO6lQkpJ7Vbia4UmH-DRbOMqp1IKWO9y3lyeBe5Kwi0/s1600/28-11-2013+12-25-36+a-m-.png)

- Vemos que ha creado toda una estructura de carpetas para guardar los estilos (.css) y los javascript (.js)

Ya tenemos la biblioteca del BootStrap. Ahora, vamos a crear la plantilla. En esta plantilla se invocará a esta biblioteca a fin de que todas las páginas usen esta misma declaración.

Tenemos dos maneras de crear la plantilla: a través del asistente de NetBeans, o a *mano*. Lo bueno de la primera forma es que nos ahorra escribir todos los tags, lo malo es que nos crea archivos que no vamos a necesitar. Así que usaremos que lo haremos a *mano*.

- Crearemos un nuevo archivo (Ctrl+N), seleccionamos en Categorías "JavaServer Faces" y el tipo de archivo "JSF Page". Clic en Next.

- El nombre del archivo será "bootstrap" y lo ubicaremos en "WEB-INF/pages/templates"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjQdQmsAuP3Um3cPs-XMfM1F8XO2YHoAZhkETnu31ELnRNy8-RylypgxcAco8WkhoqsFfBgYU3-So2xSuCCTRxtlqSRy5JExKbD3sFvjJrqIAqJcMwJVQwicsvpsBCt3_ejtuVj386LHXg/s1600/29-11-2013+11-35-39+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjQdQmsAuP3Um3cPs-XMfM1F8XO2YHoAZhkETnu31ELnRNy8-RylypgxcAco8WkhoqsFfBgYU3-So2xSuCCTRxtlqSRy5JExKbD3sFvjJrqIAqJcMwJVQwicsvpsBCt3_ejtuVj386LHXg/s1600/29-11-2013+11-35-39+a.m..png)
Clic en Finish

Ahora sí, escribiremos el siguiente contenido

```java
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets"
      xmlns:fn="http://xmlns.jcp.org/jsp/jstl/functions"
      xmlns:h="http://xmlns.jcp.org/jsf/html">

    <h:head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="#{request.contextPath}/js/libs/twitter-bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link href="#{request.contextPath}/js/libs/twitter-bootstrap/css/bootstrap-theme.css" type="text/css" rel="stylesheet"/>
        <h:outputStylesheet name="./css/style.css"/>
        <title>Plantilla BootStrap</title>
    </h:head>

    <h:body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">JSF Templates</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="#{fn:startsWith(request.pathInfo,'/index')?'active':'' } ">
                            <h:link outcome="index" value="Home"/></li>
                        <li class="#{fn:startsWith(request.pathInfo,'/about')?'active':'' } "><h:link outcome="about" value="About"/></li>
                        <li class="#{fn:startsWith(request.pathInfo,'/contact')?'active':'' } "><h:link outcome="contact" value="Contact"/></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>
        <div class="container">
            <ui:insert name="content">Content</ui:insert>
        </div>

    </h:body>
    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="#{request.contextPath}/js/libs/twitter-bootstrap/js/bootstrap.js"></script>

</html>
```

Ya tenemos nuestra plantilla, usando el BootStrap de Twitter, además que obtenemos el jquery del CDN de JQuery.

## Usando la plantilla

Para usar esta plantilla será muy fácil. Crearemos tres archivos en la carpeta "Web Pages", se deberán llamar `index.html`, `contact.xhtml` y `about.xml`. Estos deben existir porque la plantilla  está llamando a estas páginas a través del tag `<h:link />`. Aquí mostraré algunos ejemplos de cada contenido de estos archivos.

### /index.html

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE composition PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ui:composition xmlns:ui="http://java.sun.com/jsf/facelets"
                template="/WEB-INF/pages/templates/bootstrap.xhtml"
                xmlns="http://www.w3.org/1999/xhtml">

    <ui:define name="content">
        <h1>Inicio</h1>
        <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis et diam varius elit sollicitudin tempus. Etiam feugiat ut arcu ut viverra. Vestibulum magna risus, mattis vel auctor et, porta sed sem. Maecenas sagittis, orci quis accumsan luctus, massa sem tristique neque, eu ullamcorper magna purus at nisi. Nunc dapibus ultrices erat, eu vulputate lorem ultricies vitae. Fusce auctor lorem vel leo hendrerit ultricies. Aliquam magna nisi, molestie sodales mauris non, suscipit lacinia sapien. Duis ante neque, lacinia vitae magna sit amet, placerat facilisis odio. Suspendisse sem sem, iaculis sed gravida sit amet, faucibus eu est. Cras neque eros, aliquam et felis vitae, condimentum pharetra metus. Maecenas id interdum diam. Maecenas nisi justo, iaculis vitae scelerisque interdum, suscipit id justo. Praesent porta, elit non posuere tristique, turpis metus rutrum enim, et aliquam nisl quam quis nulla. Fusce sagittis, augue ut interdum laoreet, sem felis vulputate velit, nec dignissim diam odio ut ipsum. Nullam malesuada sollicitudin augue condimentum dictum. Quisque sit amet blandit tellus.
        </p>
    </ui:define>

</ui:composition>
```

### /contact.html

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE composition PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ui:composition xmlns:ui="http://java.sun.com/jsf/facelets"
                template="/WEB-INF/pages/templates/bootstrap.xhtml" xmlns="http://www.w3.org/1999/xhtml">

    <ui:define name="content">
        <h1>Contact</h1>
        <p>Vestibulum et velit sit amet felis iaculis congue. Integer ut orci ac diam congue porttitor ac vitae nisl. Nulla volutpat auctor imperdiet. Morbi vitae elit ut leo tempus consectetur eu quis libero. Aliquam sit amet adipiscing justo. Quisque in ligula nec tortor pharetra laoreet. Sed euismod, est et fringilla vestibulum, nisl augue accumsan urna, eget gravida magna augue a arcu. Sed et dolor urna. Pellentesque vestibulum, orci ac vulputate pharetra, metus nunc condimentum lacus, sit amet consectetur felis augue et metus. Nulla tincidunt nunc at venenatis cursus. Phasellus dolor ante, lacinia sed accumsan mattis, adipiscing quis lorem. Phasellus vel mollis magna, non luctus dolor. Nunc sem enim, interdum laoreet pharetra consequat, facilisis a nibh. </p>
    </ui:define>

</ui:composition>
```

### /about.html

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE composition PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ui:composition xmlns:ui="http://java.sun.com/jsf/facelets"
                template="/WEB-INF/pages/templates/bootstrap.xhtml" xmlns="http://www.w3.org/1999/xhtml">

    <ui:define name="content">
        <h1>About</h1>
        <p>Etiam dictum massa et justo auctor euismod. Duis id tortor sit amet leo iaculis consequat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla mauris erat, molestie nec leo vel, tempor tempus leo. Quisque arcu erat, volutpat a sapien eget, mollis accumsan ante. Vivamus semper interdum nunc, ac accumsan ipsum. Cras vitae ultrices velit. Praesent vehicula quam velit. Donec auctor est at fermentum dignissim. Phasellus facilisis leo dolor, quis ullamcorper metus sagittis vel. Nullam in eleifend ante, pharetra dignissim orci. Etiam fringilla lorem eu rhoncus tempor. </p>
    </ui:define>

</ui:composition>
```

Ejecutamos la aplicación y listo, ya tenemos un ejemplo de plantilla. Vean lo simple que es usar la plantilla: solo lo llamamos, y llenamos el contenido que falta.

## Código ejemplo

Y desde aquí pueden descargar el ejemplo que he usado para este post.

## Bibliografía

Me he basado - como siempre - del tutorial de Java EE 7. Esta vez, del [capítulo 8: Introduction to Facelets](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-facelets001.htm). Espero que para el siguiente post no me demore tanto.

Nos vemos a la próxima.

***¡Bendiciones a todos!***
