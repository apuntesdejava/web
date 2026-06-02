---
layout: post
title: "Cambiando el Look And Feel de NetBeans"
date: 2008-10-17T20:34:00Z
last_modified_at: 2009-04-25T21:55:03.511Z
author: "Diego Silva"
permalink: /2008/10/cambiando-el-look-and-feel-de-netbeans.html
canonical_url: https://www.apuntesdejava.com/2008/10/cambiando-el-look-and-feel-de-netbeans.html
tags:
  - "netbeans 6.1"
  - "netbeans"
  - "netbeans 6.5"
  - "tips"
---

(Versión Wiki:[http://wiki.netbeans.org/TaT_CambiandoLookAndFeel](http://wiki.netbeans.org/TaT_CambiandoLookAndFeel))

El **look and feel** predeterminado desde la versión 6.5 del IDE NetBeans se establece de acuerdo al sistema operativo. Esto hace que el NetBeans parezca una aplicación de Windows con el **Look and Feel** del Windows que se esté usando, y así en cualquier sistema operativo.

![chlaf1.jpg](http://wiki.netbeans.org/attach/TaT_CambiandoLookAndFeel/chlaf1.jpg)

Para cambiar el **look and feel** necesitamos editar el archivo *netbeans.conf* que se encuentra en la subcarpeta **etc** del directorio de NetBeans. Abriremos ese archivo usando un editor de texto. Lo que necesitamos editar es la línea que dice "netbeans_default_options":

![chlaf2.jpg](http://wiki.netbeans.org/attach/TaT_CambiandoLookAndFeel/chlaf2.jpg)

Lo que debemos es agregar al final de la cadena (como parte de la cadena, es decir, dentro de las comillas dobles) lo siguiente:

```java
--laf javax.swing.plaf.metal.MetalLookAndFeel<br />
```

al reiniciar el IDE, veremos los cambios

![chlaf3.jpg](http://wiki.netbeans.org/attach/TaT_CambiandoLookAndFeel/chlaf3.jpg)

![](file:///d:/TEMP/moz-screenshot.jpg)![](file:///d:/TEMP/moz-screenshot-1.jpg)
