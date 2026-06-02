---
layout: post
title: "Liferay 7.2. Service Layer + Portlet. Un CRUD básico"
date: 2020-02-04T16:51:00.001Z
last_modified_at: 2020-02-04T16:51:51.203Z
author: "Diego Silva Límaco"
permalink: /2020/02/liferay-72-service-layer-portlet-un.html
canonical_url: https://www.apuntesdejava.com/2020/02/liferay-72-service-layer-portlet-un.html
description: "En este post conoceremos cómo implementar un CRUD muy básico, pero consiste en unir el Service layer con el Portlet. Aquí ya unimos las piezas que forman el MVC en Liferay."
tags:
  - "liferay"
  - "web"
  - "portales"
  - "tutorial"
  - "video"
  - "portlets"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vS9xw2cEtjbvK9hV2JSEATTxi5--5ZA09r3NYjrmu8Ztf3_9-igOogL9omMvIR-7fOk3RV93W7F88bk/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vS9xw2cEtjbvK9hV2JSEATTxi5--5ZA09r3NYjrmu8Ztf3_9-igOogL9omMvIR-7fOk3RV93W7F88bk/pub?w=1440&h=810)

En este post conoceremos cómo implementar un CRUD muy básico, pero consiste en unir el Service layer con el Portlet. Aquí ya unimos las piezas que forman el MVC en Liferay.

## A por el código

### Ordenando un poco el código

Comenzaremos por ordenar un poco la casa. Siempre es recomendable usar constantes en lugar de poner una cadena expresa en cada declaración. Así que las URL de cada petición del portlet lo pondremos en una clase llamada `ConstantsCommands.java` en el módulo del Portlet. Aquí el código:

```java
package com.apuntesdejava.virtualclassroom.course.constants;

public class ConstantsCommands {
 public static final String NEW_COURSE="/course/new";
 public static final String EDIT_COURSE="/course/edit";
 public static final String UPDATE_COURSE="/course/update";
}
```

Y en la clase `CourseEditMVCRenderCommand.java` vamos a utilizar esas declaraciones. Además, esta clase se va a invocar desde dos peticiones: cuando sea nuevo registro, y cuando se edite registro. Así que tendrá dos nombres:

```java
@Component(
  immediate = true,
  property = {

   "javax.portlet.name=" + CoursePortletKeys.COURSE,
   "mvc.command.name="+ConstantsCommands.NEW_COURSE,
   "mvc.command.name="+ConstantsCommands.EDIT_COURSE
  },
  service = MVCRenderCommand.class
 )
public class CourseEditMVCRenderCommand implements MVCRenderCommand {
//...
```

### Juntando Service Layer en el Portlet

Ahora bien, necesitamos juntar ambas capas. Necesitamos utilizar la interfaz, el API de nuestra capa de servicio. Ojo, no vamos a poner la implementación como se hacía antes de la versión 7. Antes se juntaba todo en un .war: capa de servicio , interfaz y clases implementadas. Ahora, con el modelo OSGi, todo van en .jars diferentes, y se invocan a través del nombre de cada bundle. Así que, en nuestro `course-portlet/build.gradle` le pondremos esa dependencia.

```java
dependencies {
 compileOnly group: "com.liferay.portal", name: "com.liferay.portal.kernel"
 compileOnly group: "com.liferay.portal", name: "com.liferay.util.taglib"
 compileOnly group: "javax.portlet", name: "portlet-api"
 compileOnly group: "javax.servlet", name: "javax.servlet-api"
 compileOnly group: "jstl", name: "jstl"
 compileOnly group: "org.osgi", name: "org.osgi.service.component.annotations"

 compileOnly project(":modules:classroom:classroom-api")
}
```

## Preparando el Portlet para edición y nuevo registro

Necesitamos acondicionar nuestro portlet para que realice dos momentos de nuestro CRUD: Preparar el formulario para: nuevo registro y para editar. Y, debemos guardar los datos del registro tanto para el nuevo como para la edición.

Así que comenzaremos con preparar el formulario:

### Preparando el formulario

Ya habíamos hecho antes la clase `CourseEditMVCRenderCommand` que practicamente solo redireccionaba al archivo `/edit.jsp`. Ahora necesitamos considerar cuando se vaya a editar un registro. Asumiremos lo siguiente: este render recibirá como parámetro el ID del curso. Por lo que debemos buscar ese registro en la base de datos, y lo guardamos en un atributo del portlet. Para poder buscar en la base de datos necesitamos, primero, crear la referencia a la interfaz del Service Layer correcta. En este caso se llama a `CourseService`. Recordemos que es la interfaz. En la versión anterior a la 7 de Liferay, se llamaba a una clase que terminaba con Impl, y los métodos eran estáticos. Aquí no: estamos llamando a una interfaz. Su implementación será proporcionada por el servidor OSGi, así que no tendremos que preocuparnos. Agregamos la siguiente línea en `CourseEditMVCRenderCommand`.

```java
@Reference
 private CourseService _courseService;
```

Ahora vamos a cambiar el método `render()` a fin de poder obtener el registro de la base de datos. Solo si recibimos el parámetro `courseId` haremos la búsqueda. De lo contrario no haremos nada, y cuando se quiera acceder al atributo no se podrá obtener nada, solo `null`. Estas son las líneas a modificar:

```java
@Override
 public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {
  long courseId = ParamUtil.getLong(renderRequest, "courseId"); //obtenemos el parámetro numérico
  if (courseId > 0) { //si se envió, debería ser mayor a 0
   Course course = _courseService.fetchCourse(courseId); //buscamos el objeto en la base de datos
   renderRequest.setAttribute("course", course); //lo guardamos en un atributo. OJO con el nombre
  }
  return "/edit.jsp"; //continúa el flujo al JSP
 }
//...
```

Ahora vamos por el formulario. Este es el archivo `edit.jsp`. Recordemos el nombre del atributo guardado en el render último. Se llama `"course"` y puede tener valor o no. Editemos el código del jsp:

```java
<%@ include file="init.jsp" %>
<liferay-ui:header title="course.edit" backURL="<%= backURL %>"></liferay-ui:header>

<liferay-portlet:actionURL var="updateURL" name="<%=ConstantsCommands.UPDATE_COURSE %>">
 <liferay-portlet:param name="backURL" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>
<%Course course=  (Course)renderRequest.getAttribute("course") ; %>
<aui:form action="${updateURL }">
 <aui:model-context bean="<%=course %>" model="<%=Course.class %>"></aui:model-context>
 <aui:input name="courseId" type="hidden"></aui:input>
 <aui:input name="name" label="course.name"   ></aui:input>
 <aui:input name="description"   ></aui:input>

 <aui:button-row>
  <aui:button type="submit" value="save"></aui:button>
  <aui:button type="cancel" value="cancel" href="<%= backURL %>"></aui:button>
 </aui:button-row>
</aui:form>
```

Explicaremos línea por línea:

- Línea 4: es el nombre del action. Ahora usaremos la constante que hemos declarado antes.

- Línea 7: tratamos de obtener el objeto del render guardado con el nombre course. Si no tiene nada (porque el parámetro era 0) obtendrá nulo. Esta parte es importante recordar.

- Línea 9: definimos el contexto que tendrá nuestro formulario. En este caso, este formulario manejará un bean de tipo `Course`, y los datos de este formulario estarán en la variable `course` (de la línea 7). Si es nulo, entonces los atributos a mostrar en cada campo serán varios.

- Línea 10: Es un `input` de tipo `hidden` para saber a qué registro se está haciendo referencia. Si es nulo la variable `course`, entonces no mostrará nada en el valor.

- Línea 11,12 Son los `input` por cada campo. De la misma manera, si es nulo la variable `course`, entonces no mostrará nada. De lo contrario mostrará el valor en cada campo. Está asociado por el atributo `name` de cada `input`.

### Procesando la petición

Ahora bien, ya tenemos el formulario que - sí o sí - va a enviar datos. Así que cada campo lo leeremos y lo procesaremos. La clase ya existe, es la `CourseUpdateMVCActionCommand`. Así que editaremos el código de la siguiente manera:

Agregamos la referencia a `CourseService`

```java
private static final Log _log=LogFactoryUtil.getLog(CourseListMVCRenderCommand.class);

 @Reference
 private CourseService _courseService;
}
```

Ahora, vamos a editar el método `processAction()`:

```java
@Override
 public boolean processAction(ActionRequest actionRequest, ActionResponse actionResponse) throws PortletException {

  try {
   long courseId=ParamUtil.getLong(actionRequest, "courseId"); //obtenemos el ID del curso

   Map<locale string=""> name = LocalizationUtil.getLocalizationMap(actionRequest, "name"); //obtenemos el campo "name". Pero este es localizado, por lo que lo obtendremos así.
   String description=ParamUtil.getString(actionRequest, "description"); //El campo description, y es de manera simple texto.

   ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY); //Con este atributo podemos obtener información como el site donde se encuentra el portlet y el usuario.
   long groupId=themeDisplay.getScopeGroupId(); //el id del site para registrarlo
   ServiceContext serviceContext;
   serviceContext = ServiceContextFactory.getInstance(actionRequest); //creamos el contexto del servicio
   if (courseId==0) //si no tiene nada, entonces es NUEVO..
    _courseService.addCourse(groupId, name, description, serviceContext); //creamos el registro en la base de datos
   else //sino...
    _courseService.updateCourse(courseId, name, description, serviceContext); //... actualizamos el registro
   return true; //devuelve true porque terminó bien
  } catch (PortalException e) {
   _log.error(e);
  }
  return false; //devuelve false si termina mal

 }</locale>
```

### El listado

Ahora bien, tanto para crear un nuevo registro y como para editar un registro parten de un jsp que debería tener tanto el botón de NUEVO como el botón EDITAR por cada registro. Estos registros deberían estar en un listado. Solo para este post usaremos una tabla simple.

Necesitamos cargar todos los registros a mostrar. Se mostrará en `view.jsp` y antes de este paso debemos leer los registros. Crearemos un nuevo render, y la ruta que tendrá será la raiz. Este siempre se invocará únicamente cuando se llame a la raíz, es decir, al `view.jsp`. Clase `CourseListMVCRenderCommand`:

```java
@Component(
  immediate = true,
  property = {

   "javax.portlet.name=" + CoursePortletKeys.COURSE,  //pertenece al portlet
   "mvc.command.name=/" //va a ser llamado desde la raiz
  },
  service = MVCRenderCommand.class //será un Render
 )
public class CourseListMVCRenderCommand implements MVCRenderCommand {

 @Override
 public String render(RenderRequest renderRequest, RenderResponse renderResponse) throws PortletException {
  ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY); //para conocer el id del site...
  long groupId=themeDisplay.getScopeGroupId(); // el id del site donde se encuentra el portlet
  List<course> courses = _courseService.findByGroupId(groupId); //buscamos todos los registros del site
  renderRequest.setAttribute("courses", courses ); //lo guardamos en un atributo
  return null; //que continue el flujo normal.
 }
 private static final Log _log=LogFactoryUtil.getLog(CourseListMVCRenderCommand.class);

 @Reference
 private CourseService _courseService; //referencia al service layer
}</course>
```

Y, finalmente, tendremos el `view.jsp` con el siguiente contenido. Esto nos permitirá mostrar el listado obtenido en el render, y ponerle botones de edición:

```java
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@ include file="init.jsp" %>

<% List<Course> courses=(List<Course>)renderRequest.getAttribute("courses");  %>

<p>

  <liferay-portlet:renderURL var="newURL"  windowState="<%= LiferayWindowState.NORMAL.toString() %>" >
   <liferay-portlet:param name="mvcRenderCommandName" value="<%=ConstantsCommands.NEW_COURSE %>"/>
   <liferay-portlet:param name="backURL" value="<%= currentURL %>"/>
  </liferay-portlet:renderURL>
  <aui:button value="new" href="${newURL }"></aui:button>

  <table>
   <thead>
    <tr>
     <th>Nombre</th>
     <th>Descripcion</th>
     <th>-</th>
    </tr>
   </thead>
   <tbody>
   <%for(Course course:courses){ %>
    <tr>
     <td><%= course.getName(locale) %> </td>
     <td><%= course.getDescription() %></td>
     <td>
      <liferay-portlet:renderURL var="editURL">
       <liferay-portlet:param name="mvcRenderCommandName" value="<%=ConstantsCommands.EDIT_COURSE %>"/>
       <liferay-portlet:param name="backURL" value="<%= currentURL %>"/>
       <liferay-portlet:param name="courseId" value="<%= String.valueOf(course.getCourseId()) %>"/>
      </liferay-portlet:renderURL>

      <liferay-ui:icon-menu>
       <liferay-ui:icon url="${editURL }"  message="edit" >

       </liferay-ui:icon>
      </liferay-ui:icon-menu>
     </td>
    </tr>

   <%} %>
   </tbody>
  </table>
</p>
```

Explicamos línea por línea:

- Línea 5: Obtenemos los registros que hemos guardado en el render.

- Línea 10: Cambiaremos el nombre de la variable a newURL

- Línea 11: Usaremos la constante

- Línea 14: Aquí va nuestra variable URL

- A partir de la 16 armaremos una tabla para mostrar el contenido de los registros.

- Línea 25: Usando JSTL hacemos un recorrido de todos los registros de la lista.

- Línea 27: Mostramos el valor del campo name, pero como es localizado, usaremos como parámetro el objeto locale.

- Línea 28: Mostramos el valor del campo description.

- Línea 30: Preparamos un URL que hace el Render para mostrar el formulario de edición. Es similar al newURL pero en este caso le pasaremos el ID del registro.

- Línea 31: Le decimos que es un render

- Línea 33: Le pasamos el ID del registro.

- Línea 36: Mostraremos un menú de botones simpáticos.

- Línea 37: Solo pondremos - por ahora - un solo botón, que es el llama al render de la línea 30.

Y listo, ya tenemos nuestro CRUD (sin el D de delete) para nuestro portlet. Si no me creen, vean el vídeo a continuación.

## Vídeo explicado

<iframe allowfullscreen="" class="YOUTUBE-iframe-video" data-thumbnail-src="https://i.ytimg.com/vi/OIPS8YAuBo0/0.jpg" frameborder="0" height="266" src="https://www.youtube.com/embed/OIPS8YAuBo0?feature=player_embedded" width="320"></iframe>

## Recursos

El código fuente de esta publicación la puedes descargar desde aquí:

- Bitbucket: [https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/crud-basico/](https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/crud-basico/)

- Github: [https://github.com/apuntesdejava/liferay-virtual-classroom/tree/crud-basico](https://github.com/apuntesdejava/liferay-virtual-classroom/tree/crud-basico)
