---
layout: post
title: "Internacionalización (i18n) con Visual JSF"
date: 2008-10-16T17:44:00Z
last_modified_at: 2009-04-25T21:55:03.503Z
author: "Diego Silva"
permalink: /2008/10/internacionalizacion-i18n-con-visual.html
canonical_url: https://www.apuntesdejava.com/2008/10/internacionalizacion-i18n-con-visual.html
tags:
  - "netbeans 6.1"
  - "netbeans"
  - "jsf"
  - "web"
  - "netbeans 6.5"
---

(Versión Wiki: [http://wiki.netbeans.org/TaT_I18nVisualJSF](http://wiki.netbeans.org/TaT_I18nVisualJSF))

Todos sabemos que escribir un texto rígido (hard-code) en nuestras aplicaciones no es una buena práctica. Esto cubre también a los textos de los formularios. Todo debemos pasarlo a variables, y si modificamos el contenido de la variable, toda la aplicación donde usa esa variable, se actualizarán automáticamente. Bueno, eso lo sabemos todo.

Los mensajes de la interfaz de usuario - ya sea web o desktop - deben estar almacenados en un archivo de recurso llamado .properties. Además, estos tipos de archivos permiten la internacionalización (i18n)

En la web de Sun existe un tutorial sobre la i18n, y esta es [Trail: Internationalization](http://java.sun.com/docs/books/tutorial/i18n/index.html)

Aquí veremos como usar el archivo .properties para Visual JSF.

Para comenzar, diseñaremos un formulario simple como este:

![i18n-vjsf-01.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-01.jpg)

Ahora, en el panel del proyecto, dentro del paquete del código fuente, buscamos el archivo *Bundle.properties*.

![i18n-vjsf-02.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-02.jpg)

Editamos este archivo de tal manera que tengan los textos necesarios para nuestro formulario. Si es necesario, también usamos su texto localizado.

![i18n-vjsf-03.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-03.jpg)

Bundle.properties:

```java
app_upload_title=Load files package<br />app_upload_file=Select package<br />app_upload_submit=Submit<br />
```

Bundle_es.properties:

```java
app_upload_title=Cargar paquete de archivos<br />app_upload_file=Indique paquete de archivos<br />app_upload_submit=Cargar<br />
```

Regresamos al editor visual de nuestra aplicación. De la paleta de componentes, en la categoría **Advanced** buscamos el elemento *Load Bundle*

![i18n-vjsf-04.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-04.jpg)

Lo seleccionamos, lo arrastramos y lo soltamos sobre la ventana de editor visual. No pasará nada visual, pero si vemos en el panel *Navegador* veremos que existe el elemento *loadBundle*

![i18n-vjsf-05.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-05.jpg)

Ahora, volvemos a enfocarnos en el editor visual. Seleccionamos un elemento, por ejemplo el *Static text* que está en la parte superior. a este elemento escribimos en la propiedad *text* lo siguiente: **#{messages1.app_upload_title}**, para el componente *label* colocamos: **#{messages1.app_upload_file}**, y para el *botton* colocamos: **#{messages1.app_upload_submit}**

Al final del diseño, el editor mostrará lo siguiente

![i18n-vjsf-06.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-06.jpg)

Ahora, cuando desplegamos la aplicación, veremos que lucirá así:

![i18n-vjsf-07.jpg](http://wiki.netbeans.org/attach/TaT_I18nVisualJSF/i18n-vjsf-07.jpg)

Ahora, en adelante, si necesitamos modificar un texto, solo modificamos el archivo **Bundle.properties**
