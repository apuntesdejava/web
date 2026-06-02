---
layout: post
title: "net.sf.jasperreports.engine.JRRuntimeException: Unknown hyperlink target 0"
date: 2010-06-02T14:42:00Z
last_modified_at: 2010-06-02T14:45:38.420Z
author: "Diego Silva"
permalink: /2010/06/netsfjasperreportsenginejrruntimeexcept.html
canonical_url: https://www.apuntesdejava.com/2010/06/netsfjasperreportsenginejrruntimeexcept.html
tags:
  - "java"
  - "jasperreports"
  - "tips"
  - "errores"
  - "ireport"
---

Si haz usado [iReport](http://jasperforge.org/projects/ireport)para hacer tus reportes, y al ejecutarlo en un servidor lanza este error

```java
<code>net.sf.jasperreports.engine.JRRuntimeException: Unknown hyperlink target 0</code>
```

y por más que compiles y recompiles el .jrxml, lanza el mismo error.... revisa las versiones del iReport y del [JasperReports](http://jasperforge.org/projects/jasperreports)utilizado en el proyecto.

Asegúrate que sean la misma versión. En la publicación de este post, la versión del [iReport](http://jasperforge.org/projects/ireport)es 3.7.3 al igual que el [JasperReports](http://jasperforge.org/projects/jasperreports).

Para ver todas las versiones del JasperReports, revisa esta página

[http://sourceforge.net/projects/jasperreports/files/jasperreports](http://sourceforge.net/projects/jasperreports/files/jasperreports)

Y para ver las de iReport

[http://sourceforge.net/projects/ireport/files/iReport/](http://sourceforge.net/projects/ireport/files/iReport/)

También existe el plugin para NetBeans

[http://sourceforge.net/projects/ireport/files/iReport%20Plugin%20for%20NetBeans/](http://sourceforge.net/projects/ireport/files/iReport%20Plugin%20for%20NetBeans/)
