---
layout: post
title: "CodeHaus Cargo - Ejecutando aplicaciones Jakarta EE sin descargar servidores"
date: 2025-05-17T19:28:00.002Z
last_modified_at: 2025-05-17T19:28:55.287Z
author: "Diego Silva Límaco"
permalink: /2025/05/codehaus-cargo-ejecutando-aplicaciones.html
canonical_url: https://www.apuntesdejava.com/2025/05/codehaus-cargo-ejecutando-aplicaciones.html
description: "En este ejemplo ejecutaremos una aplicación bastante sencilla, con un CRUD simple para RESTful (usaremos base de datos h2) y lo trataremos de ejecutar"
tags:
  - "apache"
  - "tomee"
  - "jakarta ee"
  - "payara"
  - "wildfly"
---

[![](https://i.imgur.com/hWHXVSA.png)](https://i.imgur.com/hWHXVSA.png)

Una de las tantas dificultas que tiene un desarrollador de Jakarta EE es
el configurar un servidor de - justamente - Jakarta EE. Aparte que existe varias
como GlassFish, JBoss, Resin, Tomcat / TomEE, WebLogic, Wildfly (y de más), lo
más complicado es:

- Descargar

- Configurar

  Pues en este artículo vamos a conocer un plugin que ha reducido el dolor de
  cabeza. Se llama Code Haus Cargo.

  En este ejemplo ejecutaremos una aplicación bastante sencilla, con un CRUD
  simple para RESTful (usaremos base de datos h2) y lo trataremos de ejecutar en
  Apache TomEE y en WebLogic.

## Proyecto Base

El proyecto base es el siguiente:

  [https://github.com/apuntesdejava/jakarta-ee-cargo](https://github.com/apuntesdejava/jakarta-ee-cargo)

Tiene un código bastante simple que tiene un endpoint:

<iframe allow="clipboard-write" frameborder="0" scrolling="no" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fapuntesdejava%2Fjakarta-ee-cargo%2Fblob%2Fsimple%2Fsrc%2Fmain%2Fjava%2Fcom%2Fapuntesdejava%2Fcargoexample%2Fapp%2Fresources%2FPersonResource.java&amp;style=default&amp;type=code&amp;showBorder=on&amp;showLineNumbers=on&amp;showFileMeta=on&amp;showFullPath=on&amp;showCopy=on&amp;fetchFromJsDelivr=on" style="height: 982px; width: 100%;"></iframe>

Y un JPA:

<iframe allow="clipboard-write" frameborder="0" scrolling="no" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fapuntesdejava%2Fjakarta-ee-cargo%2Fblob%2Fsimple%2Fsrc%2Fmain%2Fjava%2Fcom%2Fapuntesdejava%2Fcargoexample%2Finfrastructure%2Fjpa%2Frepository%2FPersonEntityRepository.java&amp;style=default&amp;type=code&amp;showBorder=on&amp;showLineNumbers=on&amp;showFileMeta=on&amp;showFullPath=on&amp;showCopy=on&amp;fetchFromJsDelivr=on" style="height: 730px; width: 100%;"></iframe>

  La base de datos será agnóstica, tanto así que no la estaré configurando en el
  proyecto. Solo tengo esta configuración:

<iframe allow="clipboard-write" frameborder="0" scrolling="no" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fapuntesdejava%2Fjakarta-ee-cargo%2Fblob%2Fsimple%2Fsrc%2Fmain%2Fresources%2FMETA-INF%2Fpersistence.xml&amp;style=default&amp;type=code&amp;showBorder=on&amp;showLineNumbers=on&amp;showFileMeta=on&amp;showFullPath=on&amp;showCopy=on&amp;fetchFromJsDelivr=on" style="height: 394px; width: 100%;"></iframe>

## Cargo

  Ahora bien, cuando uso un IDE, ya sea IntelliJ, NetBeans o VisualStudio Code
  he tenido problemas para ejecutar el proyecto en un servidor Jakarta EE. Los
  problemas son los siguientes

- Configurar el servidor en el mismo IDE

- Configurar la conexión de base de datos en el Servidor

- Ejecutar el servidor desde el IDE

  Si me siguen desde hace un tiempo, sabrán que soy muy seguir de Payara... y su
  servidor no me funciona en los IDEs, ni menos en el (también bien usado IDE
  por mí) NetBeans. Así que estaba buscando una manera de cómo ejecutarlo de
  manera transparente. Pensé en Docker, pero aún debo configurar por cada uno de
  ellos.... hasta que conocí a Codehaus Cargo!.

Sin mucha vuelta, vamos al grano.

  Cargo tiene muchas maneras de ejecutarse, pero vamos al más simple: un plugin
  de Maven.

  Del mismo proyecto que hemos creado, vamos a agregar al
  `pom.xml` un perfil (para no modificar la funcionalidad normal del
  proyecto)

  Este es el extracto del perfil, con comentarios para explicar qué hace cada
  parte

```java
<profile>
            <id>local-cargo</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.codehaus.cargo</groupId>
                        <artifactId>cargo-maven3-plugin</artifactId>
                        <version>1.10.19</version>
                        <configuration>
                            <containerId>tomee10x</containerId> <!-- el nombre del contenedor -->
                            <container>
                                <contextKey>${project.artifactId}</contextKey> <!-- el contexto de la aplicación -->
                                <dependencies> <!-- las dependencias que se incluir en el servidor -->
                                    <dependency>
                                        <groupId>org.hsqldb</groupId>
                                        <artifactId>hsqldb</artifactId>
                                    </dependency>
                                </dependencies>
                                <log>${project.build.directory}/cargo.log</log> <!-- quiero ver un log -->
                                <logLevel>DEBUG</logLevel>

                            </container>
                            <configuration>
                                <datasources> <!-- configuro la conexión a la base de datos -->
                                    <datasource>
                                        <jndiName>jdbc/person</jndiName>
                                        <connectionType>javax.sql.Driver</connectionType>
                                        <driverClass>org.hsqldb.jdbc.JDBCDriver</driverClass>
                                        <url>jdbc:hsqldb:mem:persondb</url>
                                        <username>sa</username>
                                        <password>sa</password>
                                    </datasource>
                                </datasources>
                                <properties>
                                    <cargo.logging>high</cargo.logging>
                                </properties>
                            </configuration>
                        </configuration>
                    </plugin>
                </plugins>
            </build>
        </profile>
```

  La configuración no es difícil de seguirle el rastro. Es fácil de entender

Lo que me sorprende de esta configuración es lo siguiente

-
    Solo le digo que se tratará de, en este caso, tomee10x (línea 68) y Cargo se
    encargará de bajar el contenedor adecuado, y en adelante, todas las
    configuraciones serán respecto a ese contenedor.

-
    No me debo preocupar dónde debo colocar la biblioteca del JDBC. Solo le digo
    que deba incluirlo (línea 72) y Cargo se encargará.

-
    Le digo que utilice un DataSource (línea 83) y Cargo, conociendo que se
    trata de Tomee (en este caso) se encargará de configurar todo para este
    proyecto

Ahora, probemos cómo funciona

## Ejecución del proyecto

  Como ahora está dentro de un perfil, necesitamos activar el proyecto, y
  ejecutamos el goal `cargo:run`

![](https://i.imgur.com/yiAGCov.png)

Ejecutando...

  Cuando ya aparezca este mensaje, es porque ya está corriendo el contenedor
  Java

  [![](https://i.imgur.com/OhePno0.png)](https://i.imgur.com/OhePno0.png)

¿Lo probamos?

  [![](https://i.imgur.com/HVHdXci.png)](https://i.imgur.com/HVHdXci.png)

## Otro contenedor Java

  Podemos cambiar a cualquier contenedor (servidor) Java que nos proporciona
  Cargo según esta lista: https://codehaus-cargo.github.io/cargo/Home.html

  Si bien ya hay servidores descontinuados, al menos da soporte a algunos
  nuevos. Entre ellos están:

- Payara

- Apache Tomee

- Apache Tomcat

- Wildfly

- Open Liberty (con el nombre WebSphere Liberty)

  Ahora bien ¿cómo cambiar de servidor? Pues solo cambiar el valor del tag
  `containerId` con alguno que está en la tabla de Cargo. Nada más.

  Para que sea más simple nuestro trabajo, vamos a
  parametrizar. Ese valor lo pondremos como propiedad de Maven

```java
<properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.release>21</maven.compiler.release>
        <junit.version>5.12.2</junit.version>
        <org.hsqldb.version>2.7.4</org.hsqldb.version>
        <containerId>tomee10x</containerId>
    </properties>
```

Ahora, lo ponemos en el plugin

```java
<groupId>org.codehaus.cargo</groupId>
                        <artifactId>cargo-maven3-plugin</artifactId>
                        <version>1.10.19</version>
                        <configuration>
                            <containerId>${containerId}</containerId>
                            <container>
```

Y ejecutamos

[![](https://i.imgur.com/UBVtHrf.png)](https://i.imgur.com/UBVtHrf.png)

Y ya está:

[![](https://i.imgur.com/LNJvImz.png)](https://i.imgur.com/LNJvImz.png)

Y si probamos, nuevamente, los comandos al endpoint, nos dará el mismo resultado

[![](https://i.imgur.com/5WXcmKe.png)](https://i.imgur.com/5WXcmKe.png)

Como se puede ver, la cabecera que devuelve en la respuesta ya dice "Payara" a diferencia del anterior que decía "Apache TomEE"

¿Cuánto modifiqué en el proyecto?

**¡NADA!**

## ¿Cómo funciona?

Toda la magia se hace dentro de la carpeta target. Dentro se crea la carpeta cargo. Allí se descargan y descomprimen los contenedores (servidores) Java.

[![](https://i.imgur.com/lCrK90x.png)](https://i.imgur.com/lCrK90x.png)

En la carpeta installs es la versión descargada, y en la carpeta configurations están la instancias (dominio) para ejecutar el proyecto. Por ello no modificar el contenedor, sino utiliza una configuración.

Si deseas ver el log, pues solo toca ver el log en cada configuración.

Por ejemplo, para Payara es:

[![](https://i.imgur.com/QloaeXW.png)](https://i.imgur.com/QloaeXW.png)

Y para Apache TomEE:

[![](https://i.imgur.com/BqnWvos.png)](https://i.imgur.com/BqnWvos.png)

Si notamos, ahí se ve dónde se pegaron el .jar del JDBC.

Ah, adicionalmente está el log que le pusimos para ver la ejecución del Cargo. Eso lo configuramos dentro de target.

[![](https://i.imgur.com/f8H4Sie.png)](https://i.imgur.com/f8H4Sie.png)

Espero que te haya gustado este post

## Recursos

El proyecto completo lo encontrarás aquí:

- Código base: [https://github.com/apuntesdejava/jakarta-ee-cargo/tree/simple](https://github.com/apuntesdejava/jakarta-ee-cargo/tree/simple)
- Código con Cargo: [https://github.com/apuntesdejava/jakarta-ee-cargo/tree/cargo](https://github.com/apuntesdejava/jakarta-ee-cargo/tree/cargo)
