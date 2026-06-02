---
layout: post
title: "mysqldump: ignorando el tag DEFINER"
date: 2010-09-16T22:16:00Z
last_modified_at: 2010-09-16T22:16:19.325Z
author: "Diego Silva"
permalink: /2010/09/mysqldump-ignorando-el-tag-definer.html
canonical_url: https://www.apuntesdejava.com/2010/09/mysqldump-ignorando-el-tag-definer.html
tags:
  - "mysql"
  - "tips"
  - "trucos"
---

[![]({{ '/assets/blogger/logo-mysql-110x57.png' | relative_url }})]({{ '/assets/blogger/logo-mysql-110x57.png' | relative_url }})

Este es otro no-apunte-de-java. Se trata del MySQL.

Resulta que he tratado de hacer un dump de un servidor a otro. Pero como tienen usuarios restringidos por host, y el `mysqldump` me genera el script con el tag

```java
<code>
/*!50013 DEFINER=`root`@`10.%` SQL SECURITY DEFINER */
</code>
```

... pensé que debería haber algún parámetro de `mysqldump` para ignorar estos tags. Pero según el mismo MySQL dicen que tendría [problemas de seguridad](http://bugs.mysql.com/bug.php?id=24680) (vamos: darle derechos de pasar un VIEW o STORED PROCEDURE a alguien que no le corresponde).

Así que tuve que valerme de un comando de unix/linux para ignorar estos tag:

Este comando es el famoso [grep](http://www.gnu.org/software/grep/).

Y aquí está mi `mysqldump` modificado:

```java
<code>
mysqldump -u root -p -B  db100 | grep -v 'DEFINER' > dump.sql
</code>
```

Espero que les sea de utilidad.
