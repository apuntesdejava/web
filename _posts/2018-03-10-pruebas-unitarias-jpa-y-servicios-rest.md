---
layout: post
title: "Pruebas Unitarias a JPA y servicios REST con Arquillian + Payara. (4/4) - Empaquetando el Servicio"
date: 2018-03-10T06:30:00.001Z
last_modified_at: 2018-03-10T06:30:57.528Z
author: "Diego Silva Límaco"
permalink: /2018/03/pruebas-unitarias-jpa-y-servicios-rest.html
canonical_url: https://www.apuntesdejava.com/2018/03/pruebas-unitarias-jpa-y-servicios-rest.html
tags:
  - "restful"
  - "microservicios"
  - "payara"
  - "payaramicro"
  - "jakarta ee"
  - "java ee"
---

[![]({{ '/assets/blogger/79-focus.png' | relative_url }})]({{ '/assets/blogger/79-focus.png' | relative_url }})

Ya hemos desarrollado el servicio, con acceso a base de datos, lógica de negocio, lo hemos probado tanto a nivel de EJB de base de datos, como probando el servicio REST.

Ahora nos toca empaquetarlo todo en un solo .jar para poderlo ejecutar como servicio autónomo.

## Conexión a la base de datos

Hasta ahorita la conexión a la base de datos era ficticia. Bueno, era una conexión real, pero la base de datos y el contenido era falso, porque eran para las pruebas funcionales.

Ahora nos toca crear la verdadera conexión a base de datos para producción.

Crearemos la base de datos, y para este ejemplo, usaremos MySQL, con los siguientes valores:

- Base de datos: store

- Usuario: store

- Contraseña: store

Listo. Seguimos con realizar la conexión a la base de datos. Como estamos bajo el estándar de Java EE Jakarta EE, utilizaremos un DataSource para que la conexión lo gestione el servidor que es Payara Micro. Crearemos el archivo `web.xml` y colocaremos el siguiente contenido:

```java
<?xml version="1.0" encoding="UTF-8"?>

<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
  version="3.1">
    <session-config>
        <session-timeout>
            30
        </session-timeout>
    </session-config>
    <data-source>
        <name>java:app/store</name>
        <class-name>com.mysql.jdbc.jdbc2.optional.MysqlXADataSource</class-name>
        <url>jdbc:mysql://localhost/store</url>
        <user>store</user>
        <password>store</password>
    </data-source>
</web-app>
```

Notemos que esta declaración es la estándar. No necesitamos configurar la conexión (ni el pool ni el recurso) en el Payara Micro, porque no tendremos una línea de comandos (ni menos una consola web) para crear la conexión. Aunque hay maneras de crearlas al ejecutar el microservicio, pero por ahora nos bastará con realizar la conexión desde el archivo `web.xml`. No faltará uno que diga: pero la conexión debería ser parametrizada por un archivo externo... sí, tienes razón, pero eso lo veremos en otro momento.

## Unidad de persistencia

Hasta ahora, la unidad de persistencia creada era únicamente para las pruebas, no existe nada real hasta ahora. Así que, crearemos el archivo `persistence.xml` con el siguiente contenido:

```java
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.1" xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence              http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
  <persistence-unit name="storePU" transaction-type="JTA">
    <jta-data-source>java:app/store</jta-data-source>
    <shared-cache-mode>ALL</shared-cache-mode>
    <properties>
      <property name="hibernate.hbm2ddl.auto" value="update"/>
      <property name="javax.persistence.schema-generation.database.action" value="create"/>
    </properties>
  </persistence-unit>
</persistence>
```

Debemos remarcar lo siguiente:

- La línea 3 debe mantener el mismo nombre de la unidad (`storePU`) que nuestra unidad para pruebas, ya que nuestros EJB utilizan ese mismo nombre de unidad.

- La línea 4 es la conexión a la base de datos creada en el archivo `web.xml`, tal cual.

## El perfil para distribuir

He trabajado con maneras más complejas para crear el archivo resultante, pero en este ejemplo dejaré lo más básico posible con tal de generar nuestro microservicio ejecutable.

Para ello, necesitamos crear un perfil en el `pom.xml` llamado `dist` de tal manera que al ejecutar el maven con ese perfil, se prepare el archivo `.jar` con todo lo necesario para ejecutarse.

Este perfil también debe contar con la biblioteca de la base de datos, en este caso, de MySQL.

Además, el log debería ser simple, no al detalle como lo es el modo debug. Ya no necesitaríamos el Log4j.

```java
<profiles>
        <profile>
            <id>dist</id>

<!-- aqui pondremos lo demas -->
        </profile>
    </profiles>
```

### Dependencias

Las dependencias para este perfil son como sigue: MySQL y slf4j-simple

```java
<profiles>
        <profile>
            <id>dist</id>
            <dependencies>
                <dependency>
                    <groupId>org.slf4j</groupId>
                    <artifactId>slf4j-simple</artifactId>
                    <version>1.7.25</version>
                </dependency>
                <dependency>
                    <groupId>mysql</groupId>
                    <artifactId>mysql-connector-java</artifactId>
                    <version>5.1.45</version>
                </dependency>

            </dependencies>
```

### La creación del empaquetado y del Uber jar

Aquí es donde se empaqueta todo, se prepara el uber jar con todo el .war generado y metido con el mismo Payara Micro:

```java
<build>
                <plugins>
                    <!-- Copy project dependency -->
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-dependency-plugin</artifactId>
                        <version>3.0.2</version>
                        <executions>
                            <execution>
                                <id>copy-payara-micro</id>
                                <goals>
                                    <goal>copy</goal>
                                </goals>
                                <configuration>
                                    <outputDirectory>target</outputDirectory>
                                    <stripVersion>true</stripVersion>
                                    <silent>true</silent>
                                    <artifactItems>
                                        <artifactItem>
                                            <groupId>fish.payara.extras</groupId>
                                            <artifactId>payara-micro</artifactId>
                                            <type>jar</type>
                                        </artifactItem>
                                    </artifactItems>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                    <plugin>
                        <groupId>org.codehaus.mojo</groupId>
                        <artifactId>exec-maven-plugin</artifactId>
                        <version>1.6.0</version>
                        <dependencies>
                            <dependency>
                                <groupId>fish.payara.extras</groupId>
                                <artifactId>payara-micro</artifactId>
                                <version>${payara.version}</version>
                            </dependency>
                        </dependencies>
                        <executions>

                            <execution>
                                <id>payara-uber-jar</id>
                                <phase>package</phase>
                                <goals>
                                    <goal>exec</goal>
                                </goals>
                                <configuration>
                                    <executable>java</executable>
                                    <arguments>
                                        <argument>-jar</argument>
                                        <argument>target/payara-micro.jar</argument>
                                        <argument>--port</argument>
                                        <argument>9595</argument>
                                        <argument>--logo</argument>
                                        <argument>--nocluster</argument>
                                        <argument>--deploy</argument>
                                        <argument>${basedir}/target/${project.build.finalName}.war</argument>
                                        <argument>--outputuberjar</argument>
                                        <argument>${basedir}/target/${project.build.finalName}.jar</argument>
                                    </arguments>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
```

Para más detalle de este archivo de configuración, lo puedes revisar en la sección final del post [Ejemplos de Microservicios con Java]({{ '/2017/12/ejemplos-de-microservicios-con-java.html' | relative_url }}).

## Creamos el archivo .jar

Listo!. crearemos el paquete con el siguiente comando desde la consola.

```java
mvn clean package -P dist
```

El comando pasará por las etapas de construcción, prueba y empaquetado.

[![]({{ '/assets/blogger/2018-03-10_01-08-57.png' | relative_url }})]({{ '/assets/blogger/2018-03-10_01-08-57.png' | relative_url }})

## Ejecución del microservicio.

Ya tenemos el jar. Solo nos bastará con ejecutarlo como un .jar cualquiera. Como se generó en la carpeta `target`, entraremos allí y ejecutamos:

```java
target target
java -jar payara-arquillian-1.0.jar
```

Y vemos que se ejecute:

[![]({{ '/assets/blogger/2018-03-10_01-13-59.png' | relative_url }})]({{ '/assets/blogger/2018-03-10_01-13-59.png' | relative_url }})

 Incluso, podemos revisar si el servicio se ha conectado a la base de datos utilizando el pool de conexiones. Podemos revisar esto en el MySQL:

[![]({{ '/assets/blogger/2018-03-10_01-17-05.png' | relative_url }})]({{ '/assets/blogger/2018-03-10_01-17-05.png' | relative_url }})

## Invocando al servicio

Nos aseguramos de que la base de datos tenga la información necesaria. Yo generé data con [https://www.mockaroo.com/](https://www.mockaroo.com/) Lo recomiendo.

Pues bien, ahora invocamos el servicio (yo lo haré usando httpie) y este es el resultado.

[![]({{ '/assets/blogger/2018-03-10_01-27-53.png' | relative_url }})]({{ '/assets/blogger/2018-03-10_01-27-53.png' | relative_url }})

## Código fuente

El código fuente de la aplicación para este tutorial está disponible aquí

[https://bitbucket.org/apuntesdejava/payara-arquillian/src](https://bitbucket.org/apuntesdejava/payara-arquillian/src)
