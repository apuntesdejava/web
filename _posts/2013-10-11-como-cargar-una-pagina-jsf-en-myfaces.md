---
layout: post
title: "Cómo cargar una página JSF en MyFaces / ADF dentro de un iframe"
date: 2013-10-11T21:37:00.001Z
last_modified_at: 2013-10-11T21:55:44.232Z
author: "Diego Silva Límaco"
permalink: /2013/10/como-cargar-una-pagina-jsf-en-myfaces.html
canonical_url: https://www.apuntesdejava.com/2013/10/como-cargar-una-pagina-jsf-en-myfaces.html
tags:
  - "adf"
  - "web"
  - "myfaces"
  - "jsf"
  - "tips"
  - "trucos"
---

[![](/assets/blogger/MyFaces_logo.jpg)](/assets/blogger/MyFaces_logo.jpg)

[Oracle Application Development Framework](http://www.oracle.com/technetwork/es/developer-tools/adf/) (más conocido como ADF) está basado en [Apache MyFaces](http://myfaces.apache.org/). Algunas de sus configuraciones se puede hacer en los archivos de Myfaces, como el `trinidad-config.xml`. Esta semana me he roto la cabeza tratando de cargar una página JSF de ADF dentro de un `iframe` que estaba en otro contexto. Noté que sí cargaba la página, sí la identificaba, pero no la mostraba. Comencé a revisar la configuración del archivo `web.xml` y encontré un parámetro muy escondido.

El parámetro `org.apache.myfaces.trinidad.security.FRAME_BUSTING` es quien hace la magia. Por omisión tiene valor `differentOrigin` que significa que si se trata de cargar en un frame desde un **contexto diferente**, detiene la carga (ajá! justo lo que me pasaba). Así que solamente le puse el valor `never`.. y listo, problema solucionado.

Aquí está la documentación del parámetro: [http://myfaces.apache.org/trinidad/devguide/configuration.html](http://myfaces.apache.org/trinidad/devguide/configuration.html)
