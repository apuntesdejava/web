---
layout: post
title: "Convertidor de tipo de atributo con JavaPersistence API"
date: 2015-10-15T22:13:00Z
last_modified_at: 2016-03-04T21:26:53.409Z
author: "Diego Silva Límaco"
permalink: /2015/10/convertidor-de-tipo-de-atributo-con.html
canonical_url: https://www.apuntesdejava.com/2015/10/convertidor-de-tipo-de-atributo-con.html
tags:
  - "java ee"
  - "jpa 2.1"
  - "jpa"
  - "java ee 7"
---

[![](https://docs.google.com/drawings/d/1qA82Kiyq3VnnR7z_rQjin3JTf5-2Ny2RWrMZKLNJblA/pub?w=442&h=181)](https://docs.google.com/drawings/d/1qA82Kiyq3VnnR7z_rQjin3JTf5-2Ny2RWrMZKLNJblA/pub?w=442&h=181)

Java nos permite crear muchos tipos de datos. Pero cuando queremos guardarlo en la base de datos, necesitamos hacer una conversión. Y de manera inversa, cuando queremos obtener un valor de la base de datos, necesitamos convertirlo a nuestro tipo de valor especial.

Menudo trabajo. Optamos o por hacer un convertidor de datos a nivel de DAO, o no usamos nuestra estructura de datos especial.

¿Y si usamos JPA? Calma, calma. La versión JPA 2.1 (que viene incluido en Java EE 7 - [JSR 338](https://jcp.org/en/jsr/detail?id=338)) tiene un convertir de tipos para ayudarnos con este problema.

## Clase de prueba

Consideraremos que tenemos una clase de prueba que tendrá dos métodos importantes: Uno lista los objetos usando JPA, y otro lista los registros usando JDBC. Además, necesitaremos de un método que haga la persistencia del objeto.

```java
private void listadoObjetos() {
        System.out.println("--- Listado de objetos  ---");
        TypedQuery<Producto> query = em.createQuery("Select a from Producto a", Producto.class);
        List<Producto> lista = query.getResultList();
        lista.stream().forEach((p0) -> {
            System.out.println(p0);
        });
        System.out.println("--- Fin de listado objetos---");
    }

    private void listadoJDBC() {
        System.out.println("--- Listado según JDBC Nativo ---");
        try (Connection conn = DriverManager.getConnection("jdbc:hsqldb:file:data/jpademo;ifexists=true", "jpa", "jpa")) {
            String sql = "SELECT * from producto";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            ResultSetMetaData meta = rs.getMetaData();
            String[] columnNames = new String[meta.getColumnCount()];
            for(int i=0;i<columnNames.length;i++)
                columnNames[i]=meta.getColumnName(i+1);
            while (rs.next()) {
                for (int i = 0; i < columnNames.length; i++) {
                    System.out.print('\t'+columnNames[i]+':'+rs.getString(i+1));
                }
                System.out.println();
            }

        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, null, ex);
        }

        System.out.println("--- Fin Listado según JDBC Nativo ---");
    }

    private void listar() {
        listadoObjetos();
        listadoJDBC();

    }

    /**
     * Método que crea la persistencia en el JPA
     * @param object
     */
    public void persist(Object object) {
        em.getTransaction().begin();
        try {
            em.persist(object);
            em.getTransaction().commit();
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Error guardando el objeto", e);
            em.getTransaction().rollback();
        }
    }
```

Estos métodos se ejecutarán para ver el contenido después de cada inserción de registros, a fin de comparar entre los objetos creados por el API y los registros obtenidos de la base de datos.

Además, necesitaremos preparar el EntityManager cada ve que se ejecute la prueba, y que se cierre la conexión al terminar. Por eso, necesitamos estos métodos.

```java
@Before
    public void setUp() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("demojpaPU");
        em = emf.createEntityManager();
    }

    @After
    public void tearDown() {
        em.close();
    }
```

## JPA 2.1

La implementación de JPA que funciona mejor es la de Hibernate, y no la de Eclipselink. Por tanto, necesitaremos que pongamos esta dependencia en nuestro archivo `pom.xml`:

```java
<dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-entitymanager</artifactId>
            <version>4.3.11.Final</version>
        </dependency>
```

## Base de datos

Para este ejemplo, estoy usando una base de datos incrustable llamada HSQLDB (http://hsqldb.org/) que, a mi parecer, es la más práctica para hacer demos.

Anteriormente hice un post sobre [Base de datos relacionales Java]({{ '/2009/01/base-de-datos-relacionales-en-java.html' | relative_url }}), donde menciono a HSQLDB y Apache Derby. Entre los dos, prefiero el primero.

```java
<dependency>
            <groupId>org.hsqldb</groupId>
            <artifactId>hsqldb</artifactId>
            <version>2.3.3</version>
        </dependency>
```

## Converter básico

Para crear nuestro convertidor necesitamos crear una clase que implemente la interfaz `javax.persistence.AttributeConverter` y que tenga la anotación `@javax.persistence.Converter`

Primero, vayamos con lo más fácil:

- Tenemos nuestra entidad (una clase JavaBean común y silvestre) con un atributo de tipo `boolean` y necesitamos que se guarde como tipo Texto. (Dije que comenzaríamos con lo más fácil)

Entonces, aquí tenemos nuestra clase con nuestra propiedad boolean:

```java
@Entity
public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String descripcion;

    private boolean existe;
//....
```

Creamos nuestra clase `BooleanStringConverter.java` así:

```java
package com.apuntesdejava.app.demo.jpa.converter.helper;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

/**
 *
 * @author diego.silva@apuntesdejava.com
 */
@Converter
public class BooleanStringConverter implements AttributeConverter<Boolean, String> {

    //Dos tipos de valores

    static final String EXISTE = "Existe";
    static final String NO_EXISTE = "No Existe";

    /**
     * Convierte el tipo del atributo en un valor válido para una columna de la
     * tabla
     *
     * @param attribute el valor a convertir
     * @return el valor convertido
     */
    @Override
    public String convertToDatabaseColumn(Boolean attribute) {
        return attribute ? EXISTE : NO_EXISTE;
    }

    /**
     * Convierte el tipo de dato que viene de la base de datos al tipo de
     * nuestra entidad
     *
     * @param dbData El valor de la base de datos
     * @return El valor devuelto
     */
    @Override
    public Boolean convertToEntityAttribute(String dbData) {
        //devuelve TRUE si el valor de la columna es EXISTE
        return dbData.equals(EXISTE);
    }

}
```

Este Converter dice: Yo convierto tu data Java Boolean a String para que lo guardes en la base de datos (método `convertToDatabaseColumn`); y cuando leo de la base de datos la cadena lo convertiré en objeto Java Boolean. (método `convertToEntitytAttribyte`)

Ahora, agregaremos la siguiente anotación en la entidad para que considere ese converter

```java
@Entity
public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Convert(converter = BooleanStringConverter.class)
    private String descripcion;

    private boolean existe;
//....
```

Ahora bien, crearemos la inserción de objetos:

```java
@Test
    public void createInstance() {

        Producto p = new Producto();
        p.setExiste(true);
        p.setDescripcion("Teclado");

        persist(p);

        Producto p1 = new Producto();
        p1.setDescripcion("Monitor");
        persist(p1);

        listar();

    }
```

Al ejecutarlo, tendremos el siguiente resultado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnsQ5348JOmK_eVjxd_gnfEF93xD3kg29PAdmhHwT06oNA5TGP8xnGzobNeNvBRK6UwkfHrda5Gkt5m_YyH6PiJZ5rRpz7dXG4zelcqC-Y4I469OjVRFYlqaz08mNn5U_17YqNohm0XJk/s640/15-10-2015+03-48-47+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnsQ5348JOmK_eVjxd_gnfEF93xD3kg29PAdmhHwT06oNA5TGP8xnGzobNeNvBRK6UwkfHrda5Gkt5m_YyH6PiJZ5rRpz7dXG4zelcqC-Y4I469OjVRFYlqaz08mNn5U_17YqNohm0XJk/s1600/15-10-2015+03-48-47+p.m..png)

Como se puede ver, el primer listo muestra el valor del atributo convertido en Boolean, pero en el segundo listado aparece como fue guardado en la base de datos, como un VARCHAR.

## Converter automático

Ahora bien, también podemos hacer que un converter se auto aplique a todos los tipos de atributo de entidad que tengan el valor que corresponde. Por ejemplo, aumentemos dos propiedades más a nuestra entidad:

```java
@Entity

public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String descripcion;

    @Convert(converter = BooleanStringConverter.class)
    private boolean existe;

    private Fecha fechaRenovacion;

    private Fecha fechaActualizacion;
//...
```

Crearemos nuestro Converter `AttributeConverter`

`
`

```java
@Converter(autoApply = true)
public class FechaConverter
        implements AttributeConverter<Fecha, java.sql.Date> {

    @Override
    public Date convertToDatabaseColumn(Fecha attribute) {
        LocalDate localDate = LocalDate.parse(attribute.getDia()
                + '/' + attribute.getMes()
                + '/' + attribute.getAnio(),
                DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        Date date = Date.valueOf(localDate);

        return date;

    }

    @Override
    public Fecha convertToEntityAttribute(Date dbData) {
        LocalDate localDate = dbData.toLocalDate();
        return new Fecha(localDate.format(DateTimeFormatter.ofPattern("dd")),
                localDate.format(DateTimeFormatter.ofPattern("MM")),
                localDate.format(DateTimeFormatter.ofPattern("YYYY")));
    }

}
```

La clase `Fecha` es un simple JavaBean que tiene tres atributos de tipo String: dia, mes y año.

Notemos la línea 14, donde se define la anotación `@Converter` tiene el atributo `autoApply = true`. Esto quiere decir, que cuando vea en cualquier entidad el tipo `Fecha` declarado en un atributo, se le aplicará este converter.

Ahora bien, como hemos declarado dos atributos de tipo `Fecha` en nuestra entidad, a los se aplicará este Converter. Pero, si queremos que uno de ellos no se aplique, le agregamos una notación

```java
@Entity

public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String descripcion;

    @Convert(converter = BooleanStringConverter.class)
    private boolean existe;

    private Fecha fechaRenovacion;

    @Convert(disableConversion = true)
    private Fecha fechaActualizacion;
//....
```

Lo ejecutamos, y este es nuestro resultado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLZmiTWiLI8cV7Zbf96-KoqCWgsH-BhrqWKYU79sK6t7-R-B4f2bxWyPPqk-LjRZL3zQkqsUNPjjCvDYIukWsDkmiIoTwQoT2pvhE1OfJOVO-V3wIEzCw_uhLY90YzhevXj5tneUopRLo/s640/15-10-2015+04-07-55+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLZmiTWiLI8cV7Zbf96-KoqCWgsH-BhrqWKYU79sK6t7-R-B4f2bxWyPPqk-LjRZL3zQkqsUNPjjCvDYIukWsDkmiIoTwQoT2pvhE1OfJOVO-V3wIEzCw_uhLY90YzhevXj5tneUopRLo/s1600/15-10-2015+04-07-55+p.m..png)

Se puede ver que, como objeto, obtienen bien los valores convertidos, pero en la base de datos, el campo `fechaActualizacion` que tiene la notación `disabledConversion=true` es guardado como objeto serializado. Pero el otro campo, `fechaRenovacion` que no tiene ninguna anotación, tiene el siguiente resultado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgF1FX3s3QxERwpRb0VR3TM0xGO1rzZqVj8meUUA7s9QxpfgWa3TKS5nLrlkSoMnxbs-RBEu4k1tkr2aZwwPfyOeI76sY41-3x_ewORtfL5nTu2WmxIkLKFoWSDJvJiCUGCvj9T__rSjwc/s640/15-10-2015+04-08-13+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgF1FX3s3QxERwpRb0VR3TM0xGO1rzZqVj8meUUA7s9QxpfgWa3TKS5nLrlkSoMnxbs-RBEu4k1tkr2aZwwPfyOeI76sY41-3x_ewORtfL5nTu2WmxIkLKFoWSDJvJiCUGCvj9T__rSjwc/s1600/15-10-2015+04-08-13+p.m..png)

## Lista de objetos

En JPA 2.0 nos traía una interesante novedad: si teníamos un atributo que era una lista, podíamos usar la anotación `[@javax.persistence.ElementCollection](https://docs.oracle.com/javaee/6/api/javax/persistence/ElementCollection.html)` El JPA se encargará de crear una tabla adicional relacionada a la tabla de la entidad.

Veamos, agregaremos una lista en nuestra entidad:

```java
@Entity

public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String descripcion;

    @Convert(converter = BooleanStringConverter.class)
    private boolean existe;

    @ElementCollection
    private List<String> otrosNombres;
    //Se autoaplicará el FechaConverter
    private Fecha fechaRenovacion;

    @Convert(disableConversion = true)
    private Fecha fechaActualizacion;
//...
```

Agregamos los valores en la entidad en nuestra clase de prueba.

```java
@Test
    public void createInstance() {
       Fecha f1 = new Fecha("27", "03", "1976"),
                f2 = new Fecha("23", "08", "2020");

        Producto p = new Producto();
        p.setExiste(true);
        p.setDescripcion("Teclado");
        p.setFechaRenovacion(f1);
        p.setFechaActualizacion(f2);
        p.setOtrosNombres(new ArrayList<>(Arrays.asList(new String[]{"Keyboard", "Dispositivo de entrada"})));

        persist(p);

        Producto p1 = new Producto();
        p1.setFechaRenovacion(f2);
        p1.setFechaActualizacion(f1);
        p1.setDescripcion("Monitor");
        persist(p1);

        listar();

    }
```

Y el resultado es:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibGOglNWB_2octFvZqyttDYSfYrffo9WjKKUDX_sXfIVq89blNVd9KsuVjV37vmJ2_-DffEQEPPl3meCN5Qj1ZILl3-K5Lu5Q1COtDFVl9nM1P9CL7WQpyfAWW9J0cg8Q7AVc9teQYzOs/s640/15-10-2015+04-44-47+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibGOglNWB_2octFvZqyttDYSfYrffo9WjKKUDX_sXfIVq89blNVd9KsuVjV37vmJ2_-DffEQEPPl3meCN5Qj1ZILl3-K5Lu5Q1COtDFVl9nM1P9CL7WQpyfAWW9J0cg8Q7AVc9teQYzOs/s1600/15-10-2015+04-44-47+p.m..png)

Y las tablas creadas en la base de datos son:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg6SLq99Hj9OAgnZ-x6bEWgsDRLXfoPx7yrWPwmzJ3SIFvmO7J65pf2_RPFeRPgKwOeuh1sowNY96pfowLv2OpojMm3XqD9VpIOSJTR6dKiMkoqLVKspMa5NQFr7TKGPyV95TdLE4UMIKU/s320/15-10-2015+04-50-34+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg6SLq99Hj9OAgnZ-x6bEWgsDRLXfoPx7yrWPwmzJ3SIFvmO7J65pf2_RPFeRPgKwOeuh1sowNY96pfowLv2OpojMm3XqD9VpIOSJTR6dKiMkoqLVKspMa5NQFr7TKGPyV95TdLE4UMIKU/s1600/15-10-2015+04-50-34+p.m..png)

Así es como funciona en JPA 2.0, pero si queremos que no cree otra tabla, sino que la lista en Java se convierta en un campo, aquí es donde entra el Converter.

Creamos nuestro converter `ListaNombresConverter` con el siguiente contenido:

```java
@Converter
public class ListaNombresConverter implements AttributeConverter<List<String>, String> {

    @Override
    public String convertToDatabaseColumn(List<String> attribute) {
        if (attribute == null) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        attribute.stream().forEach((attr) -> {
            sb.append(attr).append(',');
        });
        return sb.toString();
    }

    @Override
    public List<String> convertToEntityAttribute(String dbData) {
        if (dbData == null) {
            return null;
        }
        String[] splits = dbData.split(",");
        List<String> lista = new ArrayList<>(Arrays.asList(splits));

        return lista;
    }

}
```

Y cambiamos la anotación en la entidad:

```java
@Entity

public class Producto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String descripcion;

    @Convert(converter = BooleanStringConverter.class)
    private boolean existe;

    @Convert(converter = ListaNombresConverter.class)
    private List<String> otrosNombres;
    //Se autoaplicará el FechaConverter
    private Fecha fechaRenovacion;

    @Convert(disableConversion = true)
    private Fecha fechaActualizacion;
//...
```

Y al ejecutarlo...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRKpvHDdZVQomoLCqzUx0lU26aJkhoqtd9opfFJUgalt_vrYBkhs9Vquu0Iz80hHQ7BzbuJDMtrkAUlOt6ISO1XxGxcDKWKOFdtqYoifPLvLJYiK_RzNGCIz9FkEm8ukPKlUOpyQ9B9aM/s640/15-10-2015+05-00-30+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRKpvHDdZVQomoLCqzUx0lU26aJkhoqtd9opfFJUgalt_vrYBkhs9Vquu0Iz80hHQ7BzbuJDMtrkAUlOt6ISO1XxGxcDKWKOFdtqYoifPLvLJYiK_RzNGCIz9FkEm8ukPKlUOpyQ9B9aM/s1600/15-10-2015+05-00-30+p.m..png)

## Código fuente

El código fuente lo puedes descargar desde aquí:

[https://bitbucket.org/apuntesdejava/app-demo-jpa-converter/get/0ff166023de3.zip](https://bitbucket.org/apuntesdejava/app-demo-jpa-converter/get/0ff166023de3.zip)

Y también puedes examinarlo desde aquí: [https://bitbucket.org/apuntesdejava/app-demo-jpa-converter/src/tip](https://bitbucket.org/apuntesdejava/app-demo-jpa-converter/src/tip)

En Oracle Tecnology Network he publicado una documentación más completa:

>

Como convertir el tipo de atributo con [#Java](https://twitter.com/hashtag/Java?src=hash) Persistence API (JPA), por Diego Silva: [https://t.co/nPRrCcRVPi](https://t.co/nPRrCcRVPi)

&mdash; Oracle OTN (@oracleotnla) [26 de febrero de 2016](https://twitter.com/oracleotnla/status/703352332659122177)

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Bibliografía

- JavaDoc de Java EE 7:
[http://docs.oracle.com/javaee/7/api/javax/persistence/Convert.html](http://docs.oracle.com/javaee/7/api/javax/persistence/Convert.html)

Pensé que estaría en el Tutorial Java EE 7, pero no lo encontré.
