---
layout: post
title: "Probando RESTful con Poster"
date: 2011-09-13T22:36:00Z
last_modified_at: 2011-09-13T22:36:54.888Z
author: "Diego Silva Límaco"
permalink: /2011/09/probando-restful-con-poster.html
canonical_url: https://www.apuntesdejava.com/2011/09/probando-restful-con-poster.html
tags:
  - "webservices"
  - "glassfish v3"
  - "restful"
  - "firefox"
  - "ejb 3.1"
  - "netbeans"
  - "ejb"
  - "ajax"
---

[![]({{ '/assets/blogger/rest-ful-webservice-baner.png' | relative_url }})]({{ '/assets/blogger/rest-ful-webservice-baner.png' | relative_url }})

Seguimos con RESTful en Java!

Ya luego comentaré qué pasó conmigo y por qué no estuve enviando contenido a mi blog.

Hasta el momento hemos visto casi de manera abstracta el funcionamiento de [RESTful](http://en.wikipedia.org/wiki/Representational_State_Transfer) usando [Jersey](http://jersey.java.net/) desde [NetBeans](http://netbeans.org/).

Ahora veremos como probar todo un [CRUD](http://es.wikipedia.org/wiki/CRUD) de RESTful desde un complemento de Firefox llamado [Poster](https://addons.mozilla.org/es-ES/firefox/addon/poster/).

La mejor manera de probar un servicio es no creando una aplicación. Es decir, si vamos a probar como funciona algo, no tenemos que hacer un programa que utilice ese algo.

El objetivo principal del RESTful es proveer servicios estándar para todo tipo de cliente ¿cierto? Entonces, si hacemos una aplicación que consuma nuestro servicio, corremos el peligro de que ajustemos el servicio para que corra con nuestra aplicación y al final no sea estándar.

Así que, antes de mostrar el RESTful, debemos instalar el complemento Poster en nuestro Firefox (porque asumimos que como buenos programadores, usamos Firefox) Este se puede descargar desde aquí: [https://addons.mozilla.org/es-ES/firefox/addon/poster/](https://addons.mozilla.org/es-ES/firefox/addon/poster/)

Ahora, les comento que he ordenado un poco el proyecto que hemos estado haciendo en los post anteriores. Ahora tiene un EJB que manejará la colección de entidades (como debe ser) y que está separado de la clase de recursos (como debe ser).

Además, el manejo de las peticiones CRUD en un REST son como sigue:

<table border="1">
<tbody>
<tr><th>Verbo REST</th><th>URI</th><th>Acción a realizar</th></tr>
</tbody><tbody>
<tr>
<td>POST</td><td><code>/persona</code></td><td>Create</td></tr>
<tr>
<td>GET</td><td><code>/persona/id</code></td><td>Read</td></tr>
<tr>
<td>PUT</td><td><code>/persona/id</code></td><td>Update</td></tr>
<tr>
<td>DELETE</td><td><code>/persona/id</code></td><td>Delete</td></tr>
</tbody>
</table>
Así, el código final del recurso REST es el siguiente:

```java
@Path("/persona")
@Consumes({"application/json", "application/xml"})
@Stateless
public class PersonaService {

    @EJB
    private PersonaFacade facade;

    @POST
    public Response create(Persona p) {
        facade.insert(p);
        return Response.ok(p).build();
    }

    @GET
    @Path("{id}/")
    public Persona read(@PathParam("id") int i) {
        Persona p = facade.findById(i);
        return p;
    }

    @GET
    public List<Persona> read(@QueryParam("nombre")
            @DefaultValue("") String nombre) {
        List<Persona> l = nombre.isEmpty() ? facade.findAll() : facade.findByNombre(nombre);
        return l;
    }

    @DELETE
    @Path("/{id}")
    public Response delete(@PathParam("id") int i) {
        if (facade.delete(i)) {
            return Response.ok().build();
        }
        return Response.status(Response.Status.NOT_FOUND).build();
    }

    @PUT
    @Path("/{id}")
    public Response update(@PathParam("id") int i, Persona p) {
        p.setId(i);
        facade.update(p);
        return Response.ok().build();
    }
}
```

Y el EJB es el siguiente:

```java
@Stateless
public class PersonaFacade {

    private static List<Persona> lista = new ArrayList<Persona>(); //lista temporal

    public void insert(Persona p) {
        lista.add(p); //agrega a la lista

    }

    public Persona findById(int id) {
        Persona p = new Persona(id); //crea un objeto temporal...
        int i = lista.indexOf(p); //... para buscarlo en la lista
        if (i < 0) {//si no lo encuentra
            return null; //... devuelve null
        }
        return lista.get(i);  // sino, lo devuelve
    }

    public List<Persona> findAll() {
        return lista;
    }

    public List<Persona> findByNombre(String nombre) {

        List<Persona> $lista = new ArrayList<Persona>(); //un arreglo temporal
        for (Persona persona : lista) {  //se recorre la lista...
            if (persona.getNombre().contains(nombre)) { //se compara el nombre
                $lista.add(persona); //y si es parecido, lo agrega en la lista
            }
        }
        return $lista; //... para devolverlo
    }

    public boolean delete(Persona p) {
        return lista.remove(p);
    }

    public void update(Persona p) {
        int pos = lista.indexOf(p); //busca en la lista..
        if (pos >= 0) { //si lo encuentra...
            lista.set(pos, p); //... lo actualiza
        }

    }

    public boolean delete(int i) {
        Persona p = findById(i);
        return delete(p);
    }
}
```

## Ejecutando Poster

Ahora bien, una vez instalado el Poster en Firefox, lo abrimos haciendo clic en la barra inferior del navegador en el ícono color amarillo con una letra P. Esto nos abrirá la siguiente ventana:

[![]({{ '/assets/blogger/poster01.png' | relative_url }})]({{ '/assets/blogger/poster01.png' | relative_url }})

Es bastante fácil su utilización como lo veremos a continuación.

Ejecutemos el proyecto desde nuestro NetBeans y veremos que se abrirá una ventana de bienvenida (no muy elegante) y un enlace para visualizar la descripción del recurso. Al hacer clic en ese enlace, se mostrará el [WADL](http://www.w3.org/Submission/wadl/) Podemos examinar por curiosidad para conocer los recursos existentes. Pero en este momento vamos a ver cómo funciona el Poster.

En la casilla URL se deberá poner el URI del servicio completo. Para nuestro ejemplo es http://localhost:8084/PersonasRestful/rest/persona (cambiar el puerto si es necesario)

En la casilla central llamada "Content type" se pondrá el tipo de datos que se manejará en el envío. Le pondremos el valor: `application/json`

En la caja grande de entrada es el contenido a enviar. Ahí pondremos los datos a enviar.

### Create

Para crear un nuevo objeto en la "base de datos" usando el servicio, necesitamos colocar el contenido siguiente:

```java
{
  "nombre":"Ann",
  "fechaNacimiento":"2010-11-12"
}
```

[![]({{ '/assets/blogger/poster02.png' | relative_url }})]({{ '/assets/blogger/poster02.png' | relative_url }})

Luego, hacemos clic en el botón central "POST". El Poster nos mostrará un resultado:

[![]({{ '/assets/blogger/poster03.png' | relative_url }})]({{ '/assets/blogger/poster03.png' | relative_url }})

Este resultado es porque se ha puesto que devuelva el objeto que se agregó.

Intentemos agregar más objetos y hacer POST por cada uno de ellos.

### Read

Para obtener el listado de todos los objetos registrados en el servicio, nos aseguramos que el URL apunte a URI `/rest/persona` y hacemos clic en el botón GET. El Poster nos mostrará el siguiente contenido.

[![]({{ '/assets/blogger/poster04a.png' | relative_url }})]({{ '/assets/blogger/poster04a.png' | relative_url }})

[![]({{ '/assets/blogger/poster04.png' | relative_url }})]({{ '/assets/blogger/poster04.png' | relative_url }})

Esto me devuelve el listado completo. Pero si solo quiero uno de ellos, y conozco el ID, pondremos en el URI el ID de una persona. Por ejemplo `/rest/persona/2` y luego hacemos clic en "GET".

[![]({{ '/assets/blogger/poster05a.png' | relative_url }})]({{ '/assets/blogger/poster05a.png' | relative_url }})

[![]({{ '/assets/blogger/poster05.png' | relative_url }})]({{ '/assets/blogger/poster05.png' | relative_url }})

### Update

Para actualizar un registro se debe tener lo siguiente: apuntar a un URI incluyendo el ID `/rest/persona/2` y en el contenido colocar las propiedades a actualizar. Por ejemplo:

```java
{
  "nombre":"Alfred",
  "fechaNacimiento":"2010-11-12"
}
```

Y hacemos clic en el botón PUT

Esta petición no nos ha respondido nada, ya que así lo hemos pusimos en el RESTful.

Podemos verificar el contenido haciendo un GET de todos los objetos registrados.

### Delete

Igual que el PUT y UPDATE... solo le indicamos el ID en el URI y hacemos clic en "DELETE". Luego verificamos haciendo un GET de todos los objetos registrados y veremos si está o no.

## Cambiando el objeto resultado

Como podemos ver, todas las peticiones que hemos hecho (PUT y POST) tienen el formato JSON, pero los resultados a nuestras peticiones tienen formato XML. Bueno, por omisión el Jersey devolverá bajo ese tipo. Pero también permite devolver formato JSON si así lo solicita el cliente POSTER. Para ello vamos a la pestaña "Headers" del Poster y agregamos la siguiente cabecera:

- Accept: application/json

.. y hacemos clic en "Add/Change"

[![]({{ '/assets/blogger/poster06.png' | relative_url }})]({{ '/assets/blogger/poster06.png' | relative_url }})

Y luego, hagamos el GET de todos los objetos para visualizar el contenido.

[![]({{ '/assets/blogger/poster06a.png' | relative_url }})]({{ '/assets/blogger/poster06a.png' | relative_url }})

## Recursos

El proyecto utilizado se puede descargar desde aquí:

[http://kenai.com/projects/apuntes/downloads/download/CRUDPersonasRest/personas-restful-crud.tar.gz](http://kenai.com/projects/apuntes/downloads/download/CRUDPersonasRest/personas-restful-crud.tar.gz)
