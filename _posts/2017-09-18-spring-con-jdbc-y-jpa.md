---
layout: post
title: "Spring con JDBC y JPA"
date: 2017-09-18T20:51:00.002Z
last_modified_at: 2017-09-18T20:51:34.937Z
author: "Diego Silva Límaco"
permalink: /2017/09/spring-con-jdbc-y-jpa.html
canonical_url: https://www.apuntesdejava.com/2017/09/spring-con-jdbc-y-jpa.html
description: "En este post veremos una aplicación Java Web donde la conexión a la base de datos se hará usando Spring, y también veremos cómo manipular la data con JDBC y con JPA. Todo esto lo ejecutaremos desde Tomcat."
tags:
  - "spring"
  - "tomcat"
  - "web"
  - "jpa"
  - "jdbc"
  - "mvc"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSAQBQCCt-CZMH3J8_RJFaY3W870I1c-W78j3vsauZK1e-AH6onDeA0F2Q46JkSgE76S7kJgbHyKUKa/pub?w=1024&h=512)](https://docs.google.com/drawings/d/e/2PACX-1vSAQBQCCt-CZMH3J8_RJFaY3W870I1c-W78j3vsauZK1e-AH6onDeA0F2Q46JkSgE76S7kJgbHyKUKa/pub?w=1024&h=512)

En este post veremos una aplicación Java Web donde la conexión a la base de datos se hará usando Spring, y también veremos cómo manipular la data con JDBC y con JPA. Todo esto lo ejecutaremos desde Tomcat.

Tecnologías utilizadas en este post:

- Maven

- JPA 2.1

- Tomcat 8.5

- Spring 4.3

- Hibernate 5.2

- Java 8

- Java EE Web Profile 7.0 (por el Tomcat)

- slf4j

- Base de datos

## 0. Logging

Para todo buen proyecto, es necesario contar con un logging. Para ello, usaremos el S4JL con puente el Log4j. Necesitamos para ello la dependencia en el `pom.xml`

```java
<dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-log4j12</artifactId>
            <version>1.7.25</version>
        </dependency>
```

Además, necesitamos el archivo `log4j.properties`  bien configurado para el proyecto.

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/resources/log4j.properties?embed=t"></script>.

Estas serán las propiedades que utilizaremos en el proyecto:

```java
<properties>
        <endorsed.dir>${project.build.directory}/endorsed</endorsed.dir>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring.version>4.3.11.RELEASE</spring.version>
        <hibernate.version>5.2.11.Final</hibernate.version>
    </properties>
```

## 1. Generar el Proyecto desde Plantilla Maven

Ejecutar desde la consola del sistema operativo:

```java
mvn archetype:generate -DgroupId=com.apuntesdejava -DartifactId=db-spring-sample-web -Dversion=1.0 -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
```

También podríamos haberlo creado desde NetBeans o Eclipse como Módulo Web.

## 2. Archivo context.xml para Tomcat. Conexión a base de datos

La base de datos que usaremos es el [H2 Database](http://www.h2database.com/).

```java
<!-- https://mvnrepository.com/artifact/com.h2database/h2 -->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <version>1.4.196</version>
        </dependency>
```

Recomiendo mucho que la conexión a la base de datos se encargue el contenedor web, y no que la aplicación lo haga. La aplicación solo debería conectarse usando el JNDI. Aquí una explicación en un post anterior: [DataSources en una aplicación Java EE](/2017/06/datasources-en-una-aplicacion-java-ee.html)

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/webapp/META-INF/context.xml?embed=t"></script>

Adicionalmente, para que los componentes Java lo puede ver, es necesario crear la referencia en el archivo `web.xml`.
<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/webapp/WEB-INF/web.xml?embed=t"></script>

## 3. Archivo spring.xml para nuestra configuración de Spring con JDBC + DataSource

Necesitamos agregar las dependencias para Spring:

```java
<!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>${spring.version}</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>${spring.version}</version>
        </dependency>
        <!-- https://mvnrepository.com/artifact/org.springframework/spring-orm -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-orm</artifactId>
            <version>${spring.version}</version>
        </dependency>
```

Tendremos nuestro archivo `src/main/resources/spring.xml` con el siguiente contenido:

```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:c="http://www.springframework.org/schema/c"
       xmlns:context="http://www.springframework.org/schema/context"

       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-4.3.xsd
          http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd
">
    <bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean">
        <property name="jndiName" value="java:comp/env/jdbc/SampleDB"/>
    </bean>

    <context:annotation-config />
    <context:component-scan base-package="com.apuntesdejava.db"/>
</beans>
```

Entre las líneas 10 al 12 es importante, ya que allí es donde se establece la conexión a la base de datos. Además, en la línea 15 nos indica que comenzará a barrer todas las clases que serán interpretadas como beans de Spring, y los instanciará y asociará según sea lo necesario.

## 4. Clase que accede a Spring

Tendremos una clase Singleton (que será como una instancia Global) que nos permitirá acceder a las clases de Lógica negocio (o también llamados *Servicios*).

```java
package com.apuntesdejava.db.util;

import com.apuntesdejava.db.service.PersonService;
import com.apuntesdejava.db.service.ProductService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 *
 * @author diego
 */
public class ApplicationBeans {

    private final ApplicationContext context;

    private ApplicationBeans() {
        context = new ClassPathXmlApplicationContext("spring.xml");
    }

    public static ApplicationBeans getInstance() {
        return ApplicationBeansHolder.INSTANCE;
    }

    private static class ApplicationBeansHolder {

        private static final ApplicationBeans INSTANCE = new ApplicationBeans();
    }

    public PersonService getPersonService() {
        //con JDBC
        return context.getBean(PersonService.class);
    }
```

## 5. Servicio: Interfaz e Implementación

`PersonService` tendrá el ejemplo para acceder usando JDBC. Aquí solo colocamos la interfaz, luego Spring sabrá cuál se instanciará.

Esta es la interfaz

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/service/PersonService.java?embed=t"></script>

Esta es la implementación. Así de simple.

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/service/impl/PersonServiceImpl.java?embed=t"></script>

## 6. Implementando de DAO con JDBC

De la misma manera, se asocia la interfaz para el DAO `PersonDao`, y Spring sabrá qué clase usar para instanciar.

Esta es la interfaz del DAO...

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/dao/PersonDao.java?embed=t"></script>

...y esta es su implementación con JDBC.

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/dao/impl/JdbcPersonDao.java?embed=t"></script>

## 7. JSPs para listar y formulario de edición

Crearemos el archivo `/src/main/webapp/persons/index.jsp` que es el que visualizará el contenido de la tabla `Person`. Aquí accederemos al servicio `PersonService` y dejaremos que todo lo implementando antes fluya:
<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/webapp/persons/index.jsp?embed=t"></script>

Como se puede ver, el código es practicamente limpio, ya que el acceso a la base de datos se ha hecho simple a través de su clase de servicio

Ahora, para crear un nuevo registro, el JSP es bastante simple:

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/webapp/persons/edit.jsp?embed=t"></script>

Si pueden notar la línea 16, el action apunta a un servlet que ahora lo vamos a crear.

## 8. Servlet Controlador del formulario Person

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/person/servlet/PersonServlet.java?embed=t"></script>

La línea 56 es crucial: Simplemente se pasan los parámetros al servicio (que fue instanciado en la línea 50) y el registro en la base de datos es transparente.

Spring ya nos instanció tranquilamente la clase DAO para JDBC utilizando el DataSource configurado en la aplicación mediante el archivo context.xml.

## 9. Preparando la conexión con JPA

¿Y si queremos usar las funcionalidades de JPA, y en Tomcat? Aquí tengo la explicación.

Antes que nada, el archivo `persistence.xml` puede estar configurado con todos los valores para conectarse a la base de datos. Pero en honor a la reutilización, esto sería un desperdicio.. ya que la conexión a la base de datos ya está en el archivo `context.xml`, y nuestra parte de JDBC funciona bien... entonces ¿para que volver a crear la conexión a la base de datos?. Afortunadamente, JPA permite configurar usando el JNDI de un DataSource... y esta sería la configuración del archivo

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/resources/META-INF/persistence.xml?embed=t"></script>

Tomcat, tal cual como está "sacado de caja" no permite conexiones JTA. Por ello la configuración es `RESOURCE_LOCAL`.

## 10. Dependencias para JPA (con Hibernate)

Agregaremos esta dependencia en el `pom.xml` para usar el JPA implementado en Hibernate.

```java
<!-- JPA / Hibernate  -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-core</artifactId>
            <version>${hibernate.version}</version>
        </dependency>
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-jpamodelgen</artifactId>
            <version>${hibernate.version}</version>
        </dependency>
        <!-- FIN JPA / Hibernate -->
```

## 11. Método para la clase Spring

Agregamos  en la clase `com.apuntesdejava.db.util.ApplicationBeans` el método

```java
public ProductService getProductService() {
        //con JPA
        return context.getBean(ProductService.class);
    }
```

## 12. Interfaz e Implementación del Servicio Product

Es igual que con JDBC. Aquí está la interfaz:

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/e483f444a7cbe3d832a9b5e3b8db4a77fa8c523c/src/main/java/com/apuntesdejava/db/service/ProductService.java?embed=t"></script>

Y aquí la implementación:

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/service/impl/ProductServiceImpl.java?embed=t"></script>

## 13. Implementación del JPA

Spring nos instancia los objetos necesarios de tal manera que solo lo usemos de manera transparente. Aquí está la interfaz para DAO (bastante simple, luce igual que el JDBC, claro.. porque es la interfaz):

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/dao/ProductDao.java?embed=t"></script>

Y aquí el DAO implementado

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/dao/impl/JpaProductDao.java?embed=t"></script>

El Spring nos ayudó a implementar JPA reutilizando la conexión de la base de datos del Tomcat. Sin ello, la conexión - realmente - se hace un poco complicado, declarando más variables y más objetos.

## 14. Para terminar: Los JSPs y el Servlet Controlador

Esto ya no tiene mucha explicación:

El Listado:

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/webapp/products/index.jsp?embed=t"></script>

El Formulario:

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/webapp/products/edit.jsp?embed=t"></script>

El Servlet Controlador:

<script src="https://bitbucket.org/apuntesdejava/db-spring-sample-web/src/master/src/main/java/com/apuntesdejava/db/product/servlet/ProductServlet.java?embed=t"></script>

## 15. Los Recursos

Aquí está el código fuente para que lo puedan examinar, revisar y hacer lo que necesiten:

- Para descargar: [https://bitbucket.org/apuntesdejava/db-spring-sample-web/downloads/](https://bitbucket.org/apuntesdejava/db-spring-sample-web/downloads/)

- El proyecto para hacer git clone: [https://bitbucket.org/apuntesdejava/db-spring-sample-web](https://bitbucket.org/apuntesdejava/db-spring-sample-web)
