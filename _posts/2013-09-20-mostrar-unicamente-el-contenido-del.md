---
layout: post
title: "Mostrar únicamente el contenido del portlet en Liferay"
date: 2013-09-20T17:07:00Z
last_modified_at: 2013-09-20T17:24:27.040Z
author: "Diego Silva Límaco"
permalink: /2013/09/mostrar-unicamente-el-contenido-del.html
canonical_url: https://www.apuntesdejava.com/2013/09/mostrar-unicamente-el-contenido-del.html
tags:
  - "portlets"
  - "liferay"
  - "web"
  - "tips"
  - "trucos"
---

[![](/assets/blogger/heading.png)](/assets/blogger/heading.png)Este es un post corto, ya que es un tip.

Los portlets  tienen tres estados de ventana:

- Minimizado (minimized)

- Maximizado (maximized)

- Normal (normal)

El primero hace que el portlet se muestre "cerrado", y que solo muestre el título.

El segundo hace que el portlet se muestre en toda la página web del portal.

El tercero es el común: se muestra dentro del diseño del portal.

Pero estos tres estados tienen algo en común: muestra el portlet dentro del diseño del portal, incluyendo sus javascript, los diseños, la cabecera, su theme, etc etc etc. Está muy bien si lo que queremos es mostrar todo el look&feel del portal adornando nuestro portlet.

Ahora bien: si estamos haciendo un portlet que su contenido queremos que no salga incrustado (la palabra '*embebido'* suena feo en castellano) en el portal ¿cómo le hacemos?

Por ejemplo, si nuestro `view.jsp` tiene únicamente esto:

```java
<h3>Hola a todos</h3>
```

y queremos que salga únicamente ese texto, sin ninguna decoración, debemos llamar al portlet con el estado de ventana "exclusive"

¿Para qué nos serviría? Por ejemplo, nos puede ser útil como respuestas para peticiones ajax, que queremos que se procese en el portlet, y que la respuesta está preparada en un .jsp del portlet.

```java
<a href="javascript:mostrarListado()" > Clic aquí para mostrar el Listado </a>

<div id="listado">Aquí se mostrará el listado</div>

<liferay-portlet:renderURL windowState="exclusive" var="url">
   <liferay-portlet:param name="jspPage"
                          value="/html/miportlet/resultado.jsp" />

</liferay-portlet:renderURL>

<script type="text/javascript">
    function mostrarListado(){
      jQuery.get('<%=url%>',function(data){
        $("#listado").html(data);
      });
    }
</script>
```

Y el contenido de `resultado.jsp` es un jsp que quieran.

 Espero que les sea de utilidad!
