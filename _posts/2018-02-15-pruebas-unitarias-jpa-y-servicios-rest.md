---
layout: post
title: "Pruebas Unitarias a JPA y servicios REST con Arquillian + Payara. (3/4) - Probando el Servicio"
date: 2018-02-15T18:28:00.005Z
last_modified_at: 2018-02-15T18:49:59.388Z
author: "Diego Silva Límaco"
permalink: /2018/02/pruebas-unitarias-jpa-y-servicios-rest.html
canonical_url: https://www.apuntesdejava.com/2018/02/pruebas-unitarias-jpa-y-servicios-rest.html
description: "Ya tenemos la persistencia (JPA), ya tenemos la lógica de negocio (EJB) y con sus respectivas pruebas, ahora nos falta la parte principal del microservicio: el servicio.    Así que haremos un par de servicios y sus respectivas pruebas con Arquillian."
tags:
  - "junit"
  - "restful"
  - "jersey"
  - "java ee"
  - "arquillian"
---

[![](/assets/blogger/12-testing-hammering-nails.png)](/assets/blogger/12-testing-hammering-nails.png)

Ya tenemos la persistencia (JPA), ya tenemos la lógica de negocio (EJB) y con sus respectivas pruebas, ahora nos falta la parte principal del microservicio: el servicio.

Así que haremos un par de servicios y sus respectivas pruebas con Arquillian.

Hasta el momento hemos hecho las pruebas usando las notación `@Inject` como si estuviéramos en un entorno Java EE. Ahora, los servicios son probados como una llamada a un servidor web. Entonces, las llamadas se harán por HTTP.

## Creando los servicios

Comenzaremos por crear la clase `ProductREST.java`, será el servicio para buscar productos, y este es el código.

```java
@Path("product")
@Produces(MediaType.APPLICATION_JSON)
@Singleton
public class ProductREST {

    @Inject
    private ProductFacade facade; //instanciamos el EJB

    @GET
    public List<Product> findByName(
            @QueryParam("name") @DefaultValue("") String name
    ) {
        return facade.findByName(name); //solo llamamos al método del EJB
    }
}
```

Bastante fácil y simple. Solo le pasamos el nombre del producto (o parte del nombre); y si no le pasa un texto en el parámetro, tomará el valor `""` para evitar el valor nulo. Notemos el valor que está respondiendo: una lista de `Product`.

Ahora crearemos otro servicio que realizará la venta del producto. Este tendrá un método de tipo `POST` que recibirá los parámetros de algún formulario. La clase a crear se llamará `SellREST.java`, y este es su código:

```java
@Path("sell")
@Produces(MediaType.APPLICATION_JSON)
@Singleton
public class SellREST {

    @Inject
    private ProductFacade productFacade;

    @POST
    @Produces(MediaType.TEXT_PLAIN)

    public Response sell(
            @FormParam("productId") long productId,
            @FormParam("quantity") int quantity
    ) {
        try {
            double mount = productFacade.sell(productId, quantity);
            return Response.ok(mount).build();
        } catch (NoProductException ex) {
            return Response.status(Response.Status.NOT_FOUND).build();
        } catch (OutStockException ex) {
            return Response.status(Response.Status.BAD_REQUEST).build();
        }
    }
}
```

Hay varias maneras de devolver los errores al cliente: por códigos de error HTTP, o por un json con un campo que dice "error" indicando el error. Todo depende cómo lo acuerden en el diseño. En este ejemplo estoy usando los códigos de error HTTP: si no se encuentra el producto, entonces lanza el error `404`, y si se excede del stock lanzará el error `400`. En caso que esté todo bien, debería devolver el monto de la venta del producto.

Ya casi vamos a terminar, solo nos falta la clase que configura los servicios en el entorno. Esta clase se llamará `ApplicationConfig` y este es su código:

```java
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(com.apuntesdejava.arquillian.rest.ProductREST.class);
        resources.add(com.apuntesdejava.arquillian.rest.SellREST.class);
    }

}
```

En un entorno real de Java EE no necesita más que las anotaciones para declarar qué clase es la encargada de configurar el entorno REST. cof cof, spring aún necesita de xml, cof cof.

Y listo, ya tenemos los servicios, ahora vamos a probarlos.

## Configurando las pruebas para REST

Básicamente, la configuración es la misma que en el post anterior. Solo que, vamos a necesitar el URL donde está desplegado el war en nuestro entorno de prueba. Crearemos la clase `RESTTest` y esta es la primera parte del código:

```java
@RunWith(Arquillian.class)
public class RESTTest {

    private static final Logger LOGGER = LoggerFactory.getLogger(RESTTest.class);

    @ArquillianResource
    private URL deploymentURL; //el URL donde se desplegó el war

    @Deployment
    public static WebArchive createDeployment() {
        return ShrinkWrap.create(WebArchive.class, "payara-arquillian-rest.war")
                .addAsResource("test-persistence.xml", "META-INF/persistence.xml")
                .addClasses(ProductREST.class,
                        SellREST.class,
                        ProductFacade.class,
                        SellFacade.class,
                        ApplicationConfig.class,
                        Product.class,
                        Sell.class);
    }
//...
```

Notemos que en la línea 45 Arquillian injectará el valor del URL donde estará desplegado el war. Las líneas 51 y 52 son las clases REST que incluiremos en el entorno para  el despliegue y así hagamos las pruebas.

### Probado el servicio GET

Necesitamos crear un cliente HTTP y que procese las peticiones como JSON, por ello crearemos el siguiente método:

```java
private static Client createClient() {
        return ClientBuilder
                .newBuilder()
                .register(JacksonJaxbJsonProvider.class) //para procesar las peticiones como JSON
                .build();
    }
```

Ahora sí, crearemos nuestra prueba al método de buscar productos:

```java
@Test
    @UsingDataSet("datasets/products.yml")
    public void testFindProduct() throws URISyntaxException {
        Client client = createClient(); //creamos el cliente
        WebTarget target = client.target(deploymentURL.toURI()) //registramos el servidor...
                .path("webresources/product") //.. el path del servicio...
                .queryParam("name", "DE"); //... y los parámetros
        LOGGER.info("--- test find product:{}", target.getUri());
        Response response = target.request(MediaType.APPLICATION_JSON).get(); //invocamos al servicio por GET
        if (response.getStatus() != HttpStatus.OK_200.getStatusCode()) { //si no es correcto..
            fail("Error :" + response.getStatusInfo().getReasonPhrase()); //.. lanza el error y termina
        }
        //si todo está bien, tratamos de leer el contenido como la lista de Productos esperado
        List<Product> data = response.readEntity(new GenericType<List<Product>>() {
        });
        Assert.assertFalse(data.isEmpty()); //.. no debería estar vacía la lista.
        data.forEach((p) -> {
            LOGGER.info("\tproduct:{}", p.getName()); //mostramos el contenido.
        });

    }
```

Notemos lo siguiente:

- Línea 63: usaremos la misma data de prueba para buscar los productos.

- Línea 66 al 68, crearemos la llamada al URL del servidor preparado en el entorno, y le pasaremos los parámetros. Podríamos haberlo hecho escribiendo los parámetros como un URL que conocemos, así: `/webresources/product/?name=DE`, pero se ve más elegante utilizando los métodos de esa clase.

- Línea 70:
  es la llamada en sí al servicio. Línea 71: posiblemente haya un error, así que mejor lo atrapamos y mostramos el error.

- Línea 75: convertimos el resultado de JSON a una lista de Productos que sí podemos entender.

- Línea 77: suponemos que no esté vacía.

- Línea 78: Mostramos el contenido.

Al ejecutar la prueba, este es el resultado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpl1zD8VgViUl-Qg5fvLjLPG5L2Cnj9jKR2hs-oMsSJHBn0qqQkMY9-8BeLumLsl45yM3pxZmxptuwgkLI1goOVeZF89rGbex9MaU1FgYuFsTK7OqDPIRDoMTiV1AGvbDRF2z4C7DkK84/s1600/arquillian+-test+find+product.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpl1zD8VgViUl-Qg5fvLjLPG5L2Cnj9jKR2hs-oMsSJHBn0qqQkMY9-8BeLumLsl45yM3pxZmxptuwgkLI1goOVeZF89rGbex9MaU1FgYuFsTK7OqDPIRDoMTiV1AGvbDRF2z4C7DkK84/s1600/arquillian+-test+find+product.png)

### Probando el servicio POST

Ahora, haremos la prueba del método de venta de producto. Recordemos lo siguiente: es de tipo POST, recibe dos parámetros,si está todo bien devuelve un código de error 200 y el monto de la venta, pero si no existe el producto o sobrepasa el stock, recibiremos otros códigos de errores.

Aquí vamos, este es el método:

```java
@Test
    @UsingDataSet("datasets/products.yml")
    @ShouldMatchDataSet("datasets/after_sales_web.yml")
    public void testSell() throws URISyntaxException {
        Client client = createClient();
        WebTarget target = client.target(deploymentURL.toURI()) //registramos el servidor...
                .path("webresources/sell"); //... y el path del servicio
        LOGGER.info("--- test sell product:{}", target.getUri());

        Form form = new Form() //preparamos  el formulario para el POST
                .param("productId", "2")
                .param("quantity", "2");

        Response response = target.request(MediaType.TEXT_PLAIN)
                .post(Entity.form(form)); //invocamos al servicio

        //procesamos el resultado de la invocacion
        switch (Response.Status.fromStatusCode(response.getStatus())) {
            case OK: //si esta ok (200)
                Double mount = response.readEntity(Double.class); //leemos el valor..
                LOGGER.info("Monto de venta:{}", mount); //.. y lo mostramos.
                break;
            case NOT_FOUND: //si es 404...
                LOGGER.error("El producto no fue encontrado"); //.. no está el producto
                break;
            case BAD_REQUEST: //si es 400..
                LOGGER.error("El stock no alcanza"); //... está fuera de stock
                break;
            default:
                //en cualquier otro caso, mostrar el error
                fail("Error :" + response.getStatusInfo().getReasonPhrase());
        }
    }
```

- En la línea 85 se indica que se utilizará la misma data para las pruebas

- La línea 86 indica cómo quedará la data después de la venta. Como son otros valores que se están probando, tendrá otro resultado, por eso se ha creado un archivo diferente de resultados.

- Cómo los parámetros de tipo POST son diferentes que los GET (el primero es por formulario y el segundo por query), en la línea 93 se configura cómo se enviarán los parámetros al servicio.

- La línea 101 procesa la respuesta de la petición utilizando el código HTTP recibido.

- Lo demás está claro de entender.

El contenido del archivo `after_sales_web.yml` es como sigue:

```java
PRODUCT:
- PRODUCT_ID: 1
  PRODUCT_NAME: MESAS
  PRODUCT_PRICE: 150
  PRODUCT_ENABLED: TRUE
  PRODUCT_STOCK: 20
- PRODUCT_ID: 2
  PRODUCT_NAME: JUEGO DE SOFA
  PRODUCT_PRICE: 500
  PRODUCT_ENABLED: TRUE
  PRODUCT_STOCK: 3
- PRODUCT_ID: 3
  PRODUCT_NAME: SILLA DE PLAYA
  PRODUCT_PRICE: 20
  PRODUCT_ENABLED: TRUE
  PRODUCT_STOCK: 100
- PRODUCT_ID: 4
  PRODUCT_NAME: BAUL
  PRODUCT_PRICE: 150
  PRODUCT_ENABLED: FALSE
  PRODUCT_STOCK: 0
SELL:
- MOUNT: 1000
  QUANTITY: 2
  product_id: 2
```

Al ejecutar la prueba, este es el resultado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-koxegiPiFjjxmxEbIzcIk2IOYwe34fjyCvbB-H10laV3rEOc70o0BtEj6s7yUxV3HnbXEF5qp7ZuAvJpjO9mdad_6j2L1Ovk-6fQcp-XTQh2Bhg43LF-aZEekKexaUx48rpTj2e2Fng/s1600/arquillian+-test+sell+product.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-koxegiPiFjjxmxEbIzcIk2IOYwe34fjyCvbB-H10laV3rEOc70o0BtEj6s7yUxV3HnbXEF5qp7ZuAvJpjO9mdad_6j2L1Ovk-6fQcp-XTQh2Bhg43LF-aZEekKexaUx48rpTj2e2Fng/s1600/arquillian+-test+sell+product.png)

Notar cómo se ejecutan las instrucciones SQL al realizar la venta.

## Recursos

Como es costumbre en este post, aquí está disponible el código fuente del proyecto hasta este post:

[https://bitbucket.org/apuntesdejava/payara-arquillian/src/](https://bitbucket.org/apuntesdejava/payara-arquillian/src/)

## Redes sociales

### Twitter

>

Seguimos con las pruebas funcionales con [@arquillian_org](https://twitter.com/arquillian_org?ref_src=twsrc%5Etfw) Ahora crearemos y probaremos servicios [#REST](https://twitter.com/hashtag/REST?src=hash&ref_src=twsrc%5Etfw). Así tendremos nuestro microservicio para [@Payara_Fish](https://twitter.com/Payara_Fish?ref_src=twsrc%5Etfw) [https://t.co/I6p2PPfKLZ](https://t.co/I6p2PPfKLZ) [#JPA](https://twitter.com/hashtag/JPA?src=hash&ref_src=twsrc%5Etfw) [#EJB](https://twitter.com/hashtag/EJB?src=hash&ref_src=twsrc%5Etfw) [#Payara](https://twitter.com/hashtag/Payara?src=hash&ref_src=twsrc%5Etfw) [#GlassFish](https://twitter.com/hashtag/GlassFish?src=hash&ref_src=twsrc%5Etfw) [#Arquillian](https://twitter.com/hashtag/Arquillian?src=hash&ref_src=twsrc%5Etfw) Si te gusta dale like, si te es útil comparte.

&mdash; Apuntes de Java (@apuntesdejava) [15 de febrero de 2018](https://twitter.com/apuntesdejava/status/964207489045626881?ref_src=twsrc%5Etfw)

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Facebook

<iframe src="https://web.facebook.com/plugins/post.php?href=https%3A%2F%2Fweb.facebook.com%2FApuntesDeJava%2Fposts%2F1797812643563359&width=500" width="500" height="540" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
