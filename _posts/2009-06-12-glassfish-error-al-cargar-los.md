---
layout: post
title: "Glassfish: \" Error al cargar los descriptores de implementación para el módulo...\""
date: 2009-06-12T18:10:00.005Z
last_modified_at: 2009-06-15T20:16:43.342Z
author: "Diego Silva"
permalink: /2009/06/glassfish-error-al-cargar-los.html
canonical_url: https://www.apuntesdejava.com/2009/06/glassfish-error-al-cargar-los.html
tags:
  - "glassfish"
  - "webservices"
  - "netbeans"
  - "ejb"
  - "tips"
  - "trucos"
---

El escenario es el siguiente:
Tienes un módulo EJB que consume un WebService, ya sea desde otro proyecto local o desde un WSDL externo al proyecto. Y tienes una aplicación web que utiliza el módulo EJB. Cuando despliegas el EJB, no hay problemas, pero cuando despliegas el módulo web, no sale nada y lanza un error:

```java
<code> wsdl file META-INF/wsdl/client/......wsdl does not exist for service-ref...</code>
```

Dirás (como yo dije) "pero si compila!!!".. y pensarás "y si consumo el WS dentro del modulo web?". y te negarás porque eso rompería el esquema que pensabas...

bueno... alguien también le pasó y también encontró la solución.

Nada más hay que revisar el código que crea NetBeans en el EJB cuando consume un WebService:

```java
<code>@WebServiceRef(wsdlLocation = "META-INF/wsdl/client/ProductsList/localhost_8084/ProductsListService/ProductsList.wsdl")<br />private ProductsListService service;</code>
```

El EJB lo consume normalemente, porque el WSDL está dentro del mismo proyecto EJB. Cuando es llamado desde el módulo Web, el EJB buscará el wsdl desde donde fue llamado, y como el módulo web no tiene ese archivo, manda el error que mencioné.

**Solución:**
**La más pesada:** poner el EJB y el web dentro de un Enterprise Application.

**La más técnica:** Copiar el archivo .wsdl dentro de la carpeta del web, y cambiar la referencia (`wsdlLocation`) a esa nueva ubicación.

**La más práctica:**
En el EJB que consume el WebService, cambiar el valor de `wsdlLocation` y colocar el URL del WSDL público.

```java
<code >@WebServiceRef(wsdlLocation = "http://localhost:8084/ProductsListService/ProductsList.wsdl")<br />private ProductsListService service;</code>
```

Obviamente, el URL debe ser el del WSDL real que estas consumiendo. Yo usé este para poder ilustrar el ejemplo.

**La más elegante:** Usar algún [ESB](http://en.wikipedia.org/wiki/Enterprise_Service_Bus), pero eso será tema de otro post.
