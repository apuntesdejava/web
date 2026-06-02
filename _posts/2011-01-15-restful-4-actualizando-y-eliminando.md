---
layout: post
title: "RESTful parte 4: Actualizando y eliminando elementos de una colección."
date: 2011-01-16T02:47:00.002Z
last_modified_at: 2011-09-13T17:20:27.257Z
author: "Diego Silva Límaco"
permalink: /2011/01/restful-4-actualizando-y-eliminando.html
canonical_url: https://www.apuntesdejava.com/2011/01/restful-4-actualizando-y-eliminando.html
tags:
  - "netbeans 6.9"
  - "restful"
  - "java ee"
  - "tutorial"
  - "netbeans"
  - "java ee 6"
---

[![](/assets/blogger/rest-ful-webservice-baner.png)](/assets/blogger/rest-ful-webservice-baner.png)

Todo mantenimiento de objetos debe tener siempre lo que en inglés se llama CRUD (Create - Read - Update - Delete). Hasta ahora hemos visto C y R. Faltan el U y el D. Así que en este artículo hablaremos de ello

En cualquier manera de almacenamiento de datos (sea un arreglo o una base de datos) siempre se debe poder identificar a un solo objeto a través de una clave principal. ¿Cómo se puede borrar o actualizar un solo objeto si no sabemos cuál es?.

En nuestros [anteriores artículos](http://www.apuntesdejava.com/search/label/restful) hemos creado objetos y le hemos puesto un ID automático. Aunque no es la manera más optima de hacerlo (ya que le hemos puesto como ID el tamaño del arreglo), vamos a actualizar un poco esta asignación. Para ello editaremos la clase `Persona` de tal manera que tenga un contador de objetos. Para ello hagamos lo siguiente.

```java
//...
public class Persona {
    private static int contador = 0;
    public static int getNuevoId() {
        return ++contador;
    }
//...
```

Luego, en la clase `PersonasResource`, en el método `guardar` le cambiaremos la línea donde se asigna el ID con lo siguiente:

```java
//...
     public Response guardar(Persona p) {
            p.setIdPersona(Persona.getNuevoId());     //nueva manera de asignar ID
            personas.add(p);
            return Response.ok(p).build();
     }
//...
```

Ahora, necesitamos también una manera óptima de identificar un objeto `Persona` a través de su ID. Creame que usando el `for()` no es la manera óptima. Debemos usar los mecanismos propios de Java. Para ello, debemos reescribir el método `equals()` en la clase `Persona`. Y, como siempre, el NetBeans nos va a ayudar. Abramos esa clase y hagamos clic derecho y seleccionamos `Insert code...`

[![](/assets/blogger/rest4-001.jpg)](/assets/blogger/rest4-001.jpg)

y luego seleccionamos "equals() & hashCode()...". Ahora, seleccionamos el campo "idPersona" en ambos paneles. Esto es que se utilizará el campo "idPersona" para hacer la comparación (equals) y para agrupar la comparación (hashCode)

[![](/assets/blogger/rest4-002.jpg)](/assets/blogger/rest4-002.jpg)

Clic en "Generate".

Y vemos que el NetBeans creó los métodos mencionados.

Una rápida explicación de esos métodos: el equals() sirve para poder comparar dos objetos. Es la única manera de comparar objetos que utilizará el Java. Así nos evitaremos hacer una comparación de un campo por nuestra cuenta cada vez que necesitemos. Y método hashCode() permite devolver un valor que permitirá reducir la comparación. Por ejemplo, si tenemos mil objetos, y todos tienen id diferentes, y necesitamos buscar un ID específico, el Java agrupará todos los que tengan el hashCode similar, y después hará la búsqueda uno por uno dentro de ese grupo reducido.

### Obtener un objeto de la colección a través de su ID

Lo que haremos es acceder a un objeto de la colección pero le damos el ID como parte del URL. Por ejemplo, hasta el momento hemos accedido a un URL como este:

```java
<code>http://localhost:8080/PersonaRESTWeb/resources/listaPersonas</code>
```

... y nuestro reto ahora es obtener el objeto con ID=2 usando este URL

```java
<code>http://localhost:8080/PersonaRESTWeb/resources/listaPersonas/2/</code>
```

Antes de continuar, recordemos en el artículo donde se habló cómo [manejar un solo objeto](/2010/11/restful-la-forma-mas-ligera-de-hacer_25.html) en RESTful, que el recurso mismo es el que tiene un URL para devolver el objeto.Entonces, modificaremos el recurso `PersonasResource` (el que tiene el arreglo) para que devuelva el `PersonaResource` (el que tiene un solo objeto) y devuelva el objeto seleccionado. Entonces, debemos modificar este último recurso para que la variable `Persona` que tiene no sea `static`, pero que el valor de esa variable sea recibida por un método.

```java
//...
 public class PersonaResource {
       private Persona persona;
   //...
       public void setPersona(Persona persona) {
             this.persona = persona;
       }
}
```

Ahora sí, regresemos al recurso `PersonasResource` (el que tiene la colección de objetos) y agreguemos una referencia al recurso `PersonaResource`. Como es un EJB, entonces lo declaramos como tal:

```java
//...
@Stateless
@Path("/listaPersonas")
public class PersonasResource {
    @EJB
    PersonaResource personaResource;
   //...
```

Luego, agregamos un método que recibirá como parámetro el ID del objeto a buscar, busca el ID en el arreglo, y si existe, le asignará al recurso `personaResource` y lo devolverá al cliente.

```java
//...
public PersonaResource getPersona(Integer id) {
           if (id == null) { //si no se pasó el ID...
                 return null; //... termina el método
           }
           Persona $temp = new Persona(); //creamos un temporal...
           $temp.setIdPersona(id); //.. que tendrá el ID...
           if (personas.contains($temp)) { // ... para buscarlo en la colección. Para eso sirve el método equals(). Si existe en la colección...
                 int idx = personas.indexOf($temp);  //... obtenemos su índice...
                 Persona actual = personas.get(idx); //... lo obtenemos de la colección...
                 personaResource.setPersona(actual); //.. y lo marcamos como "actual"...
                 return personaResource; //... para que lo devuelva al cliente.
           }
             return null; //.. si no lo encuentra, devuelve null
    }
//...
```

Listo, y funciona... pero no tan rápido ¿Cómo sabemos que el ID será parte del URL?. Bien, agregaremos la anotación `@Path("{idPersona}/")` de la siguiente manera

```java
//...
     @Path("{idPersona}/")
     public PersonaResource getPersona(Integer id) {
 //...
```

... y para asociar ese parámetro al parámetro del método, lo hacemos con la anotación `@PathParam()` de la siguiente manera:

```java
//...
     @Path("{idPersona}/")
     public PersonaResource getPersona( @PathParam("idPersona") Integer id) {
 //...
```

Al final, el método completo es como sigue:

```java
//...
     @Path("{idPersona}/")
     public PersonaResource getPersona(@PathParam("idPersona") Integer id) {
             if (id == null) { //si no se pasó el ID...
                     return null; //... termina el método
             }
             Persona $temp = new Persona(); //creamos un temporal...
             $temp.setIdPersona(id); //.. que tendrá el ID...
             if (personas.contains($temp)) { // ... para buscarlo en la colección. Para eso sirve el método equals(). Si existe en la colección...
                   int idx = personas.indexOf($temp);  //... obtenemos su índice...
                   Persona actual = personas.get(idx); //... lo obtenemos de la colección...
                   personaResource.setPersona(actual); //.. y lo marcamos como "actual"...
                   return personaResource; //... para que lo devuelva al cliente.
             }
             return null; //.. si no lo encuentra, devuelve null
     } //...
```

Listo, ahore probemos colocando unos valores como:

```java
<code>{"nombre_persona":"Albert"} {"nombre_persona":"Bernard"} {"nombre_persona":"Carl"}</code>
```

... desde el Test de NetBeans.

[![](/assets/blogger/rest4-003.png)](/assets/blogger/rest4-003.png)

Ahora, del árbol izquierdo, abramos el nodo "listaPersonas" y seleccionemos el nodo "{idPersona}"

[![](/assets/blogger/rest4-004.png)](/assets/blogger/rest4-004.png)

Y en el campo "idPersona", escribiremos el ID de uno de los creados, por ejemplo "2", y hacemos clic en "Test"

[![](/assets/blogger/rest4-005.png)](/assets/blogger/rest4-005.png)

También podemos probar desde el URL de la siguiente manera. Primero toda la lista.

http://localhost:8080/PersonaRESTWeb/resources/listaPersonas

[![](/assets/blogger/rest4-006.png)](/assets/blogger/rest4-006.png)

Y luego, el del ID=2

http://localhost:8080/PersonaRESTWeb/resources/listaPersonas/2/

[![](/assets/blogger/rest4-007.png)](/assets/blogger/rest4-007.png)

### Reemplazar objeto y borrar objeto de la colección

El recurso `PersonasResource` es el que tiene la colección de objetos. Así que aquí le deberemos agregar los métodos que modifiquen y eliminen los objetos de la colección. Pero - OJO - estos no serán accedidos desde el URL. Solo fueron puestos aquí porque tiene la colección. Si se manejara una base de datos, se tendría otro EJB que maneje esos objetos. Bien, nuestro recurso tendrá los siguientes métodos:

```java
//...
public void borrarPersona(Persona p) {
           personas.remove(p); //... busca en la lista y borra el elemento
     }
     public void cambiarPersona(Persona actual, Persona p) {
           int idx = personas.indexOf(actual); //... obtiene la posición del actual
           if (idx >= 0) { //... si existe...
                 p.setIdPersona(actual.getIdPersona()); //... ponerle el ID en el nuevo objeto...
                 personas.set(idx, p); //..y reemplazar el objeto en la misma posición del anterior
           }
     }//...
```

Cada línea está comentada para que quede bien explicado.

Recordemos otra vez que nuestro recurso `PersonaResource` tendrá el objeto seleccionado por el ID. Y como el que tiene la colección de objetos es el recurso `PersonasResource` y es un EJB, entonces agregaremos la referencia de la siguiente manera:

```java
//...
public class PersonaResource {
//el que tiene el objeto actual
@EJB    PersonasResource personasResource;
//el que tiene la colección de objetos
//...
```

Entonces los métodos `@PUT` y `@DELETE` será sobre el objeto seleccionado. Así que en este recurso agregaremos los siguientes métodos:

```java
//...
@DELETE
public void borrar() {
 personasResource.borrarPersona(persona);  //porque tiene la colección de objetos
}
@PUT
@Consumes({"application/xml", "application/json"})
public void actualizar(Persona p) {
 personasResource.cambiarPersona(persona,p); //porque tiene la colección de objetos
}
//...</code>
```

Y listo. Probemos el test de NetBeans,´agregamos los mismo objetos, y probemos la actualización: Seleccionamos el idPersona:2 y le ponemos el nuevo objeto a reemplazar, utilizando el método "PUT"

[![](/assets/blogger/rest4-008.png)](/assets/blogger/rest4-008.png)

Y cuando consultamos el ID=2, este será el nuevo objeto:

[![](/assets/blogger/rest4-009.png)](/assets/blogger/rest4-009.png)

Y luego para el método "DELETE", y le indicamos el de ID=1

[![](/assets/blogger/rest4-010.png)](/assets/blogger/rest4-010.png)

.. y luego obtenemos el listado de objetos.

[![](/assets/blogger/rest4-011.png)](/assets/blogger/rest4-011.png)

### Código fuente del proyecto

Como siempre, aquí publico el código fuente del proyecto utilizado en este artículo para que lo prueben y vean que no miento `:)`

[http://kenai.com/projects/apuntes/downloads/download/CRUDPersonasRest%252FPersonaRESTWeb.tar.gz](http://kenai.com/projects/apuntes/downloads/download/CRUDPersonasRest%252FPersonaRESTWeb.tar.gz)
