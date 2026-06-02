---
layout: post
title: "Migración de datos de MySQL desde Windows a Linux"
date: 2014-01-29T21:48:00.001Z
last_modified_at: 2014-01-29T21:48:43.128Z
author: "Diego Silva Límaco"
permalink: /2014/01/migracion-de-datos-de-mysql-desde.html
canonical_url: https://www.apuntesdejava.com/2014/01/migracion-de-datos-de-mysql-desde.html
tags:
  - "nojava"
  - "mysql"
  - "tips"
  - "off topic"
  - "trucos"
---

[![]({{ '/assets/blogger/logo-mysql-110x57.png' | relative_url }})]({{ '/assets/blogger/logo-mysql-110x57.png' | relative_url }})

Este es otro apunte "No Java"

Si creas tablas en MySQL con nombres en Mayusculas/Minúsculas, habrás notado que puedes migrar la base de datos de un MySQL en Linux a uno en Windows sin problema.. pero no sucede al revés. ¿Por qué?

MySQL crea un archivo un archivo físico por cada tabla. Entonces, en Linux una tabla llamada "Cuenta" no es lo mismo a "cuenta", ya que el sistema de archivos de Linux no lo permite. En cambio, en Windows, "Cuenta" es lo mismo que "cuenta".

Por tanto, desde un inicio se debe considerar cómo debe de manejarse los nombres de las tablas: o todo mayúsculas o todo minúsculas, o en CamelCase.

Pero digamos que hemos estado usando  - por algún estándar caprichoso como el de Hibernate - llegamos a usar las tablas en CamelCase... y nos hemos acostumbra a usar siempre ese formato. Todo estamos felices en el mundo de Windows.... y de pronto nos piden migrarlo a Linux. Se hace la migración sin problema y ¡PUM! Nuestras aplicaciones no funcionan, porque a veces se llama a la tabla "cuenta" o a la tabla "CUENTA" o "Cuenta". Para Linux son cosas diferentes. Por tanto: o buscamos todas las incidencias en los códigos fuente donde se utilizan esas tablas, y cambiarlos a un solo estándar... o regresamos a Windows... o... hacer que MySQL del Linux ignore los nombres con Mayúsculas/Minúsculas de tal manera que cuando se llame a la tabla "Cuenta" puede hacerse también usando "CUENTA" o "cuenta" de manera indistinta.

¿Cómo se hace eso?

**Primero**: Debemos exportar la base de datos **sin considerar comillas** en la creación de las tablas.

Esto es: un "create table Cuenta..." no es lo mismo a "create table `Cuenta`..." ¿por qué? Porque en la creación de la tabla, al considerar las comillas, estamos diciéndole **que se creará **con el nombre "Cuenta" **pero se accederá **con ese nombre.

Para exportarlo sin considerar comillas, se usará la opción "quote-names"

```java
mysqldump -u root -p base_de_datos --quote-names=false > archivo.sql
```

**Segundo:** Modificar el archivo **my.cnf** en el servidor destino (Linux) y agregamos la siguiente línea en la sección `[mysqld]`

`
`

```java
[mysqld]
//... más líneas de configuración
lower_case_table_names=1
```

.. y reiniciamos el servicio MySQL de Linux.

**Finalmente: **importamos el archivo exportado en el MySQL Linux y listo.

```java
select * from Cuenta
```

será igual que

```java
select * from CUENTA
```
