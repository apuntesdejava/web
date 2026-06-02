---
layout: post
title: "Un vistazo a JSON-B de Java EE8"
date: 2017-04-06T17:17:00Z
last_modified_at: 2018-01-10T23:41:13.549Z
author: "Diego Silva Límaco"
permalink: /2017/04/un-vistazo-json-b-de-java-ee8.html
canonical_url: https://www.apuntesdejava.com/2017/04/un-vistazo-json-b-de-java-ee8.html
description: "Java EE 8 viene con muchas características interesantes, y en este post veremos un poco de la nueva implementación: JSON Binding, o también conocido como JSON-B (JSR-367)"
tags:
  - "jsonb"
  - "java ee"
  - "java ee 8"
  - "json"
---

[![](/assets/blogger/jsonb-logo.png)](/assets/blogger/jsonb-logo.png)

Java EE 8 viene con muchas características interesantes, y en este post veremos un poco de la nueva implementación: JSON Binding, o también conocido como JSON-B ([JSR-367](https://jcp.org/en/jsr/detail?id=367))

Ya tenenemos un JSON-P para manipular y procesar JSON (lo hemos visto en un post anterior: [Ejemplo básico de API JSON e Java EE7](/2015/08/ejemplo-basico-de-api-json-e-java-ee7.html) ) pero usarlo quizás no sea tan cómodo como es [Gson](https://github.com/google/gson) o [Jackson](https://github.com/FasterXML/jackson).

Java EE necesita de un estándar propio, por eso se encargaron de desarrollar el JSR-367 que consiste en procesar de Java a JSON y viceversa de manera muy transparente.

### Implementación

<iframe allowtransparency="true" frameborder="0" height="466" scrolling="no" src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1435026653175295%3A0&amp;width=500" style="border: none; overflow: hidden;" width="500"></iframe>

Está disponible una implementación muy madura para esta especificación. Se encuentra en [http://json-b.net](http://json-b.net/). Para usarlo en nuestro proyecto, necesitamos agregar estos repositorios en el `pmo.xml`

```java
<repository>
            <id>java.net-Public</id>
            <name>Maven Java Net Snapshots and Releases</name>
            <url>https://maven.java.net/content/groups/public/</url>
        </repository>
        <repository>
            <id>yasson-snapshots</id>
            <name>Yasson Snapshots repository</name>
            <url>https://repo.eclipse.org/content/repositories/yasson-snapshots</url>
        </repository>
```

Y consideramos estas dependencias:

```java
<dependency>
            <groupId>javax.json.bind</groupId>
            <artifactId>javax.json.bind-api</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <dependency>
            <groupId>org.eclipse</groupId>
            <artifactId>yasson</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <dependency>
            <groupId>org.glassfish</groupId>
            <artifactId>javax.json</artifactId>
            <version>1.1.0-SNAPSHOT</version>
        </dependency>
```

Con esta configuración, comenzamos nuestro ejemplo.

### El objeto

Comenzaremos con definir nuestro objeto, que es un Java Bean común y silvestre:
<script src="https://bitbucket.org/apuntesdejava/javaee8-jsonb-demo/src/master/src/main/java/com/apuntesdejava/javaee8/jsonb/Persona.java?embed=t"></script>

Luego, comenzaremos por crear nuestro procesador de JSON:

```java
Jsonb jsonb = JsonbBuilder.create();
```

Listo, no necesitamos nada más. Ahora continuaremos con el procesamiento.

### Objeto a JSON

```java
//Convirtiendo objeto a JSON
        Persona p = new Persona(1, "Diego");
        String obj2json = jsonb.toJson(p);
        System.out.println("json:" + obj2json);
```

Y el resultado es

```java
json:{"activo":false,"id":1,"nombre":"Diego"}
```

### JSON a Objeto

```java
//Convirtiendo JSON a Objeto
        String json = "{\"id\":10, \"nombre\":\"java\", \"fechaNacimiento\":\"1976-03-27T00:00:00\", \"activo\":true }";
        Persona q = jsonb.fromJson(json, Persona.class);
        System.out.println("objeto:" + q);
```

Notar como se pasan las fechas, y que los nombres de los atributos están entre comillas simples.

El resultado es

```java
objeto:Persona{id=10, nombre=java, fechaNacimiento=Sat Mar 27 00:00:00 COT 1976, activo=true}
```

### Lista de objetos a JSON

```java
//Convirtiendo Lista a JSON
        List<Persona> lista = Arrays.asList(p, q);
        String listaStr = jsonb.toJson(lista);
        System.out.println("Lista json:" + listaStr);
```

La salida es:

```java
Lista json:[{"activo":false,"id":1,"nombre":"Diego"},{"activo":true,"fechaNacimiento":"1976-03-27T00:00:00","id":10,"nombre":"java"}]
```

### JSON a Lista de objetos

```java
//Convirtiendo JSON a Lista
        String listaJson = "[{\"id\":1,\"nombre\":\"Ana\"},{\"id\":2,\"nombre\":\"Beto\",\"activo\":true},{\"id\":3,\"nombre\":\"Carlos\",\"fechaNacimiento\":\"2000-05-06T00:00:00\"}]";
        List<Persona> personas = jsonb.fromJson(listaJson, new ArrayList<Persona>() {
        }.getClass());
        System.out.println("Personas:" + personas);
```

Y el resultado es:

```java
Personas:[{id=1, nombre=Ana}, {id=2, nombre=Beto, activo=true}, {fechaNacimiento=2000-05-06T00:00:00, id=3, nombre=Carlos}]
```

### Personalizando el JSON

Adicionalmente este API puede ser personalizado, aquí un par de muestras:

```java
//Personalizado el JSONP
        JsonbConfig config = new JsonbConfig()
                .withFormatting(Boolean.TRUE)    //salidas con formato
                .withDateFormat("dd/MM/yyyy", Locale.getDefault()) //como manejar las fechas
                .withPropertyNamingStrategy(PropertyNamingStrategy.LOWER_CASE_WITH_DASHES); //otra forma de manipular las propiedades

        Jsonb jsonb2 = JsonbBuilder.create(config);
```

JSON a Objeto, un poco cambiado:

```java
String json2 = "{\"id\":10,\"fecha_nacimiento\":\"23/08/1999\" }";
        Persona p2 = jsonb2.fromJson(json2, Persona.class);
        System.out.println("json personalizado:" + p2);
```

Y esta es la salida:

```java
json personalizado:Persona{id=10, nombre=null, fechaNacimiento=null, activo=false}
```

Notemos cómo reconoce el nombre de las propiedades entre `fecha_nacimiento` de JSON con `fechaNacimiento` de Java, además del formato de fecha.

Y convertir de Objeto a JSON:

```java
String json3 = jsonb2.toJson(q);
        System.out.println("persona con json personalizado:" + json3);
```

Y este es el resultado

```java
persona con json personalizado:
{
    "activo":true,
    "fecha-nacimiento":"27/03/1976",
    "id":10,
    "nombre":"java"
}
```

Luce bonito, no?

### Código fuente

No puede faltar el código fuente que usé en este proyecto:

- Para descargar: [https://bitbucket.org/apuntesdejava/javaee8-jsonb-demo/downloads/](https://bitbucket.org/apuntesdejava/javaee8-jsonb-demo/downloads/)

- Código en Git: [https://bitbucket.org/apuntesdejava/javaee8-jsonb-demo](https://bitbucket.org/apuntesdejava/javaee8-jsonb-demo)

### Bibliografía adicional

- [JSON-B Public Review Draft Now Available](http://blog.rahmannet.net/2016/06/json-b-public-review-draft-now-available.html) por Reza Rahman

>

Un vistazo a JSON-B de Java EE8[#JavaEE](https://twitter.com/hashtag/JavaEE?src=hash) [#JavaEE8](https://twitter.com/hashtag/JavaEE8?src=hash) [#JSON](https://twitter.com/hashtag/JSON?src=hash) [#JSONB](https://twitter.com/hashtag/JSONB?src=hash)[https://t.co/AKW4eSnMeQ](https://t.co/AKW4eSnMeQ)

— Apuntes de Java (@apuntesdejava) [6 de abril de 2017](https://twitter.com/apuntesdejava/status/850037289266950144)

<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>

<iframe allowtransparency="true" frameborder="0" height="349" scrolling="no" src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1477027595641867&amp;width=500" style="border: none; overflow: hidden;" width="500"></iframe>
