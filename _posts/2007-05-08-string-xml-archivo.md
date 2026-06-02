---
layout: post
title: "String XML a Archivo"
date: 2007-05-08T21:58:00Z
last_modified_at: 2009-04-25T21:55:03.718Z
author: "Diego Silva"
permalink: /2007/05/string-xml-archivo.html
canonical_url: https://www.apuntesdejava.com/2007/05/string-xml-archivo.html
tags:
  - "xml"
---

La manera más común de mandar una cadena a un archivo es justamente usar Streams.
Pero podemos aprovechar el JDK utilizando los manejadores XML que tiene incorporado.

Asumiendo que la variable **xml** es un String que contiene un XML válido, y la variable **f** es un objeto de tipo java.io.File.

<style type="text/css"><br /><!-- body {color: #000000; background-color: #ffffff; font-family: Monospaced} table {color: #000000; background-color: #e9e8e2; font-family: Monospaced} .java-keywords {color: #000099; font-family: Monospaced; font-weight: bold} .java-layer-method {font-family: Monospaced; font-weight: bold} .java-string-literal {color: #99006b} --><br /></style>

```java
<br />          DocumentBuilderFactory factory = DocumentBuilderFactory.<span class="java-layer-method">newInstance</span>();<br />          DocumentBuilder builder = factory.<span class="java-layer-method">newDocumentBuilder</span>();<br />          Document document = builder.<span class="java-layer-method">parse</span>(<span class="java-keywords">new</span> <span class="java-layer-method">InputSource</span>(<span class="java-keywords">new</span> <span class="java-layer-method">StringReader</span>(xml)));<br />          document.<span class="java-layer-method">setXmlVersion</span>(<span class="java-string-literal">"1.0"</span>);<br />          Source source=<span class="java-keywords">new</span> <span class="java-layer-method">DOMSource</span>(document);<br />          Result result=<span class="java-keywords">new</span> <span class="java-layer-method">StreamResult</span>(f);<br />          Transformer xformer= TransformerFactory.newInstance().newTransformer();<br />        <br />          xformer.transform(source, result);<br />
```
