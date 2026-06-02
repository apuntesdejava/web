---
layout: post
title: "Payara + MySQL en contenedores"
date: 2022-02-05T01:24:00.001Z
last_modified_at: 2022-02-05T01:24:57.429Z
author: "Diego Silva Límaco"
permalink: /2022/02/payara-mysql-en-contenedores.html
canonical_url: https://www.apuntesdejava.com/2022/02/payara-mysql-en-contenedores.html
description: "Colocamos una aplicación Jakarta EE en un contenedor con Payara y MySQL."
tags:
  - "payara"
  - "jakarta ee"
  - "mysql"
  - "contenedores"
  - "docker"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vRh3kq3K3f7GUDAWNIEHd_WCF91SNhBFj9-0i1bthLAnCc7YlqqVV_LDvUgif0dZW5XiQNKhoZ2TN51/pub?w=960&h=540)](https://docs.google.com/drawings/d/e/2PACX-1vRh3kq3K3f7GUDAWNIEHd_WCF91SNhBFj9-0i1bthLAnCc7YlqqVV_LDvUgif0dZW5XiQNKhoZ2TN51/pub?w=960&h=540)

 Seguimos con la contenedir.. bueno, poniendo todo en contenedores. Ahora, una aplicación que estaba desarrollando en vivo, una aplicación Jakarta EE (con EJB, JPA y JSF) lo he puesto para que, en desarrollo, se pueda ejecutar en un Payara normal del IDE, y que también pueda ejecutarse en contenedores. Aquí explicaré un poco de cómo se logra esto, y un breve repaso a la organización de la aplicación.

## ¿Por qué EJB?¿ Aún sirve? ¡Es antiguo!

Es posible que me digas eso, ¿para qué usar EJB? Bueno, lo que estoy desarrollando a futuro es una aplicación bien modulada, de tal manera que no haya dependencia, y utilizando todas las tecnologías de Jakarta EE. y Sí, EJB aún funciona, ahora va en la versión 4 del Jakarta EE 9. Pero para este ejemplo usaré aún el Payara 5 que utiliza Jakarta EE 8.

## Código fuente

Comenzaré esta vez publicando primero el código fuente para que se tome de referencia, y poco a poco iré explicando de cómo funciona esto.

[https://bitbucket.org/apuntesdejava/sales-manager/src/develop/](https://bitbucket.org/apuntesdejava/sales-manager/src/develop/)

## Estructura del Proyecto

Este código fuente se compone de tres sub proyectos, que son

- `sales-manager-api` que contiene todas las clases entidad, y las interfaces para los EJB remoto que se utilizará en el módulo web, por ejemplo:

```java
package com.apuntesdejava.salesmanager.api;

import com.apuntesdejava.salesmanager.model.Category;
import java.util.List;
import java.util.Set;
import javax.ejb.Remote;

/**
 *
 * @author Diego Silva <diego.silva at apuntesdejava.com>
 */
@Remote
public interface CategoryService {

    List<Category> listAll();

    Category create(Category model);

    Set<Category> create(Category... model);

    boolean deleteById(Long key);

    Category findById(Long key);

    Category update(Long key, Category model);
}
```

 Notar la línea 12, donde se hace la anotación `@Remote`. Es muy importante para poderlo invocar desde el módulo web.

-
    `sales-manager-ejb` donde se implementa las interfaces del módulo `sales-manager-api`, y también tiene los repositorios de acceso a la base de datos. Las implementaciones de las interfaces se declaran con una anotación - en este caso - `@Statless`

```java
package com.apuntesdejava.salesmanager.logic;

import com.apuntesdejava.salesmanager.api.CategoryService;
import com.apuntesdejava.salesmanager.model.Category;
import com.apuntesdejava.salesmanager.repository.CategoryRepository;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author Diego Silva <diego.silva at apuntesdejava.com>
 */
@Stateless
public class CategoryServiceImpl extends AbstractService<Long, Category> implements CategoryService {

    @EJB
    private CategoryRepository repository;

    @Override
    protected CategoryRepository getRepository() {
        return repository;
    }

}
```

  Los demás métodos están implementados en la clase `AbstractService`. Aquí aplico la herencia y polimorfismo 😎.

- y finalmente `sales-manager-web` que es la aplicación web con JSF. Aquí utilizo la implementación PrimeFaces 11. Si luce feo, es porque no le puse mucho dedicación a la interfaz, ya que la idea aquí es probar la utilización de contenedores.

## Requisitos

Para poder ejecutar esta aplicación desde el ambiente local, es necesario tener una base de datos (que puede ser MySQL) y tener configurado un recurso JDBC llamado `jdbc/sales`. Eso ya lo dejamos del lado de la configuración. No iré muy al fondo en esto, ya lo que lo demostraré en un vídeo.

## Preparando el contenedor

Ahora bien, lo importante aquí es la preparación del contenedor. Usaremos MySQL y también Payara 5. El archivo [docker-compose.yml](https://bitbucket.org/apuntesdejava/sales-manager/src/develop/containers/payara/docker-compose.yml) está bien claro de cómo estarán estructurados los servicios, pero igual lo explicaré más abajo:

```java
version: '3.8'
services:
  payara-server:
    depends_on:
      - mysql.8
    image: payara/server-full:5.2021.10-jdk11
    environment:
        LANGUAGE: es_PE:es
        LANG: es_PE.UTF-8
        LC_ALL: es_PE.UTF-8
    ports:
      - '18080:8080'
      - '14848:4848'
    volumes:
      - ./config/post-boot-commands.asadmin:/opt/payara/config/post-boot-commands.asadmin
      - ./domains/domain1/lib:/opt/payara/appserver/glassfish/domains/domain1/lib
      - ./deployments:/opt/payara/deployments
    networks:
        - salesnet
  mysql.8:
      container_name: mysql_sales
      image: mysql:latest
      environment:
          MYSQL_ROOT_PASSWORD: root
          TZ: America/Lima
          MYSQL_USER: sales
          MYSQL_PASSWORD: sales
          MYSQL_DATABASE: sales
      ports:
          - '3316:3306'
      command: --init-file /data/application/init.sql
      volumes:
          - ./mysql-volumes:/var/lib/mysql
          - ./init.sql:/data/application/init.sql
      networks:
          - salesnet
networks:
    salesnet:
```

- Línea 6, usaremos la versión full de Payara 5, pero con el JDK 11
- Línea 11 al 13, estos son los puertos desde donde podremos acceder, para la aplicación (18080) y para el administrador (14848)
- Líneas 14 al 17, son los volumenes que se incorporarán en payara, pero haré unas explicaciones:

- Línea 15 es [un archivo de texto plano con los comandos](https://bitbucket.org/apuntesdejava/sales-manager/src/develop/containers/payara/config/post-boot-commands.asadmin) que se ejecutarán después de que inicie Payara. Como podrán ver, son comandos en el `asadmin`
- Línea 16 es donde se colocarán archivos principales para que la aplicación funcione, como es el driver de MySQL, una biblioteca de common y el API
- Línea 17 es la ubicación donde colocaré los archivos para desplegar: el .jar con la implementación del EJB y el .war de la aplicación web

- A partir de la línea 20 es el servicio de MySQL.
- La línea 30, es el puerto para que podamos acceder desde fuera del contenedor.
- La línea 21 es el comando que se ejecutará al iniciar el servicio. Este archivo está montado en la línea 34. El [contenido](https://bitbucket.org/apuntesdejava/sales-manager/src/develop/containers/payara/init.sql) indica la creación de la base de datos y la asignación del usuario a esa base de datos.

```java
CREATE DATABASE IF NOT EXISTS sales;
GRANT ALL ON sales.* to sales@"%";
```

Todos esos archivos como mencionados ya están en el repositorio. Y, las otras carpetas que se utilizán en los volúmenes se crearán al iniciar los servicios.

## Estrategia de despliegue

Como mencioné líneas arriba, los archivos que necesitamos, que son justamente: el .jar del API, el .jar de los EJB y el .war de la aplicación web, deben estar en lugares específicos para que funcione correctamente. Así que, pensaba hacer este tutorial explicando dónde colocar qué, poner un .bat o un bash para que ejecutasen... pero lo más sano sería sea de manera automática, así que lo explicaré así:

 Dos archivos `pom.xml` tienen un perfil que, si se le indica, copiará los archivos en las ubicaciones establecidas. Entonces, estos `pom.xml` están preparados para este proyecto. Si desean hacerlo a su manera, pues modifiquen las rutas. Este es un ejemplo para sus futuros proyectos.

### sales-manager-ejb/pom.xml

El perfil se llama `payara` (Esto es, porque usaré payara. En el futuro modificaré un poco para que funcione con otro servidor Jakarta EE).

```java
<profile>
            <id>payara</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-dependency-plugin</artifactId>
                        <version>3.2.0</version>
                        <executions>
                            <execution>
                                <id>copy-libs</id>
                                <phase>prepare-package</phase>
                                <goals>
                                    <goal>copy</goal>
                                </goals>
                                <configuration>
                                    <outputDirectory>${basedir}/../containers/payara/domains/domain1/lib
                                    </outputDirectory>
                                    <stripVersion>true</stripVersion>
                                    <artifactItems>
                                        <artifactItem>
                                            <groupId>mysql</groupId>
                                            <artifactId>mysql-connector-java</artifactId>
                                            <version>8.0.28</version>
                                        </artifactItem>
                                        <artifactItem>
                                            <groupId>org.apache.commons</groupId>
                                            <artifactId>commons-lang3</artifactId>
                                            <version>3.12.0</version>
                                        </artifactItem>
                                        <artifactItem>
                                            <groupId>com.apuntesdejava.salesmanager.api</groupId>
                                            <artifactId>sales-manager-api</artifactId>
                                            <version>1.0-SNAPSHOT</version>
                                        </artifactItem>
                                    </artifactItems>
                                </configuration>
                            </execution>
                            <execution>
                                <id>copy-ejb</id>
                                <phase>verify</phase>
                                <goals>
                                    <goal>copy</goal>
                                </goals>
                                <configuration>
                                    <outputDirectory>${basedir}/../containers/payara/deployments
                                    </outputDirectory>
                                    <stripVersion>true</stripVersion>
                                    <artifactItems>
                                        <artifactItem>
                                            <groupId>${project.groupId}</groupId>
                                            <artifactId>${project.artifactId}</artifactId>
                                            <version>${project.version}</version>
                                        </artifactItem>
                                    </artifactItems>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
```

Explicación:

- Línea 80 ejecuto el primer bloque de copia. En la línea 82 indica que lo hará en la fase prepare-package, es decir, antes de install.
- En la línea 87 indica que se copiará en la carpeta "padre" y luego dentro de `containers/payara/domains/domain1/lib`. Esto es el directorio de las bibliotecas para Payara ¿qué se va a copiar? Pues están entre las líneas 90 y 106. Como ven, se trata del API de los servicios (Línea 103), el Driver de MySQL (Línea 93) y una biblioteca de apoyo para el EJB
- Línea 109 es el siguiente bloque de copia. Esta vez se va a copiar el archivo .jar del proyecto `sales-manager-ejb` y lo pondrá dentro de la carpeta de despliegues preconfigurado en el volumen de Payara: `containers/payara/deployments`
Y listoles! ¿cómo se ejecuta este despliegue? con el siguiente comando:

```java
mvn clean install -P payara
```

### sales-manager-web/pom.xml

Este archivo también es similar, pero solo se centrará en el .war

```java
<profile>
            <id>payara</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-dependency-plugin</artifactId>
                        <version>3.2.0</version>
                        <executions>

                            <execution>
                                <id>copy-war</id>
                                <phase>verify</phase>
                                <goals>
                                    <goal>copy</goal>
                                </goals>
                                <configuration>
                                    <outputDirectory>${basedir}/../containers/payara/deployments
                                    </outputDirectory>
                                    <stripVersion>true</stripVersion>

                                    <artifactItems>
                                        <artifactItem>
                                            <groupId>${project.groupId}</groupId>
                                            <artifactId>${project.artifactId}</artifactId>
                                            <version>${project.version}</version>
                                            <type>war</type>
                                        </artifactItem>
                                    </artifactItems>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
```

Lo mismo hace, en la fase `verify` de línea 106, y copiará en la carpeta `containers/payara/deployments` indicada en la línea 111 ¿qué va a copiar?: el archivo generado por el proyecto, indicado entre las líneas 117 y 121.

## Ejecución del contenedor

Para esto debemos tener instalado el docker en nuestro equipo, nos ubicamos en la raíz del proyecto y ejecutamos:

```java
docker-compose -f containers/payara/docker-compose.yml up
```

Si estás en Windows, cambias el separador de ruta de `/` a `\`:

```java
docker-compose -f containers\payara\docker-compose.yml up
```

Dejamos que cocine, y listo.

[![](https://blogger.googleusercontent.com/img/a/AVvXsEhNpqbdzN4Bqf6T_DaLs7_d6fmQ95aiKFYCcturX25x1c_q5Vr2H5jYdAVGPXLb0XztEGzPwHWNtRVRELMWN3bgQ0_8n6G8d7Akg3-M0GKeRN2PIz0wiixR0_sGCDl-0f_BeUMHhiS8w1Shu4-FFAJM-PUvxs_vE64lev0t2oJvQVpw41Lh-hpJKIVR=w640-h320)](https://blogger.googleusercontent.com/img/a/AVvXsEhNpqbdzN4Bqf6T_DaLs7_d6fmQ95aiKFYCcturX25x1c_q5Vr2H5jYdAVGPXLb0XztEGzPwHWNtRVRELMWN3bgQ0_8n6G8d7Akg3-M0GKeRN2PIz0wiixR0_sGCDl-0f_BeUMHhiS8w1Shu4-FFAJM-PUvxs_vE64lev0t2oJvQVpw41Lh-hpJKIVR=s960)

Abrimos: [http://localhost:18080/sales-manager-web](http://localhost:18080/sales-manager-web)

Yo ya estuve llenando unos datos:

[![](https://blogger.googleusercontent.com/img/a/AVvXsEiZ-xTYOsVbtxjNi8Y4FqHR5EJJpM-NLeuxtXRr3j7vw8Mb6Kyh4tNaPCLJR-XEo6AktaNHyoHJ8-UHit20kJOac0d2qJ8-dnZ-obuljjVLMeVnt536sKWbom6KpLKX1xJuclqePzlGRLukamxybuYQBCCHNlYMO-c1gjozemiDMIcNfLEvzwjx8HY4=w640-h310)](https://blogger.googleusercontent.com/img/a/AVvXsEiZ-xTYOsVbtxjNi8Y4FqHR5EJJpM-NLeuxtXRr3j7vw8Mb6Kyh4tNaPCLJR-XEo6AktaNHyoHJ8-UHit20kJOac0d2qJ8-dnZ-obuljjVLMeVnt536sKWbom6KpLKX1xJuclqePzlGRLukamxybuYQBCCHNlYMO-c1gjozemiDMIcNfLEvzwjx8HY4=s1171)

Si
 te gustó la publicación, coméntalo en la caja de abajo. Si te es útil,
compártelo que es gratis. Si deseas que haga un vídeo de esto, también
coméntalo abajo.
