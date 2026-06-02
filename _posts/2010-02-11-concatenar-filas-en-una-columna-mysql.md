---
layout: post
title: "Concatenar filas en una columna (MySQL)"
date: 2010-02-11T19:18:00Z
last_modified_at: 2010-02-11T19:18:03.952Z
author: "Diego Silva"
permalink: /2010/02/concatenar-filas-en-una-columna-mysql.html
canonical_url: https://www.apuntesdejava.com/2010/02/concatenar-filas-en-una-columna-mysql.html
tags:
  - "mysql"
  - "tips"
  - "trucos"
  - "off topic"
---

Este truco lo vi en la documentación de MySQL (vamos, sí, sí. no es Java, pero es algo que encontré y quiero compartirlo).

Imaginemos que tenemos una tabla así

```java
<code>+--------+--------+
| campo1 | campo2 |
+--------+--------+
| fila1  |   a    |
| fila2  |   b    |
| fila2  |   c    |
| fila1  |   b    |
| fila3  |   b    |
| fila2  |   c    |
+--------+--------+
</code>
```

Y queremos concatenar todos los valores del `campo2` por cada fila no repetida de `campo1` así:

```java
+--------+--------+
| campo1 | campo2 |
+--------+--------+
| fila1  |  a,b   |
| fila2  |  b,c   |
| fila3  |   b    |
+--------+--------+
```

Para ello, hay que usar la función de agregación [GROUP_CONCAT](http://dev.mysql.com/doc/refman/5.0/en/group-by-functions.html#function_group-concat)

```java
<code>
SELECT campo1,group_concat(distinct campo2) FROM tabla GROUP BY 1
</code>
```
