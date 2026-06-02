---
layout: post
title: "Convertir cualquier cadena en objeto java.util.Date"
date: 2010-05-25T17:21:00.001Z
last_modified_at: 2010-05-25T17:22:20.805Z
author: "Diego Silva"
permalink: /2010/05/convertir-cualquier-cadena-en-objecto.html
canonical_url: https://www.apuntesdejava.com/2010/05/convertir-cualquier-cadena-en-objecto.html
tags:
  - "formateo"
  - "java"
  - "tips"
  - "trucos"
---

```java
<code class="prettyprint">
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date date = dateFormat.parse("2010-05-17 15:18:19");
</code>
```
