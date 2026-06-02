---
layout: post
title: "Tutorial JSF 2.2 - Sesión 2: Navegación"
date: 2013-09-25T06:00:00Z
last_modified_at: 2018-01-10T23:46:06.828Z
author: "Diego Silva Límaco"
permalink: /2013/09/tutorial-jsf-22-sesion-2-navegacion.html
canonical_url: https://www.apuntesdejava.com/2013/09/tutorial-jsf-22-sesion-2-navegacion.html
tags:
  - "web"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "tutorial"
  - "jsf"
  - "jsf 2.2"
---

[![](/assets/blogger/jsf-logo.png)](/assets/blogger/jsf-logo.png)

La navegación en JSF hace fácil la navegación entre páginas y permite manejar procesamiento adicional que sea necesario al momento de ir entre una página y otra.

Hay dos tipos de navegación: la **implícita **y la **definida por el usuario**.

En este post veremos estos dos con un ejemplo simple.

Para navegar de una página a otra dentro de una aplicación JSF se hacen a través de los tags `<h:commandLink />` y `<h:commandButton />`. Ambos hacen los mismo: **hacen un "post"** redireccionando el destino a otra página, o a la misma.

**Algo importante:** Para poder usar bien estos command, deben estar dentro de los tags ` <h:form> ... </h:form> `, sino, no funciona.

### Navegación implícita

La navegación implícita consiste en indicarle al tag - mediante el atributo `action` - a qué página se direccionará cuando sea ejecutado. Solo deberá ir el nombre del archivo sin la extensión. Es por ello que se llama "implícito".

Nuestro archivo `mensajes.properties`

```java
abrir_pagina_1_enlace=Este enlace abrirá la página 1
abrir_pagina_1_texto=Esta es la página 1
```

Nuestro `index.xhtml`:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <title>Facelet Title</title>
        <f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>

    </h:head>
    <h:body>
        <h:form>
            <h:commandLink value="#{msg.abrir_pagina_1_enlace}" action="pagina1" />

        </h:form>
    </h:body>
</html>
```

Notemos en la línea 13 (además de usar la buena práctica que vimos en el anterior post), el `action` solo indica el nombre del archivo a mostrar. No incluye la extensión.

Y nuestro archivo `pagina1.xhtml`

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <title>Facelet Title</title>
        <f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>
    </h:head>
    <h:body>
        <h1>#{msg.abrir_pagina_1_texto}</h1>
    </h:body>
</html>
```

### Navegación definida por el usuario

Este tipo de navegación se hace usando un archivo de configuración, tal como `faces-config.xml` usando reglas en formato xml. La estructura de la regla es bastante simple:

- Se indica en qué página se ejecutará la regla

- Qué comando y orden se ejecutará

- Qué página se mostrará.

Creemos los enlaces en la página de inicio (`index.xhtml`)

```java
<li>#{msg.navegacion_definida_usuario}
                    <ul>
                        <li><h:commandLink action="page1" value="#{msg.pagina1_enlace}" /></li>
                        <li><h:commandLink action="page2" value="#{msg.pagina2_enlace}" /></li>
                    </ul>
                </li>
```

Y crearemos dos páginas más `navegacion_definida_usuario_pagina1.xhtml` y `navegacion_definida_usuario_pagina2.xhtml`

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>
        <title>#{msg.navegacion_definida_usuario}</title>
    </h:head>
    <h:body>
        <h1>#{msg.navegacion_definida_usuario}</h1>
        <h2>#{msg.pagina1}</h2>

        <h:form>
            <h:commandButton value="#{msg.ir_inicio}" action="index" />
        </h:form>
    </h:body>
</html>
```

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>
        <title>#{msg.navegacion_definida_usuario}</title>
    </h:head>
    <h:body>
        <h1>#{msg.navegacion_definida_usuario}</h1>
        <h2>#{msg.pagina2}</h2>

        <h:form>
            <h:commandButton value="#{msg.ir_inicio}" action="index" />
        </h:form>
    </h:body>
</html>
```

Sí, el único fue el titulo y el nombre físico del archivo.

Ahora bien ¿cómo se le dice que cuando se llame a `page1` vaya a `navegacion_definida_usuario_pagina1.xhtml` ? Aquí es donde entrar el archivo de configuración. Si lo ejecutamos tal cual, nos aparecerá un mensaje de advertencia.

[![](/assets/blogger/nav01.png)](/assets/blogger/nav01.png)

Para ello, crearemos un nuevo archivo (Ctrl+N) y en la categoría "JavaServer Faces" seleccionamos "JSF Faces Configuration".

[![](/assets/blogger/nav02.png)](/assets/blogger/nav02.png)

Clic en "Next" y clic en "Finish" aceptando todas las opciones por omisión.

Se nos abrirá en el editor el archivo en formato xml. Hagamos clic en el barra superior sobre el botón "PageFlow".

[![](/assets/blogger/nav03.png)](/assets/blogger/nav03.png)

Ahora sí!, algo visual en NetBeans!

[![](/assets/blogger/nav04.png)](/assets/blogger/nav04.png)

Desde aquí podemos definir la navegación desde index.html hasta las demás páginas. Veamos en el nodo que representa a `index.html` hay un icono cuadrado azul en el lado derecho. Hagamos clic allí y arrastremos la flecha hacía las páginas `navegacion_definida_usuario_pagina1.xhtml` y `navegacion_definida_usuario_pagina2.xhtml`

[![](/assets/blogger/nav05.png)](/assets/blogger/nav05.png)

Y veremos que cada arco tiene un nombre: `case1` y case2. Hagamos clic derecho en cada uno de ellos y seleccionemos "Rename..." para cambiarle el nombre a `page1` y `page2` respectivamente.

[![](/assets/blogger/nav06.png)](/assets/blogger/nav06.png)

Adicionalmente, podemos seleccionar el botón superior "Source"

```java
<?xml version='1.0' encoding='UTF-8'?>
<faces-config version="2.2"
    xmlns="http://xmlns.jcp.org/xml/ns/javaee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-facesconfig_2_2.xsd">
    <navigation-rule>
        <from-view-id>/index.xhtml</from-view-id>
        <navigation-case>
            <from-outcome>page1</from-outcome>
            <to-view-id>/navegacion_definida_usuario_pagina1.xhtml</to-view-id>
        </navigation-case>
        <navigation-case>
            <from-outcome>page2</from-outcome>
            <to-view-id>/navegacion_definida_usuario_pagina2.xhtml</to-view-id>
        </navigation-case>
    </navigation-rule>
</faces-config>
```

... pero es más rápido (y más bonito) con la parte visual, cierto? `:)`

Ahora, ejecutamos la aplicación, y probamos los enlaces.

### Navegación dependiente de un valor

Hasta este momento, las navegaciones eran en "duro", ya que están definidas hacía donde tiene que navegar. Pero lo más complejo - y lo más común - es que después de un procesamiento se decida a qué página hacer. Y este procesamiento lo haremos usando un `ManagedBean`.

Para hacer que nuestra aplicación decida a qué página debe direccionarse, bastará con hacer métodos que devuelvan una cadena y que no tengan parámetros en el ManagedBean. Lo que devuelva esos métodos pueden ser el nombre de la regla de navegación descrita en el `faces-config.xml` o pueden ser la ruta y nombre de los .xhtml que debería mostrar.

Vamos a hacer un ejemplo que demuestre esto. Haremos un enlace que llame a un método de un ManagedBean, este identificará la hora actual, y dependiendo de la hora redireccionará a una página que diga "buenos días", o "buenas tardes", o "buenas noches" dependiendo del caso.

Este es nuestro `ManagedBean`

```java
package com.apuntesdejava.jsf.controladores;

import java.util.Calendar;
import java.util.logging.Logger;
import javax.enterprise.context.RequestScoped;
import javax.inject.Named;

/**
 *
 * @author dsilva
 */
@Named("navegacionBean")
@RequestScoped
public class NavegacionBean {

    static final Logger LOGGER = Logger.getLogger(NavegacionBean.class.getName());

    public NavegacionBean() {
        LOGGER.info("Iniciando Bean");
    }

    public String saludar() {
        int hora = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
        if (hora < 12) {
            return "buenos-dias";
        }
        if (hora < 18) { //aquí en Lima, a partir de las 7pm ya es oscuro
            return "buenas-tardes";
        }
        if (hora < 23) {
            return "buenas-noches";
        }
        return null; //todo action=null redirecciona  a la misma página de donde fue invocado
    }
}
```

Nuestro `faces-config.xml` va a recibir esas respuestas y redireccionará a cada página según corresponda.

```java
<?xml version='1.0' encoding='UTF-8'?>
<faces-config version="2.2"
    xmlns="http://xmlns.jcp.org/xml/ns/javaee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-facesconfig_2_2.xsd">
   <navigation-rule>
        <from-view-id>/index.xhtml</from-view-id>
        <navigation-case>
            <from-outcome>page1</from-outcome>
            <to-view-id>/navegacion_definida_usuario_pagina1.xhtml</to-view-id>
        </navigation-case>
        <navigation-case>
            <from-outcome>page2</from-outcome>
            <to-view-id>/navegacion_definida_usuario_pagina2.xhtml</to-view-id>
        </navigation-case>
        <navigation-case>
            <from-outcome>buenos-dias</from-outcome>
            <to-view-id>/saludo/maniana.xhtml</to-view-id>
        </navigation-case>
        <navigation-case>
            <from-outcome>buenas-tardes</from-outcome>
            <to-view-id>/saludo/tarde.xhtml</to-view-id>
        </navigation-case>
        <navigation-case>
            <from-outcome>buenas-noches</from-outcome>
            <to-view-id>/saludo/noche.xhtml</to-view-id>
        </navigation-case>
    </navigation-rule>
</faces-config>
```

Y crearemos estos saludos en nuestro proyecto. Crearemos tres archivos llamados `maniana.xhtml`,`tarde.xhtml` y `noche.xhtml`. Por orden, los puse dentro de la subcarpeta `saludo`. Aquí solo mostraré uno de esos archivos, porque los demás serán iguales:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h1>#{msg.saludo_maniana}</h1>
        <h:form>
            <h:commandButton value="#{msg.ir_inicio}" action="/index" />
        </h:form>

    </h:body>
</html>
```

Y... cuando se invoca desde la página de inicio, se deberá llamar al `managedBean` seguido del método.

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>
        <title><h:outputText value="#{msg.app_title}"/></title>

    </h:head>
    <h:body>
        <h1><h:outputText value="#{msg.app_title}"/></h1>

        <h:form>
          #{msg.navegacion_procesada}<br/>
          <h:commandLink value="#{msg.saludar}" action="#{navegacionBean.saludar}"/>
        </h:form>
    </h:body>
</html>
```

Y listo! Probemos y veamos la magia!

### Antes de terminar...

Los nombres de las reglas de navegación pueden ser cualquiera, a gusto del desarrollador. Pero hay una lista de nombres comunes en las aplicaciones:

- success

- failure

- login

- no results

Estos lo podrás ver descritos aquí: [Configuring Navigation Rules](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-configure009.htm#BNAXF)

### El código fuente

Como siempre, aquí les ofrezco el código fuente que utilicé para este post.

[https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-02-navegacion.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-02-navegacion.tar.gz)

Y si quereís ver el código fuente sin descargar el proyecto, aquí lo podeís encontrar.

[https://java.net/projects/apuntes/sources/hg/show/jsf-02-navegacion](https://java.net/projects/apuntes/sources/hg/show/jsf-02-navegacion)

### Bibliografía

Naturalmente, toda esta información no fue tomada del aire ni de mi imaginación. Para este post me he basado de: **[The Java EE 7 Tutorial - Navigation Model](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-intro005.htm)**.

**Hasta el próximo tutorial!**

**Bendiciones a todos**
