---
layout: post
title: "Servidor RESTful sin contenedor Java EE: Grizzly, Jersey y Maven"
date: 2016-03-03T23:55:00.001Z
last_modified_at: 2016-03-03T23:55:44.369Z
author: "Diego Silva Límaco"
permalink: /2016/03/servidor-restful-sin-contenedor-java-ee.html
canonical_url: https://www.apuntesdejava.com/2016/03/servidor-restful-sin-contenedor-java-ee.html
description: "¿Quieres implementar un servidor RESTful sin usar GlassFish, JBoss, Tomcat, Wildfly, Payara, Jetty, WebLogic ni nada parecido? ¿y en Java sin usar Node.js?   Bueno, aquí les comparto una manera de montar de montar un servidor RESTful usando Jersey pero ejecutable desde la línea de comandos."
tags:
  - "grizzly"
  - "webservices"
  - "restful"
  - "maven"
  - "jersey"
  - "netbeans"
  - "eclipse"
---

[![](https://docs.google.com/drawings/d/1Mvemz4WbeQHA3Q8i7TFSd90In8bZYcMMQRoL6YBiXg4/pub?w=378&h=283)](https://docs.google.com/drawings/d/1Mvemz4WbeQHA3Q8i7TFSd90In8bZYcMMQRoL6YBiXg4/pub?w=378&h=283)

¿Quieres implementar un servidor RESTful **sin usar** GlassFish, JBoss, Tomcat, Wildfly, Payara, Jetty, WebLogic ni nada parecido? ¿y en Java sin usar Node.js?

Bueno, aquí les comparto una manera de montar de montar un servidor RESTful usando Jersey pero ejecutable desde la línea de comandos.

Jersey tiene un arquetipo en Maven que nos prepara un proyecto listo para adaptarlo a nuestra manera.

Desde la consola del sistema operativo podemos poner este comando:

mvn archetype:generate -DarchetypeArtifactId=jersey-quickstart-grizzly2 -DarchetypeGroupId=org.glassfish.jersey.archetypes -DinteractiveMode=false -DgroupId=com.example.rest -DartifactId=restful-standalone -Dpackage=com.apuntesdejava -DarchetypeVersion=2.22.1

Y listo, tenemos preparado nuestro servidor. Nos creará una clase `Main` que será la única clase que estará en modo de servidor y configurará los servicios REST de nuestra aplicación.
<script src="https://bitbucket.org/apuntesdejava/restful-standalone/src/eced6be78988ffdc92139960f3891f3840cdcae1/src/main/java/com/apuntesdejava/restful/standalone/Main.java?embed=t"></script>

Para crear nuestro servicio, bastará con crear una clase con la anotación `@Path`

<script src="https://bitbucket.org/apuntesdejava/restful-standalone/src/eced6be78988ffdc92139960f3891f3840cdcae1/src/main/java/com/apuntesdejava/restful/standalone/MyResource.java?embed=t"></script>

## Implementando base de datos

Ahora bien, haremos que nuestro servicio utilice una base de datos. Para este ejemplo usé JPA, que tranquilamente puede correr fuera de un contenedor JavaEE. Me conecté a la base de datos de ejemplo de Java DB usando el archivo `persistence.xml`

<script src="https://bitbucket.org/apuntesdejava/restful-standalone/src/eced6be78988ffdc92139960f3891f3840cdcae1/src/main/resources/META-INF/persistence.xml?embed=t"></script>

Pero para mi aplicación necesito agregar la biblioteca del driver de Java DB, además de las dependencias necesarias para implementar JPA.

```java
<dependency>
            <groupId>org.eclipse.persistence</groupId>
            <artifactId>eclipselink</artifactId>
            <version>2.5.2</version>
        </dependency>
        <dependency>
            <groupId>org.eclipse.persistence</groupId>
            <artifactId>org.eclipse.persistence.jpa.modelgen.processor</artifactId>
            <version>2.5.2</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.derby</groupId>
            <artifactId>derbyclient</artifactId>
            <version>10.12.1.1</version>
        </dependency>
```

Ahora, hacemos las clases necesarias para usar JPA con Base de datos. Pudieron haber utilizado el que sea como Hibernate, JDBC, el que sea. Para mi comodidad usé JPA.AH! no olvidar colocar la notación `@XmlRootElement` en cada objeto que van a devolver al servicio.

## El servicio

Y bien, el servicio es bastante sencillo. Hice solo dos métodos: leer todos y obtener uno en base a un ID:

<script src="https://bitbucket.org/apuntesdejava/restful-standalone/src/eced6be78988ffdc92139960f3891f3840cdcae1/src/main/java/com/apuntesdejava/restful/standalone/CustomersService.java?embed=t"></script>

Ojo al Piojo, es necesario agregar una dependencia más para poder convertir los objetos obtenidos de la base de datos y convertirlo en JSON.

```java
<dependency>
            <groupId>org.glassfish.jersey.media</groupId>
            <artifactId>jersey-media-json-jackson</artifactId>
            <version>2.22.1</version>
        </dependency>
```

Y listo! Funciona de maravilla.

## El vídeo

¿No me creen?

Aquí el vídeo usando NetBeans
<iframe allowfullscreen="" frameborder="0" height="480" src="https://www.youtube.com/embed/GTyXugZNVoA" width="853"></iframe>

## El código fuente

Y, como en todo post de este humilde blog, comparto el código bajo git.

[https://bitbucket.org/apuntesdejava/restful-standalone](https://bitbucket.org/apuntesdejava/restful-standalone)
