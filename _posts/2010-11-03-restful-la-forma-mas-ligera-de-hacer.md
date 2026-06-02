---
layout: post
title: "RESTful... la forma más ligera de hacer WebServices (Parte 1)"
date: 2010-11-03T22:29:00Z
last_modified_at: 2013-04-11T20:00:35.070Z
author: "Diego Silva"
permalink: /2010/11/restful-la-forma-mas-ligera-de-hacer.html
canonical_url: https://www.apuntesdejava.com/2010/11/restful-la-forma-mas-ligera-de-hacer.html
tags:
  - "webservices"
  - "netbeans 6.9"
  - "restful"
  - "web"
  - "netbeans"
  - "java ee 6"
  - "tutorial java"
---

[![](/assets/blogger/rest-ful-webservice-baner.png)](/assets/blogger/rest-ful-webservice-baner.png)

Quienes hayan usado SOAP para WebService, sabrán que es bien fácil de diseñar, pero algo complicado de consumir: se necesita toda una API para construir los clientes utilizando el WSDL. Por ejemplo, para PHP se necesita de la biblioteca NuSOAP. Entonces, para lograr el concepto de "lenguaje único XML" es un dolor de cabeza. Y más aún si el cliente es tan simple como JavaScript, manejar XML de SOAP provocaría suicidos masivos... o no usar WebServices.

Además, con SOAP se permite crear un solo servicio y ponerle varios métodos. Esto puede llevar a un mal diseño del servicio ya que podría tener un servicio que haga de todo: por ejemplo, un servicio de manejo de Clientes que permita también manejar Proveedores.

[RESTful](http://es.wikipedia.org/wiki/Representational_State_Transfer) es una propuesta muy interesante de [Roy Fielding](http://es.wikipedia.org/wiki/Roy_Fielding) que permite manejar los servicios web con métodos definidos, manteniendo la simpleza del protocolo como XML, pero que cada servicio sea identificado únicamente con un solo [URI](http://es.wikipedia.org/wiki/Uniform_Resource_Identifier).

En este post veremos cómo crear un Servicio RESTful usando NetBeans, y haremos crecer de poco a poco nuestro ejemplo... desde hacer operaciones sencillas, hasta manejar estructuras complejas.

Cabe destacar que los servicios de las redes sociales como Flickr, Twitter, Facebook, etc son basados en RESTful.

Para este ejemplo usaremos NetBeans 6.9.1, y GlassFish v3.0.1, ya que usaremos las características de [Java EE6](http://www.oracle.com/technetwork/java/javaee/tech/index.html). Con GlassFish v.2 igual funciona, y NetBeans ayuda en ello,

Para comenzar, debemos entender que necesitamos de una clase para manejar un servicio. En esta clase solo pueden haber máximo cuatro métodos públicos que son ejecutados por los cuatro métodos HTTP disponibles para RESTful:

- GET

- POST

- DELETE

- PUT

Los métodos GET y POST son conocidos en los formularios (`<form method="post" />`) ¿Tienen algo que ver? Sí, y lo veremos poco a poco. Cada uno de estos métodos determina la acción que hará el REST sobre nuestra aplicación. No deben haber más de un GET o POST o DELETE o PUT, solo tiene que haber uno de cada método. Cada uno tiene una tarea especifica:

- GET: Para obtener un valor. Puede ser un listado de objetos

- POST: Para guardar un nuevo objeto (instancia de identidada) en la aplicación

- DELETE: Para eliminar un objeto (instancia de identidad)

- PUT: Para actualizar un objeto.

¿Suena a un mantenimiento CRUD? Sí, exacto. Eso es lo que es: los métodos para hacer mantenimiento a una entidad de la aplicación. Entonces, la clase que deberá tener estos métodos es como una clases EJB Facade  de una aplicación Java EE. Por tanto, esta clase se llamará "Recurso", funcionará como un EJB, solo manejará la persistencia de una etndiad, pero será accedido desde la web. ¿Cómo se hace? Bueno, iremos de poco a poco conociendo cómo hacer un mantenimiento complejo usando únicamente RESTful.

## Creando proyecto y configurando REST

Crearemos un proyecto web común y silvestre en NetBeans. Yo crearé uno llamado `SimpleRESTweb`. Este proyecto hará un simple cálculo de factorial. (Aunque a muchos no les guste, comenzaré siempre con una calculadora ya que es el clásico ejemplo de Entrada->Procesamiento->Salida.. lo demás, usando entidades, bases de datos, etc.. es lo mismo, solo que utiliza  más variables)

Luego, crearemos una clase común y silvestre, llamada `FactorialResource`. Tendrá (por ahora) un método llamado `factorial()`

```java
<code>
public class FactorialResource {

    public long factorial(long base) {
        if (base >= 1) {
            return factorial(base - 1) * base;
        }
        return 1;
    }
}

</code>
```

A esta clase se puede crear su TestCase para asegurarnos que funciona correctamente. Notemos que hasta ahora no hemos hecho nada REST. La  diversión comienza aquí:

Agreguemos la notación `@Stateless` al inicio de la clase. Esto convierte automáticamente a nuestra clase en un EJB

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtym6hMbFVVGpjIla2WjUwKmDJs9nA8ujNqthLTFRyn1sw5z6EkayTlZhuu006IMuggroDxYJr9dVbzgbzf32iQQl3QbTuEUwkiWrOXlfsbLYn9NyFhggQ7xnP1JRkpFyjanUdOyeQ8Gw9/s320/rest-01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtym6hMbFVVGpjIla2WjUwKmDJs9nA8ujNqthLTFRyn1sw5z6EkayTlZhuu006IMuggroDxYJr9dVbzgbzf32iQQl3QbTuEUwkiWrOXlfsbLYn9NyFhggQ7xnP1JRkpFyjanUdOyeQ8Gw9/s1600/rest-01.jpg)

Luego, seguido al `@Stateless` agregamos la anotación `@Path("/factorial")` Esto indica que este recurso será accedido desde la ruta "/factorial" via web. Ahora, guardemos el archivo... y en ese mismo momento, el NetBeans detectará de que se ha creado un recurso REST, entonces pedirá activar esta característica en la aplicación... por tanto pedirá dónde estará activado todos los recursos REST.

[](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimO6rQHGaktnQlCv0hKs8egYawu6MJmwgmvamEapzrstYLyUwSPQxtRmgzuwk7UpteuZb1mqA25PR_2VWMwUloA57IYgAnxHTHpigVm_0y3HKZCbQJ5-8rSF23gt3Vu3sFg5P866cuJF-c/s1600/rest-03.jpg)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgEm33G0HVNn3pRQEtASTMuvDo2yMD5Co1dHFre0JUYOU2pmewG6DHrJCRFg8aG0sUDWzaHjm2XF140P4UrS7VlLvR2qeaH3W9Rw4qp83qXy68Zjz4Hn-u1e-mVswY2FEqB2AjaRzsROufp/s400/rest-02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgEm33G0HVNn3pRQEtASTMuvDo2yMD5Co1dHFre0JUYOU2pmewG6DHrJCRFg8aG0sUDWzaHjm2XF140P4UrS7VlLvR2qeaH3W9Rw4qp83qXy68Zjz4Hn-u1e-mVswY2FEqB2AjaRzsROufp/s1600/rest-02.jpg)

Utilizaremos el dado por defecto (`/resources`). Clic en Ok.

**Nota de actualización:** Para NetBeans 7.3, la opción de crear el recurso REST cambia. Mirar aquí [RESTful con NetBeans 7.3](/2013/04/restful-con-netbeans-73.html)

***Nota: En GlassFish v2 (Java EE 5) solo existirán dos opciones***

Y con esto, nuestra clase ya es un recurso REST.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimO6rQHGaktnQlCv0hKs8egYawu6MJmwgmvamEapzrstYLyUwSPQxtRmgzuwk7UpteuZb1mqA25PR_2VWMwUloA57IYgAnxHTHpigVm_0y3HKZCbQJ5-8rSF23gt3Vu3sFg5P866cuJF-c/s320/rest-03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimO6rQHGaktnQlCv0hKs8egYawu6MJmwgmvamEapzrstYLyUwSPQxtRmgzuwk7UpteuZb1mqA25PR_2VWMwUloA57IYgAnxHTHpigVm_0y3HKZCbQJ5-8rSF23gt3Vu3sFg5P866cuJF-c/s1600/rest-03.jpg)

Pero aún este recurso no tiene métodos. Ahora veremos cómo convertir nuestro método convencional en un método REST.

## Creando un método REST

Recordemos que solo podemos crear un método de tipo GET,POST,PUT y DELETE. Y como el método `factorial` nos deberá devolver un solo valor según el parámetro que le especificamos, usaremos el tipo GET.

Para ello agregamos la anotación `@GET` antes del método.

Y con esto, nuestro recurso ya tiene un método.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj25NVe_VoLFqVrKtAI7-WB4OwBD9bdFg6rgz-oYoCJew1hcNu_k4xua4K0KfYqk7wGYvqlQXTR6bozAhcCCjEWeCVFXLupmvgrVX72-gkk2ORlO_1coDFvajLx14aVG1NIrpkzflEtHlHn/s320/rest-04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj25NVe_VoLFqVrKtAI7-WB4OwBD9bdFg6rgz-oYoCJew1hcNu_k4xua4K0KfYqk7wGYvqlQXTR6bozAhcCCjEWeCVFXLupmvgrVX72-gkk2ORlO_1coDFvajLx14aVG1NIrpkzflEtHlHn/s1600/rest-04.jpg)

Antes de continuar, los valores que se reciben desde el recurso REST deben ser objetos. Por tanto, nuestro método debe cambiar un poco para que no devuelva un `long`, sino un `java.lang.String`.

Además, debemos indicar que el parámetro `base` del método Java `factorial` será recibido via URL con el nombre `base`. Es decir, se llamará al URL así

`..../factorial?base=5`

Para ello usaremos la notación `@QueryParam` antes de la declaración del parámetro y ponemos el nombre de la cadena query.

```java
<code>
@Stateless
@Path("/factorial")
public class FactorialResource {

    @GET
    public String factorial(@QueryParam("base") long base) {

        return Long.toString($factorial(base));
    }

    long $factorial(long base) {
        if (base >= 1) {
            return $factorial(base - 1) * base;
        }
        return 1;
    }
}

</code>
```

El nombre del parámetro de la cadena query podría ser diferente al del método java.

```java
<code>
//....
    @GET
    public String factorial(@QueryParam("numero") long base) {
//....

</code>
```

Pero si se hace eso, se debería recordar que para accederlo via URL debe ser con ese mismo nombre

`..../factorial?numero=5`

Pero para evitar problemas, usaremos el mismo nombre. Y en caso de ser necesario, podemos cambiar el nombre. Eso ya queda a criterio del diseñador de la aplicación.

## Probando la aplicación

Pues bien, ahora guardemos el proyecto, hagamos clic derecho sobre el ícono de proyecto y seleccionamos "Deploy". Esperamos a que se compile el proyecto, se ejecute el GlassFish y se despliegue.

Aquí propondré tres maneras de probar el recurso REST. El primero es el más fácil, usando el URL. Bastará con abrir nuestro navegador y escribir el URL del proyecto:

`http://localhost:8080/SimpleRESTweb/resources/factorial?base=10`

Este URL está compuesto de lo siguiente:

- SimpleRESTweb: El contexto de la aplicación. Que generalmente es el nombre del proyecto.

- resources: Ubicación de los recursos REST de la aplicación. Este nombre nos lo pidió el NetBeans cuando guardamos la clase Java por primera vez con la notación `@Path` ya que detectó que tenía recursos REST. Si se desea cambiar esta ruta, hagamos clic derecho en el nodo "RESTful Web Services" del proyecto y seleccionando "REST Resources Configuration"

- factorial: Es el nombre de nuestro recurso (Definido por la anotación `@Path`)

- base: Es el parámetro del recurso. Justamente es una cadena Query.

El resultado debe mostrarse tan simple como una web sin formato ni nada

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjb83jPEMxqRyAKgB5smrtW1ti3DV1wHfjjcyFf0AgBYHT-_FzjyOYrm4xwzmZJCzf44h9ZTwclazX60Rt4Y8Hu0nID9SLkvTaUS8r-BmbDcTUDrKKq4RQ-8WcGgC-71CUrHKLz_-LxQWVW/s640/rest-05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjb83jPEMxqRyAKgB5smrtW1ti3DV1wHfjjcyFf0AgBYHT-_FzjyOYrm4xwzmZJCzf44h9ZTwclazX60Rt4Y8Hu0nID9SLkvTaUS8r-BmbDcTUDrKKq4RQ-8WcGgC-71CUrHKLz_-LxQWVW/s1600/rest-05.jpg)

Y ese es el resultado. Quizás me digan "hey, pero esto también lo puedo hacer con un servlet". Pues sí, pero no es lo mismo, ya que el Servlet puede guardar variables de sesión, y aquí en REST no... en Servlet se puede formatear en un HTML, pero aquí en REST no, porque lo que debe devolver es solo dato.

La segunda manera que muestro cómo probar este recurso REST es usando un formulario HTML. Escribamos lo siguiente en el `index.jsp`

```java
<code>
 <body>
        <h1>Calculando factorial</h1>
        <form action="resources/factorial">
            Base: <input name="base" type="text" />
            <button>Calcular</button>
        </form>
    </body>

</code>
```

El resultado saldrá en otra página.

Y la tercera forma (que es la más profesional) es usando el NetBeans.

Hacemos clic derecho sobre el ícono del proyecto y seleccionamos "Test RESTful WebService".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4MMHMdngYe7Og-hu45KbfMEhhKnI1h4G26PkDvFal3eZtIf7_qcMcZx0xp221tKwON_jIE7kxLn2nUcUWMsPrwP9dalISCk5nzxERniI4K5NjxtT4C2tAqPGeUh_ECEfHFQDmlfq-4AUV/s320/rest-06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4MMHMdngYe7Og-hu45KbfMEhhKnI1h4G26PkDvFal3eZtIf7_qcMcZx0xp221tKwON_jIE7kxLn2nUcUWMsPrwP9dalISCk5nzxERniI4K5NjxtT4C2tAqPGeUh_ECEfHFQDmlfq-4AUV/s1600/rest-06.jpg)

Con esto, el IDE creará una página local que accederá al WADL de la aplicación y se mostrará en el navegador web.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3RPUWA39sK072L4k6T-d6YxZL-2MqbUF278epa2jPIhgkaWzKuZdkAIxXZdY0AHeAPj1wQrNWSvYchL43ICZi8rJw2Bq3ViymOQQlzEbOvfwNmXgQFQnoz3yPnvbi8BllCwiFXPg4t_EV/s640/rest-07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3RPUWA39sK072L4k6T-d6YxZL-2MqbUF278epa2jPIhgkaWzKuZdkAIxXZdY0AHeAPj1wQrNWSvYchL43ICZi8rJw2Bq3ViymOQQlzEbOvfwNmXgQFQnoz3yPnvbi8BllCwiFXPg4t_EV/s1600/rest-07.jpg)

El [WADL](http://en.wikipedia.org/wiki/Web_Application_Description_Language) es análogo al WSDL de SOAP

Luego, podemos seleccionar del panel izquierdo el recurso que está disponible (en este caso "factorial")...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpYvUhKzP2gjqK4Fm-l-KMbJM4zw6vSsRch6INAbKQkLDZkYnCTqdfTiYioK0zMYZBFvBJuDw-r2Y_IKqiOwpaUI98rlqUjfdjOugSOdic1MTL4ygYlMpoMc8FAyDziefiJZ8MTuBxliTp/s640/rest-08.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpYvUhKzP2gjqK4Fm-l-KMbJM4zw6vSsRch6INAbKQkLDZkYnCTqdfTiYioK0zMYZBFvBJuDw-r2Y_IKqiOwpaUI98rlqUjfdjOugSOdic1MTL4ygYlMpoMc8FAyDziefiJZ8MTuBxliTp/s1600/rest-08.jpg)

... y vemos que nos muestra cuales son los parámetros (solo **base**) que están disponibles para este recurso. Probamos escribiendo valores en el parámetro, y hacemos clic en "Test".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgXEXgRbYlgpVOaAt5r2OhCeG1r92cBDdrvBBtI2zITRiqlPhbVxINGmx88OuvRTV8yy9qqP6eRTHbVFYo12v0l6lqDQVYAlXWqN604pciJ4r1E2F5-O3EwuD2MwEdmitYA-ZFjvE3VZetP/s640/rest-09.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgXEXgRbYlgpVOaAt5r2OhCeG1r92cBDdrvBBtI2zITRiqlPhbVxINGmx88OuvRTV8yy9qqP6eRTHbVFYo12v0l6lqDQVYAlXWqN604pciJ4r1E2F5-O3EwuD2MwEdmitYA-ZFjvE3VZetP/s1600/rest-09.jpg)

## Consumiendo REST

Todo servicio web no es útil si no se sabe cómo consumir. En este post mostraremos cómo consumir este simple REST. En los siguientes post realizaremos recursos que utilizan objetos complejos.

### Usando JavaScript

Para consumir desde JavaScript, se debería utilizar la técnica AJAX. Y en vez de hacer toda la biblioteca de consumir AJAX con JavaScript, mejor usamos algo ya hecho... como el jQuery.

Crearemos una página html al que llamaremos test-jquery.html. Y ahí pondremos lo siguiente.

```java
<code>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js">
        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h2>Calcular factorial</h2>
        Número:<input type="text" name="base" id="base"/>
        <button type="button" id="calcularBtn">Calcular</button>
        <div id="resultado">
            Resultado: <span></span>
        </div>
        <script type="text/javascript">
            jQuery("#calcularBtn").click(function(){
                var base = jQuery("#base").val();
                jQuery.get("http://localhost:8080/SimpleRESTweb/resources/factorial",{
                    base:base
                },function(resultado){
                    jQuery("#resultado span").text(resultado)
                })
            })
        </script>
    </body>
</html>

</code>
```

Esta HTML funciona desde Firefox cuando se ejecuta desde el NetBeans,

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjAM0ojoD46T3FwP4yGeiTAbCehFXnmjLqNSeKqJ0pgKe0Ws48w6jjXt6Dwv6lVquC7AcSC4z16ivdw-lRFTjai9M5Av1HMZXERiDbChUCfuECxLBQydlM8vOVLUJwTUEqdxcRVQ6ovXsm0/s640/rest-10.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjAM0ojoD46T3FwP4yGeiTAbCehFXnmjLqNSeKqJ0pgKe0Ws48w6jjXt6Dwv6lVquC7AcSC4z16ivdw-lRFTjai9M5Av1HMZXERiDbChUCfuECxLBQydlM8vOVLUJwTUEqdxcRVQ6ovXsm0/s1600/rest-10.jpg)

y funciona en IExplorer si se ejecuta localmente (o sea, abriéndolo desde el explorador de archivos y activar el filtro de ActiveX que advierte el IE).

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEid_j-XaLNh1NtJyMyix1pu5RtX7hfCukE4nP8_sYoiEfafE_APPh-kOfM6IHW-FPh93KoiGAqBHgKTf88yoYNoNljRJJBqFYBGfdNQKtzGi2X2ltETHYkkljV07WykIcnml9zELtOh3AoO/s640/rest-11.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEid_j-XaLNh1NtJyMyix1pu5RtX7hfCukE4nP8_sYoiEfafE_APPh-kOfM6IHW-FPh93KoiGAqBHgKTf88yoYNoNljRJJBqFYBGfdNQKtzGi2X2ltETHYkkljV07WykIcnml9zELtOh3AoO/s1600/rest-11.jpg)

### Usando Java

Con NetBeans más el complemento Jersey, se nos hace muy fácil consumir servicios REST. Para integrarlo con el IDE, necesitamos registrar el WADL. Esta URL lo podemos obtener así: http://host:puerto/contexto-web/resources/application.wadl

Para nuestro ejemplo, este es

[http://localhost:8080/SimpleRESTweb/resources/application.wadl](http://localhost:8080/SimpleRESTweb/resources/application.wadl)

Podemos abrirlo desde el navegador y se nos mostrará un XML que contiene la definición de los recursos (`/factorial`) y los parámetros de cada método. En este caso hay un método GET y tiene como parámetro un long.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjoM15VDv43nz6xzUs-uPfUL2__YOg57AZ_45gjY_bwBGnLhSjCEfJezq_L3VhDTPf1HthFBXvFvsarznrS3mf8ID-sf9DD_LhGsBwI3dTKNj0Pku2hE9vBnzprOy-wI0mh2BwkWTSt6Lcj/s640/rest-12.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjoM15VDv43nz6xzUs-uPfUL2__YOg57AZ_45gjY_bwBGnLhSjCEfJezq_L3VhDTPf1HthFBXvFvsarznrS3mf8ID-sf9DD_LhGsBwI3dTKNj0Pku2hE9vBnzprOy-wI0mh2BwkWTSt6Lcj/s1600/rest-12.jpg)

Ahora bien, este URL del WADL lo vamos a necesitar para registrarlo en el NetBeans. En el IDE vayamos al panel de servicios (Ctrl+5) y hacemos clic derecho sobre el nodo "Web Services" y seleccionamos "Add Web Service..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAFriPSmWcwewo2GJRENu6_Xq8N7xPy0sNL2fpffz6evwSG_Hbj16U0hIEJEIQ_0DRtOa10d0Ljs8J468EMtPq5vAt9IeNh4qP31jV1CDqYu4_wDZbq3u9aSoYbJMSyHbpmjaA8iA55lOl/s400/rest-13.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAFriPSmWcwewo2GJRENu6_Xq8N7xPy0sNL2fpffz6evwSG_Hbj16U0hIEJEIQ_0DRtOa10d0Ljs8J468EMtPq5vAt9IeNh4qP31jV1CDqYu4_wDZbq3u9aSoYbJMSyHbpmjaA8iA55lOl/s1600/rest-13.jpg)

Luego, en la entrada de URL, pegamos la dirección del WADL. Y como nombre de paquete ponemos `simplerest`.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyPLizfb_Dm8YlfzjS4Odoe5hRTsqCVW0-zLxxLDZ4JS1Us3xnD13YfjINFhnrvoDMc01lKp-JQ2Fnt3t_q3ENO8CKBWfQzIcshBkF3kmeORnlfEYsejEsVMq1GBhyQ3xGdzidSXv_nZT4/s640/rest-14.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyPLizfb_Dm8YlfzjS4Odoe5hRTsqCVW0-zLxxLDZ4JS1Us3xnD13YfjINFhnrvoDMc01lKp-JQ2Fnt3t_q3ENO8CKBWfQzIcshBkF3kmeORnlfEYsejEsVMq1GBhyQ3xGdzidSXv_nZT4/s1600/rest-14.jpg)

Y listo, ya tendremos registrado el WebService en nuestro IDE.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiLwYu_1J60EFv_9y_5Xn84sv4-MdSB5W0eyWfGR1hjncI-4s2V4p7H2bLphkpr8CEzg8jReSjSDAwT73vE7pZhnEbvMJ5FatR4rpeZVgF2gQ9wE_FSaldWbDho7O6E32f7lORQDAAiCJek/s320/rest-15.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiLwYu_1J60EFv_9y_5Xn84sv4-MdSB5W0eyWfGR1hjncI-4s2V4p7H2bLphkpr8CEzg8jReSjSDAwT73vE7pZhnEbvMJ5FatR4rpeZVgF2gQ9wE_FSaldWbDho7O6E32f7lORQDAAiCJek/s1600/rest-15.jpg)

Esto nos permitirá utilizar este servicio en cualquiera de nuestras aplicaciones. Por ejemplo, ahora, en Java.

Hagamos un nuevo proyecto llamado `SimpleRESTClientJavaApp`.

Ahora, crearemos un nuevo archivo (Ctrl+N) y seleccionamos la categoría "Web Services" y el tipo de archivo "RESTful Java Client"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjgYJNMNS4YEiih-42F-X3RoEJbPwwgmgpn_vF8znG2Pb25JlKGooIzS8Fo2PVQpHXLe5UD015iv0fftckFVvoweHSRCgruGPr1s6cf5ZAN4I_NotsJzRTwJYWoxz-O7m2jCNR4b0J-yhdv/s640/rest-16.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjgYJNMNS4YEiih-42F-X3RoEJbPwwgmgpn_vF8znG2Pb25JlKGooIzS8Fo2PVQpHXLe5UD015iv0fftckFVvoweHSRCgruGPr1s6cf5ZAN4I_NotsJzRTwJYWoxz-O7m2jCNR4b0J-yhdv/s1600/rest-16.jpg)

Luego, en el siguiente paso, pongamos como nombre de la clase `FactorialClient`, dentro de la opción "Select the REST resource" seleccionemos la opción "IDE Registered"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjazfbaKQpyS_zbl55sGr2zgvI0D4diWLlcAGCRB8H1TIiH0afHQ2CRiRKjBCqkOEXql8KXFnGED0oD0iuqJrrxbdR_mnQmfcK1t64BMFIaWisc2VG0UaURYJ2R4vmDB5wa8-SEaIS9kAqt/s640/rest-17.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjazfbaKQpyS_zbl55sGr2zgvI0D4diWLlcAGCRB8H1TIiH0afHQ2CRiRKjBCqkOEXql8KXFnGED0oD0iuqJrrxbdR_mnQmfcK1t64BMFIaWisc2VG0UaURYJ2R4vmDB5wa8-SEaIS9kAqt/s1600/rest-17.jpg)

... y hagamos clic en "Browse" para seleccionar el WebService que acabamos de registrar.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdCNIbWAKmlnn3wFHQFu0uzxp2haYEE5vCCovF61tpGOgVadJGvitqYdoz6mIFHPRlnCb2Buu4fM_i5AUN8Hr8yQLEM0wFX7165jDaTL5wg77gDICibhwCfynrlmp0JBr6NZkmn6jirGcQ/s400/rest-18.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdCNIbWAKmlnn3wFHQFu0uzxp2haYEE5vCCovF61tpGOgVadJGvitqYdoz6mIFHPRlnCb2Buu4fM_i5AUN8Hr8yQLEM0wFX7165jDaTL5wg77gDICibhwCfynrlmp0JBr6NZkmn6jirGcQ/s1600/rest-18.jpg)

y clic en "Finish". Listo, el IDE nos creará la clase `FactorialClient` que contendrá los recursos necesarios para acceder al servicio REST.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7CGYMi5SWhLppF2E8ZmwPN3vCcRYH-OVZISSWbRR2EpWyJRCsQfVNsaofvl2y83Mhs7IdV50xoYvF-0DTCSxxI4t_TNhJj7QluAqhPXNZK2CjQJlweDHDcaE_SRVvJdz8yQunV1RizhhD/s640/rest-19.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7CGYMi5SWhLppF2E8ZmwPN3vCcRYH-OVZISSWbRR2EpWyJRCsQfVNsaofvl2y83Mhs7IdV50xoYvF-0DTCSxxI4t_TNhJj7QluAqhPXNZK2CjQJlweDHDcaE_SRVvJdz8yQunV1RizhhD/s1600/rest-19.jpg)

Ahora, ¿cómo se consume esto?... en nuestra clase Java solo debemos instanciar la clase, pasarle el parámetro y recibir el valor. Fácil

```java
<code>
        FactorialClient client = new FactorialClient();
        long base = 15;
        String resultado = client.factorial(String.class, String.valueOf(base));
        System.out.println("Resultado: " + resultado);

</code>
```

## Código fuente

El ejemplo del servidor REST se encuentra aquí

[http://kenai.com/projects/apuntes/downloads/download/Simple%2520RESTful%252FSimpleRESTweb.tar.gz](http://kenai.com/projects/apuntes/downloads/download/Simple%2520RESTful%252FSimpleRESTweb.tar.gz)

y el ejemplo de cliente REST en Java se puede descargar de aquí

[http://kenai.com/projects/apuntes/downloads/download/Simple%2520RESTful%252FSimpleRESTClientJavaApp.tar.gz](http://kenai.com/projects/apuntes/downloads/download/Simple%2520RESTful%252FSimpleRESTClientJavaApp.tar.gz)
