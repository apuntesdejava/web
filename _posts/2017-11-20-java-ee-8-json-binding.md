---
layout: post
title: "Java EE 8 - Json Binding"
date: 2017-11-20T19:24:00Z
last_modified_at: 2018-01-10T23:40:54.389Z
author: "Diego Silva Límaco"
permalink: /2017/11/java-ee-8-json-binding.html
canonical_url: https://www.apuntesdejava.com/2017/11/java-ee-8-json-binding.html
description: "Una de las nuevas características de Java EE 8 es el api de JSON-B, o Json Binding, que consiste en mapear cada entrada de un dato json a un objeto java."
tags:
  - "jsonb"
  - "java ee"
  - "java ee 8"
  - "json"
---

Una de las nuevas características de Java EE 8 es el api de JSON-B, o Json Binding, que consiste en mapear cada entrada de un dato json a un objeto java.

[![](/assets/blogger/jsonb-logo.png)](/assets/blogger/jsonb-logo.png)

Aquí unos ejemplos:

## De cadena json a objeto

Considerando que existe una clase `Libro` con algunas propiedades, podemos convertir rápidamente de una cadena a un objeto, siempre y cuando las propiedades coincidan. Si no coincide un atributo del json con un campo del objeto, lo pondrá nulo.

```java
String json = "{\"nombre\":\"Los gatos caen de pie\",\"anio\":1234 }";

        Libro libro = JsonbBuilder.create().fromJson(json, Libro.class);
        System.out.println("libro:" + libro);
```

Y el resultado es:

```java
libro:Libro{nombre=Los gatos caen de pie, anio=1234, isbn=null, fechaPublicacion=null}
```

## De objeto a cadena json

Esta es otra forma muy útil. Primero instanciaremos nuestro objeto, y luego lo convertiremos:

```java
Libro libro = new Libro();
        libro.setAnio(2014);
        libro.setNombre("Los gatos no ladran");
        libro.setIsbn("123-456-789");
        libro.setFechaPublicacion(new Date());
        libro.setPrecio(13456.0);

        String json = JsonbBuilder.create(config).toJson(libro);

        System.out.println("json:" + json);
```

Adicionalmente, podemos usar el parámetro `config` para definir cómo será el json resultante:

```java
config = new JsonbConfig()
                .withFormatting(true)
                .withDateFormat("dd-MMMM-yyyy", Locale.getDefault())
                .withPropertyNamingStrategy(PropertyNamingStrategy.LOWER_CASE_WITH_UNDERSCORES);
```

El resultado es sorprendente:

```java
--- tojson ---
json:
{
    "anio": 2014,
    "fecha_publicacion": "20/11/2017",
    "isbn": "123-456-789",
    "nombre": "Los gatos no ladran",
    "valor": "13,456.00000"
}
```

## Código fuente

El código fuente del proyecto lo pueden descargar de aquí:

- [https://bitbucket.org/apuntesdejava/novedades-javaee-8/src/master/jsonb-demo/](https://bitbucket.org/apuntesdejava/novedades-javaee-8/src/master/jsonb-demo/)

- [https://github.com/apuntesdejava/javaday-peru-2017/tree/master/jsonb-demo](https://github.com/apuntesdejava/javaday-peru-2017/tree/master/jsonb-demo)
