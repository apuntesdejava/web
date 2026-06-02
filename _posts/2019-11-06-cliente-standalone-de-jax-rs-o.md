---
layout: post
title: "Cliente Standalone de JAX-RS (o cualquier endpoint RESTful)"
date: 2019-11-06T23:16:00.003Z
last_modified_at: 2019-11-06T23:20:00.661Z
author: "Diego Silva Límaco"
permalink: /2019/11/cliente-standalone-de-jax-rs-o.html
canonical_url: https://www.apuntesdejava.com/2019/11/cliente-standalone-de-jax-rs-o.html
tags:
  - "jaxrs"
  - "restful"
  - "microprofile"
  - "jakarta ee"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vTJ5kV7fhzmK-n7ayHEnzOpRyS9LOdFHtkuNN7ePSauowBaSrI6iSvBX3QqW3ehUzN38v9-bfyOXnkv/pub?w=960&h=600)](https://docs.google.com/drawings/d/e/2PACX-1vTJ5kV7fhzmK-n7ayHEnzOpRyS9LOdFHtkuNN7ePSauowBaSrI6iSvBX3QqW3ehUzN38v9-bfyOXnkv/pub?w=960&h=600)

Si tenemos una aplicación standalone (puede ser un JavaFX, de línea de comandos, batch, etc) que necesite consumir un endpoint hecho en RESTful, por lo general usaríamos algo como esto:

```java
public class RestClient {

    private static final String REST_URI
      = "http://localhost:8082/spring-jersey/resources/employees";

    private Client client = ClientBuilder.newClient();

    public Employee getJsonEmployee(int id) {
        return client
          .target(REST_URI)
          .path(String.valueOf(id))
          .request(MediaType.APPLICATION_JSON)
          .get(Employee.class);
    }
    //...
}
```

(Tomado de [https://www.baeldung.com/jersey-jax-rs-client](https://www.baeldung.com/jersey-jax-rs-client))

Lo cual no está mal, pero creo que debería ser lo más transparente posible. ¿Cómo es eso?

Si ven en la línea 13 del código anterior, significa que hay que decirle que haga un `GET` a la petición, además de pasarle el tipo de respuesta y otras cosas más. La cuestión se volvería algo compleja si queremos hacer otras peticiones como `POST`, `DELETE`, etc.

Pues aquí vengo con una solución que encontré revisando la documentación de JAX-RS.

## El servidor

Para este ejemplo, he creado un pequeño servidor CRUD en Payara Micro, el cual puedes obtener su código aquí: [https://github.com/apuntesdejava/demo-jaxrs-standalone/tree/master/demo-jaxrs-server](https://github.com/apuntesdejava/demo-jaxrs-standalone/tree/master/demo-jaxrs-server)

El Endpoint principal es este:

```java
@Path("person")
@Produces(APPLICATION_JSON)
@Consumes(APPLICATION_JSON)
@ApplicationScoped
public class PersonEndpoint {

    @Inject
    private PersonRepository personRepository;

    @POST
    public Response create(PersonParam param) {
        Person p = personRepository.create(param.getName(), param.getEmail());
        return Response.ok(p).build();
    }

    @GET
    public Response list() {
        List<Person> list = personRepository.findAll();
        return Response.ok(list).build();
    }

    @DELETE
    @Path("{id}")
    public Response delete(@PathParam("id")long personId){
        personRepository.delete(personId);
        return Response.ok().build();
    }

}
```

El cual tiene tres métodos principales:

- `@POST` `create()` para insertar registros

- `@GET` `list()` para leer todos los registros

- `@DELETE` `delete()` para borrar un registro

Una manera para probarlo es ejecutándolo y llamando desde un cliente:

Insertando un registro:

[![]({{ '/assets/blogger/2019-11-06_17-40-37.png' | relative_url }})]({{ '/assets/blogger/2019-11-06_17-40-37.png' | relative_url }})

Listando los registros:

[![]({{ '/assets/blogger/2019-11-06_17-43-17.png' | relative_url }})]({{ '/assets/blogger/2019-11-06_17-43-17.png' | relative_url }})

Borrando ese registro (en mi caso, el 97)

[![]({{ '/assets/blogger/2019-11-06_17-44-30.png' | relative_url }})]({{ '/assets/blogger/2019-11-06_17-44-30.png' | relative_url }})

## El Cliente

En el cliente tiene que existir un método que luzca igual que la clase del endpoint servidor para que sea "transparente" la invocación.

```java
@Path("person")
@Produces(APPLICATION_JSON)
@Consumes(APPLICATION_JSON)
public interface PersonEndpoint {

    @POST
    Response create(PersonParam param);

    @GET
    Response list();

    @DELETE
    @Path("{id}")
    Response delete(@PathParam("id") long personId);
}
```

Pero esto tiene un tratamiento muy especial: no es una clase, es una interfaz. Aquí es lo divertido ¿cómo es que lo podrá identificar cada petición? Pues esta es la magia del cliente JAX-RS.

Hay varios clientes de JAX-RS, algunos son:

- RestEasy: https://github.com/resteasy/resteasy-examples/tree/3.6.0.Final/jaxrs-2.0/simple-client

- Quarkus: https://quarkus.io/guides/rest-client

- Apache CXF: [https://cxf.apache.org/](https://cxf.apache.org/)

Aquí usaré el Apache CXF. Independientemente puede usarse cualquier implementación, pero seguirá siendo la misma interfaz. Solo cambia cómo se invoca al Endpoint del Cliente.

Así se construye usando Apache CXF:

```java
PersonEndpoint client = JAXRSClientFactory.create(
                REST_URI,
                PersonEndpoint.class,
                Arrays.asList(
                        new JacksonJaxbJsonProvider()
                ));
```

Luego, se llama como si fuera cualquier método "local":

```java
PersonParam param = new PersonParam("persona 1", "abc@mail.com"); //creo los parámetros
        Response resp = client.create(param); //invoco al endpoint
        LOG.log(Level.INFO, "status:{0}", resp.getStatusInfo().getReasonPhrase()); //muestro la respuesta
        if (resp.getStatus() == Response.Status.OK.getStatusCode()) { //si está ok...
            Person p = resp.readEntity(Person.class); //.. convierto la petición en la entidad que se recibió...
            LOG.log(Level.INFO, "-> registro insertado:{0}", p.toString()); //... y muestro el contenido
        }
```

Si deseamos listar, también se haría lo mismo:

```java
resp = client.list(); //invocamos el método de listado
        LOG.log(Level.INFO, "status:{0}", resp.getStatusInfo().getReasonPhrase()); //mostramos el resultado...
        List<Person> list = null;  //preparamos nuestra lista que vamos a recibir
        if (resp.getStatus() == Response.Status.OK.getStatusCode()) { //evaluamos el contenido... si está OK...
            list = resp.readEntity(new GenericType<List<Person>>() {  //... convertimos la petición en el listado
            });
            list.forEach((p) -> { //... y podemos listar el contenido.
                LOG.log(Level.INFO, "id:{0}\tname:{1}\temail:{2}", new Object[]{p.getPersonId(), p.getName(), p.getEmail()});
            });
        }
```

## Código fuente

El código fuente para este proyecto se puede encontrar aquí:

- [https://github.com/apuntesdejava/demo-jaxrs-standalone](https://github.com/apuntesdejava/demo-jaxrs-standalone)

- [https://bitbucket.org/apuntesdejava/demo-jaxrs-standalone/](https://bitbucket.org/apuntesdejava/demo-jaxrs-standalone/)
