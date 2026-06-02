---
layout: post
title: "Cómo agregar un javascript o css a un portlet"
date: 2013-07-23T18:53:00.001Z
last_modified_at: 2013-09-20T17:20:37.663Z
author: "Diego Silva Límaco"
permalink: /2013/07/como-agregar-un-javascript-o-css-un.html
canonical_url: https://www.apuntesdejava.com/2013/07/como-agregar-un-javascript-o-css-un.html
tags:
  - "liferay"
  - "portlets"
  - "tips"
---

En liferay, cuando creamos un portlet, éste tiene un .js y un .css asociados directamente al portlet. Modificamos allí, creamos nuestras cascadas o funciones JavaScript y listo. ¿Pero si queremos agregar un .js de terceros únicamente a este portlet? Aquí dejo un tip.

Primero, debemos considerar el taglib `liferay-util`

```java
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>
```

Luego, debemos agregar los siguientes tags, si queremos que aparezcan nuestro JavaScript o CSS al inicio de la página web.

```java
<liferay-util:body-top>
 <script type="text/javascript" src="<%=PortalUtil.getStaticResourceURL(request,request.getContextPath() + "/js/mi_archivo.js")%>"></script>

</liferay-util:body-top>

<liferay-util:body-bottom>
 <script type="text/javascript">
  alert("cargado");
 </script>
</liferay-util:body-bottom>
```

Y si queremos que aparezca al inicio de todo el HTML, usamos el tag `<liferay-util:html-top>`
Y al final del html `<liferay-util:html-bottom>`
