---
layout: post
title: "DataSource en Jakarta EE"
date: 2022-08-31T23:24:00.001Z
last_modified_at: 2022-08-31T23:24:09.592Z
author: "Diego Silva Límaco"
permalink: /2022/08/datasource-en-jakarta-ee.html
canonical_url: https://www.apuntesdejava.com/2022/08/datasource-en-jakarta-ee.html
description: "Cómo configurar una conexión a base de datos usando DataSource en JakartaEE"
tags:
  - "jakarta ee"
  - "datasource"
  - "mysql"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vRfc64Mw7JAY2dnNrWlup38nZ-49x7AAAj454KZjek3ofpSuC3dyJsu54djCzg_WAeeEG7PniLbO3j_/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vRfc64Mw7JAY2dnNrWlup38nZ-49x7AAAj454KZjek3ofpSuC3dyJsu54djCzg_WAeeEG7PniLbO3j_/pub?w=1440&h=810)

  Para que nuestra aplicación Jakarta EE tenga conexión a la base de datos,
  debemos configurar un DataSource. No debemos usar la clase
  [java.sql.DriverManager](https://docs.oracle.com/javase/8/docs/api/java/sql/DriverManager.html), es decir, la conexión nativa a JDBC, sino, debemos usar lo que ofrece el
  servidor Jakarta EE. Aquí mostraremos dos maneras: configurando el DataSource
  en la misma aplicación, y configurando en el Servidor Jakarta EE.

## Configurando en la Aplicación

  Existen dos maneras de configurar el DataSource desde la aplicación. Si usas
  una aplicación web, usas el `web.xml` y sino puedes usas crear una
  clase con la notación
  [@DataSourceDefinition](https://jakarta.ee/specifications/platform/9.1/apidocs/jakarta/annotation/sql/DataSourceDefinition.html)

### Usando web.xml

La notación en el archivo `web.xml` es así:

```java
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_5_0.xsd"
         version="5.0">
    <data-source>
        <name>java:app/jdbc/sakila</name>
        <class-name>com.mysql.cj.jdbc.MysqlDataSource</class-name>
        <url>jdbc:mysql://localhost:23306/sakila
        <</url>
        <user>sakila</user>
        <password>sakila</password>
        <property>
            <name>allowPublicKeyRetrieval</name>
            <value>true</value>
        </property>
        <property>
            <name>serverTimezone</name>
            <value>America/Lima</value>
        </property>
        <property>
            <name>useSSL</name>
            <value>false</value>
        </property>
    </data-source>
</web-app>
```

  Asumiendo que se usa MySQL 8, se deben agregar ciertas propiedades como los
  que están al final

.

### Usando @DataSourceDefinition

En esta manera se debe crear una clase y definir la anotación como sigue:

```java
import jakarta.annotation.sql.DataSourceDefinition;
import jakarta.enterprise.context.ApplicationScoped;

@DataSourceDefinition(
        name = "java:app/jdbc/sakila",
        className = "com.mysql.cj.jdbc.MysqlDataSource",
        databaseName = "sakila",
        user = "sakila",
        password = "sakila",
        portNumber = 23306,
        properties = {
                "allowPublicKeyRetrieval=true",
                "serverTimezone=America/Lima",
                "useSSL=false"
        }

)
@ApplicationScoped
public class DataSourceProvider {
//..
}
```

  En ambos casos se está creando un DataSource con nombre
  `java:app/jdbc/sakila` y se puede consumir de la siguiente manera:

```java
@ApplicationScoped
public class DataSourceProvider {

    @jakarta.enterprise.inject.Produces
    @Resource(lookup = "java:app/jdbc/sakila")
    private DataSource dataSource;
}
```

  Y en adelante, solo lo podríamos reutilizar con un `@Inject`, por
  ejemplo:

```java
@ApplicationScoped
public class CityService {
    @Inject
    private DataSource dataSource;

    public List<CityDTO> getCitiesList() {
        List<CityDTO> citiesList = new ArrayList<>();
        try (Connection conn = dataSource.getConnection()) {
            try (Statement stmt = conn.createStatement()) {
                try (ResultSet rs = stmt.executeQuery("select  * from city")) {
                    while (rs.next()) {
                        citiesList.add(new CityDTO(rs.getInt("city_id"), rs.getString("city")));

                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citiesList;
    }
}
```

## Configurando en el servidor Jakarta EE

Para este ejemplo usaríamos Payara Server o GlassFish

### Consola Web admin

  El paso más largo es hacer visualmente siguiendo los pasos para crear tanto el
  Pool, como el Recurso. En el vídeo se puede ver mejor.

### Comandos create-jdbc-connection-pool y create-jdbc-resource

  Estos comandos pueden ser un script que se pueden ejecutar desde el
  `asadmin`. Tienen todos los parámetros que van para crear tanto el
  pool como el recurso:

```java
create-jdbc-connection-pool --ping=true --pooling=true --restype=javax.sql.DataSource --datasourceclassname=com.mysql.cj.jdbc.MysqlDataSource --property user=sakila:password=sakila:serverName=localhost:port=23306:databaseName=sakila:allowPublicKeyRetrieval=true:serverTimezone=America/Lima:useSSL=false SakilaPool

create-jdbc-resource --connectionpoolid SakilaPool jdbc/sakila
```

### XML de recursos + comando add-resources

  Otra manera es crear un archivo `.xml` con la configuración de
  todos los parámetros del Pool y del Recurso y ejecutarlo desde el
  `asadmin` con el comando `add-resources`. Este es un
  ejemplo del archivo `resources.xml`:

```java
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<resources>
    <jdbc-resource jndi-name="jdbc/sakila" pool-name="SakilaPool"/>
    <jdbc-connection-pool datasource-classname="com.mysql.cj.jdbc.MysqlDataSource" name="SakilaPool" resType="javax.sql.DataSource">
        <property name="url" value="jdbc:mysql://localhost:23306/sakila"/>
        <property name="user" value="sakila"/>
        <property name="password" value="sakila"/>
        <property name="allowPublicKeyRetrieval" value="true"/>
        <property name="serverTimezone" value="America/Lima"/>
        <property name="useSSL" value="false"/>
    </jdbc-connection-pool>
</resources>
```

En ambos casos, se está creando el recurso con el nombre `jdbc/sakila` y la manera de consumirlo es:

```java
@ApplicationScoped
public class DataSourceProvider {

    @jakarta.enterprise.inject.Produces
    @Resource(lookup = "jdbc/sakila")
    private DataSource dataSource;
}
```

Y todo sigue igual

## Vídeo

El vídeo con más detalle se encuentra aquí.

<iframe allowfullscreen="" class="BLOG_video_class" height="324" src="https://www.youtube.com/embed/u-skqqdLfIQ" width="506" youtube-src-id="u-skqqdLfIQ"></iframe>
