---
layout: post
title: "Liferay 7.2. Navegando entre páginas"
date: 2019-07-15T23:01:00.003Z
last_modified_at: 2019-07-15T23:01:51.798Z
author: "Diego Silva Límaco"
permalink: /2019/07/liferay-72-navegando-entre-paginas.html
canonical_url: https://www.apuntesdejava.com/2019/07/liferay-72-navegando-entre-paginas.html
description: "En este post conoceremos un poco la navegación de Liferay considerando el tag liferay-portlet:renderURL."
tags:
  - "liferay"
  - "video"
  - "portlets"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vTxdgH8MG-YCvMVRSrC-WoVQy428pJq_5okgcOgeV3XxFaMGQxzdAnC4BUBSKADSRe46f-edfvTxTIn/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vTxdgH8MG-YCvMVRSrC-WoVQy428pJq_5okgcOgeV3XxFaMGQxzdAnC4BUBSKADSRe46f-edfvTxTIn/pub?w=1440&h=810)

Como en toda página web es necesario conocer cómo navegar entre páginas. Naturalmente usaremos un tag `a`, pero un portlet de Liferay necesita cierto cuidado dado que se deben pasar parámetros específicos, además de considerar valores precargados dependiendo del caso.

En este post conoceremos un poco la navegación de Liferay considerando el tag `liferay-portlet:renderURL`.

<iframe allowfullscreen="" frameborder="0" height="270" src="https://www.youtube.com/embed/CFP2Dv0_y64" width="480"></iframe>

## RenderURL

El URL se crea usando el tag `liferay-portlet:renderURL` de la siguiente manera:

```java
<liferay-portlet:renderURL var="editURL">
 <liferay-portlet:param name="mvcPath" value="/edit.jsp"/>
 </liferay-portlet:renderURL>
```

Esta es una manera directa de crear un enlace hacia una página en específico, solo que existen dos problemas:

- Si deseamos cambiar el destino de ese enlace, tendríamos que buscar todas los enlaces que apunten a esa página y cambiar manualmente.

- Si deseas precargar valores antes de mostrar `edit.jsp`, sería algo dificultoso.

Por eso, la recomendación es una clase que implemente la interfaz `com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand`. Esta clase, por convención, debe tener el nombre finalizado por `-RenderCommand`

. Así:

```java
//...
public class CourseEditRenderCommand implements MVCRenderCommand {
//...
```

Luego, en la implementación del método, debemos hacer que devuelva la página que queremos mostrar, así:

```java
//...
public class CourseEditRenderCommand implements MVCRenderCommand {

 @Override
 public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {

  return "/edit.jsp"; //aquí se devuelve la página
 }

}
```

Y, finalmente, debemos declarar la anotación que declara que esta clase es un Componente de Liferay, así:

```java
//...
@Component(
  immediate = true,
  property = {
   "javax.portlet.name=" + CoursePortletKeys.COURSE, //el mismo nombre del portlet
   "mvc.command.name=edit-course"                    //el nombre único para llegar a este render
  },
  service = MVCRenderCommand.class                          //servicio de tipo MVCRenderCommand
 )
public class CourseEditRenderCommand implements MVCRenderCommand {
//...
```

La clase completa es:

```java
package com.apuntesdejava.virtualclassroom.course.portlet;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

import com.apuntesdejava.virtualclassroom.course.constants.CoursePortletKeys;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;

@Component(
  immediate = true,
  property = {
   "javax.portlet.name=" + CoursePortletKeys.COURSE,
   "mvc.command.name=edit-course"
  },
  service = MVCRenderCommand.class
 )
public class CourseEditRenderCommand implements MVCRenderCommand {

 @Override
 public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {

  return "/edit.jsp";
 }

}
```

Finalmente, la declaración del URL desde el JSP para llamar será así:

```java
<liferay-portlet:renderURL var="editURL">
 <liferay-portlet:param name="mvcRenderCommandName" value="edit-course"/> <!-- el nombre del render -->
</liferay-portlet:renderURL>

<aui:a href="<%= editURL %>">Editar</aui:a> <!-- usando el enlace -->
```

## Bonus

Es recomendable poner enlaces que permitan regresar a la página anterior, por eso en el `init.jsp` declararemos las siguientes variables:

```java
<%
 String currentURL = PortalUtil.getCurrentURL(renderRequest);
 String backURL = ParamUtil.getString(renderRequest, "backURL");
%>
```

Luego, en la declaración del URL, colocar el parámetro `backURL` apuntando a la página actual:

```java
<liferay-portlet:renderURL var="editURL">
 <liferay-portlet:param name="mvcRenderCommandName" value="edit-course"/>
 <liferay-portlet:param name="backURL" value="<%= currentURL %>"/>
 </liferay-portlet:renderURL>

 <aui:a href="<%= editURL %>">Editar</aui:a>
```

Y, finalmente, en la página final, debería tener el tag que permita regresar. Ese se llama `liferay-ui:header`, y se usaría así:

```java
<%@ include file="init.jsp" %>
<liferay-ui:header title="course.edit" backURL="<%= backURL %>"></liferay-ui:header>
```

Espero que te haya gustado. Sígueme en mi canal en youtube para crear más contenido así. ¡Bendiciones a todos!
