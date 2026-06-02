---
layout: post
title: "RESTful parte 3: Manejando colecciones de objetos y objetos complejos"
date: 2011-01-05T00:52:00Z
last_modified_at: 2011-01-05T00:52:06.850Z
author: "Diego Silva Límaco"
permalink: /2011/01/restful-parte-3-manejando-colecciones.html
canonical_url: https://www.apuntesdejava.com/2011/01/restful-parte-3-manejando-colecciones.html
tags:
  - "netbeans 6.9"
  - "restful"
  - "java ee"
  - "tutorial"
  - "netbeans"
  - "java ee 6"
---

[![]({{ '/assets/blogger/rest-ful-webservice-baner.png' | relative_url }})]({{ '/assets/blogger/rest-ful-webservice-baner.png' | relative_url }})

Comenzamos este año nuevo con la continuación del (creo yo) más esperado tema de tutorial: [RESTful](http://www.apuntesdejava.com/search/label/restful). Y esta vez hablaremos sobre el manejo de colecciones y objetos complejos. Por ahora será de manera básica y veremos poco a poco cómo hacerlo más y más complejo.

## Manejo de colecciones

Para comenzar, tomaremos el mismo proyecto que vimos en el último [post]({{ '/2010/11/restful-la-forma-mas-ligera-de-hacer_25.html' | relative_url }}) y agregaremos otro recurso llamado `PersonaResource` con el path apuntando por `/listaPersonas`.

¿Cómo hacer esto? Bien fácil:

- Crear una clase llamada `PersonaResource` dentro del paquete `com.apuntesdejava.rest`

- Agregar las siguientes anotaciones al inicio de la declaración de la clase:

```java
<code>@Stateless
@Path("/listaPersonas")</code>
```

Es decir, al final tendremos el código para la clase de la siguiente manera:

```java
<code>package com.apuntesdejava.rest;

import javax.ejb.Stateless;
import javax.ws.rs.Path;

@Stateless
@Path("/listaPersonas")
public class PersonasResource {
}</code>
```

### Guardando objetos en la colección

Esto es realmente fácil. Es como cualquier método en Java que recibe un objeto y lo guarda en el arreglo:

```java
<code>//...
    static List<Persona> personas = new ArrayList<Persona>();

    @POST
    @Consumes({"application/xml", "application/json"})
    public Response guardar(Persona p) {
        p.setIdPersona(personas.size() + 1); //se le autoasigna un id al objeto
        personas.add(p);
        return Response.ok(p).build();
    }
//...
</code>
```

Sabemos que el objeto vendrá en formato JSON o XML. Si tenemos dudas, probemos con el "Test RESTful Web services" de NetBeans.

Probaremos enviando la siguiente cadena en el método POST.

```java
<code>{"nombre_persona":"Juan Perez",
"edad":"35",
"trabajador":"true",
"fechaNacimiento":"1976-01-01"}</code>
```

Y veremos que en la respuesta nos devuelve con el ID de la persona autogenerada.

```java
<code><?xml version="1.0" encoding="UTF-8"?>
   <persona id_persona="1">
       <fechaNacimiento>1976-01-01T00:00:00-05:00</fechaNacimiento>
       <nombre_persona>Juan Perez</nombre_persona>
       <sexo>0</sexo>
       <trabajador>true</trabajador>
   </persona> </code>
```

Como se puede en esta imagen, está el envío de la data, y la respuesta del servidor.

[![]({{ '/assets/blogger/rest-lista-001.jpg' | relative_url }})]({{ '/assets/blogger/rest-lista-001.jpg' | relative_url }})

Esto es bastante fácil, porque es lo mismo que se vió en el anterior post. Ahora veremos como se obtiene una lista.

### Obteniendo objetos en la colección

Lo bueno de utilizar RESTful en Java es que no requiere declarar métodos extraños ni clases adicionales (hasta ahora). Entonces, si queremos que nuestra clase tenga un método que devuelva una lista de objetos de una lista en base a un criterio (por ejemplo, los que tengan uno determinado texto), podría ser como el que sigue:

```java
<code>    public List<Persona> buscar(String nombre) {
        List<Persona> lista = new ArrayList<Persona>();
        for (Persona persona : personas) {
            if (persona.getNombre().indexOf(nombre) >= 0) {
                lista.add(persona);
            }

        }
        return lista;
    }
</code>
```

¿Cierto? Bien, ahora lo convertiremos en servicio RESTful agregando la anotación `GET`, además de qué tipos va a devolver.

```java
<code>    @GET
    @Produces({"application/xml", "application/json"})
    public List<Persona> buscar( String nombre) {
        List<Persona> lista = new ArrayList<Persona>();
        for (Persona persona : personas) {
            if (persona.getNombre().indexOf(nombre) >= 0) {
                lista.add(persona);
            }

        }
        return lista;
    }
</code>
```

Pero como va a recibir un parámetro, por método `@GET` (es decir, como parte del URL.. o query string) entonces hay que darle un nombre usando `@QueryParam`.

```java
<code>    @GET
    @Produces({"application/xml", "application/json"})
    public List<Persona> buscar(@QueryParam("nombre") String nombre) {
        List<Persona> lista = new ArrayList<Persona>();
        for (Persona persona : personas) {
            if (persona.getNombre().indexOf(nombre) >= 0) {
                lista.add(persona);
            }

        }
        return lista;
    }
</code>
```

Ahora, probemos con el "Test REST" de NetBeans (previo registro de objetos, claro está).

[![]({{ '/assets/blogger/rest3-002.jpg' | relative_url }})]({{ '/assets/blogger/rest3-002.jpg' | relative_url }})

Notemos que el nombre del parametro query no necesariamente tiene que ser el mismo nombre del parámetro del método de Java. Es decir, esto es totalmente válido:

```java
<code>    @GET
    @Produces({"application/xml", "application/json"})
    public List<Persona> buscar(@QueryParam("name") String nombre) {
//...
    }
</code>
```

## Objetos complejos

Ahora bien, ya nos podemos imaginar que si permite exportar una simple colección de la manera más simple, también se puede exportar un objeto compuesto (es decir, un objeto que tenga propiedades que son otros objetos).

Pero antes de seguir, quiero recordar que esta parte del tutorial es aún básico. Por ahora no pretendamos poner un objeto que tenga una referencia cíclica, es decir, que tenga una propiedad que es otro objeto y que este tenga otra propiedad que apunte al primer objeto. Sí se puede hacer, pero por ahora no lo veremos porque para ello hay que hacer algunas modificaciones adicionales.

Crearemos una clase llamada `Telefono` que tendrá las propiedades `area` y `numero`.

```java
<code>public class Telefono {

    private String numero;
    private String area;

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }
}</code>
```

Y, en nuestra clase `Persona` agregaremos una colección de la clase recién creada:

```java
<code>
public class Persona {
//....
    private List<Telefono> telefonos;

    public List<Telefono> getTelefonos() {
        return telefonos;
    }

    public void setTelefonos(List<Telefono> telefonos) {
        this.telefonos = telefonos;
    }
//....</code>
```

Ahora, probemos con la siguiente cadena JSON (no olvidar que se selecciona POST (application/json)) para registrar nuestro objeto:

```java
<code>{
  "nombre_persona":"Carl",
  "telefonos"     :[
                    {"area":"51","numero":"12345"},
                    {"area":"54","numero":"98765"}
                   ]
}</code>
```

Y al obtener la lista de los objetos, se obtiene sin ningún problema. Ya sea en XML...

[![]({{ '/assets/blogger/rest3-003.jpg' | relative_url }})]({{ '/assets/blogger/rest3-003.jpg' | relative_url }})

... o en JSON...

[![]({{ '/assets/blogger/rest3-004.jpg' | relative_url }})]({{ '/assets/blogger/rest3-004.jpg' | relative_url }})

Si quieres conocer más sobre los formatos de JSON, visita aquí: [http://www.json.org/json-es.html](http://www.json.org/json-es.html)

Ya haré un post dedicado únicamente a los clientes de RESTful, tanto como para probar como para hacer una aplicación desktop, javascript, javafx, mobile, etc.

El siguiente post, cómo manejar los `java.util.Map` y después, los métodos `@DELETE` y `@PUT`

## El código fuente

Aquí está el infaltable código fuente del proyecto

[http://kenai.com/projects/apuntes/downloads/download/PersonaRESTWeb%252FPersonasRESTWeb.tar.gz](http://kenai.com/projects/apuntes/downloads/download/PersonaRESTWeb%252FPersonasRESTWeb.tar.gz)

Bendiciones!
