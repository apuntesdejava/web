---
layout: post
title: "El problema del AUTO_INCREMENT con el API de Persistencia"
date: 2007-09-06T19:27:00Z
last_modified_at: 2009-04-25T21:55:03.695Z
author: "Diego Silva"
permalink: /2007/09/el-problema-del-autoincrement-con-el.html
canonical_url: https://www.apuntesdejava.com/2007/09/el-problema-del-autoincrement-con-el.html
tags:
  - "jpa"
  - "netbeans"
---

Al crear una clase entidad utilizando el API de persistencia (JPA) con Netbeans,  el IDE creará por omisión los ID con las siguientes anotaciones

```java
<code>    @Id<br />@GeneratedValue(strategy = GenerationType.AUTO)<br /><br /></code>
```

Con ello creará una tabla llamada SEQUENCE donde almacenará el valor del último ID utilizado. Es lo más estándar posible, ya que sabemos que existen RDBMS que no tienen la capacidad de generar un ID autoincrementado (como el Firebird, que necesita de un generator).

Pero ¿si uso MySQL, Apache Derby (o un RDBMS que pueda permitir valores de ID autoincrementales)? Pues, si revisamos la documentación de Java

[http://java.sun.com/javaee/5/docs/api/javax/persistence/GenerationType.html#SEQUENCE](http://java.sun.com/javaee/5/docs/api/javax/persistence/GenerationType.html#SEQUENCE)

dice textualmente " Indicates that the persistence provider must assign primary keys for the entity using database sequence column."

entonces, la anotación que necesitamos es

```java
<code>    @GeneratedValue(strategy = GenerationType.SEQUENCE)<br /><br /></code>
```

Para salir de las dudas, al ejecutar nuestra aplicación, veremos que en la carpeta del proyecto (Ctrl + 2 en Netbeans) veremos archivos de extensión .sql: createDDL.sql y dropDDL.sql. Abrimos el primero y veremos que hay un sql como este:

```java
<code><br />CREATE TABLE PERSONA (<span style="font-weight: bold; color: rgb(0, 0, 153);">ID BIGINT <span style="color: rgb(204, 0, 0);">AUTO_INCREMENT</span> NOT NULL</span>, NOMBRE VARCHAR(255), EDAD INTEGER, PRIMARY KEY (ID))<br /><br /></code>
```

... si hemos usado MySQL, mientras que con Apache Derby, se mostraría así:

```java
<code>CREATE TABLE PERSONA (<span style="font-weight: bold; color: rgb(0, 0, 153);">ID BIGINT <span style="color: rgb(255, 0, 0);">GENERATED ALWAYS AS IDENTITY</span> NOT NULL</span>, NOMBRE VARCHAR(255), EDAD INTEGER, PRIMARY KEY (ID))<br /><br /></code>
```
