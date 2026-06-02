---
layout: post
title: "JSP Invisibles (con Struts)"
date: 2007-01-13T05:21:00Z
last_modified_at: 2009-04-25T21:55:03.903Z
author: "Diego Silva"
permalink: /2007/01/jsp-invisibles-con-struts.html
canonical_url: https://www.apuntesdejava.com/2007/01/jsp-invisibles-con-struts.html
tags:
  - "web"
  - "struts"
---

No es buena idea que se accedan directamente a los JSP. Debería hacerse a través de un Action, o un forward:

`<html:link action="/algunAction">...</html:link>`

Y para asegurarnos de que no lo va hacer, es mejor protegerlo desde la configuración de la aplicación web:

```java
<web-app><br />...<br /><security-constraint><br /><web-resource-collection><br />  <web-resource-name>no_access</web-resource-name><br />  <url-pattern>*.jsp</url-pattern><br /></web-resource-collection><br /><auth-constraint><br /></auth-constraint><br />...<br /></security-constraint><br /></web-app>
```
