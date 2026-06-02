---
layout: post
title: "MVC Framework en JavaEE 8"
date: 2014-10-02T20:48:00.002Z
last_modified_at: 2018-01-10T23:46:54.899Z
author: "Diego Silva Límaco"
permalink: /2014/10/mvc-framework-en-javaee-8.html
canonical_url: https://www.apuntesdejava.com/2014/10/mvc-framework-en-javaee-8.html
tags:
  - "java ee"
  - "java ee 8"
  - "mvc"
  - "comentarios"
---

[![](/assets/blogger/mvc.png)](/assets/blogger/mvc.png)

Existe un nuevo [JSR](https://jcp.org/en/jsr/detail?id=371) para el MVC 1.0 que se debería incluir en el Java EE 8. Ya hemos trabajado por mucho tiempo con frameworks que implementan MVC como Struts, Spring MVC y JSF. La pregunta es ¿por qué necesitamos otro MVC? ¿No basta con el estándar de JSF? Aquí comentaremos un poco en qué consiste este MVC que aparecerá en JvaEE8

Para comenzar, veamos algo extraño. Java EE ya tiene un framework MVC llamado JSF ¿Por qué necesitamos otro? ¿No es una exageración? La respuesta está en distinguir entre los diferentes tipos de MVC. Para efectos de este post, se considerarán dos tipos de MVC:

- Orientado al interfaz de usuario

- Orientado a la acción

Hay otros tipos de esquemas, pero nos quedaremos con estos dos. Al final del post comprenderemos la razón porque debe existir este JSR que se centra únicamente al MVC y explica cómo esta especificación se relacionará con la próxima versión de JSF.

### MVC orientado al interfaz de usuario = JSF

[![](/assets/blogger/jsfcomponent-framework-2280471.png)](/assets/blogger/jsfcomponent-framework-2280471.png)

En JSF, el modelo es CDI, la vista son facelets y el controlador es el ciclo de vida de JSF, como se muestra en la imagen de la izquierda. Una marca distintiva que el MVC está orientado al interfaz de usuario es el concepto de IoC ([Inversión de Control](http://es.wikipedia.org/wiki/Inversi%C3%B3n_de_control)) que consiste en que el MVC tiene su propio flujo y nos da espacios específicos por donde nosotros podemos ingresar alguna programación. Lo notamos en los JSF, donde nosotros específicamos facelets y estos se arman en todo el HTML creado por el framework (que agrega más código javascript, tags especiales, validaciones, etc.) Además, nosotros no recibimos un submit de tipo POST/GET, simplemente nuestro ManagedBean utiliza los valores que en algún momento alguien lo ha recibido y nosotros nos limitamos a utilizar los valores. Bueno, ya no nos preocupamos de la validación y de que el HTML esté bien escrito ¿cierto?

Veremos un ejemplo de código que muestra el extremo del IoC para mostrar el concepto. Este ejemplo consiste en buscar un símbolo. Primero veamos el `index.html`

```java
<!DOCTYPE html>
   <html xmlns="http://www.w3.org/1999/xhtml"
         xmlns:f="http://xmlns.jcp.org/jsf/core"
         xmlns:jsf="http://xmlns.jcp.org/jsf">
   <head jsf:id="head">
      <title>Symbol lookup</title>
   </head>

   <body jsf:id="body">

   <form jsf:id="form">

       <p>Enter symbol:
           <input name="textField" type="text" jsf:value="#{bean.symbol}" />
           <input type="submit" jsf:id="submitButton" value="submit" jsf:actionListener="#
{bean.actionListener}">
            <f:ajax execute="@form" render="@form" />
          </input>
       </p>

       <div jsf:rendered="#{not empty bean.info}">
           <p>Info for #{bean.symbol}: #{bean.info}.</p>
       </div>

   </form>

   </body>

   </html>
```

Este es una página HTML simple con componentes JSF (tal como lo vimos en un anterior post sobre [JSF con HTML5](/2014/08/tutorial-jsf-22-sesion-8-html5.html)). El símbolo para buscar se escribe en el campo de texto de nombre "textField". El botón para enviar es un `input` con tipo `submit`, que recibe un método `actionListener`. En este método es donde podemos programar para hacer que busque el símbolo en la base de datos. Además está el componente `<f:ajax />` dentro del botón. Esto hace que el botón tenga efecto ajax, permitiendo el envío del formulario y la actualización de la página se haga automáticamente usando `XmlHttpRequest`. Finalmente hay un div que se muestra si el info del bean no está vacío, que sería el resultado de la búsqueda.

Aquí tenemos otra porción de código del managedbean que es llamado por el nombre `#{bean}` en el JSF.

```java
import java.io.Serializable;
   import javax.enterprise.context.RequestScoped;
   import javax.inject.Named;

   @Named
   @RequestScoped
   public class Bean implements Serializable

       private String symbol;

       public String getSymbol() {
           return symbol;
       }

       public void setSymbol(String symbol) {
           this.symbol = symbol;
       }

       public void actionListener() {
           // Poll stock ticker service and get the data for the requested symbol.
           this.info= "" + System.currentTimeMillis();
       }

       private String info;

       public String getInfo() {
           return info;
       }
   }
```

Este bean es realmente un objeto java simple que con un métodos get/set para la propiedad `symbol`, un método get para la propiedad `info`, y un método llamado `actionListener()`.JSF maneja todos los mecanismos repetitivos del controlador. Esta aplicación se desplegará correctamente en cualquier contenedor Java EE 7 tal como GlassFish 4.x. Si quieren el código fuente lo podemos encontrar aquí: [https://bitbucket.org/edburns/jsf-symbol](https://bitbucket.org/edburns/jsf-symbol) El ejemplo incliye dos archivos adicionales que no están aquí: el `pom.xml` y el `faces-config.xml`

El MVC orientado al interfaz de usuario es bastante útil cuando deseamos ocultar código HTML/CSS/JSS y HTTP desde la página del autor. El autor de la página se centra más en la composición de las interfaces de usuario usando componentes preconstruidos y en poner pedazos de códigos por aquí y por allá para integrarlo al modelo. Con este enfoque, debemos tener mucha confianza en el contenedor, pero a cambio tenemos una codificación rápida y simple.

Las bondades de este enfoque comienzan a disminuir cuando tenemos requerimientos que nos piden tener más control dentro del ciclo de vida desde el nivel más bajo de HTTP como son los request/response, y cuando necesitamos más control en el comportamiento de HTML/CSS/JS que son parte del usuario. El HTML5 en JSF 2.2 mitiga en parte este problema, pero igual siguen siendo HTML con componentes JSF. Esto ha llevado a que algunos consideren que el JSF sea "demasiada pegajosa", pero esta dureza se debe al efecto secundario del IoC y las inyección de dependencias. Y eso que no consideramos incluir al JSF otras tecnologías sin saber cómo funciona. Y para terminar, los que desarrolladores nuevos que vienen usando PHP o Struts, les costará mucho comprender este enfoque.

### MVC orientado a la acción = MVC 1.0

En contraste al enfoque anterior mostrado, el MVC que se propone como MVC 1.0 se puede llamar "MVC orientado a la acción". Este estilo se puede ver en la siguiente figura. Para los desarrolladores de [Apache Struts](http://struts.apache.org/) y [Spring MVC](http://docs.spring.io/spring/docs/current/spring-framework-reference/html/mvc.html) les debe ser conocido.

[![](/assets/blogger/jsfactionframework-2280469.png)](/assets/blogger/jsfactionframework-2280469.png)

El controlador envía (o *despacha*) a una acción específica, basada en la información que está en la petición. Cada acción hace una cosa específica para transformar la solicitud y lo procesa de acuerdo a lo necesario, y si es necesario actualiza el modelo. Este enfoque no solo evita ocultar el modelo request/response de HTTP, sino también no indica qué especificaciones se deben tener en cuenta de HTML/CSS/JS respecto al interfaz de usuario.

Aunque el API para MVC 1.0 es muy amplia, una pieza primordial está influenciado por el sistema [Jersey MVC](https://jersey.java.net/documentation/latest/mvc.html). El código fuente de Jersey incluye varios ejemplos, incluyendo la aplicación Bookstore, y aquí veremos un exactro.

Nuevamente comenzamos con un simple JSP:

```java
<%@page contentType="text/html"%>
   <%@page pageEncoding="UTF-8"%>

   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
       "http://www.w3.org/TR/html4/loose.dtd">

   <html>
       <head>
           <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <style type="text/css" media="screen">
              @import url(<c:url value="/css/style.css"/> );
           </style>
           <title>REST Bookstore Sample</title>
       </head>
       <body>

       <h1>${it.name}</h1>

       <h2>Item List</h2>

       <ul>
           <c:forEach var="i" items="${it.items}">
               <li><a href="items/${i.key}/">${i.value.title}</a>
           </c:forEach>
       </ul>

       <h2>Others</h2>
       <p>
         <a href="count">count inventory</a>
       <p>
         <a href="time">get the system time</a>
       <p>
         <a href="jsp/help.jsp">regular resources</a>
       </p>
       </body>
   </html>
```

En este enfoque, la hoja de estilos (CSS) se debe insertar manualmente usando la instrucción `@import` en la sección `<head>`. Si la página necesita usar javascript, se deberá insertar de la misma manera. Con JSF, estos recursos se insertan automáticamente cuando indicamos los recursos a necesitar (Para más detalles de Recursos en JSF, ver el post [Tutorial JSF 2.2: Recursos](/2014/06/tutorial-jsf-22-sesion-6-recursos.html)). En el ejemplo anterior de symbol, el uso de `<f:ajax/>` provoca una referencia Javascript para que sea incluido en la página. La aplicación Bookstore usa varias expresiones EL, comenzando con el elemento `<h1>`. Este bean se encuentra ubicado en el alcance del framework MVC. JSTL interactúa con la colección de libros en la variable `${it}`, en la etiqueta `<c:forEach/>`

El `index.jsp` se muestra implícitamente cuando un requerimiento GET se hace a la URL raíz de la aplicación web. Es decir, si la aplicación se llama "BookStore", el JSP se invocará cuando se llame a http://localhost:8080/BookStore. Eso sucede porque existe la anotación JAX-RS `@Path("/")` en el siguiente código.

```java
@Path("/")
    @Singleton
    @Template
    @Produces("text/html;qs=5")
    @XmlRootElement
    @XmlAccessorType(XmlAccessType.FIELD)
    public class Bookstore {

        private final Map<String, Item> items = new TreeMap<String, Item>();
        private String name;

        public Bookstore() {
            setName("Czech Bookstore");
            getItems().put("1", new Book("Svejk", "Jaroslav Hasek"));
            getItems().put("2", new Book("Krakatit", "Karel Capek"));
            getItems().put("3", new CD("Ma Vlast 1", "Bedrich Smetana", new Track[]{
                new Track("Vysehrad",180),
                new Track("Vltava",172),
                new Track("Sarka",32)}));
        }

        @Path("items/{itemid}/")
        public Item getItem(@PathParam("itemid") String itemid) {
            Item i = getItems().get(itemid);
            if (i == null) {
                throw new NotFoundException(Response
                        .status(Response.Status.NOT_FOUND)
                        .entity("Item, " + itemid + ", is not found")
                        .build());
            }

            return i;
        }

        @GET
        @Produces({MediaType.APPLICATION_XML, MediaType.TEXT_XML, MediaType.APPLICATION_JSON})
        public Bookstore getXml() {
            return this;
        }

        public long getSystemTime() {
            return System.currentTimeMillis();
        }

        public Map<String, Item> getItems() {
            return items;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
```

Notemos la manera manual de mostrar las anclas (`<a%gt;`) HTML en `index.jsp`. El atributo href de estas anclas  hacen referencia al URL RESTful del método `getItem()` (Método de la línea 23). Esto ilustra la característica del MVC orientado a la acción, sobre qué tiene que hacer cuando el usuario hace clic en un componente de la interfaz de usuario. Con MVC orientado a componentes, todos los "clics" son manejados por el framework, del cual no tienes mucho el control.

La aplicación Bookstore se ejecuta en GlassFish 4.0 y el código fuente está disponible en el repositorio de Jersey en GitHub: [https://github.com/jersey/jersey.git](https://github.com/jersey/jersey.git)

Este enfoque es mejor frente al MVC orientado a componentes cuando se requiere un mayor control en las peticiones y respuestas request/response. Los diseñadores web pueden estar a favor de este enfoque porque consideran que la abstracción proporcionada el MVC orientado al interfaz de usuario (componentes) limita el control de HTML/CSS/JS. Por último, este enfoque se ajusta bien a las peticiones REST debido a que utiliza la semántica natural de HTTP.

### Conclusión

La decisión de incluir como estándar MVC 1.0 a JavaEE 8, sin dejar de dar soporte y mejorar el JSF, fue tomado en base a los comentarios de la comunidad de muchas fuentes, incluyendo la encuesta [Java EE 8 Developer Survey](https://blogs.oracle.com/ldemichiel/entry/results_from_the_java_ee). Dada la preferencia de la comunidad en usar MVC, la pregunta fue ¿ en qué parte de Java EE se debe crear la especificación? Varias opciones fueron consideradas antes de decidir presentar un JSR independiente. La opción más obvia fue modificar el JSR de JSF. Una opción era reemplazar la especificación JSF. Esto generaría una confusión para el desarrollador sobre la perspectiva de todo el Java EE. Por otro lado, esta opción provocaría que la gente huya asustada del uso de JSF debido a su aparente complejidad y estarían con una curva de aprendizaje bastante empinada. Otra opción era cambiar el JSR de JAX-RS. JAX-RS se ajusta bien al MVC porque es inherentemente cercano al HTTP, y - por tanto - más natural. Una desventaja de esta alternativa es que es imposible hacer un MVC en el lado de servidor, siempre que esté orientado a la acción, sin introducir algún nivel de manejo de sesión en el sistema. Los RESTafarian aborrecen los estados y por lo tanto contaminaría a JAX-RS con manejo de estados. La última opción - de separarlo en un JSR independiente - tiene el ventaja de no asustar a la gente que no quiere usar JSF. A la pregunta "¿cuál uso?" seguirá existiendo, pero la idea de este post es aclarar un poco el escenario.

Por último, no hay que prestar mucha atención a cada JSR que se está trabajando. Lo mejor es mirar a Java EE como una solución cohesionada de tecnologías que tiene ambos estilos de trabajo. Estas dos tecnologías compartirán componentes comunes:

- Usa CDI para el nivel del modelo

- Usa Bean Validation en la capa de validación

- Usa el lenguaje de expresiones (EL) para la manipulación entre la vista y el modelo.

- Usa Facelets o JSP si se desea tener compatibilidad con otros idiomas.

El JSR de MVC 1.0 también explora el uso de Faces Flows y/o alcance Flash y probablemente compartirá elementos de JAX-RS.

En el lado de JSF, además de los cambios necesarios que tendrá el MVC 1.0, JSF 2.3 es una versión enfocada a la comunidad. Los temas a tratar incluyen la invocación ajax, varias limpieza de código y características solicitadas por la comunidad tales como un mejor soporte para Twitter BootStrap, JQuery y Foundation.

(Traducción libre del artículo [Why Another MVC?](http://www.oracle.com/technetwork/articles/java/mvc-2280472.html) de [Ed Burns](https://www.java.net/blog/edburns).  [http://www.oracle.com/technetwork/articles/java/mvc-2280472.html](http://www.oracle.com/technetwork/articles/java/mvc-2280472.html))
