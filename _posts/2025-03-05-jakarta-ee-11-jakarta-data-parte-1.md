---
layout: post
title: "Jakarta EE 11 - Jakarta Data - Parte 1"
date: 2025-03-05T17:15:00.001Z
last_modified_at: 2025-03-05T17:15:54.134Z
author: "Diego Silva Límaco"
permalink: /2025/03/jakarta-ee-11-jakarta-data-parte-1.html
canonical_url: https://www.apuntesdejava.com/2025/03/jakarta-ee-11-jakarta-data-parte-1.html
tags:
  - "jakarta ee"
  - "payara"
  - "hibernate"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSFP4cVqoQ4xlvEIr6HY9vBmmtj8giBiUQNxDo9lnfwFRSub6cAJcgn9DJTKVCId9eX5Nl6nrOAVrwT/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vSFP4cVqoQ4xlvEIr6HY9vBmmtj8giBiUQNxDo9lnfwFRSub6cAJcgn9DJTKVCId9eX5Nl6nrOAVrwT/pub?w=1440&h=810)

 A la fecha de esta publicación, aún no se ha lanzado oficialmente
[Jakarta EE 11. Pero ya hay unos avances de ciertas especificaciones, como Jakarta Data la que yo considero una de las más interesantes e importantes. En este post veremos cómo podemos configurar nuestro proyecto con Jakarta EE 11 + Jakarta Data, utilizando la implementación de Hibernate sobre Payara Server](https://jakarta.ee/specifications/platform/11/).

## Creación del proyecto

Para comenzar, crearemos un proyecto utilizando un arquetipo de Maven:

```java
<code class="language-shell">mvn archetype:generate \
  -DarchetypeGroupId=com.apuntesdejava \
  -DarchetypeArtifactId=jakarta-ee-essentials \
  -DarchetypeVersion=0.0.2 \
  -DjakartaProfile=core
</code>
```

  Con este comando mostrará la siguiente pantalla para completar los parámetros
  como `groupId`, `artifactId`, `version` y
  `package`:

  [![](https://i.imgur.com/6F1JCEL.png)](https://i.imgur.com/6F1JCEL.png)

Que finalmente creará el proyecto con la siguiente estructura:

  [![](https://i.imgur.com/Lgwt0Dl.png)](https://i.imgur.com/Lgwt0Dl.png)

 Ese arquetipo lo he creado, y el detalle de sus parámetros lo pueden
encontrar aquí:
https://jakarta-coffee-builder.github.io/pages/archetype.html

## Agregando dependencias

   Comenzaremos por agregar las dependencias necesarias. Necesitaremos:

- El driver de la base de datos. Para este ejemplo usaremos h2.

- Hibernate ORM

- La declaración de `jakarta.data-api`

```java
<code class="language-xml">     <properties>
<!-- otras propiedades -->
        <hibernate.version>6.6.9.Final</hibernate.version>
    </properties>

    <dependencies>
<!-- ... otras dependencias -->
        <dependency>
            <groupId>jakarta.data</groupId>
            <artifactId>jakarta.data-api</artifactId>
            <version>1.0.1</version>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <version>2.3.232</version>
        </dependency>
        <dependency>
            <groupId>org.hibernate.orm</groupId>
            <artifactId>hibernate-core</artifactId>
            <version>${hibernate.version}</version>
        </dependency>
</code>
```

Y debemos configurar el plugin para generar el código para Hibernate

```java
<code class="language-xml">    <build>
        <plugins>
            <!-- otros plugins -->
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.13.0</version>
                <configuration>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.hibernate.orm</groupId>
                            <artifactId>hibernate-jpamodelgen</artifactId>
                            <version>${hibernate.version}</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
        </plugins>
    </build></code>
```

## Configuración del DataSource

  Existen dos maneras estándar para declarar un datasource: en el archivo
  `web.xml` y declarándolo en un clase. Esta vez lo haremos en el
  archivo `web.xml`

```java
<code class="language-xml"><?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <data-source>
        <name>java:global/ExampleDataSource</name>
        <class-name>org.h2.jdbcx.JdbcDataSource</class-name>
        <url>jdbc:h2:mem:</url>
        <user>sa</user>
        <password>sa</password>
        <property>
            <name>fish.payara.log-jdbc-calls</name>
            <value>true</value>
        </property>
    </data-source>

</web-app></code>
```

## Configuración de persistence.xml

  Ahora, como toda configuración de persistencia, necesitamos establecer la
  Unidad de Persisencia y asociarla al DataSource

```java
<code class="language-xml"><?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<persistence xmlns="https://jakarta.ee/xml/ns/persistence"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="https://jakarta.ee/xml/ns/persistence https://jakarta.ee/xml/ns/persistence/persistence_3_0.xsd"
             version="3.0">
    <persistence-unit name="defaultPU">
        <!-- utilizar el provider de hibernate -->
        <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>
        <jta-data-source>java:global/ExampleDataSource</jta-data-source>
        <properties>
            <!-- estos son necesarios -->
            <property name="hibernate.enhancer.enableDirtyTracking" value="false"/>
            <property name="hibernate.enhancer.enableLazyInitialization" value="false"/>
            <property name="hibernate.transaction.jta.platform" value="org.hibernate.service.jta.platform.internal.SunOneJtaPlatform"/>

            <!-- dicen que no es necesario este campo, pero si no se pone, no funciona -->
            <property name="hibernate.dialect" value="org.hibernate.dialect.H2Dialect"/>

             <!-- otros atributos -->
            <property name="hibernate.show_sql" value="true"/>
            <property name="hibernate.format_sql" value="true"/>
            <property name="hibernate.hbm2ddl.auto" value="create"/>
        </properties>
    </persistence-unit>
</persistence>
</code>
```

## El endpoint

  Necesitamos manejar el endpoint, así que tendremos las siguientes record para
  ser usados como request y response

### CoffeeRequest.java

```java
<code class="language-java">package com.example.example.jakarta.data.dto;

public record CoffeeRequest(String name, Double price) {

}</code>
```

### CoffeeResponse

```java
<code class="language-java">package com.example.example.jakarta.data.dto;

import com.example.example.jakarta.data.entity.CoffeeEntity;

public record CoffeeResponse(Long id, String name, Double price) {

    public static CoffeeResponse of(CoffeeEntity coffeeEntity) {
        return new CoffeeResponse(coffeeEntity.getId(),
                coffeeEntity.getName(),
                coffeeEntity.getPrice());
    }

}</code>
```

También necesitaremos el endpoint en sí:

### CoffeeResource.java

```java
<code class="language-java">package com.example.example.jakarta.data.resources;

import com.example.example.jakarta.data.dto.CoffeeRequest;
import com.example.example.jakarta.data.service.CoffeeService;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import static jakarta.ws.rs.core.MediaType.APPLICATION_JSON;
import jakarta.ws.rs.core.Response;

@Path("coffee")
@Produces(APPLICATION_JSON)
@Consumes(APPLICATION_JSON)
public class CoffeeResource {

    @Inject
    private CoffeeService coffeeService;

    @POST
    public Response save(CoffeeRequest coffeeRequest) {
        var coffeeSaved = coffeeService.create(coffeeRequest);
        return Response.ok(coffeeSaved).build();
    }

    @GET
    public Response list() {
        var coffeeList = coffeeService.listAll();
        return Response.ok(coffeeList).build();
    }

}</code>
```

  La clase `CoffeeService` se encargará de hacer convertir las
  entidades a las clases request y response, ya que no deberíamos exponer la
  entidad en sí.

Por tanto, ésta es la clase:

### CoffeeService.java

```java
<code class="language-java">package com.example.example.jakarta.data.service;

import com.example.example.jakarta.data.dto.CoffeeRequest;
import com.example.example.jakarta.data.dto.CoffeeResponse;
import com.example.example.jakarta.data.entity.CoffeeEntity;
import com.example.example.jakarta.data.repository.CoffeeRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;

@ApplicationScoped
public class CoffeeService {

    @Inject
    private CoffeeRepository coffeeRepository;

    public List<CoffeeResponse> listAll() {
        return coffeeRepository.findAll()
                .map(CoffeeResponse::of)
                .toList();
    }

    public CoffeeResponse create(CoffeeRequest coffeeRequest) {
        var coffeeEntity = new CoffeeEntity();
        coffeeEntity.setName(coffeeRequest.name());
        coffeeEntity.setPrice(coffeeRequest.price());
        var saved = coffeeRepository.save(coffeeEntity);
        return CoffeeResponse.of(saved);
    }
}</code>
```

## La capa de persistencia

  Ahora bien, esta es la capa de persistencia en sí. Solo heredar la interfaz
  `jakarta.data.repository.CrudRepository` y tendríamos todas las
  funcionalidades ya hechas

### Entidad CoffeeEntity.java

```java
<code class="language-java">package com.example.example.jakarta.data.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import static jakarta.persistence.GenerationType.IDENTITY;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "coffee")
public class CoffeeEntity {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @Column (
        name = "coffee_name",
        length = 100,
        unique = true,
        nullable = false
    )
    private String name;

    private Double price;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

}
</code>
```

### Repositorio CoffeeRepository.java

```java
<code class="language-java">package com.example.example.jakarta.data.repository;

import com.example.example.jakarta.data.entity.CoffeeEntity;
import jakarta.data.repository.CrudRepository;
import jakarta.data.repository.Repository;

@Repository
public interface CoffeeRepository extends CrudRepository<CoffeeEntity, Long>{

}
</code>
```

## Código fuente

El código fuente está disponible aquí: https://github.com/apuntesdejava/example-jakarta-data y también incluye ejemplos de cómo invocar a los endpoint.

## Vídeo

También hay una explicación en vivo de este código

<iframe width="560" height="315" src="https://www.youtube.com/embed/vCaazQsnm-s?si=Zjhjz3P66oLHWxV5" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
