---
layout: post
title: "Maven: Crear app .jar ejecutable con bibliotecas dependientes"
date: 2015-02-17T16:40:00.002Z
last_modified_at: 2015-02-17T16:49:00.298Z
author: "Diego Silva Límaco"
permalink: /2015/02/maven-crear-app-jar-ejecutable-con.html
canonical_url: https://www.apuntesdejava.com/2015/02/maven-crear-app-jar-ejecutable-con.html
tags:
  - "java"
  - "maven"
  - "trucos"
---

[![Maven: Crear app .jar ejecutable con bibliotecas dependientes](http://maven.apache.org/images/maven-logo-2.gif)](http://maven.apache.org/images/maven-logo-2.gif)

Lo que me gusta de NetBeans es que - al usar su propia creación de proyectos basado en [Apache Ant](http://ant.apache.org/) - es que crea una carpeta llamada `dist` que tiene todo lo necesario para que pueda ser distribuido y ejecutado en cualquier computador que tenga JVM. Hace un tiempo hice un post que ampliaba esta funcionalidad para que al final quedara todo empaquetado en un archivo zip: [Empaquetar una aplicación para distribuir, desde NetBeans](/2010/06/empaquetar-una-aplicacion-para.html). Ahora que estoy usando un poco más de [Maven](http://maven.apache.org/), noté que eso prepara los archivos como lo hacía con Ant. No los culpo... pero quiero hacer algo igual!.

Ok, por ahora no podré empaquetarlo en un archivo .zip, pero al menos quisiera que esté el .jar listo para ser ejecutado con el comando `java -jar MiApp.jar` y que incluya los .jars necesarios para mi ejecución.

Así que, googleando, encontré esto:

Agregar estos tags en el archivo `pom.xml` (dentro de la sección plugins, o crear el tag para plugins

```java
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-dependency-plugin</artifactId>
    <executions>
        <execution>
            <id>copy-dependencies</id>
            <phase>prepare-package</phase>
            <goals>
                <goal>copy-dependencies</goal>
            </goals>
            <configuration>
                <outputDirectory>${project.build.directory}/lib</outputDirectory>
                <overWriteReleases>false</overWriteReleases>
                <overWriteSnapshots>false</overWriteSnapshots>
                <overWriteIfNewer>true</overWriteIfNewer>
            </configuration>
        </execution>
    </executions>
</plugin>
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-jar-plugin</artifactId>
    <configuration>
        <archive>
            <manifest>
                <addClasspath>true</addClasspath>
                <classpathPrefix>lib/</classpathPrefix>
                <mainClass>theMainClass</mainClass>
            </manifest>
        </archive>
    </configuration>
</plugin>
```

Y Voila! Crea la carpeta lib con todos los jars necesarios, y luego distribuimos el archivo .jar de la aplicación, junto con el contenido de la carpeta lib.

Aquí tengo el código fuente de ejemplo. Espero que les sea de utilidad:;

[https://bitbucket.org/apuntesdejava/blog/src/tip/sample-dist-app/](https://bitbucket.org/apuntesdejava/blog/src/tip/sample-dist-app/)

Este ejemplo permite reproducir una pista MP3, y como es Java es multiplataforma :)

Así que para ejecutarlo desde una línea de comandos (sea Linux, Mac o Windows) se ejecutará así

```java
java -jar sample-dist-app.jar
```

Aquí está el archivo `pom.xml` con el ejemplo que mencioné. He agregado a partir de la línea 20:

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/sample-dist-app/pom.xml?embed=t"></script>

Y me basé de este post:

[http://stackoverflow.com/questions/574594/how-can-i-create-an-executable-jar-with-dependencies-using-maven#4323501](http://stackoverflow.com/questions/574594/how-can-i-create-an-executable-jar-with-dependencies-using-maven#4323501)

Si te gusta, hazlo saber; y si te es útil, comparte.. es gratis
