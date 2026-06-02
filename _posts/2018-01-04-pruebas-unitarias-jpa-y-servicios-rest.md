---
layout: post
title: "Pruebas Unitarias a JPA y servicios REST con Arquillian + Payara. (1/4)"
date: 2018-01-04T20:02:00.002Z
last_modified_at: 2018-01-11T21:57:12.740Z
author: "Diego Silva Límaco"
permalink: /2018/01/pruebas-unitarias-jpa-y-servicios-rest.html
canonical_url: https://www.apuntesdejava.com/2018/01/pruebas-unitarias-jpa-y-servicios-rest.html
description: "Las pruebas unitarias son buenas y necesarias. Nos permiten evaluar ciertas porciones del proyecto antes de integrar y ejecutarlo todo."
tags:
  - "junit"
  - "restful"
  - "payara"
  - "maven"
  - "jpa"
  - "arquillian"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vTXEAaQGxVv5nDS2vm1iaiKUSMpB02ErtFTh9Ib4ln3ChYdhoC-7_pCtTduL8IRQhS-hUrtR2gIkRvw/pub?w=1024&h=512)](https://docs.google.com/drawings/d/e/2PACX-1vTXEAaQGxVv5nDS2vm1iaiKUSMpB02ErtFTh9Ib4ln3ChYdhoC-7_pCtTduL8IRQhS-hUrtR2gIkRvw/pub?w=1024&h=512)

Las pruebas unitarias son buenas y necesarias. Nos permiten evaluar ciertas porciones del proyecto antes de integrar y ejecutarlo todo. No vamos a esperar construir todo un auto para probar si funciona. Por tanto, solo probamos cada parte y nos aseguramos que cada prueba cumpla con ciertas características. Estas características son las que se definen en las Pruebas Unitarias. Si pasan estas características - o condiciones - recién se puede construir el proyecto.

Aprovechando las fases de construir de Maven, podemos implementar pruebas unitarias para que - si aprueban las restricciones - pueda construir el proyecto sin problema.

Pero ¿si necesitamos probar accesos a JPA o lógicas establecidas en RESTful? o más aún: ¿cómo podemos probar en un ambiente Java EE sin necesidad de desplegar un servidor Java EE? Aquí es donde entra  [Arquillian](http://t.co/rTvBREfQwn).

En esta serie de publicaciones  veremos desde preparar un ambiente Java EE para Arquillian, hasta hacer pruebas con JPA y RESTful. Al final lo integraremos para usarlo como microservicio con Payara Micro.

## Estructura del Proyecto

Todo comienza con crear un proyecto, para este post estoy usando un proyecto web.

Este tendrá la siguiente estructura (considerar los subdirectorios tal como se indica).

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg81iN7A4_i7SgWeZrbgb6AQOh6hazEuuF0Sfg6QJe1X4u4nYT1WrJhzXugO5pRa_YiOxEAYYDnq3ozdiUOdNPMr1ASsVosgtjEakYMYxD3ggSV_LQQRXV-2DEBU9dk92tkUvQ44vuoYuI/s1600/arquillian+-+estructura.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg81iN7A4_i7SgWeZrbgb6AQOh6hazEuuF0Sfg6QJe1X4u4nYT1WrJhzXugO5pRa_YiOxEAYYDnq3ozdiUOdNPMr1ASsVosgtjEakYMYxD3ggSV_LQQRXV-2DEBU9dk92tkUvQ44vuoYuI/s1600/arquillian+-+estructura.png)

El archivo index.html es un texto simple, no le vamos a dar importancia. Ahora veremos los archivos de configuración.

## Dependencias y configuración recursos del archivo pom.xml

Consideraremos las propiedades del proyecto.

```java
<properties>
        <endorsed.dir>${project.build.directory}/endorsed</endorsed.dir>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <payara.version>4.1.2.174</payara.version>
    </properties>
```

Necesitamos el administrador de dependencias para agregar Arquillian.

```java
<dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.jboss.arquillian</groupId>
                <artifactId>arquillian-bom</artifactId>
                <version>1.1.13.Final</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
```

Como usaremos JUnit, agregamos su dependencia:

```java
<dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>
```

Ahora bien, como usaremos Payara para hacer las pruebas unitarias (ya que simularemos un entorno Java EE con Payara) agregaremos las dependencias correspondientes. Arquillian está diseñado para JBoss / Wildfly, pero también permite usar Payara.

```java
<dependency>
            <groupId>fish.payara.extras</groupId>
            <artifactId>payara-embedded-all</artifactId>
            <version>${payara.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>fish.payara.api</groupId>
            <artifactId>payara-api</artifactId>
            <version>${payara.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.jboss.arquillian.container</groupId>
            <artifactId>arquillian-glassfish-embedded-3.1</artifactId>
            <version>1.0.1</version>
            <scope>test</scope>
        </dependency>
```

Y, para terminar con las dependencias, utilizamos las propias para Arquillian.

```java
<dependency>
            <groupId>org.jboss.arquillian.junit</groupId>
            <artifactId>arquillian-junit-container</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.jboss.arquillian.extension</groupId>
            <artifactId>arquillian-persistence-dbunit</artifactId>
            <version>1.0.0.Alpha7</version>
            <scope>test</scope>
        </dependency>
```

Además, el Arquillian utiliza `slf4j` para mostrar los logs del entorno, así que agregaremos solo la implementación para log4j.

```java
<dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-log4j12</artifactId>
            <version>1.7.25</version>
            <scope>test</scope>
        </dependency>
```

En la sección `<build>` debemos considerar los recursos para nuestro proyecto y para las pruebas. Son dos directorios diferentes ya que los recursos que usaremos para las pruebas no necesariamente deben ser iguales al del proyecto terminado.

```java
<resources>
            <resource>
                <directory>src/main/resources</directory>
            </resource>
        </resources>
        <testResources>
            <testResource>
                <directory>src/test/resources</directory>
            </testResource>
        </testResources>
```

# Recursos para test

Crearemos el archivo `arquillian.xml` que deberá estar dentro de `src/test/resources`. El contenido es como sigue:

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
        </configuration>
    </container>
</arquillian>
```

Como vemos, ahí establecemos el puerto para nuestro Payara de prueba. Y, como vimos hace unos párrafos, necesitamos el log4j. Para ello, crearemos dentro de la misma carpeta el archivo `log4j.properties` con el siguiente contenido.

```java
log4j.rootLogger=info, stdout
log4j.logger.com.apuntesdejava=debug

# Direct log messages to stdout
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.Target=System.out
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n
```

# Clase de prueba

Aquí comenzamos con lo interesante: las pruebas unitarias. Dentro de la carpeta `src/test/java` crearemos la clase `ArquillianTest.java`. Esa clase deber tener la notación `@RunWith(Arquillian.class)` para poder decirle al JUnit que usaremos un tester específico. Además, debemos considerar crear el archivo de despliegue que se usará en el entorno Java EE. Ese método deberá tener la anotación `@Deployment`. Y, finalmente, necesitamos las pruebas en sí. Estos métodos deben tener la anotación `@Test`. Con este código lo podremos entender mejor:

```java
package com.apuntesdejava.payara.arquillian;
,
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Tu
 */
@RunWith(Arquillian.class)
public class ArquillianTest {

    private static final Logger LOGGER = LoggerFactory.getLogger(ArquillianTest.class);

    @Deployment
    public static WebArchive createDeployment() {
        return ShrinkWrap.create(WebArchive.class, "payara-arquillian.war");
    }

    @Test
    public void test01() {
        LOGGER.info("Test 01");
    }
},
```

Y listo..!!! ¿Lo probamos?. Desde la línea de comandos (o desde nuestro IDE) ejecutamos:

```java
mvn clean test
```

Y este debe ser el resultado.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQps1zNFY8vIUbcWNfBLcAstWj-gSHyeLi5NPPS-yFpREmMzHCW814GrRsEvYYkM2ik6Tbq1gjQoXu5uuTg0k3Y-v_Yer_-7azwVigtey7hcrhDYw2ZW7Sy0PpP6QKJXVp19Eg9pL60UE/s400/arquillian+-+run+01.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQps1zNFY8vIUbcWNfBLcAstWj-gSHyeLi5NPPS-yFpREmMzHCW814GrRsEvYYkM2ik6Tbq1gjQoXu5uuTg0k3Y-v_Yer_-7azwVigtey7hcrhDYw2ZW7Sy0PpP6QKJXVp19Eg9pL60UE/s1600/arquillian+-+run+01.png)

## Conclusión

Por ahora hemos configurado el entorno de Arquillian y hemos hecho una prueba. En el siguiente post veremos cómo probamos con JPA además con carga de datos para pruebas.

## Código fuente

El código fuente para este proyecto lo puedes obtener vía git desde el siguiente repositorio:

[https://bitbucket.org/apuntesdejava/payara-arquillian](https://bitbucket.org/apuntesdejava/payara-arquillian)

## Social

### Twitter

>

Comenzaremos una serie de post para implementar pruebas unitarias con  [@arquillian_org](https://twitter.com/arquillian_org?ref_src=twsrc%5Etfw)  + [@Payara_Fish](https://twitter.com/Payara_Fish?ref_src=twsrc%5Etfw). El objetivo final: preparar un [#Microservicio](https://twitter.com/hashtag/Microservicio?src=hash&ref_src=twsrc%5Etfw) [#REST](https://twitter.com/hashtag/REST?src=hash&ref_src=twsrc%5Etfw) + [#JPA](https://twitter.com/hashtag/JPA?src=hash&ref_src=twsrc%5Etfw) sobre [#PayaraMicro](https://twitter.com/hashtag/PayaraMicro?src=hash&ref_src=twsrc%5Etfw) con pruebas de integración. Serán 4 posts, ahora veremos la configuración  [https://t.co/dMrFbCek5u](https://t.co/dMrFbCek5u)

&mdash; Apuntes de Java (@apuntesdejava) [4 de enero de 2018](https://twitter.com/apuntesdejava/status/949011053844811781?ref_src=twsrc%5Etfw)

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Facebook

<iframe src="https://web.facebook.com/plugins/post.php?href=https%3A%2F%2Fweb.facebook.com%2FApuntesDeJava%2Fposts%2F1755312547813369&width=500" width="500" height="540" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
