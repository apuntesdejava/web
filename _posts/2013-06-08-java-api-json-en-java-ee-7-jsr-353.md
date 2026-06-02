---
layout: post
title: "Java API JSON en Java EE 7 (JSR 353)"
date: 2013-06-08T20:04:00.004Z
last_modified_at: 2013-06-08T20:04:50.576Z
author: "Diego Silva Límaco"
permalink: /2013/06/java-api-json-en-java-ee-7-jsr-353.html
canonical_url: https://www.apuntesdejava.com/2013/06/java-api-json-en-java-ee-7-jsr-353.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "java"
  - "web"
  - "netbeans 7.4"
  - "java ee"
  - "json"
  - "java ee 7"
  - "tutorial"
  - "netbeans"
---

[![](/assets/blogger/jsr-353.png)](/assets/blogger/jsr-353.png)

El [JSON](http://json.org/json-es.html) es un formato bastante usado para el envío de datos por internet. Es más ligero que los XML, y es usado en el API de las redes sociales tales como [Twitter](https://dev.twitter.com/docs/api/1.1), [Google](https://developers.google.com/gdata/docs/directory), [Flickr](http://www.flickr.com/services/api/response.json.html), [Facebook](https://developers.facebook.com/docs/reference/api/), etc.

En Java, para poder procesar ([parsing](http://en.wikipedia.org/wiki/Parsing)) un texto JSON, existen varias bibliotecas (revisar al pie de la página de [http://json.org/json-es.html](http://json.org/json-es.html)). Personalmente me gusta el [GSon](http://code.google.com/p/google-gson/) de Google. Pero es tiempo que el mismo Java tenga incorporado su propio API para manejar JSON. En este post hablaremos un ejemplo de cómo consumir un JSON, usando otro ejemplo usado anteriormente.

### Servidor RESTful (más simple con JavaEE 7)

Nos basaremos del proyecto creado en el anterior post "[Actualizando y eliminando elementos de una colección](/2011/01/restful-4-actualizando-y-eliminando.html)", y con algunas actualizaciones y mejoras, ahora corre en GlassFish v4. Por ejemplo, podemos omitir las etiquetas @XmlRootElement en el Bean.

El recurso será más reducido y más práctico.

<script src="http://pastebin.com/embed_js.php?i=69seeYEy"></script>

(Código fuente: [http://pastebin.com/69seeYEy)](http://pastebin.com/69seeYEy)

Podemos probar su funcionamiento usando algún manejador de RESTful para nuestro navegador, por ejemeplo el [POSTER](http://code.google.com/p/poster-extension/) en Firefox (aquí tengo un tutorial sobre ello: [Probando RESTful con Poster](/2011/09/probando-restful-con-poster.html))  o [Posterman](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm) para Chrome.

### Cliente con API JSON

Ahora, haremos el cliente que será otra aplicación web. Consistirá de la siguiente manera: un jsp con un formulario que enviará los datos por un método post, seguido de un listado simple de lo que se ha recogido.

Este es el formulario:<script src="http://pastebin.com/embed_js.php?i=xLiBCZKa"></script>

Código fuente:[http://pastebin.com/xLiBCZKa.](http://pastebin.com/xLiBCZKa)

Como vemos, tanto el formulario como el "include" llaman al mismo Servlet. Esto es para simplificar código. El Formulario apunta al servlet pero con el method "POST"; mientras que el include invoca al servlet usando el método "GET".

Este es el método "POST" del Servlet.<script src="http://pastebin.com/embed_js.php?i=D87z7bA3"></script>

Código fuente: [http://pastebin.com/D87z7bA3](http://pastebin.com/D87z7bA3)

Las líneas del 12 al 18 solo son capturas de los parámetros y colocados en el Bean. La creación del cliente de RESTful (línea 20) es bastante simple comparado a la versión anterior (ahora es solo una línea), el registro del URL del servidor  está en la línea 22. Quien hace el verdadero trabajo de convertir el bean en un formato JSON está dada en la línea 21. Allí veremos cómo funciona el API JSON. Luego, en la línea 24 vemos cómo se hace la llamada de tipo "post" al RESTful. Es mucho más simple y entendible. Finalizamos el método redireccionando la petición a "index.jsp".

Aquí el código fuente del conversor de Bean a JSON.<script src="http://pastebin.com/embed_js.php?i=Rdjvt5jc"></script>

El método `writeTo()` está bien explicado. El API JSON nos permite crear un objeto JSON usando los métodos de `writeStartObject` y agregar las propiedades usando el método `write()`.

Código fuente: [http://pastebin.com/Rdjvt5jc.](http://pastebin.com/Rdjvt5jc)

Ahora bien, ¿cómo se obtiene y convierte un JSON? Veamos el código fuente del método GET. Realmente, no es tan complicado.

<script src="http://pastebin.com/embed_js.php?i=tE8DUGwM"></script>

Código fuente: [http://pastebin.com/tE8DUGwM](http://pastebin.com/tE8DUGwM)

Para el caso de convertir un JSON a un objeto Bean, es un poco más complicado. Veamos el conversor:<script src="http://pastebin.com/embed_js.php?i=Ci8PG5Cn"></script>

Código fuente: [http://pastebin.com/Ci8PG5Cn](http://pastebin.com/Ci8PG5Cn)

***Nota**:  A la fecha que he escrito este apunte, no he logrado convertir el tipo "boolean". Debe ser porque aún no está completada la implementación del API. No lo sé. Si encuentro la solución, lo republicaré.*

Me dirán que se parece un poco al método de acceso SAX en XML, o que es mejor usar el GSon u otra biblioteca más simple. Pues sí.. estoy de acuerdo. Pero veamos que con este API se puede tener mayor control en la creación del objetos JSON, además no todo podía ser creado desde un Bean, sino desde un proceso y se va creado el Objeto JSON de manera dinámica.... y por último, esta es la primera versión del API. Estoy casi seguro que en una siguiente versión habrán mejoras.

#### Nota:

También puede ser una aplicación desktop. Y para que funcione se tendrá que agregar las bibliotecas de GlassFish, ya que allí están las implementaciones del API JSon.

### Código fuente de los proyectos

Y para finalizar... el código fuente de los proyectos usados en este post. Espero que les sea de utilidad.

- [PersonaRESTWeb.tar.gz](https://java.net/projects/apuntes/downloads/download/restful/apijson/PersonaRESTWeb.tar.gz). El código fuente del servidor de RESTful, para Java EE 7.

- [JSONApiPersonaRESTClientWeb.tar.gz](https://java.net/projects/apuntes/downloads/download/restful/apijson/JSONApiPersonaRESTClientWeb.tar.gz) . El código fuente del cliente, usando el API JSON y el cliente de RESTful, para java EE 7

Hasta la próxima.! Bendiciones a todos!
