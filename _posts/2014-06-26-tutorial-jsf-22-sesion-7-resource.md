---
layout: post
title: "Tutorial JSF 2.2 - Sesión 7: Resource Library Contracts"
date: 2014-06-27T03:29:00.001Z
last_modified_at: 2018-01-10T23:50:27.440Z
author: "Diego Silva Límaco"
permalink: /2014/06/tutorial-jsf-22-sesion-7-resource.html
canonical_url: https://www.apuntesdejava.com/2014/06/tutorial-jsf-22-sesion-7-resource.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "netbeans 8"
  - "java ee 7"
  - "netbeans"
  - "jsf"
  - "jsf 2.2"
---

[![Resource Library Contracts](/assets/blogger/3d7123fced.jpg)](/assets/blogger/3d7123fced.jpg)

¿Qué pasaría si nuestra aplicación web debe lucir con diferentes estructuras de página en diferentes secciones de la aplicación? Sabemos que podemos usar los [facelets](/2013/12/tutorial-jsf-22-sesion-4-facelets-parte.html), que - dependiendo de qué plantilla le indiquemos - nos mostrará una estructura diferente. Pero, si son varias páginas que pertenecen a una carpeta, sería un suicidio poner en todas las páginas qué plantilla debe utilizar ¿cierto?. Aquí es donde aparecen los "Resource Library Contracts" (no encontré una traducción acorde al español) que consiste en usar una plantilla especial, si las páginas en cuestión están dentro de una URL específico

### Cómo funciona

Recordemos los Facelets: En nuestro cliente de la plantilla, usamos el tag `<ui:composition />` y le indicamos en el atributo `template` cuál es la plantilla a utilizar. Si queremos que una página utilice otra plantilla, le deberíamos cambiar el valor del atributo `template`. Pues bien, para usar los Resource Library Contracts, vamos a hacer que todos los clientes de plantilla *usen* la misma plantilla. Al menos vamos a indicarle que están en la misma ubicación. El truco está en el archivo `faces-config.xml`. Allí se le indicará, dependiendo del juego de caracteres de las páginas a mostrar, qué plantilla deberá utilizar.

### Ingredientes

Para nuestro ejemplo, usaremos:

- NetBeans 8 (también funciona con la versión 7 y todas sus actualizaciones)

- GlassFish v4

- JDK 7 | JDK 8

- Base de datos - NO

### Creando y configurando el proyecto

Por practicidad, los últimos proyectos lo estoy desarrollando con Maven. Por tanto, crearemos un proyecto Maven > Web Application

[![](/assets/blogger/01.png)](/assets/blogger/01.png)

Y lo llamaré `jsf-07-rlc`. Luego, le agregaremos el framework JSF. Para ello, entraremos a las propiedades del proyecto, y en la categoría "Frameworks", agregamos a "JavaServer Faces" y nos aseguramos que sea la versión JSF 2.2.

[![](/assets/blogger/02.png)](/assets/blogger/02.png)

Clic en "OK"

### Creación de las páginas

Crearemos cuatro páginas, dos de ellas estarán en la raíz del módulo web, y las otras dos estarán en una subcarpeta llamada "app1"

[![](/assets/blogger/03.png)](/assets/blogger/03.png)

Comenzaremos a editar el archivo `/index.xhtml`

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <ui:composition template="/template.xhtml">
            <ui:define name="content">
                <h1>Este es el contenido principal de la aplicación. </h1>
                <p>Podemos ver las páginas que tienen otra plantilla haciendo clic aquí:
                     <a href="#{facesContext.externalContext.requestContextPath}/faces/app1/index.xhtml">App</a>
                </p>
            </ui:define>
        </ui:composition>
    </h:body>
</html>
```

y su página hermana `page2.xhtml`

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <ui:composition template="/template.xhtml">
            <ui:define name="content">
                <h1>Esta es la página 2. </h1>
                <p>Aquí tenemos otra página, usando la plantilla por omisión.
                    <br/>Para entrar a la otra plantilla, debemos regresar a la página principal.<br/>
                    Hacer clic arriba donde dice "Inicio".
                </p>
            </ui:define>
        </ui:composition>
    </h:body>
</html>
```

Notemos que en ambos casos existe el tag `<ui:composition template="/template.xhtml">` que prácticamente dice que hay una plantilla en la raiz.

Ahora, editaremos las páginas de `/app1/index.xhtml`

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>

        <ui:composition template="/template.xhtml">
            <ui:define name="nav">
                <a href="#{facesContext.externalContext.requestContextPath}">Inicio principal</a> -
                <a href="page1.xhtml">Página 1</a>
            </ui:define>
            <ui:define name="content">
                <h1>Este es el contenido que se encuentra en la página inicial. </h1>
                <p>Utiliza otra plantilla. Todo luce diferente, pero el contenido es el mismo
                </p>
            </ui:define>
        </ui:composition>
    </h:body>
</html>
```

y aquí está `/app1/page1.xhtml`

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>

        <ui:composition template="/template.xhtml">
            <ui:define name="nav">
                <a href="#{facesContext.externalContext.requestContextPath}">Inicio principal</a> -
                <a href="index.xhtml">Inicio</a>
            </ui:define>
            <ui:define name="content">
                <h1>Este es el contenido de otra página que se encuentra en la página inicial. </h1>
                <p>Así se usan plantillas por páginas. Clic en el menú de arriba para cambiar de página.
                </p>
            </ui:define>
        </ui:composition>
    </h:body>
</html>
```

Igual aquí se están asumiendo la misma plantilla "/template", pero ahora veremos que esto no existe.. es solo una ilusión.

### Creando el "Contrato"

Primero, vamos a crear la plantilla que se usará para la carpeta app1. Luego, se creará el que será de omisión. Con ayuda del IDE, seleccionamos File > New > JavaServer Faces > JSF Resource Library Contract

[![](/assets/blogger/04.png)](/assets/blogger/04.png)

Clic en "Next"

Nuestro contrato se llamará "app". Notemos que lo creará dentro de la carpeta "contracts". Es una carpeta predefenida como la de "resources" que vimos en el [post anterior](/2014/06/tutorial-jsf-22-sesion-6-recursos.html).

Activamos el check de "Create Initial Template" para que nos cree una plantilla inicial.

[![](/assets/blogger/05.png)](/assets/blogger/05.png)

Clic en "Finish".

Veamos la estructura que ha creado.

[![](/assets/blogger/06.png)](/assets/blogger/06.png)

Vemos la carpeta "contracts", la subcarpeta "app" y dentro está la plantilla y su css. Notemos, además, que el template.xhtml está en la *raiz* relativa a "app"

También veamos el template.xhtml creado. Cuenta con dos `<ui:insert />` llamados "top" y "content".

[![](/assets/blogger/07.png)](/assets/blogger/07.png)

Cambiaremos el nombre del "top" a "nav", ya que contendrá nuestro menú principal

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets"
      xmlns:h="http://xmlns.jcp.org/jsf/html">

    <h:head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <h:outputStylesheet name="./css/default.css"/>
        <h:outputStylesheet name="./css/cssLayout.css"/>
        <title>App Template</title>
    </h:head>

    <h:body>

        <div id="top" class="top">
            <ui:insert name="nav">Top</ui:insert>
        </div>

        <div id="content" class="center_content">
            <ui:insert name="content">Content</ui:insert>
        </div>

    </h:body>

</html>
```

Crearemos otro contract, pero que se llamará "default" y no le pediremos que cree una plantilla. Con esto, solo nos creará la carpeta dentro de contract. Allí crearemos el archivo template.xml, que será nuestra nueva raíz.

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:ui="http://xmlns.jcp.org/jsf/facelets"
      xmlns:h="http://xmlns.jcp.org/jsf/html">

    <h:head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Default Template</title>
    </h:head>

    <h:body>

        <nav >
            <ui:insert name="nav">
                <h:form>
                    <h:commandLink value="Inicio" action="index"/> |
                    <h:commandLink value="Página 2" action="page2"/>
                </h:form>
            </ui:insert>
        </nav>

        <div id="content" class="center_content">
            <ui:insert name="content">Content</ui:insert>
        </div>

    </h:body>

</html>
```

### El gestor de contratos - faces-config.xml

Ahora, crearemos el archivo faces-config.xml: File > New > JavaServer Faces > JSF Faces Configuration

[![](/assets/blogger/08.png)](/assets/blogger/08.png)

Clic en Next, y con los valores predeterminados, clic en "Finish"

[![](/assets/blogger/09.png)](/assets/blogger/09.png)

El contenido será el siguiente:

```java
<?xml version='1.0' encoding='UTF-8'?>
<faces-config version="2.2"
              xmlns="http://xmlns.jcp.org/xml/ns/javaee"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-facesconfig_2_2.xsd">
    <application>
        <resource-library-contracts>
            <contract-mapping>
                <url-pattern>/app1/*</url-pattern>
                <contracts>app</contracts>
            </contract-mapping>
            <contract-mapping>
                <url-pattern>*</url-pattern>
                <contracts>default</contracts>
            </contract-mapping>
        </resource-library-contracts>
    </application>
</faces-config>
```

El primer contract (línea 8 al 11) define que todas las páginas que estén dentro de `/app1/*` usen el contrato `app`,

```java
<contract-mapping>
                <url-pattern>/app1/*</url-pattern>
                <contracts>app</contracts>
            </contract-mapping>
```

y el siguiente contrato  indica que todos los demás `<url-pattern>*</url-pattern>`(a manera de un default de switch case, es decir, si no se cumple lo de arriba, se aplica el último) se utilizará el contrato `default`

```java
<contract-mapping>
                <url-pattern>*</url-pattern>
                <contracts>default</contracts>
            </contract-mapping>
```

Y listo el pollo! (creo que tengo hambre).

### Proyecto en ejecución

Veamos cómo luce cuando se ejecuta. Esta es la página principal, con sus dos enlaces arriba, y el enlace de abajo que nos lleva a las páginas de /app1

Esta es la /index.xhtml

[![](/assets/blogger/10.png)](/assets/blogger/10.png)

 Cuando hacemos clic en "Pagina 2" de arriba, nos lanza esto

[![](/assets/blogger/11.png)](/assets/blogger/11.png)

Regresamos a la página "Inicio" y ahora le damos clic en "App"

[![](/assets/blogger/12.png)](/assets/blogger/12.png)

Y cuando hacemos clic en el menú de arriba en "Pagina 1", nos muestra esto

[![](/assets/blogger/13.png)](/assets/blogger/13.png)

### Código fuente

El código para explorarlo lo pueden encontrar aquí

[https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-07-rlc/](https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-07-rlc/)

Y el proyecto para bajar, está aquí:

[https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-07-rlc.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-07-rlc.tar.gz)

### Bibliografía

Este artículo está basado en el capítulo "[8.8 Resource Library Contracts](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-facelets008.htm)" del [Tutorial de Java EE 7](http://docs.oracle.com/javaee/7/tutorial/doc/)

¡Bendiciones a todos!
