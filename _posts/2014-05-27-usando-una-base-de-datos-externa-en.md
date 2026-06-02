---
layout: post
title: "Usando una base de datos externa en Liferay a través de Spring"
date: 2014-05-27T18:46:00.001Z
last_modified_at: 2014-05-27T18:46:39.471Z
author: "Diego Silva Límaco"
permalink: /2014/05/usando-una-base-de-datos-externa-en.html
canonical_url: https://www.apuntesdejava.com/2014/05/usando-una-base-de-datos-externa-en.html
tags:
  - "spring"
  - "configuración"
  - "tutorial"
  - "liferay"
  - "web"
---

[![Usando una base de datos externa con Liferay a través de Spring](/assets/blogger/liferay-spring.png)](/assets/blogger/liferay-spring.png)

Todos los aplicativos (portlets) de Liferay, usando a través del *Service Builder*, utilizan la misma base de datos donde se configuró el servidor. Si deseamos utilizar otra base de datos ya existente, podemos hacer una integración en nuestro portlet. En este post veremos cómo hacer esta integración, pero en esta manera no usaremos el Service Builder.

Para comenzar, crearemos un portlet común y corriente (o usamos uno ya existente). Para mi ejemplo crearé un portlet llamado "Sample", utilizaré la base de datos de Apache Derby que viene con el JDK llamado "Sample" y listaré el contenido de la tabla PRODUCT.

### Mis recursos:

- JDK 8 (sí, me está resultando el Liferay con Java8)

- Eclipse Kepler + Liferay Plugin (se puede configurar desde el Marketplace de Eclipse. También funciona con Eclipse Juno)

- Tomcat 7 preconfigurado con Liferay 6.2

### Agregando las bibliotecas necesarias

Lo común es agregar más bibliotecas al proyecto, pero el Liferay ya cuenta con sus propias bibliotecas de Spring (porque buena parte está hecho con Spring), así que solo le decimos que vamos a necesitar las bibliotecas compartidas del framework. Para ello seleccionamos el archivo `docroot/WEB-INF/liferay-plugin-package.properties`

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgSPDqHs0lSP_IuuWmbCK9UWROO7bW1FQ86ECKNlEs8zclqIZimWxh9hteXgyV3EwvXzpQCegHSLNusgf3yK7KwIdVPNJspIT9elz-ZOR8OaIbOhJUIwEQk8e-aH8Blbpq3Uwcd7wWxjA4/s1600/26-05-2014+05-12-58+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgSPDqHs0lSP_IuuWmbCK9UWROO7bW1FQ86ECKNlEs8zclqIZimWxh9hteXgyV3EwvXzpQCegHSLNusgf3yK7KwIdVPNJspIT9elz-ZOR8OaIbOhJUIwEQk8e-aH8Blbpq3Uwcd7wWxjA4/s1600/26-05-2014+05-12-58+p.m..png)

... y en la sección "Portal Dependency Jars" hacemos clic en "Add..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRhPomIfLs04EX8AmYTMhdf0jD42M3RIcIE0f-mMgMcz-xg-MchdBR3Fvtt58lpdo2qAIyGbUQdQANnIQFbgAOqujgZxFwcQF2aHWSKlE6TwGIVZuvGsiOOmO8Zd2QhN7EMPKR92giU2k/s1600/26-05-2014+05-14-29+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRhPomIfLs04EX8AmYTMhdf0jD42M3RIcIE0f-mMgMcz-xg-MchdBR3Fvtt58lpdo2qAIyGbUQdQANnIQFbgAOqujgZxFwcQF2aHWSKlE6TwGIVZuvGsiOOmO8Zd2QhN7EMPKR92giU2k/s1600/26-05-2014+05-14-29+p.m..png)

... para agregar los siguientes paquetes:

- spring-asm

- spring-beans

- spring-context

- spring-core

- spring-expression

- spring-jdbc

- spring-web

- spring-web-portlet

- spring-web-servlet

También necesitamos la biblioteca cliente para la base de datos. Debemos agregarlo manualmente a la carpeta `$TOMCAT_HOME/lib/ext` antes de iniciar el Liferay. Los archivos que vamos a cargar son `derby.jar` y `derbyclient.jar` que lo podemos obtener de `$JAVA_HOME/db/lib`

### Crear configuración Spring con conexión a base de datos

Para configurar el Spring, necesitamos crear un archivo llamado `applicationContext.xml` dentro de `WEB-INF` y tendrá el siguiente contenido:

<script src="https://gist.github.com/apuntesdejava/9318291ee77f15b08656.js"></script>

Ese archivo `my-dao-spring.xml` lo crearemos dentro de la carpeta `src/META-INF`. Si no existe la carpeta `META-INF`, lo creamos.

El contenido del archivo xml será el siguiente (una configuración propia de Spring con JDBC)

<script src="https://gist.github.com/apuntesdejava/514a0e75f62dd4c6ac85.js"></script>

### Cargar archivo Spring en el portlet

Necesitamos que la configuración del spring sea cargado con toda la aplicación. Para ello debemos configurar el archivo `web.xml` con lo siguiente:

<script src="https://gist.github.com/apuntesdejava/b1bd9eea62916be0824e.js"></script>

### Las clases DAO

Ahora nos toca crear las clases DAO que se usarán por el Spring. Esto es puro POJO a manera de ejemplo:

Primero, la interfaz DAO

<script src="https://gist.github.com/apuntesdejava/085c3a9c78d60f5fe8ef.js"></script>

La implementación...

<script src="https://gist.github.com/apuntesdejava/1b6a0df5b8c58286a3a1.js"></script>

### El Portlet

Crearemos un Portlet tipo MVCPorlet llamado `SamplePortlet` dentro de la categoría `Sample`, y este será el código:

<script src="https://gist.github.com/apuntesdejava/bf15d22c2cba6417ac16.js"></script>

Y vemos que la implementación es bastante simple. Solo llamamos al SpringContext, obtenemos el DAO que hemos creado, y usamos su método. Esto es lo bueno de usar patrones: todo está ordenado y no necesitamos de enredarnos con códigos que no le corresponde.

Y en nuestro JSP usaremos taglibs de liferay para mostrar la lista pero en una tabla y de manera paginada:

<script src="https://gist.github.com/apuntesdejava/83c38a9eafd35ed8ae4e.js"></script>

### Desplegando

Desplegamos el proyecto desde el menú contextual > Liferay > SDK > deploy

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhYc7gUq4_hZN8LMdTDjU6ZgDVHCAxycvIh08RtycXSKlEez30HkubzNDCrbuNODNqmX8PJYAMWTIpmTm_lSmHN3W98-hktZRgJJVXVNnZnHQGJCwbPNTPlFMKN4PTnHObRU3AERZM1XSc/s1600/27-05-2014+01-24-29+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhYc7gUq4_hZN8LMdTDjU6ZgDVHCAxycvIh08RtycXSKlEez30HkubzNDCrbuNODNqmX8PJYAMWTIpmTm_lSmHN3W98-hktZRgJJVXVNnZnHQGJCwbPNTPlFMKN4PTnHObRU3AERZM1XSc/s1600/27-05-2014+01-24-29+p.m..png)

Esperamos que cocine... y, desde el portal lo agregamos.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhD7aMI2dlIS7rz_thVdG5034wKKel_nXG1zIKiGo2vRSp7fOvvMbHzhwhnoNMNdISN59ZBlUkg72CZ2xQEe2sPf1NgnC7cNevmZWB2G2DwycL9TpRkYN6yEFkyVRS6oZsNTk2VvoJKZ4w/s1600/27-05-2014+01-27-37+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhD7aMI2dlIS7rz_thVdG5034wKKel_nXG1zIKiGo2vRSp7fOvvMbHzhwhnoNMNdISN59ZBlUkg72CZ2xQEe2sPf1NgnC7cNevmZWB2G2DwycL9TpRkYN6yEFkyVRS6oZsNTk2VvoJKZ4w/s1600/27-05-2014+01-27-37+p.m..png)

.. y listo!

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgO1CQP65ePljga_qwRy5vPpfMz7_V0jEw4pPoEOrkilekz0e1LsQmDmAvXVLZ7ICrDC6bgSlRp80ONtS1mhCbFagqT-KC77E9KCuErNWQG6-WCHBiKsOMDrp1Bm79LGdOf4M2cdO9KQ9M/s1600/27-05-2014+01-29-26+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgO1CQP65ePljga_qwRy5vPpfMz7_V0jEw4pPoEOrkilekz0e1LsQmDmAvXVLZ7ICrDC6bgSlRp80ONtS1mhCbFagqT-KC77E9KCuErNWQG6-WCHBiKsOMDrp1Bm79LGdOf4M2cdO9KQ9M/s1600/27-05-2014+01-29-26+p.m..png)

Y como estamos en Liferay, todos los tags soportan *Responsive*.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgfbhqzad6fLUi6bldjCWiYfjfHScfFnVuj6tjhl7QHhX_sQIwuCnlLnhPmNa34aUhLw5BL6RC5CtO6_L1GQ9vcpfvISCXBdz-eq-0a8ChFkfsIiK4q1V6ilZdOwy3TiHarW9GXk_AyT4E/s1600/27-05-2014+01-30-32+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgfbhqzad6fLUi6bldjCWiYfjfHScfFnVuj6tjhl7QHhX_sQIwuCnlLnhPmNa34aUhLw5BL6RC5CtO6_L1GQ9vcpfvISCXBdz-eq-0a8ChFkfsIiK4q1V6ilZdOwy3TiHarW9GXk_AyT4E/s1600/27-05-2014+01-30-32+p.m..png)

### No olvidar iniciar la base de datos...!!

... porque en este ejemplo hemos usado el Apache Derby que viene con el JDK, falta iniciar el servicio. Yo lo inicié desde el NetBeans.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgviNg4Vs7RyRI1sYiCgL4NqKtrL2fbjGKOoCzeV_1zrlLaGgy8Q47C900pafFoR-uqdsQLL4ONcB_bcLO2p2y1jeCDLKdDssF6fOiAgiQdaiXh2Xb6q7VJ2nFGIJJCCXxyFWPZkwMkTr8/s1600/27-05-2014+01-44-28+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgviNg4Vs7RyRI1sYiCgL4NqKtrL2fbjGKOoCzeV_1zrlLaGgy8Q47C900pafFoR-uqdsQLL4ONcB_bcLO2p2y1jeCDLKdDssF6fOiAgiQdaiXh2Xb6q7VJ2nFGIJJCCXxyFWPZkwMkTr8/s1600/27-05-2014+01-44-28+p.m..png)

Naturalmente, pueden cualquier base de datos. Esto es un mero ejemplo.

### El código fuente

Y este post no termina si no comparto el código fuente utilizado. Aquí les va

[https://java.net/projects/apuntes/downloads/download/web/portlets/sample-portlet.tar.gz](https://java.net/projects/apuntes/downloads/download/web/portlets/sample-portlet.tar.gz)

Espero que les sirva. Bendiciones a todos!
