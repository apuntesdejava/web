---
layout: post
title: "Cambiando propiedades de conexión JDBC en Quarkus.... durante ejecución (y en Payara Micro)"
date: 2022-03-28T21:06:00.004Z
last_modified_at: 2022-04-01T22:50:16.082Z
author: "Diego Silva Límaco"
permalink: /2022/03/cambiando-propiedades-de-conexion-jdbc.html
canonical_url: https://www.apuntesdejava.com/2022/03/cambiando-propiedades-de-conexion-jdbc.html
description: "Insertamos valores en la configuración de la aplicación, pero después de que haya iniciado ¿imposible? Para nada."
tags:
  - "microprofile"
  - "jakarta ee"
  - "payaramicro"
  - "quarkus"
---

****

**[![](/assets/blogger/f1280x720-22246_153921_5050.jpg)](/assets/blogger/f1280x720-22246_153921_5050.jpg)**

**
Normalmente**, los valores de las conexiones DEBEN estar separado del código (si eres principiante, ya debes saberlo a rajatabla). Y si usamos frameworks como Quarkus, PayaraMicro, OpenLiberty, etc (ah, también Springboot) estos ya tienen preparado características como "perfiles" donde las propiedades pueden establecerse de acuerdo a cada perfil, o también podemos usar los perfiles del Maven para usar tal o cual propiedades. O también podemos hacer que tomen los valores del entorno (variables del entorno donde se está ejecutando, sea test, staging, producción, etc). En fin, podemos configurar los valores de las propiedades **ANTES** de que se ejecute la aplicación para que funcione tranquilamente. Y así, no pasó nada.

PEROOO!!! Hay veces que el cliente, en su afán de implementar seguridad extrema dice que nada de las credenciales de base de datos puede estar en variables de entorno, ni en las propiedades de despliegue, ni nada. Sino que están en un recurso externo (puede ser un Azure Table Storage, AWS Secret Manager, REST API, en otra base de datos, etc) solo nos dicen "tú consumes este nombre y ahí están las credenciales". Suena comprensible, pero - considerando lo expuesto en el anterior párrafo - no habría manera directa de leer los valores de las credenciales antes de insertar en las propiedades justo antes que  termine de ejecutarse la aplicación. Deberíamos interceptar la ejecución de la lectura de las propiedades, o de la creación de la conexión de la base de datos.

En este post veremos la solución para dos Frameworks: Quarkus y PayaraMicro. Las credenciales serán tomadas de un servicio REST ficticio. La base de datos será H2 para no tener que pensar en configurar un ambiente.  Espero que les sea útil

## El proyecto en Quarkus

Consideremos el siguiente proyecto Quarkus con REST y JPA vía Panache. Solo mostraré los archivos principales, los demás lo dejaré publicado en el github para que lo exploren mejor. Este es el `pom.xml`

```java
<?xml version="1.0"?>
<project xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd" xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.apuntesdejava</groupId>
  <artifactId>injection-props-quarkus</artifactId>
  <version>1.0.0-SNAPSHOT</version>
  <properties>
    <compiler-plugin.version>3.8.1</compiler-plugin.version>
    <failsafe.useModulePath>false</failsafe.useModulePath>
    <maven.compiler.release>11</maven.compiler.release>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <quarkus.platform.artifact-id>quarkus-bom</quarkus.platform.artifact-id>
    <quarkus.platform.group-id>io.quarkus.platform</quarkus.platform.group-id>
    <quarkus.platform.version>2.7.5.Final</quarkus.platform.version>
    <surefire-plugin.version>3.0.0-M5</surefire-plugin.version>
  </properties>
  <dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>${quarkus.platform.group-id}</groupId>
        <artifactId>${quarkus.platform.artifact-id}</artifactId>
        <version>${quarkus.platform.version}</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
  </dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-resteasy-jackson</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-arc</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-junit5</artifactId>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-jdbc-h2</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-hibernate-orm</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-hibernate-orm-panache</artifactId>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>${quarkus.platform.group-id}</groupId>
        <artifactId>quarkus-maven-plugin</artifactId>
        <version>${quarkus.platform.version}</version>
        <extensions>true</extensions>
        <executions>
          <execution>
            <goals>
              <goal>build</goal>
              <goal>generate-code</goal>
              <goal>generate-code-tests</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
      <plugin>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>${compiler-plugin.version}</version>
        <configuration>
          <compilerArgs>
            <arg>-parameters</arg>
          </compilerArgs>
        </configuration>
      </plugin>
      <plugin>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>${surefire-plugin.version}</version>
        <configuration>
          <systemPropertyVariables>
            <java.util.logging.manager>org.jboss.logmanager.LogManager</java.util.logging.manager>
            <maven.home>${maven.home}</maven.home>
          </systemPropertyVariables>
        </configuration>
      </plugin>
    </plugins>
  </build>
  <profiles>
    <profile>
      <id>native</id>
      <activation>
        <property>
          <name>native</name>
        </property>
      </activation>
      <build>
        <plugins>
          <plugin>
            <artifactId>maven-failsafe-plugin</artifactId>
            <version>${surefire-plugin.version}</version>
            <executions>
              <execution>
                <goals>
                  <goal>integration-test</goal>
                  <goal>verify</goal>
                </goals>
                <configuration>
                  <systemPropertyVariables>
                    <native.image.path>${project.build.directory}/${project.build.finalName}-runner</native.image.path>
                    <java.util.logging.manager>org.jboss.logmanager.LogManager</java.util.logging.manager>
                    <maven.home>${maven.home}</maven.home>
                  </systemPropertyVariables>
                </configuration>
              </execution>
            </executions>
          </plugin>
        </plugins>
      </build>
      <properties>
        <quarkus.package.type>native</quarkus.package.type>
      </properties>
    </profile>
  </profiles>
</project>
```

No hay cosa de otro mundo, como ven, no he agregado ningún plugin especial.

### Endpoint

Este sería el endpoint:

```java
@Path("person")
@Produces(APPLICATION_JSON)
@Consumes(APPLICATION_JSON)
public class PersonEndpoint {

    @Inject
    PersonService personService;

    @GET
    public Response list() {
        List<Person> list = personService.list();
        return Response.ok(list).build();
    }

    @POST
    public Response create(PersonRequest request) {
        Person p = personService.create(request.getFirstName(), request.getLastName(), request.getBirthDate(), Gender.valueOf(request.getGender()));
        return Response.ok(p).build();
    }
}
```

### El Servicio

El servicio de lógica de negocio. Estamos utilizando las capas necesarias.

```java
@ApplicationScoped
public class PersonService {

    @Inject
    PersonRepository repository;

    @Transactional
    public Person create(String firstName, String lastName, LocalDate birthdate, Gender gender) {
        Person p = new Person();
        p.setFirstName(firstName);
        p.setLastName(lastName);
        p.setBirthDate(birthdate);
        p.setGender(gender);
        repository.persist(p);
        return p;
    }

    public List<Person> list(){
        return repository.listAll();
    }

}
```

### El repositorio

Aquí usamos el repositorio basado en Panache:

```java
@ApplicationScoped
public class PersonRepository implements PanacheRepositoryBase<Person, Long> {

}
```

### El archivo de configuración

Ahora bien, esta es la parte interesante: Si deseamos utilizar el archivo de configuración usando perfiles de Quarkus, podemos establecer los valores predeterminados en `application.properties` y los de desarrollo en `application-dev.properties`. (Mayor información en [https://quarkus.io/guides/config-reference](https://quarkus.io/guides/config-reference)) Y cuando estemos desplegando en ambientes, utilizamos las variables entorno o propiedades de la aplicaciones. Hagamos un ejercicio:

Este es el archivo application.properties:

```java
quarkus.datasource.db-kind = h2
quarkus.datasource.username = sa
quarkus.datasource.password = sa
quarkus.datasource.jdbc.url = jdbc:h2:mem:default;DB_CLOSE_DELAY=-1
quarkus.hibernate-orm.database.generation=create
quarkus.hibernate-orm.log.sql=true
```

Ejecutemos con:`mvn quarkus:dev`

El resultado es:

[![](/assets/blogger/QLJQzIwbNy.png)](/assets/blogger/QLJQzIwbNy.png)

La configuración es para crear una base de datos en memoria, así que si inserto datos, cierro y vuelvo a ejecutar, no habrá datos. (esto lo veremos en el vídeo).

Ahora bien ¿cómo puedo cambiar la configuración de la base de datos sin tocar nada? Puedes, leyendo la configuración, es insertando las propiedades desde la ejecución, así:

- Si es por modo dev:
 `mvn quarkus:dev -Dquarkus.datasource.jdbc.url=jdbc:h2:./target/db/test`
- Si es desde un java runner (previo `mvn  package -Dquarkus.package.type=jar`):
 `java -Dquarkus.datasource.jdbc.url=jdbc:h2:./target/db/test -jar target/quarkus-app/quarkus-run.jar`

Entonces, según la configuración del H2, se está creando una base de datos físicamente. Es porque le indicamos por propiedades.

Hasta aquí todo chévere, y es que todo lo hemos manejado así. Pero el gran problema es: ¿QUÉ HACER CUÁNDO LAS CREDENCIALES ESTÁ EN OTRA FUENTE DE DATOS ?

Que lo extraiga en Python y lo ponga como variables de entorno o propiedades y ejecute nuestra aplicación Java.

Antes de que pienses en soluciones frankestianas, considera esta:

## La solución elegante

Quarkus utiliza [Smallrye](https://smallrye.io/)que permite manipular algunas características de Microprofile, entre ellas Config API. Y una de las funcionalidades importantes es la interceptar las propiedades. Hay varias maneras, pero solo mostraré la que más nos interesa.

### Archivo application.properties

Aquí cambiaremos algo en el archivo de configuración, pero para hacerlo elegante, colocaremos propiedades reemplazables tales como `jdbc.username` `jdbc.password` y `jdbc.url`:

```java
quarkus.datasource.db-kind = h2
quarkus.datasource.username = ${jdbc.username}
quarkus.datasource.password = ${jdbc.password}
quarkus.datasource.jdbc.url = ${jdbc.url}
quarkus.hibernate-orm.database.generation=create
quarkus.hibernate-orm.log.sql=true
```

### Las credenciales externas

Como dije al inicio, pudo haber sido un Table Storage, AWS Secret Manager, etc etc, pero para hacerla fácil en este este post, he creado un servicio REST bastante simple, que el URL es `http://localhost:8000/resources/credentials` y el resultado es:

```java
{
    "password": "sa",
    "url": "jdbc:h2:~/test-db-injection",
    "username": "sa"
}
```

### Extracción de Credenciales

Ahora bien, en nuestro proyecto haremos una clase servicio que se encargará de acceder a este recurso externo y extraer esa data. Como no podemos usar `@ApplicationScoped` ni cosas por el estilo, haremos un Singleton clásico. La lógica es simple: se conecta al servicio externo, obtiene la información y lo guarda en una variable. Y cada vez que se le vuelva a pedir la información, solo le dará el valor de la variable:

```java
public class CredentialService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CredentialService.class);
    /**
     * Instancia Singleton
     */
    private static CredentialService INSTANCE;

    private static synchronized void newInstance() {
        INSTANCE = new CredentialService();
    }

    public static CredentialService getInstance() {
        if (INSTANCE == null) {
            newInstance();
        }
        return INSTANCE;
    }
    private DatabaseCredential dbCredentials;

    /**
     * Constructor del Singleton
     */
    private CredentialService() {
        try {
            // Se conecta al servicio externo
            HttpClient httpClient = HttpClient.newBuilder().build();
            HttpRequest request = HttpRequest.newBuilder()
                    .GET()
                    .uri(URI.create("http://localhost:8000/resources/credentials"))
                    .build();
            // Invoca y obtiene la respuesta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() == 200) { //si esta todo ok...
                ObjectMapper mapper = new ObjectMapper(); //... lo convierte al objeto a manipular
                this.dbCredentials = mapper.readValue(response.body(), DatabaseCredential.class);
                LOGGER.info("Credenciales cargadas:{}", this.dbCredentials);
            }
        } catch (IOException | InterruptedException ex) {
            LOGGER.error(ex.getMessage(), ex);
        }
    }

    /**
     * Devuelve las credenciales obtenidas del servicio de credenciales
     *
     * @return
     */
    public DatabaseCredential getDbCredentials() {
        return dbCredentials;
    }

}
```

### Inyección de propiedades

Hasta ahorita no hemos algo sorprendente. La duda es ¿cómo vamos a poner los valores del REST externo al `application.properties`?. Tranquilo. Aquí está la solución, en dos pasos:

#### 1. Extender la clase io.smallrye.config.ExpressionConfigSourceInterceptor

Esta clase esta preparada para interpretar las expresiones del archivo de configuraciones. Hay otras más para otras funcionalidades, pero esta es la que necesitamos.

La implementación es la siguiente:

```java
public class AppConfigSourceInterceptor extends ExpressionConfigSourceInterceptor {

    @Override
    public ConfigValue getValue(ConfigSourceInterceptorContext context, String name) {
        //Obtenemos las credenciales
        DatabaseCredential db = CredentialService.getInstance().getDbCredentials();
        //Dependiendo de la propiedad que se esté tratando...
        switch (name) { //... se colocará el valor
            case "jdbc.url":
                return ConfigValue.builder()
                        .withName(name)
                        .withValue(db.getUrl())
                        .build();
            case "jdbc.username":
                return ConfigValue.builder()
                        .withName(name)
                        .withValue(db.getUsername())
                        .build();
            case "jdbc.password":
                return ConfigValue.builder()
                        .withName(name)
                        .withValue(db.getPassword())
                        .build();

        }
        ConfigValue configValue = doLocked(() -> context.proceed(name));
        return configValue;
    }

}
```

#### 2. Agregar en la configuración de Smallrye

Ahora, debemos crear el archivo `src/main/resources/META-INF/services/io.smallrye.config.ConfigSourceInterceptor` con el nombre completo de la clase que hemos creado:

```java
com.apuntesdejava.sample.interceptor.AppConfigSourceInterceptor
```

Solo con esta configuración, al iniciar el Quarkus, el framework leer la configuración e inyectará los valores respectivos en el momento justo:

[![](/assets/blogger/WkJmG6Ee9I.png)](/assets/blogger/WkJmG6Ee9I.png)

Como se ve en el log, las credenciales se cargaron justo antes de que se mostrara el logo de inicio de carga de Quarkus.

En un futuro, si cambian el valor de las credenciales, solo tocará reiniciar el microservicio, y listo.

## ¿Y Payara Micro?

Lo veremos en el vídeo.

<iframe allowfullscreen="" class="BLOG_video_class" height="476" src="https://www.youtube.com/embed/HG1LKJHSBjI" width="572" youtube-src-id="HG1LKJHSBjI"></iframe>

## Código fuente

El código fuente de este proyecto lo puedes encontrar aquí:

[https://github.com/apuntesdejava/ejemplo-inyeccion-propiedades](https://github.com/apuntesdejava/ejemplo-inyeccion-propiedades)
