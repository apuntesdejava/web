---
layout: post
title: "According to TLD or attribute directive in tag file, attribute value does not accept any expressions"
date: 2007-07-13T00:04:00Z
last_modified_at: 2009-04-25T21:55:03.726Z
author: "Diego Silva"
permalink: /2007/07/according-to-tld-or-attribute-directive.html
canonical_url: https://www.apuntesdejava.com/2007/07/according-to-tld-or-attribute-directive.html
tags:
  - "jstl"
  - "web"
  - "jsp"
---

Este error me sucedían una y otra vez, revisaba los JSP, los TLD (que estaban dentro del .jar y siempre me aparecía ese error

According to TLD or attribute directive in tag file, attribute value does not accept any expressions

... no me dejaría resignar en dejar los JSTL solo porque a veces me sale y otras veces puedo evaluar una evaluación como.

```java
<code><c:out value="${1+2}"/><br /></code>
```

La solución es sencilla:
No debo de usar esta declaración del taglib

```java
<code><%@taglib uri="http://java.sun.com/jstl/core" prefix="c"%><br /><br /></code>
```

Sino esta:

```java
<code><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><br /><br /></code>
```
