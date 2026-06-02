---
layout: post
title: "Pruebas Unitarias a JPA y servicios REST con Arquillian + Payara. (2/4)"
date: 2018-01-10T21:27:00.002Z
last_modified_at: 2018-01-11T21:56:35.547Z
author: "Diego Silva Límaco"
permalink: /2018/01/pruebas-unitarias-jpa-y-servicios-rest_10.html
canonical_url: https://www.apuntesdejava.com/2018/01/pruebas-unitarias-jpa-y-servicios-rest_10.html
description: "Continuamos nuestra serie. Ahora veremos cómo preparar el entorno para JPA + EJB"
tags:
  - "junit"
  - "restful"
  - "microservicios"
  - "tdd"
  - "java ee"
  - "jpa"
  - "ejb"
  - "arquillian"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vRPE7dvHXE09HK9LbVRdCNMeYs15eG0ELSSCDuHyfDJKQdi1uoZERiOx-_lxv-fPVe5mjuP6LYUQrBP/pub?w=1200&h=627)](https://docs.google.com/drawings/d/e/2PACX-1vRPE7dvHXE09HK9LbVRdCNMeYs15eG0ELSSCDuHyfDJKQdi1uoZERiOx-_lxv-fPVe5mjuP6LYUQrBP/pub?w=1200&h=627)

Continuaremos con nuestro proyecto de prueba. Ahora lo configuraremos para que permita probar EJB que tendrán la lógica de negocio, y utilizando JPA como motor de persistencia.

Vamos a seguir el diseño TDD ([Test-Driven Development](https://es.wikipedia.org/wiki/Desarrollo_guiado_por_pruebas)) que consiste en hacer el desarrollo según las pruebas solicitadas, no al revés. Esto nos ayudará a mejorar el código continuamente, si vemos que se puede mejorar.

Así que, vamos a describir es lo que tiene que hacer nuestro Microservicio:

- Deberá tener un maestro de Productos que incluye precio, monto, cantidad disponible.

- Permitirá registrar productos con los valores descritos.

- Permitirá realizar una búsqueda de un producto por un nombre.

- Permitirá realizar una venta de un producto seleccionado: descontará la cantidad disponible del producto, y registrará la venta realizada guardando la fecha y el monto de la venta.

Fácil, ¿no?

## Las entidades

Comenzaremos por describir las entidades. Según vemos en el punto 1 y 4 deberían haber dos entidades: `Product` y `Sell`, para representar a los productos y a las ventas.

Yo lo voy a representar así:

### Product.java

```java
@Entity
@Table(name = "product")
public class Product implements Serializable {

    private static final long serialVersionUID = -3902279630339027684L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long productId;

    @Column(name = "product_name", length = 50)
    private String name;

    @Column(name = "product_stock")
    private int stock;

    @Column(name = "product_enabled")
    private boolean enabled;

    @Column(name = "product_price")
    private double price;

    public Product() {

    }

    public Product(String name, int stock, double price) {
        this.name = name;
        this.stock = stock;
        this.price = price;
        this.enabled = true;
    }
//... hay métodos set y get, además de equals, hashCode y toString
```

Para este ejemplo lo estoy describiendo con esos campos. Ya estamos viendo que serán entidades de JPA. Es bueno y ordenado describir el nombre de cada campo que tomará en la base de datos, así como la tabla.

Ahora describiremos la otra entidad, que registrará todas las ventas. Esta estará asociada a la entidad `Product`

### Sell.java

```java
@Entity
@Table(name = "sell")
public class Sell implements Serializable {

    private static final long serialVersionUID = -1876442557341652305L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sell_id")
    private Long sellId;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    private int quantity;

    private double mount;

    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date saleDate;
//.. métodos set y get
```

Ahora, necesitamos crear los EJB (solo la clase y parte del contenido) que serán parte del proyecto:

### SellFacade.java

```java
@Stateless
public class SellFacade {

    private static final Logger LOGGER = LoggerFactory.getLogger(SellFacade.class);

    @PersistenceContext(unitName = "storePU")
    private EntityManager em;
}
```

Como vemos, ya estamos asumiendo que existirá la unidad de persistencia llamada `storePU`.

### ProductFacade.java

```java
@Stateless
public class ProductFacade {

    private static final Logger LOGGER = LoggerFactory.getLogger(ProductFacade.class);

    @PersistenceContext(unitName = "storePU")
    private EntityManager em;

    @Inject
    private SellFacade sellFacade;
}
```

Esta clase, en alguna manera, llamará al otro `EJB`. Al menos es como lo he concebido. La cuestión es que debemos definir estas clases y en alguna manera se tendrán que comunicar. Además, si hay algún cambio, se debería hacer, y los resultados deberían ser los mismos.

## Definiendo las pruebas

Ahora vamos a ver las pruebas. En nuestra clase `ArquillianTest.java` vamos a configurar las clases que participarán de la prueba, además de los recursos que necesitará.

Como vamos a simular un ambiente Java EE, es necesario agregar los recursos que faltan, en este caso, el archivo `persistence.xml`. En un momento veremos el contenido. Por ahora vamos a ver cómo modificar nuestra clase.

### ArquillianTest.java

```java
@RunWith(Arquillian.class)
public class ArquillianTest {

    private static final Logger LOGGER = LoggerFactory.getLogger(ArquillianTest.class);

    @Inject
    private ProductFacade productFacade;

    @Deployment
    public static WebArchive createDeployment() {
        return ShrinkWrap.create(WebArchive.class, "payara-arquillian.war")
                //agregando recursos en una ubicación
                .addAsResource("test-persistence.xml", "META-INF/persistence.xml")
                //agregando las clases que se cargarán en el entorno
                .addClasses(ProductFacade.class, Product.class,
                        SellFacade.class, Sell.class);
    }
```

Revisemos:

- En la línea 34 y 35 ya estamos declarando e instanciando (con la declaración `@Inject`) el EJB para `ProductFacade`. Esta declaración la vuelve muy Java EE.

- La línea 41 estamos diciendo que tomaremos el archivo `test-persistence.xml` y lo colaremos en el archivo war de despliegue dentro de la ubicación `META-INF/persistence.xml` como recurso, o sea, estará dentro de la carpeta `classes`.

- Las líneas 43 y 44 indican que estas clases serán cargadas y reconocidas en el entorno. Si no lo colocamos esto, cuando se ejecute la prueba no podrá encontrarlas.

### La primera prueba: crear productos

Como primera prueba a realizar, será la de registrar productos. Así que agregaremos estas líneas en la clase `ArquillianTest.java`.

```java
@Test
    public void testInsertProducts() {
        LOGGER.info("-- Registrando productos");
        //insertando registros en la base de datos
        Product p1 = productFacade.create("Keyboard", 100, 20);
        Product p2 = productFacade.create("Mouse", 90, 12);
        Product p3 = productFacade.create("Monitor", 75, 30);

        //averiguando que no sean nulos
        assertNotNull(p1);
        assertNotNull(p2);
        assertNotNull(p3);

        //mostrando en pantalla lo generado
        LOGGER.info("p1:{}", p1);
        LOGGER.info("p2:{}", p2);
        LOGGER.info("p3:{}", p3);
    }
```

Listo, eso debería ser todo. **Pero aún no hemos terminado. Recién vamos por la mitad.**.

Como vemos en las líneas 56 al 58, se está invocando a un método de la clase `ProductFacade` que no existe. Al menos así se debería llamar, pero necesitamos crear el método. Así que nos vamos a la clase en cuestión y agregamos el siguiente método.

### ProductFacade.java

```java
public Product create(String name, int stock, double price) {
        Product p = new Product(name, stock, price);
        em.persist(p);
        return p;
    }
```

Eso sería todo para la prueba: crea un nuevo objeto (línea 32), lo guarda en la base de datos (línea 33) y devuelve el objeto creado después de registrarse en la base de datos (34).

## Configurando el entorno

Ahora bien, necesitamos seguir configurando el entorno actualizando y agregando archivos de configuración.

### pom.xml

Nunca hay que olvidar el logging en nuestra aplicación. Es la mejor manera de que nuestra aplicación se mantenga dando señales de vida al exterior. Ya habíamos puesto el `slf4j-log4j12` a nivel de `test`, pero para producción necesitamos otro. En cualquier caso, es necesario que declaremos el API para que pueda ser flexible de acuerdo a cualquier entorno. Así que agregaremos la siguiente dependencia.

```java
<dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.25</version>
        </dependency>
```

Luego, vamos a necesitar una base de datos. Tranquilos, no vamos a necesitar un MySQL o un Oracle para hacer pruebas. Debe ser un ambiente separado para pruebas. Así que usaremos una base de datos incrustada. Existen Apache Derby, H2, pero mi preferido es HSQLDB. Pueden usar cualquiera, la cosa es que esté disponible. Agreguemos esta dependencia:

```java
<dependency>
            <groupId>org.hsqldb</groupId>
            <artifactId>hsqldb</artifactId>
            <version>2.4.0</version>
            <scope>test</scope>
        </dependency>
```

Ahora, como usaremos un entorno Java EE, la conexión a la base de datos debe estar siempre establecida en el contenedor Java EE. No estoy de acuerdo que esté en la aplicación, ni menos en un archivo de configuración (algún properties) que esté dentro del .war final. Yo sugiero que la conexión a la base de datos sea en el contenedor Java EE, ya que quien se encarga de administrar las conexiones sea el mismo contenedor. Si hay algún cambio, se hace en el mismo contenedor, y así nos evitamos de tener que desplegar la aplicación nuevamente. Así que, considerar las líneas remarcadas a continuación en el archivo `pom.xml`.

```java
<plugin>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.20.1</version>
                <configuration>
                    <systemProperties>
                        <arquillian.launch>glassfish-embedded</arquillian.launch>
                    </systemProperties>
                    <systemPropertyVariables>
                        <glassfish.resources.file>src/test/resources/glassfish-resources.xml</glassfish.resources.file>
                        <java.util.logging.config.file>
                            ${project.build.testOutputDirectory}/logging.properties
                        </java.util.logging.config.file>
                    </systemPropertyVariables>
                </configuration>
            </plugin>
```

Veamos:

- Estas líneas son parte de las variables del sistema para el Payara

- La línea 166 indica qué archivo utilizar para indicar los recursos. Esto es: para la conexión a la base de datos.La línea 168 indica que existirá el archivo `logging.properties` para ahcer seguimiento de la consulta a la base de datos.

El archivo `src/test/resources/logging.properties` tendrá el siguiente contenido:

### logging.properties

```java
handlers=java.util.logging.ConsoleHandler
java.util.logging.ConsoleHandler.formatter=java.util.logging.SimpleFormatter
java.util.logging.SimpleFormatter.format=%4$s: %5$s%n
java.util.logging.ConsoleHandler.level=FINEST
```

### Conexión a la base de datos

Esto ya está teniendo más cuerpo. Ahora necesitamos crear el archivo `src/test/resources/glassfish-resources.xml`. Aquí es donde se crea la conexión a base de datos. Como vamos a usar GlassFish / payara, entonces son dos pasos que se crea: el Pool de conexiones y el Recurso JDBC. Así que este es el contenido del archivo

#### glassfish-resources.xml

```java
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE resources PUBLIC
        "-//GlassFish.org//DTD GlassFish Application Server 3.1
        Resource Definitions//EN"
        "http://glassfish.org/dtds/glassfish-resources_1_5.dtd">
<resources>

    <jdbc-connection-pool name="SamplePool"
                          res-type="java.sql.Driver"
                          driver-classname="org.hsqldb.jdbc.JDBCDriver"  >
        <property name="user" value="sa"/>
        <property name="password" value="sa"/>
        <property name="url" value="jdbc:hsqldb:file:./data/test"/>
    </jdbc-connection-pool>

    <jdbc-resource pool-name="SamplePool"
                   jndi-name="jdbc/sample"/>
</resources>
```

Los nombres, tanto del recurso como del pool, son arbitrarios, ya que todo esto será del ambiente de prueba. Nada de esto pasará al .war final para producción.

Necesitamos definir el archivo `src/test/resources/test-persistence.xml` que es el que define la unidad de persistencia y está asociada al pool de conexiones. Hasta ahora seguimos alineados al estándar JavaEE.

#### test-persistence.xml

```java
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.1" xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence              http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
    <persistence-unit name="storePU" transaction-type="JTA">
        <jta-data-source>jdbc/sample</jta-data-source>
        <exclude-unlisted-classes>false</exclude-unlisted-classes>
        <properties>
            <property name="javax.persistence.schema-generation.database.action" value="drop-and-create"/>
            <property name="eclipselink.ddl-generation" value="drop-and-create-tables"/>
            <property name="eclipselink.logging.level.sql" value="FINE"/>
            <property name="eclipselink.logging.parameters" value="true"/>
        </properties>
    </persistence-unit>
</persistence>
```

Notemos la línea 3. Aquí es el nombre de la unidad de persistencia. Es la misma que se está declarando en los EJB. La línea 4 es el nombre del recurso JDBC que hemos declarado en el archivo `glassfish-resources.xml`

Ahora, nos falta la parte importante: hacer que arquillian cargue el archivo `glassfish-resources.xml` en el GlassFish / Payara.

```java
<?xml version="1.0" encoding="UTF-8"?>
<arquillian xmlns="http://jboss.org/schema/arquillian"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://jboss.org/schema/arquillian
            http://jboss.org/schema/arquillian/arquillian_1_0.xsd">

    <defaultProtocol type="Servlet 3.0"/>
    <container qualifier="glassfish-embedded">
        <configuration>
            <property name="bindHttpPort">7979</property>
            <property name="resourcesXml">
                ${glassfish.resources.file}
            </property>
        </configuration>
    </container>
</arquillian>
```

En las líneas 11 al 13 se está diciendo al glassfish que la propiedad `resourcesXml` utilizará el valor definido en `glassfish.resources.file`, y que estaba definido en el archivo `pom.xml` línea 166.

Finalmente, nuestra estructura de los archivos de recurso para nuestro entorno de prueba, debe lucir así:

[![]({{ '/assets/blogger/arquillian-jpa-resources.png' | relative_url }})]({{ '/assets/blogger/arquillian-jpa-resources.png' | relative_url }})

## Realizando la prueba del registro de Productos

Bueno, bastará con ejecutar el comando:

```java
mvn clean test
```

Analicemos el resultado obtenido en la ventana de comandos.

Primero veremos que se pudo crear los recursos de la conexión a la base de datos. Eso es bueno:

[![]({{ '/assets/blogger/arquillian-run-test-01jdbc.png' | relative_url }})]({{ '/assets/blogger/arquillian-run-test-01jdbc.png' | relative_url }})

Más abajo veremos nuestros mensajes en el Log, y también las llamadas que hace el JPA. Finalmente se ve el resultado de nuestros objetos creados en la base de datos.

[![]({{ '/assets/blogger/arquillian-run-test-01-insert.png' | relative_url }})]({{ '/assets/blogger/arquillian-run-test-01-insert.png' | relative_url }})

Bien, hasta aquí ya hemos registrado unos cuantos objetos, y vemos que funciona correctamente. Ahora nos falta realizar una venta normal. Implicará:

- Buscar un producto

- Indicar la cantidad a vender.

- Registrar la venta.

## Definiendo la prueba de una venta.

Sin rodeos, vamos a definir la lógica de la prueba. Son todos los pasos a seguir durante una venta. Esto lo agregaremos a la clase `ArquillianTest.java`.

### ArquillianTest.java

```java
@Test
    public void testSell() {
        LOGGER.info("-- probando venta de productos");
        List<Product> prods = productFacade.findByName("silla");
        //comprobando que aparezca siquiera uno
        assertFalse("Se esperaba al menos un producto", prods.isEmpty());
        //tomando el primero
        Product prod = prods.get(0);
        LOGGER.info("Producto a vender:{}", prod);
        try {
            //se realiza la venta..
            int cantidadVender = 40;
            double mount = productFacade.sell(prod.getProductId(), cantidadVender);
            LOGGER.info("Cantidad vendida:{} \t monto de venta:{}", cantidadVender, mount);
        } catch (OutStockException ex) {
            fail("Stock insuficiente");
        } catch (NoProductException ex) {
            fail("No se encontró el producto solicitado");
        }
    }
```

He puesto comentarios en cada línea para entender esta lógica:

-  La línea 76 es clara: si no se encontraron registros, salta el test. No necesitamos hacer un `if`

- La línea 83 es la que hace la venta real: del producto seleccionado se le indica la cantidad. Es más,
 después de esta línea se podría hacer una prueba para comprobar que el monto obtenido sea igual a cierto cálculo, pero lo que haremos será algo más automatizado. En un momento lo vemos.

Ahora bien, necesitamos crear el método de búsqueda por nombre de `ProductFacade`. Este es de la siguiente manera:

```java
public List<Product> findByName(String name) {
        LOGGER.debug("buscando por nombre:{}", name);
        String hint = '%' + name.toUpperCase().trim().replaceAll(" ", "%") + '%';
        TypedQuery<Product> query = em.createQuery("select p from Product p where UPPER( p.name ) like :name", Product.class)
                .setParameter("name", hint);
        return query.getResultList();
    }
```

Es un método simple de búsqueda por nombre en la base de datos. Le puse más funciones como `UPPER` en el JPQL y `.toUpperName` en la cadena. Se puede ir ajustando, pero se hace a este nivel, no en el test.

Ahora necesitamos crear el método que realiza la venta. En la misma clase `ProductFacade`, creamos el siguiente método:

```java
public double sell(Long productId, int quantity) throws OutStockException, NoProductException {
        //busca un producto
        Product prod = em.find(Product.class, productId);

        if (prod == null) { //si no encontró...
            throw new NoProductException(); //... lanza la excepcion
        }
        prod.setStock(prod.getStock() - quantity); //descuenta el stock
        if (prod.getStock() < 0) { // si llega al negativo...
            throw new OutStockException(); //... lanza la exception
        }
        em.merge(prod); //actualiza la base de datos
        //registra la venta
        Sell sell = sellFacade.saveSell(prod, quantity);
        //devuelve el precio total del producto vendido
        return sell.getMount();
    }
```

Esta es la lógica que yo concebí. Puede que hayan mejores, pero yo hice esta para este post. El objetivo de este post es mas que todo la configuración del Arquillian, no de la lógica del programa.

Pues bien, hay un método aún no existente en la línea 58. Así que en la clase `SellFacade` crearemos el siguiente método:

```java
public Sell saveSell(Product p, int quantity) {
        LOGGER.debug("vender producto: {} \t cantidad:{}", p, quantity);
        Sell sell = new Sell();
        sell.setProduct(p);
        sell.setQuantity(quantity);
        sell.setMount(quantity * p.getPrice());
        sell.setSaleDate(new Date());
        em.persist(sell);
        return sell;
    }
```

Y listo, ya tenemos la lógica para probar....

¡¡¡¡¡¡PERO!!!!!

¿Notaron que estamos haciendo una prueba para buscar el producto "silla" y no la estamos cargando?

Aquí es donde Arquillian nos ayuda un montón. Resulta que instanciar todos los objetos necesarios vía java puede resultar muy tedioso. Así que, podemos cargar un archivo con la data necesaria, y hacemos que el contenido se cargado antes de ejecutarse el método.

Esto es una extensión de persistencia, hay más detalle de esto en el siguiente link: [http://arquillian.org/arquillian-extension-persistence/](http://arquillian.org/arquillian-extension-persistence/)

Este poblador de data permite cargar datos en XML, XLS, YAML y JSON. Está basado en [DBUnit](http://dbunit.sourceforge.net/)

Ahora bien, crearemos el archivo `src/test/resources/datasets/products.yml`. y tendrá el siguiente contenido:

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
  PRODUCT_STOCK: 5
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
```

Notar que se deben indicar los campos exactos que tendrá la base de datos.

Y para que nuestro test lo cargue, se debe declarar la siguiente línea antes de la declaración del método en cuestión, de la siguiente manera:

```java
@Test
    @UsingDataSet("datasets/products.yml")
    public void testSell() {
        LOGGER.info("-- probando venta de productos");
//...
```

Además, debemos configurar el archivo `arquillian.xml` para que pueda interpretar esa data y convertirlo correctamente a nuestra base de datos HSQLDB.

```java
<?xml version="1.0" encoding="UTF-8"?>
<arquillian xmlns="http://jboss.org/schema/arquillian"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://jboss.org/schema/arquillian
            http://jboss.org/schema/arquillian/arquillian_1_0.xsd">

    <defaultProtocol type="Servlet 3.0"/>
    <container qualifier="glassfish-embedded">
        <configuration>
            <property name="bindHttpPort">7979</property>
            <property name="resourcesXml">
                ${glassfish.resources.file}
            </property>
        </configuration>
    </container>
     <extension qualifier="persistence-dbunit">
        <property name="datatypeFactory">org.dbunit.ext.hsqldb.HsqldbDataTypeFactory</property>
    </extension>
</arquillian>
```

Las bases de datos permitidos por DBUnit son:

- DB2

- H2

- HSQLDB

- Mckoi

- MS SQL

- MySQL

- NetezzaData

- MySQL

- Oracle

- PostgreSQL

Ahora, ejecutemos la prueba:

[![]({{ '/assets/blogger/arquillian-run-test-02-update.png' | relative_url }})]({{ '/assets/blogger/arquillian-run-test-02-update.png' | relative_url }})

He marcado los mensajes importantes:

- Realiza la búsqueda

- Selecciona un producto a vender

- Se realiza la venta

- y el JPA hace la actualización de la base de datos.

Ok, ya parece que tiene forma... pero ¡es tan difícil saber cuál fue el resultado final! Mejor lo pongo en una base de datos y veo qué quedó!

Alto, alto, alto. Automaticemos nuestros ojos!!. Así como hay una data para cargar, también puedes decir qué data debería quedar después de la prueba.

Crearemos el archivo `src/test/resources/datasets/after_sales.yml` con el siguiente contenido:

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
  PRODUCT_STOCK: 5
- PRODUCT_ID: 3
  PRODUCT_NAME: SILLA DE PLAYA
  PRODUCT_PRICE: 20
  PRODUCT_ENABLED: TRUE
  PRODUCT_STOCK: 60
- PRODUCT_ID: 4
  PRODUCT_NAME: BAUL
  PRODUCT_PRICE: 150
  PRODUCT_ENABLED: FALSE
  PRODUCT_STOCK: 0
SELL:
- MOUNT: 800
  QUANTITY: 40
  product_id: 3
```

Notemos que aquí se deben poner los registros que van a quedar. Notar en la línea 16, ese registro debería quedar 40 productos menos. Además, habrá un registro más en la tabla `sell` (línea 22) y deberán tener esos datos (línea 23 al 25). Los campos que no aparecen (fecha de venta y el ID) no serán comprobados, serán ignorados en la comparación. (claro, no podemos saber qué fecha debe tener la venta en la prueba).

Finalmente, debemos declararlo (también) en el método TEST en cuestión, de la siguiente manera:

```java
@Test
    @UsingDataSet("datasets/products.yml")
    @ShouldMatchDataSet("datasets/after_sales.yml")
    public void testSell() {
        LOGGER.info("-- probando venta de productos");
```

Ejecuta la prueba, y verás.

## Código fuente

Como de costumbre, podrán descargar y obtener el código de este post en el siguiente repositorio GIT:

[https://bitbucket.org/apuntesdejava/payara-arquillian/src/master?at=jpa-ejb](https://bitbucket.org/apuntesdejava/payara-arquillian/src/master?at=jpa-ejb)

## Bibliografía

- [Arquillian Persistence Extension](http://arquillian.org/arquillian-extension-persistence/)

- [Testing Java Persistence](http://arquillian.org/guides/testing_java_persistence/)

## Social

### Twitter

>

Arquillian con [#JPA](https://twitter.com/hashtag/JPA?src=hash&ref_src=twsrc%5Etfw) y [#EJB](https://twitter.com/hashtag/EJB?src=hash&ref_src=twsrc%5Etfw). Seguimos con esta serie. Ahora ya nos conectamos a la base de datos, insertamos registros, y probamos el resultado final. Ya estamos cerca de terminar nuestro microservicio para [@Payara_Fish](https://twitter.com/Payara_Fish?ref_src=twsrc%5Etfw) [https://t.co/2s4ETl0vOZ](https://t.co/2s4ETl0vOZ)

&mdash; Apuntes de Java (@apuntesdejava) [10 de enero de 2018](https://twitter.com/apuntesdejava/status/951224686758776832?ref_src=twsrc%5Etfw)

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Facebook

<iframe src="https://web.facebook.com/plugins/post.php?href=https%3A%2F%2Fweb.facebook.com%2FApuntesDeJava%2Fposts%2F1761852683826022&width=500" width="500" height="560" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
