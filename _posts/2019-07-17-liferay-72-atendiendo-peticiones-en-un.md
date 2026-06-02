---
layout: post
title: "Liferay 7.2. Atendiendo peticiones en un Portlet"
date: 2019-07-17T22:24:00.001Z
last_modified_at: 2019-07-17T22:24:31.451Z
author: "Diego Silva Límaco"
permalink: /2019/07/liferay-72-atendiendo-peticiones-en-un.html
canonical_url: https://www.apuntesdejava.com/2019/07/liferay-72-atendiendo-peticiones-en-un.html
description: "Lo que ahora veremos es cómo atender peticiones tipo POST que generalmente están asociadas a las peticiones de un formulario"
tags:
  - "liferay"
  - "video"
  - "portlets"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vQh9FP3WpHhNjo8yzKjDE65ruys-6Hig6hbf8UfQfWLnpelD5xPZj5quWVb3i_O0hk0scgKQdosD5Bv/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vQh9FP3WpHhNjo8yzKjDE65ruys-6Hig6hbf8UfQfWLnpelD5xPZj5quWVb3i_O0hk0scgKQdosD5Bv/pub?w=1440&h=810)

Continuamos con las peticiones de un Portlet. En el anterior post vimos como navegar entre páginas. Esto es análogo a las peticiones GET de HTTP. Lo que ahora veremos es cómo atender peticiones tipo POST que generalmente están asociadas a las peticiones de un formulario.

<iframe allowfullscreen="" frameborder="0" height="270" src="https://www.youtube.com/embed/Uikpy_-h3W4" width="480"></iframe>

Similar al `MVCRenderCommand` del [anterior post](http://bit.ly/2XN2aVG), aquí debemos crear una clase que implemente a `com.liferay.portal.kernel.portlet.bridges.mvc.MVCActionCommand`. Esta clase sería algo como esta:

```java
package com.apuntesdejava.virtualclassroom.course.portlet;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletException;

import org.osgi.service.component.annotations.Component;

import com.apuntesdejava.virtualclassroom.course.constants.CoursePortletKeys;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCActionCommand;
import com.liferay.portal.kernel.util.ParamUtil;
@Component(
  immediate = true,
  property = {

   "javax.portlet.name=" + CoursePortletKeys.COURSE,  //el portlet al que pertenece
   "mvc.command.name=/course/update" //el nombre de esta action
  },
  service = MVCActionCommand.class
 )
public class CourseUpdateMVCActionCommand implements MVCActionCommand {

 @Override
 public boolean processAction(ActionRequest actionRequest, ActionResponse actionResponse) throws PortletException {
  String courseName = ParamUtil.getString(actionRequest, "name"); //recibimos un parámetro...
  _log.info("nombre del curso:"+courseName);    //... y lo mostramos
  return true; //devolvemos true para indicar que fue satisfactorio
 }

 private static final Log _log=LogFactoryUtil.getLog(CourseUpdateMVCActionCommand.class);

}
```

Luego, en nuestro `edit.jsp` debemos crear el URL, usando `<liferay-portlet:actionURL>` que está asociado al action que acabamos de crear. El nombre del action irá en el atributo `name`, así:

```java
<liferay-portlet:actionURL var="updateURL" name="/course/update">
</liferay-portlet:actionURL>
```

Ahora, crearemos nuestro formulario usando los tags de Liferay:

```java
<aui:form action="<%= updateURL %>">
 <aui:input name="name" label="course.name" type="text" ></aui:input>

 <aui:button-row>
  <aui:button type="submit" value="save"></aui:button>
  <aui:button type="cancel" value="cancel" href="<%= backURL %>"></aui:button>
 </aui:button-row>
</aui:form>
```

Todo el JSP lucirá así:

```java
<%@ include file="init.jsp" %>
<liferay-ui:header title="course.edit" backURL="<%= backURL %>"></liferay-ui:header>

<liferay-portlet:actionURL var="updateURL" name="/course/update">
 <liferay-portlet:param name="backURL" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>

<aui:form action="<%= updateURL %>">
 <aui:input name="name" label="course.name" type="text" ></aui:input>

 <aui:button-row>
  <aui:button type="submit" value="save"></aui:button>
  <aui:button type="cancel" value="cancel" href="<%= backURL %>"></aui:button>
 </aui:button-row>
</aui:form>
```

Y listo, todo queda igual.

En el vídeo podrás apreciar cómo funciona todo junto.

Si te gustó el vídeo, dale like; si te es útil, compártelo... es gratis.

Y si tienes algún comentario, pregunta, queja, denuncia, no dejes de hacerlas en la caja de comentarios de aquí o el del vídeo, y así estaremos más en contacto.

¡Bendiciones!
