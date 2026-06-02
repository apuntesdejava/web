---
layout: post
title: "Consumiendo servicios JSON de Liferay usando Jersey"
date: 2014-05-22T21:07:00.003Z
last_modified_at: 2014-05-22T21:12:42.641Z
author: "Diego Silva Límaco"
permalink: /2014/05/consumiendo-servicios-json-de-liferay.html
canonical_url: https://www.apuntesdejava.com/2014/05/consumiendo-servicios-json-de-liferay.html
tags:
  - "webservices"
  - "restful"
  - "liferay"
  - "jersey"
---

[![Consumiendo servicios JSON de Liferay usando Jersey]({{ '/assets/blogger/liferay-jersey.png' | relative_url }})]({{ '/assets/blogger/liferay-jersey.png' | relative_url }})

Liferay viene con servicios RESTful llamados "[Servicios Web JSON](https://www.liferay.com/es/documentation/liferay-portal/6.2/development/-/ai/json-web-services-liferay-portal-6-2-dev-guide-05-en)", porque utiliza el formato JSON. En este post voy a compartir una manera de consumir desde Jersey para acceder a sus datos.

¿Cómo sabemos qué servicios disponemos en nuestro liferay? Solo basta con entrar a la dirección `http://host:puerto/api/jsonws/`

Pero, por seguridad, necesitamos primero iniciar sesión en nuestro servidor. Así fue configurado.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHh_6NEgDHiI15gcv-0imEjF1DCgJtrFSi7Qd6EgBYzIu6ZxjccibqJNIH0VlnXXXYIFKoJqFVb6hhIoRv19gPoGaKXhCJiClARaEoIS6RWmCxDXNo5eov37XUo4Q4UEdkBD8yIbxELpE/s1600/22-05-2014+11-44-45+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHh_6NEgDHiI15gcv-0imEjF1DCgJtrFSi7Qd6EgBYzIu6ZxjccibqJNIH0VlnXXXYIFKoJqFVb6hhIoRv19gPoGaKXhCJiClARaEoIS6RWmCxDXNo5eov37XUo4Q4UEdkBD8yIbxELpE/s1600/22-05-2014+11-44-45+a.m..png)

Además, si nosotros creamos nuestros propios portlet con Service Builder, los servicios allí definidos también estarán publicados.

Ahora bien, si lo que queremos es usar los servicios JSON desde otra aplicación java, usaremos un par de bibliotecas necesarias.
 La primera será [jersey-client](https://jersey.java.net/documentation/latest/client.html).

```java
<dependency>
            <groupId>org.glassfish.jersey.core</groupId>
            <artifactId>jersey-client</artifactId>
            <version>2.6</version>
        </dependency>
```

Para nuestro ejemplo, probaremos **leer todos los grupos** que están registrados en el servidor.Para ello necesitamos el id de compañía, y el URL donde está el servicio

```java
static final String URL = "http://localhost:8080"; //el host
    static final String JSONWS_URL = URL + "/api/jsonws"; //la ruta de los servicios
    static final String GET_GROUPS_URL = JSONWS_URL + "/group/get-groups"; //la ruta del servicio de grupos
    static final int COMPANY_ID = 9999; //el id de compañia
    static final String USER = "usuario", PASS = "pass"; //las credenciales
```

La autenticación se implementará de manera *Basic*, pero en la cabecera (no encontré otra manera efectiva).

```java
String passEnc = Base64.encodeAsString(USER + ':' + PASS);
        Client groupsClient = ClientBuilder.newClient();
        WebTarget target = groupsClient.target(GET_GROUPS_URL + "/company-id/" + COMPANY_ID + "/parent-group-id/0/site/true"); //esta es la ruta para el servicio de obtener todos los grupos
        Invocation.Builder invocationBuilder = target.request()
                .header("Authorization", "Basic " + passEnc); //inicia la autenticacion
        Response response = invocationBuilder.get(); //haciendo GET al URL
        if (response.getStatus() == Response.Status.OK.getStatusCode()) { //si se conecto correctamente...

            String resp = response.readEntity(String.class); //... entonces recibo la cadena..
            LOG.log(Level.INFO, "response.getEntity():{0}", resp); //.. y ya tengo la lista

        }
```

Pero, como podrán ver, solo hemos obtenido una cadena. Créame que traté de jalarlo como un objeto ya proceso usando el Unmarshall propio de Jersey, pero no tuve éxito. Así que me ayudé usando el [Gson](http://code.google.com/p/google-gson/) de Google.

```java
<dependency>
            <groupId>com.google.code.gson</groupId>
            <artifactId>gson</artifactId>
            <version>2.2.4</version>
        </dependency>
```

Y, como debo obtener un arreglo de objetos, hago lo siguiente:

```java
GsonBuilder builder = new GsonBuilder();
Gson gson = builder.create();
Type listType = new TypeToken<ArrayList<Group>>() {
}.getType();

List<Group> groups = gson.fromJson(resp, listType); //convierto la cadena "resp" en lista de objetos
```

Y, mi clase `Group` tiene la siguiente estructura:

```java
public class Group {
    private boolean active;
    private int groupId;
    private String name;
// más propiedades
// ... y setters y getters
```

### Como saber servicios disponibles

Para conocer los servicios Json disponibles, bastará con revisar la lista mencionada arriba, tomar uno de ellos y probar sus ejemplos. Con ello sabremos cómo llamar a sus parámetros.

Probando la llamada del servicio `get-groups` con algunos parámetros

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhsUfJrK7d92H1LMSvxxtvo3ZoPEPcIC7OfYoKntTbcmrs4eECtnt-CH_hZBhPTHFjpKBt4443lGe7rNII9dkmXoqDakx8eAkCNVLSpwDTPz_7_Feg3TL6qlO_F1UaCubYIjadnNDfFnnk/s1600/22-05-2014+04-04-42+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhsUfJrK7d92H1LMSvxxtvo3ZoPEPcIC7OfYoKntTbcmrs4eECtnt-CH_hZBhPTHFjpKBt4443lGe7rNII9dkmXoqDakx8eAkCNVLSpwDTPz_7_Feg3TL6qlO_F1UaCubYIjadnNDfFnnk/s1600/22-05-2014+04-04-42+p.m..png)

... y revisando la llamada tipo GET por URL que debería usarse con esos parámetros.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEinT1jN9AiNBwHUwAigf-_CtM_CBe6wdZnug3iWA3EoxIcgR_SnZBHQs-XSr7t4tlFcGKne5dg2voeW5pU1Mp40twemjth0YtnW6H-WWNrgkfVQGF2AVbOjf4VP62schDJFpJR0D_fFThw/s1600/22-05-2014+04-03-53+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEinT1jN9AiNBwHUwAigf-_CtM_CBe6wdZnug3iWA3EoxIcgR_SnZBHQs-XSr7t4tlFcGKne5dg2voeW5pU1Mp40twemjth0YtnW6H-WWNrgkfVQGF2AVbOjf4VP62schDJFpJR0D_fFThw/s1600/22-05-2014+04-03-53+p.m..png)

Espero que les sea de utilidad, si algún momento quieren consumir los servicios json de liferay desde una aplicación que no sea liferay.

Buen día para todos!
