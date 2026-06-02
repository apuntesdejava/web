---
layout: post
title: "String to XML"
date: 2006-11-27T02:01:00Z
last_modified_at: 2009-04-25T21:55:03.910Z
author: "Diego Silva"
permalink: /2006/11/string-to-xml.html
canonical_url: https://www.apuntesdejava.com/2006/11/string-to-xml.html
tags:
  - "xml"
  - "java"
---

Necesitaba una función que me permitiera convertir una cadena en un objeto para manipular XML. Lo que hacía era crear un archivo .xml, le colocaba la cadena, lo cerraba  y lo abría después con el objeto Document. Pero aquí tengo otra función mejor

`
String xmlString = request.getParameter("PARAM1"); //obtengo la cadena
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); //un factory
DocumentBuilder builder = factory.newDocumentBuilder(); //el documento
Document document = builder.parse(new InputSource(new StringReader(xmlString))); //aqui le paso al Document

`
