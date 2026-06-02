---
layout: post
title: "campos tipo arreglo en Struts"
date: 2007-06-19T21:18:00Z
last_modified_at: 2009-04-25T21:55:03.778Z
author: "Diego Silva"
permalink: /2007/06/campos-tipo-arreglo-en-struts.html
canonical_url: https://www.apuntesdejava.com/2007/06/campos-tipo-arreglo-en-struts.html
tags:
  - "java"
  - "web"
  - "struts"
---

Los arreglos nos ayudan mucho en la programación... se puede almacenar muchos valores en una misma variable, y se pueden diferenciar a través del índice.

En la web (utilizando Struts 1), es posible que necesitemos campos variables que funcionen como arreglo. Es decir, un mismo formulario que tenga una vez 10 campos, la siguiente vez 15, y la siguiente 2 campos.

Para ello, nuestro ActionForm deberá tener un campo arreglo:

```java
public class Formulario extends ActionForm {<br /><br /><br /> private String[] pregunta=new String[10];<br /><br /> public String[] getPregunta() {<br />  return pregunta;<br /> }<br /><br /> public void setPregunta(String[] pregunta) {<br />  this.pregunta = pregunta;<br /> }<br />
```

Y en la capa de presentación (o sea, en el JSP) deberá mostrarse cada campo con un índice:

```java
<code>Pregunta 1:<html:text property="pregunta[0]"/><br/><br />Pregunta 2:<html:text property="pregunta[1]"/><br/><br />Pregunta 3:<html:text property="pregunta[2]"/><br/><br /><br /></code>
```

Si se está usando un DynaActionForm, la solución es la misma:

```java
<code><form-property name="pregunta" type="java.lang.String[]" size="10"/><br /></code>
```
