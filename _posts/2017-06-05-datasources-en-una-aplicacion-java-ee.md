---
layout: post
title: "DataSources en una aplicación Java EE"
date: 2017-06-05T19:59:00Z
last_modified_at: 2018-01-10T23:41:00.792Z
author: "Diego Silva Límaco"
permalink: /2017/06/datasources-en-una-aplicacion-java-ee.html
canonical_url: https://www.apuntesdejava.com/2017/06/datasources-en-una-aplicacion-java-ee.html
description: "En este post veremos que existen tres maneras para implementar un DataSource, con sus ventajas y desventajas, dependiendo de lo que uno desea para su propia implementación."
tags:
  - "tomcat"
  - "datasource"
  - "payara"
  - "java ee"
  - "wildfly"
  - "base de datos"
  - "tips"
---

[![]({{ '/assets/blogger/duke_log2.jpg' | relative_url }})]({{ '/assets/blogger/duke_log2.jpg' | relative_url }})

Todas las aplicaciones en Java EE va a necesitar - al menos -  una conexión a una base de datos relacional.

Según el Diseño de Patrones, la conexión a base de datos debe estar fuera de la aplicación que estamos construyendo.

Según el estándar de Java EE, la conexión a la base de datos debe estar basada en un Pool de Conexiones y que esté administrado por el Contenedor Java EE.

Esta conexión a la base de datos es a través de los DataSource del Contenedor Java EE.

En este post veremos que existen tres maneras para implementar un DataSource, con sus ventajas y desventajas, dependiendo de lo que uno desea para su propia implementación.

**Ojo: Spring Boot no hace aplicaciones Java EE. En la misma página de [Spring Boot](https://projects.spring.io/spring-boot) dice que hace aplicaciones Spring, no Aplicaciones Java EE.**

## Declarándolo en el web.xml

El archivo `web.xml` es estándar entre todas las aplicaciones Java Web, así que allí podemos configurar todo lo necesario para conectarnos a la base de datos

### Ejemplo

En el `web.xml` debería tener las siguientes etiquetas.

<script src="https://bitbucket.org/apuntesdejava/payara-micro-demo/src/master/rest-demo-services/src/main/webapp/WEB-INF/web.xml?embed=t"></script>

Para invocarlos desde el `persistence.xml` se haría de la siguiente manera.

```java
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<persistence xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.1" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
  <persistence-unit name="empleadosPU" transaction-type="JTA">
    <jta-data-source>java:app/EmpleadosDS</jta-data-source>
    <exclude-unlisted-classes>false</exclude-unlisted-classes>
    <properties>
      <property name="javax.persistence.schema-generation.database.action" value="create"/>
    </properties>
  </persistence-unit>
</persistence>
```

Y para invocarlo desde un Componente Java es de la siguiente manera.

```java
@WebServlet(name = "EmpleadoServlet", urlPatterns = {"/EmpleadoServlet"})
public class EmpleadoServlet extends HttpServlet {

    @Resource(name = "java:app/EmpleadosDS")
    private DataSource empleadosDS;
```

### Ventajas

- Es tan estándar que podemos usar el mismo .war en diferentes Contenedor Java EE indistintamente tales como Wildfly, TomEE y Payara.

- Cero configuración en el Contenedor Java EE.

- Ideal para ambientes de desarrollo

- Las credenciales de la base de datos es independiente al código Java.

- No se necesita conocer cómo configurar el Contenedor Java EE.

### Desventajas

- La configuración está basada para un solo servidor de base de datos. Si se desea cambiar a otro, se necesita cambiar el archivo, aunque existen maneras vía maven para actualizar el contenido del `web.xml` dependiendo del perfil en que se esté ejecutando; por ejemplo, para el ambiente de Producción usa una configuración, y para el de Desarrollo otra.

- Necesita del driver JDBC en la misma aplicación.

## Declarándolo como una anotación @DataSourceDefinition

Esta opción es similar al anterior, solo que todas las credenciales estarán en nuestro código .java.

### Ejemplo

Para invocarlos desde el `persistence.xml` se haría de la misma manera.

```java
<persistence-unit name="samplePU" transaction-type="JTA">
    <jta-data-source>java:app/SampleDS</jta-data-source>
    <class>com.apuntesdejava.rest.sample.services.ProductCode</class>
    <exclude-unlisted-classes>true</exclude-unlisted-classes>
    <properties>
      <property name="javax.persistence.schema-generation.database.action" value="create-or-extend-tables"/>
    </properties>
  </persistence-unit>
```

Y desde un componente Java EE igual que el anterior apartado.

### Ventajas

- Es Java

- Ideal para ambientes de desarrollo, personales y ejemplos.

- No se necesita conocer cómo configurar el Contenedor Java EE.

### Desventajas

- Si hay algún cambio en la base de datos, tendríamos que volver a compilar el código.

- Necesita del driver JDBC en la misma aplicación.

## Configurando en el Contenedor Java EE

Esta opción es, a mi punto de vista, la más práctica a la hora de configurar el entorno, ya que en nuestra aplicación solo existirá el código para utilizar una conexión del Pool, y no nos preocupamos de dónde está alojado.

Toda la configuración se hace desde el Panel de Administración del Contenedor Java EE, el administrador del Contenedor puede ajustar el tamaño del Pool, el tiempo de expiración de la conexión, etc.

### Ventajas

- Independencia del código respecto a la conectividad con la base de datos.

- Mayor flexibilidad para configurar el Pool de Conexiones, tanto que el mismo administrador del Contenedor puede configurarlo al margen del desarrollo de la aplicación.

- No necesita del driver JDBC en la aplicación. Esta estará en el contenedor Java.

### Desventajas

- Se necesita conocer cómo se configura el Contenedor, generalmente se puede utilizar algunos scripts para realizar tal acción.

- Por la misma razón, no es estándar entre los Contenedores, para cada uno necesita de una configuración especial.

### Ejemplo

Este es el script que utiliza NetBeans para desplegar el proyecto en Payara.

<script src="https://bitbucket.org/apuntesdejava/payara-micro-demo/src/datasources/rest-demo-services/src/main/setup/glassfish-resources.xml?embed=t"></script>

### Invocación

La invocación se hace de la misma manera que los demás ejemplos anteriores, ya que es estándar. La configuración del Contenedor Java EE no lo es.

```java
<persistence-unit name="sakilaPU" transaction-type="JTA">
    <jta-data-source>jdbc/sakila</jta-data-source>
    <class>com.apuntesdejava.rest.sakila.services.Actor</class>
    <exclude-unlisted-classes>true</exclude-unlisted-classes>
    <properties>
      <property name="javax.persistence.schema-generation.database.action" value="create-or-extend-tables"/>
    </properties>
  </persistence-unit>
```

## Código fuente

El código fuente para este ejemplo, y que funciona para [Payara 4](http://www.payara.fish/), [Wildfly 10](http://wildfly.org/) y  [Apache TomEE 7](http://tomee.apache.org/) está aquí:

[https://bitbucket.org/apuntesdejava/payara-micro-demo/src/datasources/rest-demo-services/](https://bitbucket.org/apuntesdejava/payara-micro-demo/src/datasources/rest-demo-services/)

Las bases de datos que utilizo son los siguientes:

- HSQL, que está tomado del [post anterior]({{ '/2017/04/payara-micro.html' | relative_url }}). Se autocrea y siguiendo unas instrucciones se puede llenar esa base de datos.

- Apache Derby, que está tomando de la base de datos Sample que viene incluido en el JDK.

- MySQL, utilizando la base de datos [Sakila](https://dev.mysql.com/doc/sakila/en/).

## Bibliografía

- `@DataSourceDefinition` [http://docs.oracle.com/javaee/7/api/javax/annotation/sql/DataSourceDefinition.html](http://docs.oracle.com/javaee/7/api/javax/annotation/sql/DataSourceDefinition.html)

- Tomcat Docs - JNDI DataSource [http://tomcat.apache.org/tomcat-8.0-doc/jndi-datasource-examples-howto.html](http://tomcat.apache.org/tomcat-8.0-doc/jndi-datasource-examples-howto.html)

- Ejemplo de DataSourceDefinition

- web.xml [https://github.com/javaee-samples/javaee7-samples/tree/master/jpa/datasourcedefinition-webxml-pu](https://github.com/javaee-samples/javaee7-samples/tree/master/jpa/datasourcedefinition-webxml-pu)

- Anotación [https://github.com/javaee-samples/javaee7-samples/tree/master/jpa/datasourcedefinition-annotation-pu](https://github.com/javaee-samples/javaee7-samples/tree/master/jpa/datasourcedefinition-annotation-pu)

- Aplication.xml [https://github.com/javaee-samples/javaee7-samples/tree/master/jpa/datasourcedefinition-applicationxml-pu](https://github.com/javaee-samples/javaee7-samples/tree/master/jpa/datasourcedefinition-applicationxml-pu)
