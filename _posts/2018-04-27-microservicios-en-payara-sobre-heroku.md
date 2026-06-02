---
layout: post
title: "Microservicios en Payara sobre Heroku"
date: 2018-04-27T06:57:00.001Z
last_modified_at: 2018-04-27T06:57:26.123Z
author: "Diego Silva Límaco"
permalink: /2018/04/microservicios-en-payara-sobre-heroku.html
canonical_url: https://www.apuntesdejava.com/2018/04/microservicios-en-payara-sobre-heroku.html
description: "Hablaremos sobre cómo poner un microservicio en Payara Micro sobre Heroku"
tags:
  - "microservicios"
  - "payaramicro"
  - "jakarta ee"
  - "heroku"
---

![](https://docs.google.com/drawings/d/e/2PACX-1vTlxcNDn8wuDdN_GRCN5BVTYdO9K97j2Twl9WBfR0MtuAjGzpBdPe1hA029HGkeSjW0NPY_a5FGOtmd/pub?w=450&h=235)

Con este post comenzamos el mundo de Jakarta EE, que es la "evolución" de Java EE.

Hablaremos sobre cómo poner un microservicio en Payara Micro sobre Heroku.

Pero, para no inventar la rueda, usaremos el proyecto que hemos visto en la anterior serie: Payara con Arquillian.

## 0. Primeros pasos

Para comenzar, debemos tener una cuenta en Heroku ([https://signup.heroku.com](https://signup.heroku.com/)). Es bastante simple.

Luego, necesitamos descargar el Heroku CLI ([https://devcenter.heroku.com/articles/heroku-cli#download-and-install](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)) que es nuestro cliente para comunicarnos con la nube.

Otra cosa a considerar es que debemos tener instalado el Git y que esté accedible desde el `PATH` de nuestro Sistema Operativo.

## 1. Preparando la aplicación

Desde la línea de comandos del sistema operativo nos iremos a la carpeta donde se encuentra nuestro proyecto.

Lo primero que tenemos que hacer es iniciar  nuestra sesión con el comando `heroku login` a lo que nos pedirá nuestras credenciales que definimos al crear nuestra cuenta.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFcQDBVdjiSOAmnHdl9stDBWmobbZ-Cnx35wbhG3NOfGGrQerrX1GsuVbkNEaNVBqDGQ8fuJ7ewDb22u-3eKA-t24wjO29hQJOjjIM_Hc1HKJVNiK5bS8YuXNhMPbiShAQh0p9NVlRZH0/s1600/heroku+login.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFcQDBVdjiSOAmnHdl9stDBWmobbZ-Cnx35wbhG3NOfGGrQerrX1GsuVbkNEaNVBqDGQ8fuJ7ewDb22u-3eKA-t24wjO29hQJOjjIM_Hc1HKJVNiK5bS8YuXNhMPbiShAQh0p9NVlRZH0/s1600/heroku+login.png)

Ahora, necesitamos crear una aplicación para heroku. En la misma carpeta escribimos el comando `heroku create`. Adicionalmente se puede colocar el nombre que tendrá nuestro proyecto, o - si lo omitimos - nos creará un nombre aleatorio.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi_HaYbg9OycrLBSCMEVBi_GSnVfV2dW3a4XNabN9P597lpU-AS_dgpzutuJFbRYcWKqvR9noknH-H5m5t3zIf5QGgqt2jVGSx_rOH1cx8zFIms4e5bMWyzhSQtdOf6fV1PhjGs4Lcirho/s1600/heroku+create.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi_HaYbg9OycrLBSCMEVBi_GSnVfV2dW3a4XNabN9P597lpU-AS_dgpzutuJFbRYcWKqvR9noknH-H5m5t3zIf5QGgqt2jVGSx_rOH1cx8zFIms4e5bMWyzhSQtdOf6fV1PhjGs4Lcirho/s1600/heroku+create.png)

 Hecho esto, podemos entrar al dashboard de Heroku ([https://dashboard.heroku.com/apps](https://dashboard.heroku.com/apps)) y ver la aplicación que hemos creado.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCzDF5o-mOqTTYiQVIL3vQgUhPOm7tVWZnByuo5ibidYjmIH4yyYONdggOnWz2zkwOPjkZPCKsiXeGfvWaZTXUDdNbK5TLhciWeVD6vrg8RBrPTRp0XpgF-m0CiQDi7Qtg4PkZ0hBDIPU/s640/heroku+dashboard+01.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCzDF5o-mOqTTYiQVIL3vQgUhPOm7tVWZnByuo5ibidYjmIH4yyYONdggOnWz2zkwOPjkZPCKsiXeGfvWaZTXUDdNbK5TLhciWeVD6vrg8RBrPTRp0XpgF-m0CiQDi7Qtg4PkZ0hBDIPU/s1600/heroku+dashboard+01.png)

## 2. Preparando la base de datos

Toda aplicación debe tener siempre un almacén de datos, sobretodo si estamos haciendo un microservicio. Recordemos que la aplicación que habíamos hecho usa H2 para hacer las pruebas con Arquillian, y se despliega con una base de datos MySQL.

Ahora bien, lo que vamos hacer es modificar un poco la aplicación para que, al desplegar, utilice el PostgreSQL de Heroku.

Pero antes, debemos configurar la base de datos para nuestra aplicación.

Desde el Dashboard, seleccionemos del menú de la cuenta la opción "Data".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYMmYx_8wqjbu3OqHJCwwN23nH7nKnVwW_r7xLgsep30Er8cnd8cbjmsS01QB2hr-FLmnjZXDKL4-oet1HnJXN_Mi4m3DRKpqkYyJlIMvIZcLHT7Ywfuo6KXTQ8dchh-DGP8YSiEz-g5A/s1600/heroku+-+dashboard+-+menu+data.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYMmYx_8wqjbu3OqHJCwwN23nH7nKnVwW_r7xLgsep30Er8cnd8cbjmsS01QB2hr-FLmnjZXDKL4-oet1HnJXN_Mi4m3DRKpqkYyJlIMvIZcLHT7Ywfuo6KXTQ8dchh-DGP8YSiEz-g5A/s1600/heroku+-+dashboard+-+menu+data.png)

 Como es la primera vez, nos dirá que no hemos creado nada todavía, y nos invita a crear una fuente de datos.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiw8ghYRnIB8xHoRqkHGzpXHPkCSRN74z-85AeMkJkUGCnn5Z6wWqWuQK5CZ4LvTxjp-9l2-MC2jXOEg9umRU-Nrn4nKwaexqMizazlaYOLMdPOZ0R8LNQr63pOlxPBP8OD5TojEruHBYg/s640/heroku+data+create.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiw8ghYRnIB8xHoRqkHGzpXHPkCSRN74z-85AeMkJkUGCnn5Z6wWqWuQK5CZ4LvTxjp-9l2-MC2jXOEg9umRU-Nrn4nKwaexqMizazlaYOLMdPOZ0R8LNQr63pOlxPBP8OD5TojEruHBYg/s1600/heroku+data+create.png)

Se nos ofrece tres tipos de repositorio de datos:

- Relacional, usando PostgreSQL

- Clave / Valor, usando Redis

- Distribuida, usando Kafka.

Por ahora veremos una base de datos relacional. Así que haremos clic en "Create one" de "Heroku Postgres".

Si es la primera vez que vamos a configurar la base de datos, nos pedirá que instalemos el Addon de PostgreSQL para Heroku.

Podemos contratar un con ciertas características, o usar uno gratuito, con las limitantes que nos ofrecen.

Comencemos por instalar el Addon

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6oOY5L-8ZIOEwmw3MsI5E6vmDw-Tk8n9qJHTiid4EKiaKwxllFt7dJC_bBLRS4JgAX1x0sBTm0544vbThYUDgajvAyfxQjg9efAHEw9AdOMGeq__9LEmFMnMz8qovtq6sdcxfkm04ngE/s640/heroku+data+install.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6oOY5L-8ZIOEwmw3MsI5E6vmDw-Tk8n9qJHTiid4EKiaKwxllFt7dJC_bBLRS4JgAX1x0sBTm0544vbThYUDgajvAyfxQjg9efAHEw9AdOMGeq__9LEmFMnMz8qovtq6sdcxfkm04ngE/s1600/heroku+data+install.png)

Ahora, nos pedirá que indiquemos cuál es el Plan de base de datos que usaremos. Hay varios planes, así que usaremos el gratuito: Hobby Dev - Free.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjuMDTAba6AcXEU5TQPZ_7aTXM5gG4iImPaePjCB4W01IF9zvQtJYQm7YNH3RAwGUfxDYXfL1wurzgXBbDLaLqPd2hkfJk-VcLMn3rZKGdcascJhnPPvf9in0JoU-sOEZExwFOrxf26vLM/s640/heroku+-+data+app+to+provision.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjuMDTAba6AcXEU5TQPZ_7aTXM5gG4iImPaePjCB4W01IF9zvQtJYQm7YNH3RAwGUfxDYXfL1wurzgXBbDLaLqPd2hkfJk-VcLMn3rZKGdcascJhnPPvf9in0JoU-sOEZExwFOrxf26vLM/s1600/heroku+-+data+app+to+provision.png)

Luego, en la siguiente casilla nos pide que escribamos el nombre de la aplicación que vamos a implementar la base de datos. Así que escribimos el nombre y la seleccionaremos.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-lg1gj5vr21ncV8LwL5I4abtYtBTyNZcjXHyhvZKYHeGz2JvAmGMFY_nRDKzXJhr75jpFAFRrHKEgw-Eg-ElACynTl_dlbdP2f52th2Bv-z2bGHYVH6g5ipKxeUnz8TYNYNiyfz07Y0s/s640/heroku+-+data+app+to+provision+2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-lg1gj5vr21ncV8LwL5I4abtYtBTyNZcjXHyhvZKYHeGz2JvAmGMFY_nRDKzXJhr75jpFAFRrHKEgw-Eg-ElACynTl_dlbdP2f52th2Bv-z2bGHYVH6g5ipKxeUnz8TYNYNiyfz07Y0s/s1600/heroku+-+data+app+to+provision+2.png)

Y hacemos clic en "Provision add-on"

Finalmente, ya tenemos nuestra base de datos lista para nuestra aplicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibSckKe2VDBH2fyQXaZqBLj1rbxdeagmbDee1uo-eBRy_1MwBxxgTkspXWRuf1MzXfZMIBwR20WjQKDbY6edyfqRUKwXHHjIuarY796797zjI6hJvL7Pwi7GQNV92hyaxd11YwXqubdrk/s640/heroku+-+data+added.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibSckKe2VDBH2fyQXaZqBLj1rbxdeagmbDee1uo-eBRy_1MwBxxgTkspXWRuf1MzXfZMIBwR20WjQKDbY6edyfqRUKwXHHjIuarY796797zjI6hJvL7Pwi7GQNV92hyaxd11YwXqubdrk/s1600/heroku+-+data+added.png)

No voy a entrar en detalle de Heroku, ya que el objetivo de este post es otro.

## 3. La conexión de la base de datos

Para que nuestra aplicación utilice la base de datos necesitamos usar sus credenciales, configurarlo en nuestra cadena de conexión del Pool (o JDBC según sea el caso) y listo.

Ahora bien ¿cuáles son las credenciales?

Entremos al panel de base de datos [https://data.heroku.com/](https://data.heroku.com/)

Ahí veremos la base de datos que acabamos de crear y enlazar a nuestra aplicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEin8RhcXLPY6FXD2En7PnN_VBNTsR8SxCukri0cIIXmLslQFPPcl15lusW5SelYXJX349wDmuV237sJoS2_EbYiA0B_pcDxpqQUoG4dxASJtL9ybi5PpCQxefmL6jLUG5k3l1R4POpffM4/s640/data+-+credenciales.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEin8RhcXLPY6FXD2En7PnN_VBNTsR8SxCukri0cIIXmLslQFPPcl15lusW5SelYXJX349wDmuV237sJoS2_EbYiA0B_pcDxpqQUoG4dxASJtL9ybi5PpCQxefmL6jLUG5k3l1R4POpffM4/s1600/data+-+credenciales.png)

Hacemos clic en nuestro datastore para entrar y conocer el detalle.

En la pestaña "Settings" hacemos clic en el botón "View credentials..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi8Ijpo20sANxDDMj7_vFnDKjaLFmEwaqWUINYfSZmBapYFzFg-4qlm9rszXI_Llui_kZjDSdD8seR9x3MxiEiQstn6QxxKg-4J_594lW49CtrnrFy2hRdNoPuttJQDBMUSAD6GRWWliWQ/s640/data+-+credenciales+02.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi8Ijpo20sANxDDMj7_vFnDKjaLFmEwaqWUINYfSZmBapYFzFg-4qlm9rszXI_Llui_kZjDSdD8seR9x3MxiEiQstn6QxxKg-4J_594lW49CtrnrFy2hRdNoPuttJQDBMUSAD6GRWWliWQ/s1600/data+-+credenciales+02.png)

Y se nos muestra lo oculto:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiRi5KbfR0IQ6mjBobnl6Dg0xiSJN0v-7vpfltKCAZ8E8Oa9tsB2hMS0oOhtlamf-LCfav4Wznpg3oBxOp1QjkjHgv0iTP_L6h8JSWoXlK3RgtYQq0rHunNRK4S9iPKQ27Xm6oVhwBtKqU/s640/data+-+credenciales+03.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiRi5KbfR0IQ6mjBobnl6Dg0xiSJN0v-7vpfltKCAZ8E8Oa9tsB2hMS0oOhtlamf-LCfav4Wznpg3oBxOp1QjkjHgv0iTP_L6h8JSWoXlK3RgtYQq0rHunNRK4S9iPKQ27Xm6oVhwBtKqU/s1600/data+-+credenciales+03.png)

Estos valores debemos tenerlo en cuenta para después.

## 4. Preparando la aplicación para Heroku

- ¿Usaremos estas credenciales y las pegaremos a nuestro código?

- No

- ¿lo pondremos en un archivo aparte para que nuestra aplicación lo lea?

- No, bueno, casi, pero no colocaremos esas credenciales en alguna parte de nuestro código

Lo genial de Heroku es que podemos usar variables de entorno y estas serán pasadas a nuestra aplicación. Así que tendremos las siguientes y grandes ventajas:

- Podemos ejecutar en nuestro entorno local de Heroku con unas credenciales diferentes al de la nube.

- La nube tendrá sus variables de entorno, y solo el administrador podrá accederlas.

- Payara Micro también puede leer variables de entorno.

 Así que, comenzaremos a modificar nuestra aplicación.

### 4.1 Las variables de entorno local

Este archivo solo será leído cuando ejecutamos el Heroku en nuestro ambiente local. Este archivo se llamada `.env`, estará en la "raiz" del proyecto, y deberá tener el siguiente contenido.

```java
JDBC_DRIVER=com.mysql.jdbc.jdbc2.optional.MysqlXADataSource
JDBC_HOST=localhost
JDBC_DBNAME=store
JDBC_USER=store
JDBC_PASSWORD=store
```

Son las mismas credenciales que hemos usado para nuestro ejemplo anterior, pero solo funcionará en nuestro local

### 4.2 El archivo Procfile.local

Este archivo es algo parecido a un script de ejecución. Se parece a un bash o .bat, pero puede hacer varias cosas. Solo por ahora veremos lo necesario. Su contenido es el siguiente:

```java
web: java -jar target\payara-arquillian-heroku-1.0.jar
```

### 4.3 Modificando el archivo web.xml

Ahora bien ¿cómo hacemos para que nuestra aplicación se entere las variables de entorno que estamos usando?. Pues, este archivo permite leer esas variables, así como variables de entorno. Veamos cómo se hace:

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
        <class-name>${ENV=JDBC_DRIVER}</class-name>
        <server-name>${ENV=JDBC_HOST}</server-name>
        <database-name>${ENV=JDBC_DBNAME}</database-name>
        <user>${ENV=JDBC_USER}</user>
        <password>${ENV=JDBC_PASSWORD}</password>
    </data-source>
</web-app>
```

### 4.4 Corriendo Heroku Local

Y Listo,  desde la línea de comandos ejecutamos la siguiente orden:

```java
mvn clean package -Pdist

heroku local web -f Procfile.local
```

La primera línea es para compiarlo y preparar para distribuir (con el perfil `dist` que usamos en el post anterior), y luego ejecutamos el heroku local.

Y este es el resultado.

[![]({{ '/assets/blogger/payara-heroku-local.png' | relative_url }})]({{ '/assets/blogger/payara-heroku-local.png' | relative_url }})

 ¿Lo probamos?

Hacemos las mismas pruebas qué hacíamos en los post anteriores.

Con httpie

```java
http http://localhost:9595/payara-arquillian-heroku-1.0/webresources/product
```

También podemos usar Postman y el resultado será el mismo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj6lkZhDSJuB8dnHY3cwM4rQnj_SCZWYceuN3vFWSQEE8K_CY6sSCZFv0zV6HttU1fs9SLpYno7A9PoJMsA2TvL0K-GDYSGUFVt1UN2tBU_RPmK0xaMEE4fxVdk_2xtlED2_FfOBqjyZqg/s400/httpie+local.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj6lkZhDSJuB8dnHY3cwM4rQnj_SCZWYceuN3vFWSQEE8K_CY6sSCZFv0zV6HttU1fs9SLpYno7A9PoJMsA2TvL0K-GDYSGUFVt1UN2tBU_RPmK0xaMEE4fxVdk_2xtlED2_FfOBqjyZqg/s1600/httpie+local.png)

### 4.5 El archivo Procfile

Este es el archivo que se ejecutará en Heroku cuando se despliegue. Recordemos que se ejecutará en un ambiente Linux, por tanto, la sintaxis de los comandos varía un poco. Este archivo también irá en la "raíz" del proyecto.

```java
web: java -jar target/payara-arquillian-heroku-1.0.jar --port $PORT
```

Notemos la variable de entorno `$PORT`. Se le va a indicar a Payara que se exponga el servicio en ese puerto. Heroku sabrá qué hacer con ese puerto para publicarlo.

### 4.6 Configuracion final de pom.xml: Driver de PostgreSQL y despliegue perfil dist automático

Nos falta dos cosas para terminar: Agregar el Driver Postgresql. Nos bastará con agregar la dependencia indicada:

```java
<dependency>
                    <groupId>org.postgresql</groupId>
                    <artifactId>postgresql</artifactId>
                    <version>42.2.2</version>
                </dependency>
```

. No importa si está junto con el Driver de MySQL. Se puede mejorar el `pom.xml` pero por ahora puede funcionar sin problema.

Ahora bien, recordemos que para preparar la aplicación como un empaquetado con Payara Micro era necesario utilizar el perfil `dist`, y por eso necesitábamos ejecutar el comando de maven con el argumento `-Pdist`.

En heroku no se puede indicar qué perfil utilizará. Solo se le hace un push a su código y este se desplegará de manera automática, sin perfil sin nada.

Una manera es dejar siempre activo ese perfil, pero lo mejor es que sea tan inteligente el `pom.xml` que sepa qué hacer en determinados ambientes.  Bastará con detectar una variable de ambiente y eso activará el perfil adecuado.

```java
<profile>
            <id>dist</id>
            <activation>
                <property>
                    <name>env.DYNO</name>
                </property>
            </activation>
            <dependencies>
...
```

### 4.7 Las variables de entorno de nuestra aplicación en Heroku

Las variables de entorno de Heroku está en la pestaña "Settings"  del Dashboard. Hay un botón llamado "Reveal Config vars".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhbTTU5v5jqv0I9ylYHXdpsfW2803brYUnRJn9ZlS0yCwlf8tjnCl0uDXNi3waVbun4OpiEm2Ed8opqDnQDu7ZIqZdS3A8lKREmWAyRsH1Aq4n5wZU_Kdd6Z5-Xd3LXnrs7Deb-XB46Nfw/s640/heroku+variables.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhbTTU5v5jqv0I9ylYHXdpsfW2803brYUnRJn9ZlS0yCwlf8tjnCl0uDXNi3waVbun4OpiEm2Ed8opqDnQDu7ZIqZdS3A8lKREmWAyRsH1Aq4n5wZU_Kdd6Z5-Xd3LXnrs7Deb-XB46Nfw/s1600/heroku+variables.png)

Hacemos clic allí y se nos mostrará un editor de variables de entorno. Existirá uno predefinido, pero necesitamos definir los nuestros. Debemos declarar las siguientes variables utilizando los valores que vimos en el entorno de Datastores.

- JDBC_DRIVER : `org.postgresql.ds.PGPoolingDataSource`

- JDBC_HOST

- JDBC_DBNAME

- JDBC_USER

- JDBC_PASSWORD

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0XSALrvltbkHGMk7Kn0DD7JqQVs1XCXXnaLlyHdjbcCQjpLtaI9-1PGmVr-SxxwgIJ_JBnKWLCeuKsDqflGlAlJVasy1PlXZGUDYxG7YN81k0L8U8y5fkieW9w4Z_ojtNda4AB98N3Jk/s640/heroku+-+variables+prod.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0XSALrvltbkHGMk7Kn0DD7JqQVs1XCXXnaLlyHdjbcCQjpLtaI9-1PGmVr-SxxwgIJ_JBnKWLCeuKsDqflGlAlJVasy1PlXZGUDYxG7YN81k0L8U8y5fkieW9w4Z_ojtNda4AB98N3Jk/s1600/heroku+-+variables+prod.png)

### 4.8 Desplegando en la nube

Para desplegar en la nube de Heroku solo se necesita hacer push al git que tiene Heroku. Para saber cuál es el git de nuestro proyecto, debemos hacer este comando. Naturalmente, debimos de haber iniciado sesión en Heroku desde la línea de comandos. Así que este es el comando:

```java
heroku apps:info nombre_de_la_aplicacion
```

En mi caso, sería este:

```java
heroku apps:info payaramicro-heroku
```

Esto me mostrará toda la info.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjV-Z-RjWoQjIQVUt8gWwNyL6vHOfdg0TP0h-7-FVhR8119IzIbHMP7dAItwQUnUFeRatjRRGVtLGhuZN3mp8kr2va7tKb-2OVuht2nzXJ7lkZyzMRclW1BKceTO5hcnGr1h64PmkFuBhs/s1600/heroku+info+app.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjV-Z-RjWoQjIQVUt8gWwNyL6vHOfdg0TP0h-7-FVhR8119IzIbHMP7dAItwQUnUFeRatjRRGVtLGhuZN3mp8kr2va7tKb-2OVuht2nzXJ7lkZyzMRclW1BKceTO5hcnGr1h64PmkFuBhs/s1600/heroku+info+app.png)

 Por tanto, hacemos commit a los cambios que hicimos:

```java
git add *
git commit -m "Preparado para Heroku"
```

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjV-OuaLN9Wi0FhsRDZya_7w3WuaoI-jUj_wxW8nfql532AncVXMymPKhRcKyMsNwoPEPgL3YLjOytILI5R7UD52X68yu2_a1fYWoVDDrC5mekaRcbLYvZvEGL07Pmp5zP7oPsh7o397qc/s1600/heroku+commit.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjV-OuaLN9Wi0FhsRDZya_7w3WuaoI-jUj_wxW8nfql532AncVXMymPKhRcKyMsNwoPEPgL3YLjOytILI5R7UD52X68yu2_a1fYWoVDDrC5mekaRcbLYvZvEGL07Pmp5zP7oPsh7o397qc/s1600/heroku+commit.png)

Y luego, push a la dirección git

```java
git push  https://git.heroku.com/payaramicro-heroku.git
```

Veamos cómo trabaja.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZdfaUGgGndbbfNc09uHKKB9UTVlgdwQFkAtvY3sEhbMtbu8hHZXh8cH0Qq_tpv6akkYckoaobPjjA4ZTD7klTHzmlIz1AM5hLCmBDUlUIhWw8mindjx_xJlBSlPBxLPH2Ii1AREHEAmw/s640/heroku+push.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZdfaUGgGndbbfNc09uHKKB9UTVlgdwQFkAtvY3sEhbMtbu8hHZXh8cH0Qq_tpv6akkYckoaobPjjA4ZTD7klTHzmlIz1AM5hLCmBDUlUIhWw8mindjx_xJlBSlPBxLPH2Ii1AREHEAmw/s1600/heroku+push.png)

Y listo, cuando veamos que terminó el maven, podemos estar casi seguros que está funcionand.

¿Cómo saberlo? Vamos al Dashboard y seleccionemos de la aplicación la opción "View logs"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcMU6Uj7lBmKH0T0OVT06-nxlsWu8kezfSCnEDBH5bLWYQlAGpuzEQj1rGG4ADbfCgB4I4BVRYXJwLFFXgGLYr6lGsZOF7B8OQh59R46IxUInaylOb4ZaAtLR4EFT8D75HmW7O7rSm5U4/s1600/dashboard+view+log+item.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhcMU6Uj7lBmKH0T0OVT06-nxlsWu8kezfSCnEDBH5bLWYQlAGpuzEQj1rGG4ADbfCgB4I4BVRYXJwLFFXgGLYr6lGsZOF7B8OQh59R46IxUInaylOb4ZaAtLR4EFT8D75HmW7O7rSm5U4/s1600/dashboard+view+log+item.png)

Y vemos...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhTg4oRdCPeiMo3HBHSamsAye9ilXeZRa8aJ4pHi5JpZGODZxXyLtTJMqU9N8bcD3l9T_eMRKg74KLO0iU4RVfWUOxSfO6Qf-EZMe3Y9KF8umhGlCV4M-QAvHUS0o_uepd5c26thwtMUgE/s640/heroku+deployed.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhTg4oRdCPeiMo3HBHSamsAye9ilXeZRa8aJ4pHi5JpZGODZxXyLtTJMqU9N8bcD3l9T_eMRKg74KLO0iU4RVfWUOxSfO6Qf-EZMe3Y9KF8umhGlCV4M-QAvHUS0o_uepd5c26thwtMUgE/s1600/heroku+deployed.png)

Tiene un final similar que cuando lo ejecutábamos en nuestro local.

### 4.9 Probando el servicio

Ahora sí, el momento de la verdad. Como usamos JPA configurado para crear las tablas, estamos 100% de que las tablas se crearon en PostgreSQL. Así que solo nos toca invocar al servicio pero utilizando el nuevo URL que se creó: Usando httpie, este es el resultado

```java
http https://payaramicro-heroku.herokuapp.com/payara-arquillian-heroku-1.0/webresources/product
```

Pero como no tenemos data, nos devolverá vacío.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiF-mdr3fv20sxou8tC_2L-IKAHpRH3ynze2BO9778IjeKqdEz3llqrhmcRzEGI0OZ-TQ8Is8rIDC5rLq4w87QZo42mHzwF5CahfKqRF_ELP8QNX0XzbbswCxCM7JmAD4GDUrBWZD_WoqQ/s640/heroku+cloud+httpie.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiF-mdr3fv20sxou8tC_2L-IKAHpRH3ynze2BO9778IjeKqdEz3llqrhmcRzEGI0OZ-TQ8Is8rIDC5rLq4w87QZo42mHzwF5CahfKqRF_ELP8QNX0XzbbswCxCM7JmAD4GDUrBWZD_WoqQ/s1600/heroku+cloud+httpie.png)

Al menos no lanzó error, y eso quiere decir que las tablas fueron creadas correctamente porque el Query no falló.

Y listo, tenemos nuestro Microservicio con Payara funcionando en Heroku.

Como estamos con un plan gratuito, si no se utiliza el servicio este se cerrará, y debemos activarlo nuevamente desde el dashboard.

## Código fuente

Como es de costumbre, el código fuente desarrollo en este post lo podrán encontrar, descargar y clonar desde aquí:

[https://bitbucket.org/apuntesdejava/payara-arquillian-heroku](https://bitbucket.org/apuntesdejava/payara-arquillian-heroku)

Y, para terminar, les dejo un Proverbio de un libro muy antiguo (La Biblia)

**"Trabaja duro y serás un líder;
    sé un flojo y serás un esclavo." Proverbios 12:24.

**Hasta la próxima.
