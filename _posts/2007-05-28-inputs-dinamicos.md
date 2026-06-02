---
layout: post
title: "INPUTS dinámicos"
date: 2007-05-28T23:01:00Z
last_modified_at: 2009-04-25T21:55:03.795Z
author: "Diego Silva"
permalink: /2007/05/inputs-dinamicos.html
canonical_url: https://www.apuntesdejava.com/2007/05/inputs-dinamicos.html
tags:
  - "web"
  - "javascript"
---

Ahora con todo eso de las aplicaciones web enriquecidas, y que las interfaces web no deberian recargarse del todo cuando se hace un pequeño cambio, pues aquí pongo un script (en javascript, obviamente) que permite agregar y quitar INPUT-TEXT según sea el gusto.

```java
<code><fieldset id="alternativas"><br />  <legend>Alternativas</legend><br />  <input type="Text" id="alt1" name="alternativa" size="100"/><br/><br />  <input type="Text" id="alt2" name="alternativa" size="100"/><br /></fieldset>  <br />  <input type="Button" value="Agregar alternativa" onclick="agregar_alternativa()"/><br />  <input type="submit" value="Guardar"/><br /><script type="text/javascript"><br />function agregar_alternativa(){<br />  var fieldset=document.getElementById("alternativas");<br />  var inputs=document.getElementsByName("alternativa");<br /><br />  var br=document.createElement("br");<br />  var newInput=document.createElement("input");<br />  var grp=document.createElement("span");<br /><br /><br />  newInput.name="alternativa";<br />  newInput.size=100;<br />  newInput.id="alt"+(inputs.length+1);<br /><br /><br />  var btnRemove=document.createElement("input");<br />  btnRemove.type="button";<br />  btnRemove.value="Quitar";<br /><br />  grp.appendChild(br);<br />  grp.appendChild(newInput);  <br />  grp.appendChild(btnRemove);  <br />  fieldset.appendChild(grp);<br />  btnRemove.onclick=function(){var elem=this.parentNode;elem.parentNode.removeChild(elem);};<br /><br />}<br /></script>  <br /></code>
```
