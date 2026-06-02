---
layout: post
title: "Combo dependiente con JSP + Ajax"
date: 2009-05-12T19:33:00Z
last_modified_at: 2016-03-10T19:48:47.513Z
author: "Diego Silva"
permalink: /2009/05/combo-dependiente-con-jsp-ajax.html
canonical_url: https://www.apuntesdejava.com/2009/05/combo-dependiente-con-jsp-ajax.html
description: "Este es sin duda el tema más buscado para los que desarrollan formularios web. Aquí el ejemplo actualizando usando JQuery y AngularJS"
tags:
  - "material design"
  - "jdbc"
  - "bootstrap"
  - "ajax"
  - "javascript"
  - "jquery"
  - "dao"
  - "java"
  - "web"
  - "datasource"
  - "netbeans"
  - "angularjs"
---

[![](https://docs.google.com/drawings/d/1Wlt5kLkDPQC9N4RSFourGBGh3B4zzv-fRQl5Ueu0TeQ/pub?w=358&h=221)](https://docs.google.com/drawings/d/1Wlt5kLkDPQC9N4RSFourGBGh3B4zzv-fRQl5Ueu0TeQ/pub?w=358&h=221)

Este es sin duda el tema más buscado para los que desarrollan formularios web:

**Combos dependientes en JSP usando AJAX**

Esto es clásico en los ejemplos de combos tipo departamento-provincia-distrito, cuando los elementos de un combo depende de la selección de otro.

Pues ya, aquí está...

... y totalmente actualizado!!

Aquí lo explicamos con JQuery y AngularJS, y de regalo.. con Bootstrap y Material Design

Esta aplicación tiene tres partes.

- Capa de datos

- Servicios "ajax"

- Vista.

### Capa de datos

La primera es la capa de datos, la cual está implementada por un DAO. Aquí he implementado con:

- **Spring.** Para instanciar los DAO

- **Base de datos Apache Derby**. Use la base de datos ejemplo "sample" que viene en el JDK. Pueden usar cualquier, pero yo usé este porque ya está implementado.

- **DBCP** para manejar el pool de conexiones

- **Clase singleton** justamente para tener un solo factory que me obtenga la conexión a la base de datos.

Las dependencias en `pom.xml` para esta parte están dadas aquí

```java
<dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>4.2.5.RELEASE</version>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-dbcp2</artifactId>
            <version>2.1.1</version>
        </dependency>
        <dependency>
            <groupId>org.apache.derby</groupId>
            <artifactId>derbyclient</artifactId>
            <version>10.12.1.1</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>4.2.5.RELEASE</version>
        </dependency>
```

El archivo `spring.xml` que crea la conexión a la base de datos es este:

<script src="https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/abb6f28e57fca55e5551256a9851519f944f3d32/src/main/resources/spring.xml?embed=t"></script>

La implementación del DAO para obtener el listado de `[ProductCode](https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/master/src/main/java/com/apuntesdejava/combo/dependiente/ajax/domain/ProductCode.java?at=master&fileviewer=file-view-default)` es este:
<script src="https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/abb6f28e57fca55e5551256a9851519f944f3d32/src/main/java/com/apuntesdejava/combo/dependiente/ajax/dao/jdbc/JdbcProductCodeDao.java?embed=t"></script>

Y listo, lo tenemos totalmente aislado para lo que queramos.

### Servicios Ajax

Está mal dicho el nombre, pero consiste en un servlet que devuelve los datos para ser consumidos como Ajax en nuestro HTML. Como son dos tablas, he creado dos servlets. Aquí está uno, el que corresponde a ProductCode.. el otro es similar.

<script src="https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/abb6f28e57fca55e5551256a9851519f944f3d32/src/main/java/com/apuntesdejava/combo/dependiente/ajax/servlet/ProductCodeServlet.java?embed=t"></script>

Consiste simplemente en usar el DAO, luego convertir el resultado en JSON (que ya es estándar) para devolvérselo al cliente

### Capa de presentación (Vista)

Esta es la parte interesante del proyecto.

#### JQuery

<script src="https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/master/src/main/webapp/jquery.html?embed=t"></script>
Con JQuery consiste en:

- obtener la lista del servlet (línea 49)

- Recorrer la lista (línea 52)

- Por cada elemento crear un elemento `option`...(Línea 53)

- .. colocándole las propiedades como el valor (Línea 54)

- ... el texto a mostrar (Línea 55)

- .. y colocándolo al combo (Línea 56)

- De paso, capturamos el evento "on change" del combo (línea 58) para que ejecute el método respectivo (línea 61)

- Este método consiste en tomar el valor del combo que cambió (línea 62)

- .. llama al servlet para obtener la lista (línea 65)

- .. con el parámetro respectivo (línea 66)

- y construimos las opciones del combo. Naturalmente hay que limpiarlo (línea 69) y agregar las líneas opciones como se hizo con el otro combo.

Y este es el resultado:![](https://docs.google.com/drawings/d/1xUv-7GIb9ocZbrYnHHnTuBf1gWZgSgGB71XvlS3t8tA/pub?w=564&h=463)

#### AngularJS

<script src="https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/abb6f28e57fca55e5551256a9851519f944f3d32/src/main/webapp/angularjs.html?embed=t"></script>

Este es el mismo ejemplo, pero usando AngularJS. Notemos que no fue necesario crear todo un servidor RESTful, ya que nuestro servlet devuelve los valores como si fuera un servidor JAX-RS. Claro, no es exactamente igual, pero como usa el estándar JSON, será más fácil hacer la portabilidad.

- Los select (línea 32 y 38) tienen enlazados por el modelo y el controlador los valores a cargar. Los modelos son llenados en el script que está a partir de la línea 46

- Nuevamente obtiene los valores del servlet (Línea 49 y 51)

- Cuando es obtenida la lista, se le pasa a la variable de alcance `productCodeList` (línea 53) En ese momento, las opciones del combo son actualizadas (línea 33)

- Cuando el valor del combo productCode cambia, ejecuta el método `productCodeOnChange()` que fue definido en la directiva `ng-change`.

- El método&nbsp `productCodeOnChange()` funciona de la misma manera que el otro combo:

- .. obtiene la lista del servlet (línea 56 y 58)

- .. usando el parámetro el parámetro respectivo (línea 60)

- Y cuando se tienen los valores, son pasados a la variable `productList` (línea 63) que actualiza inmediatamente el combo (Línea 36)

Y este es el resultado. No tiene mucha diferencia visual, pero el código fue mucho más reducido, ya que no hemos tenido que pelearnos con el DOM
![](https://docs.google.com/drawings/d/1kn3MdWWTih32D_VbWC-6ev9li5QNUNYo1TBRgVm_VRE/pub?w=575&h=387)

#### JQuery + Bootstrap

Bootstrap es un conjunto de estilos que ayudan a mejorar visualmente la aplicación sin hacer mucho código. Al código anterior en JQuery le pondremos algunas directivas de Bootstrap, y luce así

[![](https://docs.google.com/drawings/d/1pUTEb9X4kuTyikaeMGcJujzGWijfx5rqyFzP6xanimE/pub?w=769&h=617)](https://docs.google.com/drawings/d/1pUTEb9X4kuTyikaeMGcJujzGWijfx5rqyFzP6xanimE/pub?w=769&h=617)

El código fuente de está página está acá:

- [jquery-bootstrap.html](https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/master/src/main/webapp/jquery-bootstrap.html)

#### angularjs + Material Design

[Material Design](https://www.google.com/design/spec/material-design/introduction.html) son especificaciones web elaborado por Google para que las aplicaciones luzcan como... si fueran de Google. Además, la gente de AngularJS hizo una extensión de Angular para Material Design, llamada [Angular Material](https://material.angularjs.org/latest/). Consiste en usar las mismas instrucciones Angular, pero con el módulo "ngMaterial"... y cambiar algunos tags para que luzcan como Google.

Así luce la aplicación usando Angular Material.

[![](https://docs.google.com/drawings/d/1LQimwfWPeUHMXOd1wYDTNqrAv_8VIMV4LIJFQfmmq_8/pub?w=772&h=589)](https://docs.google.com/drawings/d/1LQimwfWPeUHMXOd1wYDTNqrAv_8VIMV4LIJFQfmmq_8/pub?w=772&h=589)

El código fuente de esta página está acá:

- [angularjs-material.html](https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/src/master/src/main/webapp/angularjs-material.html)

## Código fuente del proyecto

No me puedo terminar este post si no comparto el código fuente de este ejemplo.

- Aquí está para descargar: [https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/get/abb6f28e57fc.zip](https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/get/abb6f28e57fc.zip)

- Y aquí para descargarlo por git: [https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/](https://bitbucket.org/apuntesdejava/combo-dependiente-ajax/)

>

POST actualizado. Combos dependientes con Ajax, pero ahora con [@angularjs](https://twitter.com/angularjs) [https://t.co/ymENv6ATUK](https://t.co/ymENv6ATUK)

— Apuntes de Java (@apuntesdejava) [10 de marzo de 2016](https://twitter.com/apuntesdejava/status/708014821778841601)

<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>
