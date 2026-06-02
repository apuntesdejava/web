---
layout: post
title: "Descargar XLS y PDF sin abrirlos en el navegador (versión Servlet)"
date: 2010-08-18T21:19:00.001Z
last_modified_at: 2015-12-07T20:52:19.015Z
author: "Diego Silva"
permalink: /2010/08/descargar-xls-y-pdf-sin-abrirlos-en-el.html
canonical_url: https://www.apuntesdejava.com/2010/08/descargar-xls-y-pdf-sin-abrirlos-en-el.html
tags:
  - "servlets"
  - "java ee"
  - "java"
  - "web"
  - "tips"
---

![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhqsOe0PGFMzwEswvvzu4LnjI-KCO1YCvbXhbgGBQHAZskVDHbOb_W-sj7D7zFqXcb0C0U5Zy9BHFnmWta5KNKjigdPlS8f86AJTqjmxiXNYFCWscJko8YKq4AexdjYT3nNkvmOaYNt0o2R/s200/download-button.jpg)

Anteriormente hice un post de cómo "[Descargar XLS y PDF sin abrirlos en el navegador]({{ '/2007/04/descargar-xls-y-pdf-sin-abrirlos-en-el.html' | relative_url }})" pero fue realizado con PHP. Ahora les traigo el mismo ejemplo pero usando Servlet

Para realizar esto, es necesario tener un Servlet que reciba como parametro el `url` que le indica dónde está el archivo a mostrar para descargar. En este ejemplo he preparado para que descargue desde cualquier host.

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paramUrl = request.getParameter("url"); //el URL enviado como parametro
        URL url = new URL(paramUrl);

        response.setContentType("application/octet-strem");
        response.setHeader("Content-Disposition", "attachment;filename='" + url.getFile() + "'"); //preparando el 'download' al navegador

        URLConnection connection = url.openConnection();
        InputStream in = connection.getInputStream(); //conectando para descargar
        OutputStream out = new DataOutputStream(response.getOutputStream());

        byte[] buffer = new byte[BUFFER_SIZE];
        int sizeRead = 0;
        while ((sizeRead = in.read(buffer)) >= 0) { //leyendo del host
            out.write(buffer, 0, sizeRead); //escribiendo para el navegador
        }
        in.close(); // y cerrando
        out.close(); // todo

    }
```

El proyecto utilizado para este ejemplo se encuentra aquí:

[http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fweb%252FDescargarWebApp.tar.gz](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fweb%252FDescargarWebApp.tar.gz)
