---
layout: post
title: "getParameter en JSF"
date: 2009-02-09T15:12:00.001Z
last_modified_at: 2009-06-15T20:56:17.434Z
author: "Diego Silva"
permalink: /2009/02/getparameter-en-jsf.html
canonical_url: https://www.apuntesdejava.com/2009/02/getparameter-en-jsf.html
tags:
  - "netbeans"
  - "jsf"
  - "web"
  - "tips"
---

En JSF todos los valores de los formularios se pasan por ManagedBeans (con más detalle lo veremos en el curso que está a punto de salir)
Pero ¿qué pasa si queremos procesar una petición con parámetros? En Java web y Struts podemos acceder a los parámetros a través del objeto implícito "request", pero JSF no hay ese objeto implícito ¿qué se hace?

Bueno, para acceder al objeto request debemos hacer lo siguiente:

```java
<code>HttpServletRequest request = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();<br /></code>
```

A partir de allí, podemos usar el objeto `request`. Ahora, los nombres de los controles tendrán un ligero cambio. Estará compuesto por el "id" del formulario y del "id" del mismo control. Por ejemplo, consideremos este .jsp

```java
<code><h:form id="form0"><br />  <h:outputLabel value="Escriba n&#250;mero:"/><br />  <h:inputText id="numeroText" value="#{form.numero}" /><br/><br />...<br /></code>
```

Entonces, para acceder al input-text, escribimos:

```java
<code>String num=request.getParameter("form0:numeroText");</code>
```
