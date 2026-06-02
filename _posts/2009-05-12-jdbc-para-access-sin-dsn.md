---
layout: post
title: "JDBC para Access sin DSN"
date: 2009-05-12T21:52:00.004Z
last_modified_at: 2009-06-15T20:21:38.135Z
author: "Diego Silva"
permalink: /2009/05/jdbc-para-access-sin-dsn.html
canonical_url: https://www.apuntesdejava.com/2009/05/jdbc-para-access-sin-dsn.html
tags:
  - "jdbc"
  - "java"
  - "tips"
  - "trucos"
---

Para acceder a Access desde un JDBC, siempre nos han enseñado que se debe a Herramientas Administrativas > Administrador de Orígines de ODBC, crear un nuevo Origen, especificar el nombre del DNS, bla bla bla, y después desde el JDBC escribir como URL el  nombre del DNS, bla bla.
Lo malo de esta técnica es que en cada máquina donde se va a ejecutar la aplicación java, necesita que se configure el ODBC. Ya que somos profesionales, debemos evitar las configuraciones adicionales para que nuestra aplicación funcione.

Java nos hace profesionales :)

Así que, ahora evitaremos todo el rollo de crear el DSN en el ODBC. Usemos esto:

```java
<code>Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");<br />String myDB ="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=C:/data/neptuno.MDB";<br />Connection conn = DriverManager.getConnection(myDB,"","");</code>
```

Pero no solo es para Access, sino para cualquier ODBC. Veamos como hacer lo mismo pero para con el Excel

```java
<code>Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");<br />String myDB = "jdbc:odbc:Driver={Microsoft Excel Driver (*.xls)};DBQ=c:/data.xls;"<br />            + "DriverID=22;READONLY=false";<br />Connection conn=DriverManager.getConnection(myDB,"","");</code>
```
