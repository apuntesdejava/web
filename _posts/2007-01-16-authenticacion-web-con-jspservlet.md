---
layout: post
title: "Authenticacion Web con JSP/Servlet"
date: 2007-01-17T00:27:00Z
last_modified_at: 2009-04-25T21:55:03.881Z
author: "Diego Silva"
permalink: /2007/01/authenticacion-web-con-jspservlet.html
canonical_url: https://www.apuntesdejava.com/2007/01/authenticacion-web-con-jspservlet.html
tags:
  - "seguridad"
  - "web"
---

Yo creía que la authentication tipo Realm era únicamente en la configuración del contenedor,

```java
<span style="color:#000000;">        </span><span style="color:#008000;">// para ver si se autenticó</span><span style="color:#000000;"><br />       String auth = <i>request</i>.<i>getHeader</i>(</span><span style="color:#0000ff;">"Authorization"</span><span style="color:#000000;">);<br />       </span><span style="color:#008000;">//si no se autenticó...</span><span style="color:#000000;"><br />       </span><span style="color:#000080;"><b>if</b></span><span style="color:#000000;"> (auth == </span><span style="color:#000080;"><b>null</b></span><span style="color:#000000;">) {<br />           </span><span style="color:#008000;">//... responder al cliente que no está autorizado...</span><span style="color:#000000;"><br />           <i>response</i>.<i>setStatus</i>(<i>response</i>.<i>SC_UNAUTHORIZED</i>);<br />           </span><span style="color:#008000;">//... y pedir que se autentique.</span><span style="color:#000000;"><br />           <i>response</i>.<i>setHeader</i>(</span><span style="color:#0000ff;">"WWW-Authenticate"</span><span style="color:#000000;">, </span><span style="color:#0000ff;">"Basic realm=\"Esbas\""</span><span style="color:#000000;">);<br />       } </span><span style="color:#000080;"><b>else</b></span><span style="color:#000000;"> { </span><span style="color:#008000;">// si se auténtico..</span><span style="color:#000000;"><br />           </span><span style="color:#008000;">//obtenemos el par usuario/contrasenia encriptada</span><span style="color:#000000;"><br />           </span><span style="color:#008000;">//... pero se antepone la palbra Basic</span><span style="color:#000000;"><br />           String cad = auth.substring(</span><span style="color:#0000ff;">6</span><span style="color:#000000;">).trim();<br />           </span><span style="color:#008000;">//.. la clave está encriptada en BASE64..</span><span style="color:#000000;"><br />           sun.misc.BASE64Decoder decoder = </span><span style="color:#000080;"><b>new</b></span><span style="color:#000000;"> sun.misc.BASE64Decoder();<br />           </span><span style="color:#008000;">//... asi que lo decodificaremos</span><span style="color:#000000;"><br />           String clave = </span><span style="color:#000080;"><b>new</b></span><span style="color:#000000;"> String(decoder.decodeBuffer(cad));<br />           </span><span style="color:#008000;">//.. y listo, ya tenemos el par usuario/contraseña</span><span style="color:#000000;"><br />           <i>out</i>.<i>println</i>(clave);<br />       }</span>
```

`
`
