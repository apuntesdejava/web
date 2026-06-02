---
layout: post
title: "XML a Objeto Java"
date: 2010-05-25T05:01:00.003Z
last_modified_at: 2010-05-25T05:01:00.691Z
author: "Diego Silva"
permalink: /2010/05/xml-objeto-java.html
canonical_url: https://www.apuntesdejava.com/2010/05/xml-objeto-java.html
tags:
  - "apache"
  - "java"
  - "netbeans"
  - "xml"
---

¿Quién no ha querido convertir un archivo XML a objetos Java? Usando el DOM, es muy útil pero bastante trabajoso.

Hay un "parser" de [Apache Commons](http://commons.apache.org/) llamado [Digester](http://commons.apache.org/digester/)que permite convertir un XML (usando algunas reglas) a objetos Java. Lo he usado bastante tiempo y me es muy útil.

Así que comparto un ejemplo usando esta biblioteca.

[https://apuntes.dev.java.net/files/documents/10908/150452/ReadXML.tar.gz](https://apuntes.dev.java.net/files/documents/10908/150452/ReadXML.tar.gz)

En este ejemplo, se leerá el archivo [http://www.xmlfiles.com/examples/simple.xml](http://www.xmlfiles.com/examples/simple.xml), lo descargará de Internet usando [HttpClient](http://hc.apache.org/httpcomponents-client/index.html), y lo procesará usando DOM del JDK, y luego usando el Apache Digester.

Espero que les sea de utilidad.
