---
layout: post
title: "Tutorial JSF 2.2 - Sesión 6: Recursos"
date: 2014-06-25T18:00:00Z
last_modified_at: 2018-01-10T23:46:35.557Z
author: "Diego Silva Límaco"
permalink: /2014/06/tutorial-jsf-22-sesion-6-recursos.html
canonical_url: https://www.apuntesdejava.com/2014/06/tutorial-jsf-22-sesion-6-recursos.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "web"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "tutorial"
  - "jsf"
  - "jsf 2.2"
---

[![Tutorial JSF 2.2 - Sesión 6: Recursos]({{ '/assets/blogger/books1.png' | relative_url }})]({{ '/assets/blogger/books1.png' | relative_url }})

En JSF se pueden incluir recursos tales como hojas de estilos (CSS), javascript e imágenes que queramos usar en nuestra web, pero de una manera ordenada. En este post veremos cómo lo hace.

A partir de la versión JSF 2.0, los recursos pueden ubicarse en un subdirectorio bajo una carpeta llamada `resources` (así, tal cual el nombre) que debería estar dentro de la raíz del módulo web (donde están todos los archivos web) o bajo `META-INF`. Por convención, los componentes de JSF reconoce uno de estas dos ubicaciones.

Los nombres de los directorios de los recursos serán los mismos que se declaren en el atributo `library` de los componentes JSF.

Por ejemplo, para nuestros archivos .css lo guardaremos dentro de la carpeta `/resources/css/`, lo invocaremos con el tag

```java
<h:outputStylesheet library="css" name="style.css"/>
```

Para los javascript que están dentro de la carpeta `js`, lo invocamos así:

```java
<h:outputScript library="js" name="jquery-2.1.1.min.js"/>
```

Las imágenes, si están dentro de la carpeta `images` se invocaría así:

```java
<h:graphicImage library="images" name="la_tierra.jpg"/>
```

Finalmente, tendríamos la siguiente estructura

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGaFOxItUbOOX3N3gYL_HGtnEd6LuFcX6T2_PlFOfASCS1EYaeTdFSLysznAMN5RtaUpaGW8z9UC-9IGyBo8mRILw8N4TjuK5AR8yNU8yqDL6-zutldInf-W-le2gW5YZf_zD1SUDhph4/s1600/24-06-2014+07-21-57+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGaFOxItUbOOX3N3gYL_HGtnEd6LuFcX6T2_PlFOfASCS1EYaeTdFSLysznAMN5RtaUpaGW8z9UC-9IGyBo8mRILw8N4TjuK5AR8yNU8yqDL6-zutldInf-W-le2gW5YZf_zD1SUDhph4/s1600/24-06-2014+07-21-57+p.m..png)

y el código completo sería este:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html">
    <h:head>
        <title>Recursos en JSF</title>
        <h:outputStylesheet library="css" name="style.css"/>
        <h:outputScript library="js" name="jquery-2.1.1.min.js"/>
    </h:head>
    <h:body>
        <h:outputText id="info" styleClass="info" value="Esto es un mensaje de información" />
        <h:graphicImage library="images" name="la_tierra.jpg"/>
        <script>
             $("#info").hover(function(){
                 $(this).fadeOut("slow");
                 $(this).fadeIn("slow");
             })
        </script>
    </h:body>
</html>
```

### Código fuente

El código para explorar lo pueden encontrar aquí:

[https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-06-recursos/](https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-06-recursos/)

Y para descargar, aqui:

[https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-06-recursos.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-06-recursos.tar.gz)

**¡Bendiciones a todos!**
