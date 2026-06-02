---
layout: post
title: "JDK Record ¿Lo necesito?"
date: 2022-07-16T04:16:00Z
last_modified_at: 2022-07-16T04:16:00.776Z
author: "Diego Silva Límaco"
permalink: /2022/07/jdk-record-lo-necesito.html
canonical_url: https://www.apuntesdejava.com/2022/07/jdk-record-lo-necesito.html
description: "¿Para qué es? ¿Para qué sirve? ¿Será peligroso para mis hijos?"
tags:
  - "record"
  - "java record"
---

[![](/assets/blogger/Thinking.jpg)](/assets/blogger/Thinking.jpg)

JEP 395: Records :
[https://openjdk.org/jeps/395](https://openjdk.org/jeps/395).

  Apareció en la versión JDK 14 como preliminar, y ya fue lanzado como oficial
  en la versión JDK 16. ¿Para qué es? ¿Para qué sirve? ¿Será peligroso para mis
  proyectos? ¿Será más peligroso para mis hijos?. En este artículo examinaremos
  hasta qué tan útil puede ser los Records en JDK.

  Tenemos años usando el patrón Java Bean, también llamado P.O.J.O (Plain Old
  Java Objects), que son clases que solo tienen campos con métodos setters y
  getters, nada más. De verdad es algo incómodo crear clases así solo para dar
  poner campos... y daba ganas de poner las propiedades en modo
  `public` y no `private`, total, solo son para guardar
  valores, nada más.

  No hace mucho ha salido una biblioteca muy utilizada llamada Project Lombok
  [https://projectlombok.org/](https://projectlombok.org/)
  que - como bien se sabe - se coloca las propiedades básicas de la clase POJO y
  con algunas anotaciones se logra completar todos los demás métodos para
  completar el POJO: setters / getters / constructores / equals, etc.... pero
  sigue siendo una clase. Como dice un viejo refrán "aunque la mona se vista de
  seda, mona se queda".

  Por eso se creó un NUEVO TIPO de datos, no reemplaza, no ataca, a los
  legendarios POJO. Solo es una alternativa más. Java tiene una larga data de
  tener compatibilidad hacia atrás. Así que tranquilos, no va ser ningún
  problema con los códigos hechos hasta ahora.

## Declaración

  La declaración es bastante fácil. En lugar de `class` se escribe
  `record` y los campos que tendrá ese record se colocan después del
  nombre

```java
public record Person(
        String name,
        LocalDate birthdate) {

}
```

  De por sí, ya tiene un constructor que son esos dos campos ¿puedo hacer sobre
  carga de constructores? Pues sí, así:

```java
public record Person(
        String name,
        LocalDate birthdate) {

    public Person(String name) {
        this(name, LocalDate.MIN);
    }

}
```

## ¿Métodos y propiedades?

  Se pueden agregar métodos y propiedades (variables) pero son
  `static`:.

```java
public record Person(
        @JsonbProperty("fullName")
        String name,
        LocalDate birthdate) {

    public static final String  NO_NAME = "No name"; //funciona como constante

    /**
     * Método para crear un objeto con nombre "no name"
     * pero con fecha de nacimiento
     * @param birthdate La fecha de nacimiento
     * @return un nuevo objeto
     */
    public static Person newPerson(LocalDate birthdate) {
        return new Person(NO_NAME, birthdate);
    }

    public Person(String name) {
        this(name, LocalDate.MIN);
    }

}
```

## ¿Cómo se instancia?

Crearemos una colección con todos los ejemplos hasta ahora creados.

```java
var personsList = Arrays.asList(
                new Person("Ann", LocalDate.of(1976, 5, 1)), //constructor por omisión
                new Person("Bob", LocalDate.of(1986, 8, 10)),
                new Person("Carl"), //constructor sobre cargado
                Person.newPerson(LocalDate.of(1977, 10, 10)) //usando un método static
        );
```

## Cómo acceder a los valores

  Los valores que se colocan en la instanciación no pueden ser modificados, solo
  pueden ser accedidos (es como si fueran constructores a propiedades
  `final` y tiene métodos get). Veamos, imprimamos el contenido de la
  colección:

```java
personsList.forEach(person -> {
            System.out.printf("\t%s : %s \n", person.name(), person.birthdate());
        });
```

La salida es:

```java
Ann : 1976-05-01
	Bob : 1986-08-10
	Carl : -999999999-01-01
	No name : 1977-10-10
```

  Como se puede ver, para acceder a las propiedades se hace usando el mismo
  nombre de la propiedad pero como método... y no hay un método para para
  cambiar de valor. Mucho ojo con esto.

## Algunas aplicaciones

  Aquí viene lo bueno, porque ¿de qué sirve tener un nuevo tipo, que no puedo
  cambiar los valores? ¿dónde lo puedo utilizar. Aquí hay dos lugar muy grandes
  donde se puede utilizar ampliamente.

### JSON-B

Para poder leer y escribir contenido JSON usando JSON-Binding.

  A nuestro ejemplo, agregaremos esta dependencia que es compatible con el
  namespace "jakarta" y que ya se puede implementar en Jakarta EE 9.1

```java
<dependency>
            <groupId>org.eclipse</groupId>
            <artifactId>yasson</artifactId>
            <version>3.0.0</version>
        </dependency>
```

  Esta dependencia reconoce a record como un tipo de datos. Antes de esa versión
  no lo reconoce.

  Ahora bien, podemos modificar los atributos a nivel de JSON, por ejemplo, en
  vez que se llame `name` se llame `fullName`, y esto se
  hace desde en el mismo record:

```java
public record Person(
        @JsonbProperty("fullName")
        String name,
        LocalDate birthdate) {
//...
```

Veamos cómo convertir la colección que hemos creado a un String JSON.

```java
var jsonb = JsonbBuilder.newBuilder()
                .withConfig(
                        new JsonbConfig()
                                .withFormatting(true)//para que sea bonito al imprimir
                ).build();
        String json = jsonb.toJson(personsList);
        System.out.printf("from collection to json:%s\n", json);
```

Y la salida es:

```java
from collection to json:[
    {
        "birthdate": "1976-05-01",
        "fullName": "Ann"
    },
    {
        "birthdate": "1986-08-10",
        "fullName": "Bob"
    },
    {
        "birthdate": "-999999999-01-01",
        "fullName": "Carl"
    },
    {
        "birthdate": "1977-10-10",
        "fullName": "No name"
    }
]
```

Y también podemos tomar un JSON y convertirlo a la colección de record:

```java
var newList = jsonb.fromJson(json, ArrayList.class);
        System.out.printf("from json to collection:%s\n", newList);
```

Y la salida es:

```java
from json to collection:[{birthdate=1976-05-01, fullName=Ann}, {birthdate=1986-08-10, fullName=Bob}, {birthdate=-999999999-01-01, fullName=Carl}, {birthdate=1977-10-10, fullName=No name}]
```

### JSON-P

  JSON-P o JSON Processing es una buena manera para manipular los JSON a nivel
  de JSON sin llegar hasta la conversión del registro. Así que puede ser una
  buena idea tomar el JSON recién convertido por el JSON-B para poder manipular
  su contenido:

```java
try ( StringReader stringReader = new StringReader(json)) {
            JsonReader reader = Json.createReader(stringReader);

            JsonArray jsonArray = reader.readArray();
            jsonArray.stream()
                    .map(JsonValue::asJsonObject) //para manipularlo como JsonObject
                    .forEach(item -> {
                        var name = item.getString("fullName");
                        var birthdate = item.getString("birthdate");
                        System.out.printf("\t%s : %s \n", name, birthdate);
                    });
        }
```

### Servicios REST

  Este es el plato fuerte, por el cuál podemos despedirnos del Project Lombok
  (ok, no tan pronto, ya diré por qué) y olvidarnos de nuestro largos POJO en
  los request y response.

  Como mencioné al inicio, esto está disponible a partir de JDK 17, así que se
  debe tener en cuenta los Servidores Java que sean compatibles con JDK 17. He
  probado varios y los que funcionan tranquilamente son:

-
    Eclipse GlassFish 6.2.x ([https://glassfish.org/download](https://glassfish.org/download))

-
    WildFly 26.1.1.Final Preview EE 9.1 Distribution ([https://www.wildfly.org/downloads/](https://www.wildfly.org/downloads/))

-
    Apache TomEE 9.0 ([https://tomee.apache.org/download.html](https://tomee.apache.org/download.html))

OJO: Debe decir expresamente  que es compatible con Jakarta EE 9.1

(qué pasó Payara! no funcionaste!)

#### El ejemplo

  El ejemplo es bastante simple, y ya se puede intuir cómo se puede implementar.

Tendremos nuestro request y nuestro response, bastante simple:

`RequestBody.java`

```java
package com.apuntesdejava.record.rest.rest;

public record RequestBody(String name, int id) {

}
```

`ResponseBody.java`

```java
package com.apuntesdejava.record.rest.rest;

import java.time.LocalDateTime;

public record ResponseBody(String name, LocalDateTime time) {

}
```

Y nuestro servicio REST:

`SampleRest.java`

```java
package com.apuntesdejava.record.rest.rest;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import static jakarta.ws.rs.core.MediaType.APPLICATION_JSON;
import java.time.LocalDateTime;

@Path("sample")
@Produces(APPLICATION_JSON)
@Consumes(APPLICATION_JSON)
public class SampleRest {

    @GET
    public ResponseBody get() {
        return new ResponseBody("Hola", LocalDateTime.now());
    }

    @POST
    public ResponseBody post(RequestBody request) {
        return new ResponseBody("hi " + request.name() + " - " + request.id(), LocalDateTime.now());

    }
}
```

Y la invocación a los servicios es de lo más simple y común:

```java
#Invocando a GET:
http :8080/record-rest-sample/api/sample
```

[![](/assets/blogger/ubuntu_W6nRt7jbV1.png)](/assets/blogger/ubuntu_W6nRt7jbV1.png)

```java
#Invocando a POST:
http --json :8080/record-rest-sample/api/sample name=Duke id=100
```

[![](https://i.imgur.com/GI0k9Vt.png)](https://i.imgur.com/GI0k9Vt.png)

## Conclusiones

  Como se puede ver, es un mundo nuevo que se abre con la implementación de este
  nuevo tipo de datos ¿vale la pena implementarlo? pues la respuesta es la misma
  cuando hay algo nuevo:

-
    Si hasta ahorita te funciona bien con lo que tienes (POJO, Lombok Project,
    etc) entonces, déjalo ahí.

-
    Solo si vas hacer un nuevo proyecto en el cual necesariamente tengas que
    utilizar JDK 17 o superior y utilices Jakarta EE 9.1 o superior, es muy
    recomendable que utilices ya este tipo nuevo de datos. Será muy útil.

  Recordemos que en este mundo de programación y desarrollo todo va cambiando a
  mejor, y si nos quedamos en la versión antigua, pudiendo (OJO, pudiendo, no
  exigiendo) usar algo  novedoso, sería un descuido enorme. Afortunadamente
  Java, desde su concepción, permite la compatibilidad hacia atrás (salvo desde
  JDK 9 que se necesita algunos parámetros en el JVM), así que todo proyecto
  *Legacy* puede ejecutarse en una versión superior de Java.

## Código fuente

El código fuente del proyecto REST lo puedes descargar desde aquí:

  [https://github.com/apuntesdejava/record-rest-sample](https://github.com/apuntesdejava/record-rest-sample)

Si has llegado hasta aquí te agradezco muchísimo.
