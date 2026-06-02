---
layout: post
title: "RESTful - Parte 2: Manejando un solo objeto"
date: 2010-11-25T10:15:00.004Z
last_modified_at: 2010-11-25T19:53:39.403Z
author: "Diego Silva"
permalink: /2010/11/restful-la-forma-mas-ligera-de-hacer_25.html
canonical_url: https://www.apuntesdejava.com/2010/11/restful-la-forma-mas-ligera-de-hacer_25.html
tags:
  - "netbeans 6.9"
  - "restful"
  - "java ee"
  - "tutorial"
  - "netbeans"
  - "java ee 6"
---

[![](/assets/blogger/rest-ful-webservice-baner.png)](/assets/blogger/rest-ful-webservice-baner.png)

Hemos visto en el anterior [post](/2010/11/restful-la-forma-mas-ligera-de-hacer.html)cómo hacer un servicio REST solo para producir y consumir un texto simple. Ahora bien, en la vida real no son textos simples, sino estructuras de datos algo complicadas. Pero para ir lentos pero seguros, aprenderemos cómo hacer un servicio REST pero para manejar un solo objeto.

Afortunadamente para nuestros proyectos, no debemos crear ningún XML, ni tener algún "parser" que convierta nuestros objetos en formato XML o algo parecido para enviar y recibir objetos por la red. Solo necesitamos crear nuestros JavaBeans... y ponerle algunos tags.

## Manos a la obra...

Supongamos que tenemos creado el proyecto web PersonaRESTWeb sobre GlassFish v3 y sin ningún framework adicional. Recordemos que nuestro proyecto se autoconfigura en REST cuando se aplica una anotación especial.

### Creando un javaBean

Una vez creado el proyecto, crearemos un JavaBean llamado `Persona`

```java
<code>
public class Persona {

    private int idPersona;
    private String nombre;
    private java.util.Date fechaNacimiento;
    private boolean trabajador;
    private char sexo;
//...
</code>
```

... con sus respectivos set y get.

Ahora, este JavaBean lo entendemos muy bien en Java, pero recordemos de que un servicio web debe ser compatible para otros lenguajes, y que la estructura de datos más "compatible" es el XML. Así que vamos hacer que este JavaBean se convierta en XML. Bastará con poner la anotación `@XmlRootElement` al inicio de la declaración de la clase.

```java
<code>
@XmlRootElement
public class Persona {

    private int idPersona;
    private String nombre;
    private java.util.Date fechaNacimiento;
    private boolean trabajador;
    private char sexo;
//...
</code>
```

### Creando recurso manejador de Persona

El diseño de este Servicio obliga a que exista un solo recurso manejador por cada Entidad. Por tanto, debemos crear la clase `PersonaResource`. Y para que administre un JavaBean, declararemos un objeto static.

Nota: Lo normal aquí es usar un manejador de persistencia (sea JPA, JDBC, etc..), pero como el objetivo de este tutorial es ver cómo funciona un REST, no gastaremos esfuerzo por conectarnos a una base de datos.

Este es el código fuente del recurso `PersonaResource`

```java
<code>
@Stateless
@Path("/personas")
public class PersonaResource {

    static Persona persona;
}

</code>
```

Ahora, necesitamos implementar los métodos para registrar un objeto Persona desde el cliente, y leer el objeto desde el hacía hasta el cliente. Por tanto, crearemos dos métodos: registrar y leer.

### Leer valor del objeto

Esto ya lo hemos visto. Es declarar un método y declararlo con la anotación `@GET`

```java
<code>
//...
    @GET
    public Persona leer(){
        return persona;
    }
//...
</code>
```

Sí, nada más (por ahora)

### Guardar valor al objeto

Esto debería ser sencillo. Bastaría con poner este código

```java
<code>
//...
    @POST
    public void guardar(Persona p) {
        persona = p;

    }
//...
</code>
```

Pero no es así. Porque toda petición que se hace a un recurso web (el que sea) siempre debe devolver algo.. así sea un error, pero debe devolver algo. En REST debe devolver un objeto `javax.ws.rs.core.Response` que contiene el estado de la petición: si está OK, si hay error de restricción, si no responde, etc.. todos los errores que conocemos para HTTP están contenidos en ese objeto. Pero para nuestro caso, vamos a devolver el valor "ok" de la siguiente manera:

```java
<code>
//...
    @POST
    public Response guardar(Persona p) {
        persona = p;
        return Response.ok(p).build();
    }
//...
</code>
```

Ahora sí... a desplegarlo y a probar... pero si lo probamos en este momento, nos mostrará la siguiente ventana.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8kPQUUh49s36yHgsSqqD1QLJktHwDYBZgDVxUIhUW7B4YDT8pX6bAyhnrvvzU7eai1V09T3ZVorlodlzml_xTuY3N1K9qi9VPzsYVjIlqKcXqtLCNo2p_0yHlPdjEaoNazS3q5E8UGwQf/s400/rest2-01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8kPQUUh49s36yHgsSqqD1QLJktHwDYBZgDVxUIhUW7B4YDT8pX6bAyhnrvvzU7eai1V09T3ZVorlodlzml_xTuY3N1K9qi9VPzsYVjIlqKcXqtLCNo2p_0yHlPdjEaoNazS3q5E8UGwQf/s1600/rest2-01.jpg)

y.. qué pondremos en la caja de texto? Pues el objeto a enviar... pero ¿cómo? Pues un dato estándar, como XML o JSON. Por ejemplo, este código

```java
<code>
<persona>
       <idPersona>20</idPersona>
       <nombre>Albert</nombre>
       <trabajador>true</trabajador>
</persona>
</code>
```

Lo probamos y... error!!! ¿qué pasó?

Pues nuestro servicio REST no sabe si la data que va a recibir es un XML, o un JSON. Hay que decirle al método de ese recurso cómo va a recibir los datos. Por ahora, vamos a poner esta anotación en el método:

```java
<code>
//...
    @POST
    @Consumes("application/xml")
    public Response guardar(Persona p) {
        persona = p;
        return Response.ok(p).build();
    }
//...
</code>
```

Ahora sí, desplegamos, ejecutamos el Test y... vemos que ahora el método POST dice qué tipo permitirá:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgqPcWPH_Krhz3tzvJw2_7yYpJU2wpuIh9TvbR_fUFgAGQ1Up_dWQiBuMo1LIBeyFBcom4N66gOn62QHZYzxBlsxCf2xIO18BYHSeXT3pzfxIzSBV7M-9uuMtVIdUqlcjCboriwsUjRVv1t/s400/rest2-02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgqPcWPH_Krhz3tzvJw2_7yYpJU2wpuIh9TvbR_fUFgAGQ1Up_dWQiBuMo1LIBeyFBcom4N66gOn62QHZYzxBlsxCf2xIO18BYHSeXT3pzfxIzSBV7M-9uuMtVIdUqlcjCboriwsUjRVv1t/s1600/rest2-02.jpg)

Escribimos nuevamente el texto y voila!! `Status: 200 (OK) `

"Bien, el XML funciona, pero el formato es un poco grande ¿se puede usar JSON?" Sí.. y lo mejor, es bien sencillo activar esa opción.

```java
<code>
//...
    @POST
    @Consumes({"application/xml","application/json"})
    public Response guardar(Persona p) {
        persona = p;
        return Response.ok(p).build();
    }
//...
</code>
```

Listo, ahora nuestro método `guardar()` permite recibir tanto JSON como XML. Probemos ahora colocando el siguiente valor en el módulo de prueba:

```java
<code>
{  "idPersona":"20",
   "nombre":"Bernard",
   "trabajador":"true"
}
</code>
```

... seleccionamos el tipo JSON...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiXk8w9nIMjSpLDQWEacnYpwdRyfQzbioncBz3_cR90CSDUOp8kdpJAN2-ThkpYq1RzR962ay7RXT5N1IL0ROcc5bFjZOVj_BrRfsLYOrhj27ft3GjsraMcE56C6Bvqj68Kwp-CPOw-5h22/s400/rest2-03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiXk8w9nIMjSpLDQWEacnYpwdRyfQzbioncBz3_cR90CSDUOp8kdpJAN2-ThkpYq1RzR962ay7RXT5N1IL0ROcc5bFjZOVj_BrRfsLYOrhj27ft3GjsraMcE56C6Bvqj68Kwp-CPOw-5h22/s1600/rest2-03.jpg)

... y listo.. funciona!

Si no están seguros de que guardó correctamente, ejecutemos el método GET para ver si lo guardó en el objeto

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFxvJ0kWS4Mf0OIpLJxaUcmddLLAIBpbvtlr7kILx1xrIexOEAQRte6-OopWhzYj9d30BX6tXM0nd3YGF8-enaDjaLKaB6lTGK5Nhn41u68bClrsSxa02z3ZPEGAV8MvAWR8uCdOSdrVcu/s400/rest2-04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFxvJ0kWS4Mf0OIpLJxaUcmddLLAIBpbvtlr7kILx1xrIexOEAQRte6-OopWhzYj9d30BX6tXM0nd3YGF8-enaDjaLKaB6lTGK5Nhn41u68bClrsSxa02z3ZPEGAV8MvAWR8uCdOSdrVcu/s1600/rest2-04.jpg)

### Modificando el tipo de formato para leer el objeto

Ya vimos que se puede establecer el tipo que el Servicio recibirá por la red usando `@Consumes`. Y cuando probamos la lectura, lo convierte siempre a XML ¿se puede cambiar para que sea JSON? Por su puesto, y es igual de simple:

```java
<code>
//...
    @GET
    @Produces({"application/json","application/xml"})
    public Persona leer() {
        return persona;
    }
//...

</code>
```

Por omisión usará el primer tipo especificado (en este caso "json"), o  - dependiendo cómo se indique en el cliente - puede utilizar el formato XML.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgsLfNVuGwZrdvUrElRxddbaeN9azzaGA-Q-brK45LVvXCKQOFHN1QOosrpyOZs_58yKs8ziB2b01LZ8zhseGuhsdneKj_xWsAwUA72wG0aKpeE0acguaYdPR8kFEEqIMFXhad9GT03WmC-/s400/rest2-05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgsLfNVuGwZrdvUrElRxddbaeN9azzaGA-Q-brK45LVvXCKQOFHN1QOosrpyOZs_58yKs8ziB2b01LZ8zhseGuhsdneKj_xWsAwUA72wG0aKpeE0acguaYdPR8kFEEqIMFXhad9GT03WmC-/s1600/rest2-05.jpg)

### Modificando la estructura de los datos

Nuestro bean utiliza la propiedad `idPersona`, y el REST lo procesa correctamente. Pero, si el estándar de los proyectos donde se va a utilizar, dice que debe ser `id_persona` y el campo nombre sea `nombre_persona` ¿Cómo modificamos esto?

Esto también es fácil. Por cada método "get" que debemos cambiar el formato, le agregamos la anotación `@XmlElement` seguido del nombre como deberá ser manejado. Vayamos al Bean Persona y pongamos esto:

```java
<code>
//...

    @XmlElement(name = "id_persona")
    public int getIdPersona() {
        return idPersona;
    }

    @XmlElement(name = "nombre_persona")
    public String getNombre() {
        return nombre;
    }
//...

</code>
```

Ahora, probemos el método "GET".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhHSVwRhscBPwtBsL2-s92Qzz9yeMSNchcGLuDYZ3rKdf-DFKGbKfOP6BE4L6U-alLXdqcKoibpLbnDOn15HMgk6xwxuQOmyA8TOrC4AQTlDfjYyY9qvx1dEdGIGUPP3aWkgFb1q7e0Dhks/s400/rest2-06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhHSVwRhscBPwtBsL2-s92Qzz9yeMSNchcGLuDYZ3rKdf-DFKGbKfOP6BE4L6U-alLXdqcKoibpLbnDOn15HMgk6xwxuQOmyA8TOrC4AQTlDfjYyY9qvx1dEdGIGUPP3aWkgFb1q7e0Dhks/s1600/rest2-06.jpg)

¿Y si, el `id_persona` tiene que ser un atributo del XML? Cambiamos la notación `@XmlElement` por `@XmlAttribute`

```java
<code>
//...

    @XmlElement(name = "id_persona")
    public int getIdPersona() {
        return idPersona;
    }

//...

</code>
```

Ojo, cuando es atributo y  se desea enviar en formato JSON, se debe considerar ql nombre del atributo antepuesto por un `@`.

```java
<code>
{  "@id_persona":"20",
   "nombre_persona":"Bernard",
   "trabajador":"true"
}

</code>
```

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJohAsTa0mP-UZrpk6jDJkuGAYINcatlmAQM8MswnthB_sJhO-Nbe3n6wzgB7wUSRhZF0-bn09Gdhi5K_hyphenhyphenkcWJppM5EtQXaPnZ_3BH7LESA0DqpFu3Lnh4ruYmOGRHwwAKonn5L_LjIf1/s400/rest2-07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJohAsTa0mP-UZrpk6jDJkuGAYINcatlmAQM8MswnthB_sJhO-Nbe3n6wzgB7wUSRhZF0-bn09Gdhi5K_hyphenhyphenkcWJppM5EtQXaPnZ_3BH7LESA0DqpFu3Lnh4ruYmOGRHwwAKonn5L_LjIf1/s1600/rest2-07.jpg)

### "En ningún momento aparece el nombre del método guardar() y leer() ¿Cómo sabe qué método utilizar?"

Pues por el mismo método HTTP utilizado: Si se hace "POST", ejecuta el método que está asociado a `@POST`, si se hace "GET", utiliza el `@GET`.

¿"Y si quiero diferenciar un 'update' de un 'create' ? " Pues utilizar otro método. Como comenté en el anterior post, el POST debe estar asociado al "create",el GET asociado a la búsqueda, el "PUT" al "update" y el "DELETE" al borrar.

Si hay que hacer otro tipo de "POST" o de "DELETE", debemos utilizar otro objeto Recurso (con anotación `@Path`) ya que será accedido desde otra ruta.

Por ello comenté en el anterior post de que este diseño asegura de que los métodos de mantenimiento están asociados a una sola entidad..  y nos evitará tener métodos en servicios web que no corresponde, por ejemplo, no habrá un manejo de proveedores en un servicio de clientes.

## Código del proyecto

Aquí se encuentra el código fuente del proyecto web:

[http://kenai.com/projects/apuntes/downloads/download/PersonaRESTWeb%252FPersonaRESTWeb.tar.gz](http://kenai.com/projects/apuntes/downloads/download/PersonaRESTWeb%252FPersonaRESTWeb.tar.gz)

Aquí el código fuente de una aplicación Java Desktop:

[http://kenai.com/projects/apuntes/downloads/download/PersonaRESTWeb%252FPersonaRESTClient.tar.gz](http://kenai.com/projects/apuntes/downloads/download/PersonaRESTWeb%252FPersonaRESTClient.tar.gz)
