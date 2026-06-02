---
layout: post
title: "Tutorial JavaServer Faces 2.2 - Java EE 7 - Sesión 1"
date: 2013-09-17T19:32:00Z
last_modified_at: 2018-01-10T23:45:48.987Z
author: "Diego Silva Límaco"
permalink: /2013/09/tutorial-javaserver-faces-22-java-ee-7.html
canonical_url: https://www.apuntesdejava.com/2013/09/tutorial-javaserver-faces-22-java-ee-7.html
tags:
  - "web"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "tutorial"
  - "jsf"
  - "jsf 2.2"
---

[![]({{ '/assets/blogger/lossless-page1-320px-20110510-jsf-logo.tiff.png' | relative_url }})]({{ '/assets/blogger/lossless-page1-320px-20110510-jsf-logo.tiff.png' | relative_url }})

¡Ahora sí! Mi primer tutorial de JSF! Lo tengo esperando desde la versión 2.0 :) Pero más vale tarde que nunca.

Yo era muy defensor de Struts 1x, y lo veía con malos ojos al JSF 1.x. Cuando apareció la versión 2.0 con el JavaEE 6, lo probé y me resultó mucho más fácil que el Struts. Por ello, me propuse (desde post anteriores... muy anteriores) a hacer un tutorial de JSF. Espero que me puedan seguir, y si tienen alguna duda, no duden en escribir en los comentarios de este post, en el [Google Plus](https://plus.google.com/117671463358109569531), y en el [Facebook](http://facebook.com/ApuntesDeJava).

¡Comencemos!

Por si acaso, varios puntos me basaré del mismo tutorial que tiene Oracle en su página: [JavaServer Faces Techhology](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-intro.htm)

## ¿Qué es JavaServer Faces?

Esta tecnología es un marco de trabajo del lado del servidor que permite construir aplicaciones Java basadas en Web. Digo que es del lado del servidor, porque se instala en el servidor y este genera las páginas web. Por otro lado, una marco de trabajo del lado del cliente son los que se crean en el mismo cliente web, como por ejemplo JQuery y Dojo.

Este marco de trabajo tiene bastantes características que permiten crear aplicaciones web muy sofisticadas, de manera fácil y segura. (Parece un cliché que mencionan en cualquier producto)

## Partes de una aplicación JavaServer Faces

Una aplicación típica de JavaServer Faces comprende lo siguiente:

- Un conjunto de páginas web en la que se distribuyen los componentes.

- Un conjunto de etiquetas (tags) para agregar componentes a las páginas.

- Un conjunto de beans administrados (ManagedBeans), que son administrados por el contenedor usando objetos. Estos beans administrados son los que están *detrás* de una página proporcionando propiedades y funciones a la interfaz de usuario.

- Un archivo descriptor web (web.xml)

- Adicionalmente, archivos de configuración de recursos (faces-config.xml)

- Además, objetos personalizados: validadores, convertidores, oidores (listeners) para mejorar la aplicación.

- Y etiquetas adicionales personalizadas.

En la siguiente imagen se puede ver la interacción entre el cliente y el servidor en una página JSF.

[![]({{ '/assets/blogger/jeett_jsfintro-server.png' | relative_url }})]({{ '/assets/blogger/jeett_jsfintro-server.png' | relative_url }})

## Primera aplicación JavaServer Faces

Sin mucho más preámbulo (y si te aburre la teoría, seguramente haz venido directamente a esta sección) crearemos nuestra primera aplicación en NetBeans.

Para esto necesitaremos

- Java SE 7

- NetBeans 7.3 (con actualizaciones) o 7.3.1

- GlassFish 4.0 (y configurado con NetBeans)

### 1. Creando la aplicación

Como siempre, comenzamos por crear un nuevo proyecto desde File > New Project (o Shift+Ctrl+N) y se nos presentará la ventana para crear un nuevo proyecto. Seleccionamos la categoría web y en proyecto: "Web Application".

[![]({{ '/assets/blogger/jsf01.png' | relative_url }})]({{ '/assets/blogger/jsf01.png' | relative_url }})

Clic en "Next".

Escribiremos el nombre **jsf-01-primera-aplicacion**.

[![]({{ '/assets/blogger/jsf02.png' | relative_url }})]({{ '/assets/blogger/jsf02.png' | relative_url }})

Clic en "Next".

Seleccionamos el servidor GlassFish 4.0 y seleccionamos Java EE 7 Web.

[![]({{ '/assets/blogger/jsf03.png' | relative_url }})]({{ '/assets/blogger/jsf03.png' | relative_url }})

Clic en "Next"

En las opciones de "Framework", activamos la opción "JavaServer Faces" y nos aseguramos de que utilice en "Server Library" la opción JSF 2.2. Si no aparece esta opción, es muy probable que no esté seleccionada la versión Java EE 7.

[![]({{ '/assets/blogger/jsf04.png' | relative_url }})]({{ '/assets/blogger/jsf04.png' | relative_url }})

Clic en "Finish"

Listo, ya tenemos el proyecto JSF con una página.

[![]({{ '/assets/blogger/jsf05.png' | relative_url }})]({{ '/assets/blogger/jsf05.png' | relative_url }})

Lo ejecutamos, y lo que nos muestra es algo muy sencillo.

[![]({{ '/assets/blogger/jsf06.png' | relative_url }})]({{ '/assets/blogger/jsf06.png' | relative_url }})

### 2. Creando recurso de texto

Lo primero que recomiendo es **no escribir texto alguno en la página**. Es mejor usar un recurso donde estén todos los mensajes a mostrar. Si necesitamos hacer un cambio, en vez de buscar entre todas las páginas, solo cambiamos el contenido del archivo de recursos. Estos archivos de recursos son básicamente archivos .properties.

Comenzaremos con crear este archivo en File > New File (Ctrl + N) y seleccionamos en categoría "Others" y el tipo de archivo "Properties file"

[![]({{ '/assets/blogger/jsf08.png' | relative_url }})]({{ '/assets/blogger/jsf08.png' | relative_url }})

Clic en "Next"

Establecemos un nombre de archivo, en este caso se llamará "mensajes" y la ruta donde se ubicará. Se deberá indicar como ruta de carpeta en formato de paquete dentro de la carpeta "src", es decir, en lugar de colocar puntos (.) como separador de paquete, colocaremos la barra inclinada (/). (Posteriormente para acceder a ese archivo, lo haremos como una clase Java)

[![]({{ '/assets/blogger/jsf09.png' | relative_url }})]({{ '/assets/blogger/jsf09.png' | relative_url }})

Clic en "Finish"

Notar como se ha creado la estructura de carpetas en el proyecto, y la ubicación del archivo.

[![]({{ '/assets/blogger/jsf10.png' | relative_url }})]({{ '/assets/blogger/jsf10.png' | relative_url }})

Ahora, escribamos un texto que usaremos en la aplicación. Será el título de la aplicación. Luego, pondremos otro texto más, pero este se separará por puntos.

```java
app_title=Mi primera aplicación JSF
app.formulario=Directorio de contacto
```

[![]({{ '/assets/blogger/jsf11.png' | relative_url }})]({{ '/assets/blogger/jsf11.png' | relative_url }})

Necesitamos usar este archivo de recursos en nuestra página. Por tanto, regresemos a `index.html` y escribamos lo siguiente después del tag `<head> ` (Recomiendo mucho comenzar a escribir presionando Ctrl+Espacio. Esto activará el autocompletado de código y ayudará enormemente la creación de código) :

```java
<f:loadBundle basename="com.apuntesdejava.jsf.resources.mensajes" var="msg"/>
```

Notemos cómo se debe escribir para acceder al recurso. Como decía líneas arriba, se va a acceder como una clase: organizada por paquetes y sin la extensión ".properties". Ahora, para hacer referencia a ese recurso de mensajes lo guardaremos en la variable "msg".

Sigamos con escribir dentro de `<head>  </head>` escribir:

```java
<h:outputText value="#{msg.app_title}" />
```

[![]({{ '/assets/blogger/jsf12.png' | relative_url }})]({{ '/assets/blogger/jsf12.png' | relative_url }})

Vemos que se coloca el nombre de la variable, seguido de la clave del texto del properties separados por un punto.

Podemos ir ejecutando la aplicación, y veremos que aparecerá en el título del navegador, el texto que hemos colocado.

[![]({{ '/assets/blogger/jsf13.png' | relative_url }})]({{ '/assets/blogger/jsf13.png' | relative_url }})

Y ahora, agreguemos cómo título, el otro texto. Pero notemos que la clave de este texto tiene puntos "`app.formulario`"

Para usarlo, escribiremos la clave encerrándolo entre corchetes:

```java
#{msg['app.formulario']}
```

[![]({{ '/assets/blogger/jsf14.png' | relative_url }})]({{ '/assets/blogger/jsf14.png' | relative_url }})

Y al ejecutar la aplicación, nos mostrará:

[![]({{ '/assets/blogger/jsf15.png' | relative_url }})]({{ '/assets/blogger/jsf15.png' | relative_url }})

Con esto ya comenzamos a tener un código limpio de textos, y únicamente tendrán puras etiquetas.

Hemos comenzado con la capa de Vista. Ahora vamos a darle la vida a esta vista usando la capa Controladora.

### 3. Controlador de JSF

El controlador de JSF está basado en un Bean. Este es el ManagedBean. Antes se usaba la notación @ManagedBean, pero a partir de JavaEE7 se recomienda usar un @Name. Ya que técnicamente hacen lo mismo, esto es para reducir notaciones redundantes.

Se recomienda usar un Bean por cada vista, ya que serán las controladores de las páginas.

Crearemos un nuevo archivo (Ctrl+N) y seleccionamos en la categoría "JavaServer Faces" el tipo "JSF ManagedBean"

[![]({{ '/assets/blogger/jsf17.png' | relative_url }})]({{ '/assets/blogger/jsf17.png' | relative_url }})

Clic en "Next"

Ahora, colocaremos el nombre de nuestra clase, el paquete, y otras propiedades que tendrá el ManagedBean.

- Class Name: ContactoFormBean

- Package: com.apuntesdejava.jsf.controladores

- Name: contactoFormBean (se ha autogenerado)

- Scope: request

[![]({{ '/assets/blogger/jsf18.png' | relative_url }})]({{ '/assets/blogger/jsf18.png' | relative_url }})

Clic en "Finish"

Si vemos la clase generada, es una clase común y corriente, solo con dos notaciones adicionales `@Named` y `@RequestScoped`. La simplicidad de la creación de clases desde JavaEE 6, nos permite que tengamos los componentes únicamente con solo declarar la clase, sin ningún archivo adicional. Si hubiéramos creado una clase simple, y le colocábamos esas notaciones, tendríamos el mismo resultado.

[![]({{ '/assets/blogger/jsf19.png' | relative_url }})]({{ '/assets/blogger/jsf19.png' | relative_url }})

Este ManagedBean será nuestra clase que permitirá controlar el formulario para registrar los nombres de nuestro directorio de contactos.

Vamos a usar esta clase para que haga cosas simples, y a medida que vayamos avanzando, vamos a ponerlo más interesante. Hagamos que reciba un nombre, y luego que devuelva un saludo (Sí, el clásico "hola mundo")

Crearemos una propiedad en esta clase. Recordemos que es una clase POJO, por tanto, debemos sujetarnos a las reglas de un JavaBean con respecto a las propiedaes. Crearemos una propiedad llamada "nombre" de tipo "String" con sus respectivos accesores.

Tenemos varias maneras: una es escribiendo todas las declaraciones; otra, escribir la propiedad y usar la herramienta de encapsulamiento; o, haciendo clic derecho en el código fuente y seleccionar "insert code" (o presionando Alt+Insert)

[![]({{ '/assets/blogger/jsf20.png' | relative_url }})]({{ '/assets/blogger/jsf20.png' | relative_url }})

Y escribimos el campo nombre, la palabra "nombre", y dejamos las demás opciones en los valores por omisión.

[![]({{ '/assets/blogger/jsf21.png' | relative_url }})]({{ '/assets/blogger/jsf21.png' | relative_url }})

Clic en "Ok". Y el código se habrá generado, con todo y su Javadoc. Si no queremos que aparezca el Javadoc, desactivamos la creación en la ventana anterior.

[![]({{ '/assets/blogger/jsf22.png' | relative_url }})]({{ '/assets/blogger/jsf22.png' | relative_url }})

Además, agregaremos un método nuevo que permitirá devolver un saludo:

```java
public String getSaludo(){
        return "Hola "  +nombre;
    }
```

Pero como aún tiene *hardcode*, vamos a usar el mismo recurso para mostrar el saludo. Para hacerla más simple, crearemos la clase `ResourcesUtil` y tendrá un método:

```java
package com.apuntesdejava.jsf.util;

import javax.faces.context.FacesContext;

public class ResourcesUtil {

    public static String getString(String key) {
        FacesContext context = FacesContext.getCurrentInstance();
        String value = context.getApplication().evaluateExpressionGet(context, key, String.class);

        return value;
    }
}
```

y ahora sí, nuestro método de saludo lucirá así:

```java
public String getSaludo(){
        return ResourcesUtil.getString("#{msg['app.saludo']}")  +nombre;
    }
```

Terminemos nuestro formulario en `index.xhtml`: Agregemos los controles necesarios:

```java
<h:form>

            <h:outputLabel value="#{msg['app.nombre']}" for="nombre"/>
            <h:inputText value="#{contactoFormBean.nombre}" id="nombre" />

            <h:commandButton value="#{msg['app.saludar']}" />
            <h:outputText value="#{contactoFormBean.saludo}" />
        </h:form>
```

No olvidar tener en el archivo `mensajes.properties` las claves necesarias:

```java
app_title=Mi primera aplicación JSF
app.formulario=Directorio de contacto
app.nombre=Nombre
app.saludo=Hola
app.saludar=Saludar
```

Lo ejecutamos, y veremos en acción..!

[![]({{ '/assets/blogger/jsf23.png' | relative_url }})]({{ '/assets/blogger/jsf23.png' | relative_url }})

... yyyy...... se ve feo, ¿cierto?

Vemos un "null" que no debería mostrarse hasta que tenga valor, también vemos que está en una sola línea.

Vamos a arreglarlo.

### 4. Arreglando la interfaz de usuario

Primero, vamos a poner el botón más abajo. Pero no usemos `<br/>` sino vamos a ponerlo dentro de una malla.

Envolvemos la etiqueta, el input y el botón en un panelGrid, que tenga dos columnas:

```java
<h:panelGrid columns="2">
                <h:outputLabel value="#{msg['app.nombre']}" for="nombre"/>
                <h:inputText value="#{contactoFormBean.nombre}" id="nombre" />
                <h:commandButton value="#{msg['app.saludar']}" />
            </h:panelGrid>
```

¿Por qué dos columnas? Pues para que ponga un componente al costado de otro, y que hayan dos por fila.

[![]({{ '/assets/blogger/jsf24.png' | relative_url }})]({{ '/assets/blogger/jsf24.png' | relative_url }})

Ahora, necesitamos que el mensaje "Hola null" no aparezca, hasta que el "null" no sea "null". Es decir, hasta que la propiedad "nombre" tenga un valor.

Podrían decir si se usa un "if"; pero con JSF podemos hacer algo más elegante.

Agreguemos el atributo "rendered" a ese tag. Este atributo - que existe en todos los componentes de JSF - recibe un valor boolean. Si es "true" (por omisión) mostrará el componente en la interfaz de usuario. Si es "false", no.

```java
<h:outputText value="#{contactoFormBean.saludo}"
                          rendered="#{contactoFormBean.nombre ne null}" />
```

El operador `ne` significa "no equal".

Lo ejecutamos, y veremos cómo funciona:

Antes del clic en el botón:

[![]({{ '/assets/blogger/jsf25.png' | relative_url }})]({{ '/assets/blogger/jsf25.png' | relative_url }})

Después del clic en el botón

[![]({{ '/assets/blogger/jsf26.png' | relative_url }})]({{ '/assets/blogger/jsf26.png' | relative_url }})

## Conclusiones

En este primer ejemplo de JSF, no hemos cubierto únicamente hacer un "hola mundo", sino mostrar algunas características de JSF:

- Declarar un ManagedBean usando la anotación `@Named` (nuevo en JSF 2.2)

- Usando un archivo de recursos para los mensajes (buena práctica).

- Acomodando la distribución de los componentes usando un `<h.panelGrid />`

- Mostrando un componente usando el atributo `rendered`

Para terminar, aquí les dejo el código fuente de este proyecto.

**Código fuente:**[https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-01-primera-aplicacion.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-01-primera-aplicacion.tar.gz)

 Espero que les sea de utilidad, y nos veremos en un siguiente tutorial.
