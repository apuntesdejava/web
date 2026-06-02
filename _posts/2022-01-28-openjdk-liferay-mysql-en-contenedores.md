---
layout: post
title: "OpenJDK + Liferay + MySQL, en contenedores"
date: 2022-01-29T00:36:00.003Z
last_modified_at: 2022-01-29T00:36:59.234Z
author: "Diego Silva Límaco"
permalink: /2022/01/openjdk-liferay-mysql-en-contenedores.html
canonical_url: https://www.apuntesdejava.com/2022/01/openjdk-liferay-mysql-en-contenedores.html
description: "Cómo crear un entorno funcional de Liferay + MySQL sobre contenedores."
tags:
  - "openjdk"
  - "liferay"
  - "mysql"
  - "contenedores"
  - "docker"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vQUON2B1xFDnuymWBkZWTsyYM2C8O6whJ_x3hhrehqfRiZ8KiZMU_Ar6rzZs8I7gWOtdp5ZbGTL2kD8/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vQUON2B1xFDnuymWBkZWTsyYM2C8O6whJ_x3hhrehqfRiZ8KiZMU_Ar6rzZs8I7gWOtdp5ZbGTL2kD8/pub?w=1440&h=810)

Estamos en el mundo de la *contened.. conteneni...contenedoriza*... bueno, que todo lo colocan en contenedores. Lo cual es un gran alivio en la configuración y puesta en producción de servidores. No tendríamos de qué preocuparnos más que esté bien configurado a través de un archivo YAML.

Una de los temas más recurrentes que he hablado en este humilde blog es sobre el CMS hecho en Java llamado Liferay. Siempre la parte que más me preocupaba era: ¿cómo diablos podemos ponerlo en producción con algunos pasos?. Pues bueno, aquí lo explico en este post: usando Docker.

Pues bien, aquí explicaré desde lo básico hasta lo más complejo:

Antes que nada, debemos tener instalado el docker en nuestro computador.

## 1. Lo más básico: Un Liferay para demo.

Si revisamos la página de imágenes para Liferay (en este link [https://hub.docker.com/r/liferay/portal](https://hub.docker.com/r/liferay/portal)) bastaría con hacer pull a la imágen y lo ponemos a funcionar. Es buena manera, pero aquí aprenderemos a hacerlo con mejor estilo.

En una carpeta en blanco, crearemos el siguiente archivo `docker-compose.yml` con el siguiente contenido:

```java
version: '3.8'
services:
    liferay-7.4:
        image: liferay/portal:7.4.3.8-ga8
        environment:
            JAVA_VERSION: zulu11
        ports:
            - '8000:8080'
        deploy:
            resources:
                limits:
                    memory: 8g
```

Estoy usando la última versión del Liferay disponible hasta este momento. Para más versiones, revisar los tags disponibles: [https://hub.docker.com/r/liferay/portal/tags](https://hub.docker.com/r/liferay/portal/tags)

Además, según la documentación, se puede indicar qué versión de Java se puede utilizar. Eso lo hacemos con la variable de entorno `JAVA_VERSION`.

Notemos, también, que estamos exportando el puerto 8080 al puerto 8000. Así que, si tenemos alguna otra aplicación funcionando en el puerto 8080, no entrará en conflico.

Ejecutemos esta configuración con este comando:

```java
docker-compose -f docker-compose.yml up
```

Esperemos que cocine, y veamos los resultados:

(Descargando la imagen por primera vez:)

[![](https://blogger.googleusercontent.com/img/a/AVvXsEgaqGh8VKm6c-zU8WilKQs3qI4ZdL0EOJbZFKdcTrG3fUqbUpCAkUpiLF6MkPsvHPj7yhugP-UhjLYL8X7j6i70xuF_fxhFzPWGzqlPNd6db6FYfi6sKPbCPKJ5pomjOO_HX3qf_8lNcPvmZkOlLhTWIX2BFOwJPVsOPwdlpN4m33U-3xs-1_Gn5TWD=s16000)](https://blogger.googleusercontent.com/img/a/AVvXsEgaqGh8VKm6c-zU8WilKQs3qI4ZdL0EOJbZFKdcTrG3fUqbUpCAkUpiLF6MkPsvHPj7yhugP-UhjLYL8X7j6i70xuF_fxhFzPWGzqlPNd6db6FYfi6sKPbCPKJ5pomjOO_HX3qf_8lNcPvmZkOlLhTWIX2BFOwJPVsOPwdlpN4m33U-3xs-1_Gn5TWD=s960)

 Después de cargar comienza a ejecutarse:

[![](https://blogger.googleusercontent.com/img/a/AVvXsEh3hmcmTslT2GLQH-p078ZuM5-xc16g8TWXhNW472PtdFMTZweICGbvjyA-cnoZrTYwgY8W49lyX8x3OwBuGCmCcmEGqZb4BDas8QlcPeQf1VcD0GolbdvZ1gduGTctwd8ff91-pboe4D7SqsP1n3nOAjCH2szLYPcdrt_B-fly3XsfLxoUKEXznT-o=s16000)](https://blogger.googleusercontent.com/img/a/AVvXsEh3hmcmTslT2GLQH-p078ZuM5-xc16g8TWXhNW472PtdFMTZweICGbvjyA-cnoZrTYwgY8W49lyX8x3OwBuGCmCcmEGqZb4BDas8QlcPeQf1VcD0GolbdvZ1gduGTctwd8ff91-pboe4D7SqsP1n3nOAjCH2szLYPcdrt_B-fly3XsfLxoUKEXznT-o=s960)

Y después de un tiempo,ya podemos acceder a la web. Como lo hemos publicado en el puerto 8000, escribiremos en nuestro navegador [http://localhost:8000](http://localhost:8000)

[![](https://blogger.googleusercontent.com/img/a/AVvXsEhyUZE41omnIA7ypC721CAclns7XdSgbPpYpae5q4L9nYKumxStOqlxb79UsDb_vFioX6DJudxy-L347xGMTJvc5pebddfXmo0YvQ00BfF60X01vBLcvPHZyvIelSiB4VhsC591tZW72JJtra8BDkahpm4N2q6U_LkQzOWGr95pwfJi0vew32lJhDHw=w640-h468)](https://blogger.googleusercontent.com/img/a/AVvXsEhyUZE41omnIA7ypC721CAclns7XdSgbPpYpae5q4L9nYKumxStOqlxb79UsDb_vFioX6DJudxy-L347xGMTJvc5pebddfXmo0YvQ00BfF60X01vBLcvPHZyvIelSiB4VhsC591tZW72JJtra8BDkahpm4N2q6U_LkQzOWGr95pwfJi0vew32lJhDHw=s1298)

Como lo estamos ejecutando "de caja", entonces la base de datos utilizada es H2.

## 2. Configurando volúmenes.

Liferay se puede configurar accediendo a ciertas carpetas. Además, todo lo que configuremos en la aplicación se perderá en algún momento. Entonces, es necesario poner a disposición ciertas carpetas "perpetuas" para la configuración. Por ejemplo, la carpeta para desplegar las aplicaciones, los archivos de configuración, entre otras. Así que, detengamos nuestro Docker, y modifiquemos el archivo con lo siguiente:

```java
version: '3.8'
services:
    liferay-7.4:
        image: liferay/portal:7.4.3.8-ga8
        environment:
            JAVA_VERSION: zulu11
        ports:
            - '8000:8080'
        deploy:
            resources:
                limits:
                    memory: 8g
        volumes:
            - ./mnt:/mnt/liferay
            - ./liferay/osgi/modules:/opt/liferay/deploy
```

Estamos considerando dos carpetas: `mnt` y `liferay`. Estas deben existir en la carpeta donde hemos colocado nuestro archivo .yml.

[![](https://blogger.googleusercontent.com/img/a/AVvXsEgwKOTn_IPMt75jmvChin-V6Ds-7WhHudMPkyH4weXG9Xtd4nUjfUEFx7EkxtgOO-DMoP2zJjMHHqpPrR314dDC_rokLfiw3A0FTgDcgKItBGhKd5J1peEz4_VNHjuJzlBAMtbKWa2KdNh-scwWca9F1M_KZXfzw1qoZtBbOUKWEHiQhHRqAdMbny9l=s16000)](https://blogger.googleusercontent.com/img/a/AVvXsEgwKOTn_IPMt75jmvChin-V6Ds-7WhHudMPkyH4weXG9Xtd4nUjfUEFx7EkxtgOO-DMoP2zJjMHHqpPrR314dDC_rokLfiw3A0FTgDcgKItBGhKd5J1peEz4_VNHjuJzlBAMtbKWa2KdNh-scwWca9F1M_KZXfzw1qoZtBbOUKWEHiQhHRqAdMbny9l=s536)

## 3. Base de datos

Ahora, necesitamos incorporar la base de datos. Usaremos MySQL 8. Así que escribiremos lo siguiente en el archivo `docker-compose.yml`:

```java
version: '3.8'
services:
    liferay-7.4:
        depends_on:<br />            - mysql.8<br />        image: liferay/portal:7.4.3.8-ga8
        environment:
            JAVA_VERSION: zulu11
        ports:
            - '8000:8080'
        deploy:
            resources:
                limits:
                    memory: 8g
        volumes:
            - ./mnt:/mnt/liferay
            - ./liferay/osgi/modules:/opt/liferay/deploy
        networks:
            - lifenet
    mysql.8:
        container_name: mysql_liferay
        image: mysql:latest
        environment:
            MYSQL_ROOT_PASSWORD: root
            TZ: America/Lima
            MYSQL_USER: lportal
            MYSQL_PASSWORD: lportal
        ports:
            - '23306:3306'
        volumes:
            - ./mysql-volumes:/var/lib/mysql
        networks:
            - lifenet
networks:
    lifenet:
```

Pasaré a explicar cada línea:

- Línea 4: Depende del servicio MySQL que está más abajo.

- Línea 34: Aquí defino el nombre de la red que utilizaré en mis servicios. Se llamará `lifenet`. Se utilizará en la línea 19 para el servicio de Liferay, y en la línea 33 que es el servicio de MySQL.
- Línea 20: Creo mi servicio con el nombre `mysql.8`.
- Línea 21: El nombre del contenedor. OJO con este nombre, porque será el nombre del HOST que será visible en nuestros servicios.

- Línea 22: Usaremos la última versión de MySQL.
- Línea 23 al 27. Voy a definir variables de entornos. Estos están preparados para que se configuren el MySQL al iniciarse por primera vez. La línea 22 es la contraseña del ROOT, la línea 23 es para la zona horaria (he colocado mi ciudad), y las líneas 24 y 25 son el usuario predeterminado con su respectiva contraseña.
- Línea 28,29: Defino el puerto para poder acceder del MySQL. MySQL utiliza el 3306, así que lo publico por el 23306.
- Línea 30: También creo sus volúmenes. Así quedará persistente la base de datos. Ojo, hay que crear también la carpeta `mysql-volumes` en la carpeta donde tenemos el archivo .yml.

Y listo, levantamos el docker y veremos qué pasa.

[![](https://blogger.googleusercontent.com/img/a/AVvXsEjxR7manUMURwUZSaWITR2f9wtFPooFyYrjvvtw1SY5hVHr9HsXG0PgeBJS7phd_m7ZjUDdTeN4x41-HjX4CYpjyC7wO4Cod06n9KbO5hz5AmeVFWnUNFEYpHO2BdoUvCE1L1Av-0dYreMC8rlQLF3rGJhEX3y2NWZzW1zoYPV1J3ALk4tGeQVbP1pU=w640-h320)](https://blogger.googleusercontent.com/img/a/AVvXsEjxR7manUMURwUZSaWITR2f9wtFPooFyYrjvvtw1SY5hVHr9HsXG0PgeBJS7phd_m7ZjUDdTeN4x41-HjX4CYpjyC7wO4Cod06n9KbO5hz5AmeVFWnUNFEYpHO2BdoUvCE1L1Av-0dYreMC8rlQLF3rGJhEX3y2NWZzW1zoYPV1J3ALk4tGeQVbP1pU=s960)

Veremos cómo descarga la imagen de MySQL y también que se levanta el Liferay. Esto es normal porque lo habíamos puesto así. Lo que nos falta ahora es hacer que ambos se vean. Pero antes, hay que preparar la base de datos.

Así que, desde cualquier cliente de MySQL accederemos al puerto 23306 con el usuario root y la contraseña root. Yo lo mostraré desde la línea de comandos.

```java
mysql -u root -P 23306 -p
```

[![](https://blogger.googleusercontent.com/img/a/AVvXsEgLeb3_lfhoXEthwiiyj1hWEi2TP3wjSWA3etxxqAisoCNDqB6vICth69YpoEbnSbG4eUoypE1YGNjlkAjrKi3AoeaZQEL53lY5kV7yEyGbcsmO33HlDOW5zyHyRMHarNqpPHdpBcWZaAdpWGhdIP2PDGwACBLgLnO9gEQN1YHDiXWRbVi1eIZ4hT45=w640-h320)](https://blogger.googleusercontent.com/img/a/AVvXsEgLeb3_lfhoXEthwiiyj1hWEi2TP3wjSWA3etxxqAisoCNDqB6vICth69YpoEbnSbG4eUoypE1YGNjlkAjrKi3AoeaZQEL53lY5kV7yEyGbcsmO33HlDOW5zyHyRMHarNqpPHdpBcWZaAdpWGhdIP2PDGwACBLgLnO9gEQN1YHDiXWRbVi1eIZ4hT45=s711)

Ahora, desde aquí, crearemos la base de datos `lportal`, y asignaremos el usuario `lportal` a esa base de datos:

```java
create database lportal;
grant all on lportal.* to lportal@"%";
```

[![](https://blogger.googleusercontent.com/img/a/AVvXsEj2mHmy_Y78Nf0HN34BMS3dvAJy9Y7xzKSVBT9I6JVLDWlcNth1XaWBZjONiWkf17r25EDqRH4dV9Gtqe1cMfbGym64_kyJmm9bPbPbVzpurrXo7lVFXA1DxyqyjKzBmyzRRU8Oe4w3q_lnys6iZ4mvyTXIsQERbeI2ODayF4O8L_Wc0tpvCo9nXNvS=s16000)](https://blogger.googleusercontent.com/img/a/AVvXsEj2mHmy_Y78Nf0HN34BMS3dvAJy9Y7xzKSVBT9I6JVLDWlcNth1XaWBZjONiWkf17r25EDqRH4dV9Gtqe1cMfbGym64_kyJmm9bPbPbVzpurrXo7lVFXA1DxyqyjKzBmyzRRU8Oe4w3q_lnys6iZ4mvyTXIsQERbeI2ODayF4O8L_Wc0tpvCo9nXNvS=s454)

Ahora bien, podemos salir de la base de datos y probar el inicio de sesión entrando con ese usuario:

```java
mysql -u lportal -p -P 23306
```

Y desde ahí, podemos ver las bases de datos que puede ver el usuario:

```java
show databases;
```

[![](https://blogger.googleusercontent.com/img/a/AVvXsEidkgtxTylBodo5in4NvYHGVCPziJUkybfi17AzmobrpbQssyVftZ36moxHCSO3QOPzbsaHzfS7h_qUv0Sf7VcbCa1vY4ePmnyy7ia0NEztDrM9P2n3fnWg0XFifl8g0tJtCebL7KWuQshLi0o-hqXRtzdU1SxGFPZc808cMUcumkM5nO4K6xGL8fFC=s16000)](https://blogger.googleusercontent.com/img/a/AVvXsEidkgtxTylBodo5in4NvYHGVCPziJUkybfi17AzmobrpbQssyVftZ36moxHCSO3QOPzbsaHzfS7h_qUv0Sf7VcbCa1vY4ePmnyy7ia0NEztDrM9P2n3fnWg0XFifl8g0tJtCebL7KWuQshLi0o-hqXRtzdU1SxGFPZc808cMUcumkM5nO4K6xGL8fFC=s664)

Bien, podemos ver la base de datos creada para el usuario lportal, y este usuario puede verlo. Ahora, vamos a detener el docker y configuremos ciertos archivos del Tomcat de Liferay para que se conecten.

## 4. Configuración del Tomcat para que acceda al MySQL

Desde la carpeta donde se encuentra el .yml crearemos la siguiente ruta de carpetas: `mnt/files/tomcat/conf` y en esta carpeta `conf` crearemos un archivo llamado `context.xml` que contendrá el siguiente texto:

```java
<?xml version="1.0" encoding="UTF-8"?>
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>WEB-INF/tomcat-web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
<Resource
        name="jdbc/LiferayPool"
        auth="Container"
        type="javax.sql.DataSource"
        driverClassName="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://mysql_liferay:3306/lportal?characterEncoding=UTF-8&dontTrackOpenResources=true&holdResultsOpenOverStatementClose=true&serverTimezone=America/Lima&useFastDateParsing=false&useUnicode=true&allowPublicKeyRetrieval=true&useSSL=false"
        username="lportal"
        password="lportal"
        maxTotal="100"
        maxIdle="30"
        maxWaitMillis="10000"
    />

</Context>
```

Observar la línea 11. El nombre del host es justamente el nombre del host que hemos creado en el archivo .yml: `mysql_liferay`. Además se utilizará el puerto por omisión de MySQL porque ambos están en la misma red.

Ok, con esto hemos configurado el Tomcat para que se conecte a la base de datos de MySQL y esté como un DataSource. Ahora nos toca activar el Liferay para que utilice esta conexión.

## 5. Configuración del Liferay para acceder al DataSource de Tomcat.

Ahora, nos ubicamos en la carpeta `./mnt/files` y creamos el archivo `portal-ext.properties` con el siguiente contenido:

```java
include-and-override=portal-developer.properties
jdbc.default.jndi.name=jdbc/LiferayPool
```

Listo, guardamos todo y levantamos el `docker-compose.yml`.

Veremos que utilizará el dialecto MySQL, y comenzará a crear todas las tablas necesarias.

[![](https://blogger.googleusercontent.com/img/a/AVvXsEgbLl3ZtAlmq6ELR0D6dwx1FMA3dtW33IoWk8rEL5_dyqH5tT1l3v7WdzTgKbRqls4obBOt4uBY72AjQwr59uIQ_rL9kRpziHH33KS2LM47UdDiQfgqlsOry2nGO4WyAm7_toAXgK3yjt63vUki0PXXun08f72dqrTUk9OxCvZR-Fxhta52phrqs71Y=w640-h320)](https://blogger.googleusercontent.com/img/a/AVvXsEgbLl3ZtAlmq6ELR0D6dwx1FMA3dtW33IoWk8rEL5_dyqH5tT1l3v7WdzTgKbRqls4obBOt4uBY72AjQwr59uIQ_rL9kRpziHH33KS2LM47UdDiQfgqlsOry2nGO4WyAm7_toAXgK3yjt63vUki0PXXun08f72dqrTUk9OxCvZR-Fxhta52phrqs71Y=s960)

Y listo, ya tenemos nuestro entorno bien configurado para comenzar a utilizar.

 Si te gustó la publicación, coméntalo en la caja de abajo. Si te es útil, compártelo que es gratis. Si deseas que haga un vídeo de esto, también coméntalo abajo.
