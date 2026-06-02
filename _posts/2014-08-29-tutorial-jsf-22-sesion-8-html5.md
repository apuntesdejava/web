---
layout: post
title: "Tutorial JSF 2.2 - Sesión 8: HTML5"
date: 2014-08-29T21:15:00.003Z
last_modified_at: 2018-01-10T23:50:02.356Z
author: "Diego Silva Límaco"
permalink: /2014/08/tutorial-jsf-22-sesion-8-html5.html
canonical_url: https://www.apuntesdejava.com/2014/08/tutorial-jsf-22-sesion-8-html5.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "netbeans 8"
  - "html5"
  - "java ee 7"
  - "netbeans"
  - "jsf"
  - "jsf 2.2"
---

[![Tutorial JSF 2.2 - Sesión 8: HTML5](/assets/blogger/HTML5_Logo_512.png)](/assets/blogger/HTML5_Logo_512.png)

Esta vez hablaremos sobre la novísima versión de HTML que ya se ha vuelto popular, y que revoluciona el desarrollo de aplicaciones web. Es nada menos que el HTML5.

Pero, no vamos a hablar del HTML5 en sí, ya que estamos siguiendo un tutorial sobre JSF 2.2. Lo que vamos a ver es cómo puede interactuar HTML5 con JSF.

En las versiones anteriores a JSF 2.2, solo se podía usar etiquetas compatibles con HTML 4, y las etiquetas y atributos de HTML5 se estaban volviendo muy útiles y necesarias para las aplicaciones. Así que decidieron que el JSF deba contemplar HTML5. Veremos en qué consiste.

HTML5 tiene nuevas características bastantes útiles. Si quieres conocer un poco más de HTML5, te recomiendo que veas este [tutorial](http://www.w3schools.com/html/html5_intro.asp)que está muy bueno: [HTML 5 Intro](http://www.w3schools.com/html/html5_intro.asp). Ahora bien, es posible que estas características (input de tipo fecha, tag de vídeo y audio nativo, base de datos en el navegador y más) quieras implementarlas en un JSF que tiene etiquetas establecidas. JSF sale a nuestra salvación, ya que la tecnología permite dos maneras de implementación:

- Pase de elementos (Passthrough Elements)

- Pase de atributos (Passthrough Attributes).

### Pase de elementos

El pase de elementos consiste en que podemos usar etiquetas y atributos HTML5 y a la vez tratarlos con características que son propias de JSF. Para ello, necesitamos poner un [namespace](http://www.w3.org/TR/2011/WD-html5-20110405/namespaces.html) al documento JSF y usar los atributos de JSF en las etiquetas HTML pero con el prefijo del namespace. Quedaría algo así como un HTML con chispitas de sabor de JSF:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:jsf="http://xmlns.jcp.org/jsf"
      >
    <h:head>
        <title>Usando paso de elementos</title>
    </h:head>
    <h:body>
        <h1>Usando paso de elementos</h1>
        <form jsf:id="form">
            <label jsf:for="nombre">Nombre</label>
            <input required="required"
                   name="nombre"
                   jsf:id="nombre"
                   type="text"
                   value="#{formBean.nombre}"/>
            <br/>
            <label jsf:for="anioNacimiento">Año que naciste</label>
            <input required="required"
                   name="anioNacimiento"
                   jsf:id="anioNacimiento"
                   type="number"
                   value="#{formBean.anioNacimiento}"/><br/>
            <br/>
            <h:commandButton value="Calcular edad" action="paso-elementos-resp" />

            <br/>
            <h:link outcome="index" value="Regresar"/>
        </form>
    </h:body>
</html>
```

Notar que con solo colocar el atributo `jsf:id` el tag HTML5 tiene las características como JSF. Por eso podemos utilizar atributos de HTML5 (como `type="number"`, `required` y más) conjuntamente con funcionalidades JSF

### Pase de atributos

Esto es al revés: tenemos tags de JSF y queremos adornarlo con atributos propios de HTML5. El namespace a usar debe ser

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:p="http://xmlns.jcp.org/jsf/passthrough">
    <h:head>
        <title>Usando paso de atributos</title>
    </h:head>
    <h:body>
        <h1>Usando paso de atributos</h1>
        <h:form>

            <h:outputLabel value="Nombre"
                           for="nombre"
                           p:contextmenu="menu"/>
            <h:inputText id="nombre"
                         value="#{formBean.nombre}"
                         p:placeholder="Escribe tu nombre..." />
            Nota: el menú contextual del LABEL solo funciona en Firefox
            <br/>
            <h:outputLabel value="Fecha nacimiento"
                           for="fecNac" />
            <h:inputText value="#{formBean.fechaNacimiento}"
                         id="fecNac"
                         p:required="required"
                         p:type="date"/>
            Nota: El selector de fecha solo funciona en Chrome, Opera y Safari.
            <br/>
            <h:commandButton action="paso-atributos-resp" value="Calcular"/>
            <br/>
            <h:link outcome="index" value="Regresar"/>

        </h:form>
        <menu type="context" id="menu">
            <menuitem label="HOLA!"/>
            <menuitem label="Este es una opción del menú"/>
        </menu>
    </h:body>
</html>
```

### Código fuente

**Actualizado**
Nota: Agradezco a  [Miguel Angel](https://www.facebook.com/ecmik3?fref=ufi) de Quito - Ecuador que me avisó que no corría bien este código, por lo que actualicé los códigos fuentes.

El proyecto completo, lo pueden descargar desde aquí

[https://bitbucket.org/apuntesdejava/javanet/downloads/jsf-08-html5.tar.gz](https://bitbucket.org/apuntesdejava/javanet/downloads/jsf-08-html5.tar.gz)

### Bibliografía

Todo esto me basé de capítulo [8.9 HTML5-Friendly Markup](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-facelets009.htm) de [The Java EE 7 Tutorial](http://docs.oracle.com/javaee/7/tutorial/doc/home.htm).
