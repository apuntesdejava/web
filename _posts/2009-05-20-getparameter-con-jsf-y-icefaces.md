---
layout: post
title: "getParameter() con JSF y ICEfaces"
date: 2009-05-20T19:27:00.003Z
last_modified_at: 2009-06-15T20:19:51.315Z
author: "Diego Silva"
permalink: /2009/05/getparameter-con-jsf-y-icefaces.html
canonical_url: https://www.apuntesdejava.com/2009/05/getparameter-con-jsf-y-icefaces.html
tags:
  - "web"
  - "jsp"
  - "ICEfaces"
  - "jsf"
  - "tips"
  - "trucos"
---

Cuando se quiere obtener el parámetro de un URL usando JSP, se usa así:

```java
<code>String param=request.getParameter("nombre");</code>
```

En JSF, es un poquitín más largo:

```java
<code><br />String param=FacesContext.getCurrentInstance().getExternalContext()<br />             .getRequestParameterMap().get("nombre");</code>
```

Pero lo anterior no funciona en ICEfaces. Devuelve siempre nulo.

Si se quiere obtener el parámetro por URL, se debe escribir:

```java
<code><br />String param=((HttpServletRequest)FacesContext.getCurrentInstance()<br />             .getExternalContext().getRequest()).getParameter("nombre");</code>
```
