---
layout: post
title: "WebSockets en Java EE 7 (JSR 356)"
date: 2013-05-22T21:29:00.004Z
last_modified_at: 2018-01-10T23:45:36.061Z
author: "Diego Silva Límaco"
permalink: /2013/05/websockets-en-java-ee-7-jsr-356.html
canonical_url: https://www.apuntesdejava.com/2013/05/websockets-en-java-ee-7-jsr-356.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "webservices"
  - "html5"
  - "web"
  - "netbeans 7.4"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "tutorial"
  - "websockets"
---

[![](/assets/blogger/websocket-lifecycle.png)](/assets/blogger/websocket-lifecycle.png)

Los [WebSockets](http://es.wikipedia.org/wiki/WebSocket) son una manera de poder comunicarse vía web entre un cliente y un servidor. A diferencia con otras tecnologías parecidas como los RESTful WebService, es que esta tecnología es bidireccional. El RESTful tiene que constantemente pedir al servidor para ver si hay un cambio, y con algunas técnicas "push" se puede simular una comunicación bidireccional. Con WebSockets, la comunicación es nativa.

Ya que estamos cerca del lanzamiento de Java EE 7 implementado en GlassFish 4.0, veremos un pequeño esbozo de esta tecnología.

WebSockets no es nuevo. Ya existe una norma en [W3C](http://www.w3.org/TR/websockets) que regula su implementación (aunque aún está en revisión, creo que su uso será como el HTML5.. todos lo usan asumiendo que está aprobado). Existen [plugins](http://code.google.com/p/jquery-websocket/) en JQuery para consumirlos, Dojo Toolkit ya lo tiene implementado en su extensión [Dojox](http://dojotoolkit.org/features/1.6/dojo-websocket); en los navegadores desde las versiones Chrome 4, [Firefox](https://developer.mozilla.org/en-US/docs/WebSockets) 8, y Safari 5 ya está implementado (no responderé sobre MSIE)... ahora nos falta el lado del servidor, y esto es lo que veremos en este post. En la versión Java EE 7 vendrá como API para poder montar nuestro servicio WebSockets.

### Preparando el Software

A la fecha de este post, he utilizado la versión [desarrollo](http://bits.netbeans.org/download/trunk/nightly/latest/) de NetBeans. (Cuando ya sea oficial, pueden descargar la versión completa). Debemos descargar la versión completa para la plataforma, es decir, la de Windows (si usamos Windows), la de Linux (si usamos Linux), etc.. pero no la versión .zip, ya que en esta no viene incluido el GlassFish.

Después de instalarlo, nos preparamos para crear nuestro primer proyecto Web.

#### Proyecto Web

Creamos nuestro proyecto llamado **WebSocketsDemoWeb** y usamos el servidor "GlassFish Server 4.0" y elegimos la versión Java EE: Java EE 7 Web.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgL6Mp6KbV-_OJhy9W2X3Z77_GoZE2WaVULltyAjaMehGYXfMIi7rjuEjH7B4zDfpRIa04OTInArOlsmvMcsnA1xNSZpi3XZm24QeGBo06hjdbCy_EJ7FOufR0wfETNYdBxYViPjUcoYYc/s400/Captura+de+pantalla+de+2013-05-21+17:23:15.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgL6Mp6KbV-_OJhy9W2X3Z77_GoZE2WaVULltyAjaMehGYXfMIi7rjuEjH7B4zDfpRIa04OTInArOlsmvMcsnA1xNSZpi3XZm24QeGBo06hjdbCy_EJ7FOufR0wfETNYdBxYViPjUcoYYc/s1600/Captura+de+pantalla+de+2013-05-21+17:23:15.png)

... y le damos clic en "Finish".

Ahora, crearemos nuestra clase que será el punto de acceso al WebSocket. Creamos nuevo archivo desde File > New (Ctrl+N), y de la categoría "Web" seleccionamos "WebSocket Endpoint"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizjUhNzhNaZfuHNdue1GCC_9QgDL2H4XEagi3Vc1Et-b29uHCpbE1kZUw-nH7f6jUEobIsslJcN17Z4e4qyMI4WQgOA6JOKMCmy8HLXTnyvPEv8qO0dj9Y6gRi-5I0mrkfPi-h_6RJL-M/s400/Captura+de+pantalla+de+2013-05-21+17:27:28.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizjUhNzhNaZfuHNdue1GCC_9QgDL2H4XEagi3Vc1Et-b29uHCpbE1kZUw-nH7f6jUEobIsslJcN17Z4e4qyMI4WQgOA6JOKMCmy8HLXTnyvPEv8qO0dj9Y6gRi-5I0mrkfPi-h_6RJL-M/s1600/Captura+de+pantalla+de+2013-05-21+17:27:28.png)

... clic en "Next".

Ahora debemos declarar las característica que tendrá nuestro WebSocket, como el nombre de la clase, la ruta del websocket, etc.

nombre de clase: **HolaTodosEndPoint**

paquete: **com.apuntesdejava.websocket**

WebSocket URI_: **/holaTodos**

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVjQ6yJ7nWSy9zPWjpB9yb-UwWAtlG3cYPBh-gzJ-X87_5ARrOvdkAMzvAWExegQ7tmo5ObjNai2A607Lxs6cm2N7oV6IDHBhwoda16NBrRbKPa0wL8VoTNG555pxTTQYLKn9hBn9sI_s/s320/Captura+de+pantalla+de+2013-05-21+17%253A30%253A22.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVjQ6yJ7nWSy9zPWjpB9yb-UwWAtlG3cYPBh-gzJ-X87_5ARrOvdkAMzvAWExegQ7tmo5ObjNai2A607Lxs6cm2N7oV6IDHBhwoda16NBrRbKPa0wL8VoTNG555pxTTQYLKn9hBn9sI_s/s1600/Captura+de+pantalla+de+2013-05-21+17%253A30%253A22.png)

(El "Hola mundo" y "Hola todos" nunca fallan)

Y listo, la clase está creada. Como ahora vienen las clases de java se pueden declarar sin más archivos de configuración (algún archivo de despliegue o xml que configure los websockets) entonces se pudo haber creado una clase simple y a ella colocarle las anotaciones necesarias.

#### Ciclo de vida de una conexión WebSocket

Las conexiones AJAX con RESTful o SOAP (y toda aplicación web) tienen esta particularidad:

- El cliente se conecta al servidor,

- se establece la comunicación,

- el cliente hace el requerimiento,

- el servidor responde

- y terminó la conexión.

Si se tiene que hacer otro requerimiento, se vuelve a realizar todos los pasos anteriores. De ahí el uso de sesiones en cookies, variables locales y demás artilugios para  asegurar que la siguiente petición se refiere al mismo cliente.

Con el WebSocket esto se hace más simple.

[![](https://www.websequencediagrams.com/cgi-bin/cdraw?lz=V2ViU29ja2V0CgpDbGllbnRlLT5TZXJ2aWRvcjogSW5pY2lhIGNvbmV4acOzbgAQFEVudsOtYSBtZW5zYWplAAEhZQoAVwgtPgBrBwABQwAyEgAxNVRlcm1pbgCBZgs&s=napkin)](https://www.websequencediagrams.com/cgi-bin/cdraw?lz=V2ViU29ja2V0CgpDbGllbnRlLT5TZXJ2aWRvcjogSW5pY2lhIGNvbmV4acOzbgAQFEVudsOtYSBtZW5zYWplAAEhZQoAVwgtPgBrBwABQwAyEgAxNVRlcm1pbgCBZgs&s=napkin)

Es decir:

- El cliente inicia la conexión con el servidor

- Ambos se comunican. El cliente al servidor o el servidor al cliente.

- Se termina la conexión.

Ya se parece a una aplicación Desktop (por qué no lo inventaron desde un inicio!? El modelo MVC2 se puede ir al tacho!... bueno, es lo que yo opino)

#### Implementando el WebSocket

Ahora nos toca escribir el código que estará del lado del servidor.

Escribiremos este código co

n algunas anotaciones del WebSocket:

<script src="https://pastebin.com/embed_js.php?i=9bbPPhUw"></script>
Código:[https://pastebin.com/9bbPPhUw](https://pastebin.com/9bbPPhUw)

Notemos que - gracias a las anotaciones - ya no necesitamos implementar ni extender alguna clase. Basta con describir la anotación, Java sabrá que hacer con ese método.

#### Implementado el cliente

En el lado del cliente lo haremos usando HTML5, así que funcionará con FF, GC y Safari (sorry MSIE). El código es bastante simple, y está comentado para no perder el hilo.

<script src="https://pastebin.com/embed_js.php?i=CAgYxzqX"></script>
Código: [https://pastebin.com/CAgYxzqX](https://pastebin.com/CAgYxzqX)

#### Probando la aplicación

Bastará con ejecutar la aplicación.

Si estamos con Chrome activemos la consola de desarrollo con la tecla F12. Veremos en la pestaña de NetWork solo ha tenido dos peticiones, la primera es la misma HTML y la segunda es la conexión al WebSocket... y tiene estado pendiente!

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgox0H3RaVET2Wc02jE1ctq8aERfQMc6UYZCJAQkgLbJMBlCkNBtWC42_lrAM2WlswnEfdwGUwCH9_GGJt16hAufNtBv0XSw0rLxfZZy230QrNvG3RYxLOqYrbvwju6M5KVxqthdwGMGjc/s640/Captura+de+pantalla+de+2013-05-22+11:14:52.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgox0H3RaVET2Wc02jE1ctq8aERfQMc6UYZCJAQkgLbJMBlCkNBtWC42_lrAM2WlswnEfdwGUwCH9_GGJt16hAufNtBv0XSw0rLxfZZy230QrNvG3RYxLOqYrbvwju6M5KVxqthdwGMGjc/s1600/Captura+de+pantalla+de+2013-05-22+11:14:52.png)

Hacemos clic en ese nodo para ver el detalle. Podremos ver la cabecera de conexión...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZLA_zd7KonejYHyCiEYBEo0UtHl9njlqLxAbi97GYjGRfZqB4-aAGO_VgitVMUJwUEfGORS-PrAUlP17tA7WNJaUCXTniooEiRswuSX73hpHOiJJAMQdEHWN0kR2hWkxYpLRu7TQOsSQ/s640/Captura+de+pantalla+de+2013-05-22+11:54:28.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZLA_zd7KonejYHyCiEYBEo0UtHl9njlqLxAbi97GYjGRfZqB4-aAGO_VgitVMUJwUEfGORS-PrAUlP17tA7WNJaUCXTniooEiRswuSX73hpHOiJJAMQdEHWN0kR2hWkxYpLRu7TQOsSQ/s1600/Captura+de+pantalla+de+2013-05-22+11:54:28.png)

... y los *frames* de comunicación. Cada vez que escribimos un mensaje en el input veremos cómo se envían los frames entre el servidor y el cliente.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt7QdY-K_rLksKKlY0ABaRJt9RZm9Cf_VWDCHNg9OU4mEBrlDX5RzKUtTulNdaQrpG-91xMf1piT7k_ocfIHItoATdDYbnUb5GoggyVX3NkBXBA-Ih_BbhepNaO-xbrT35btOq2uYbMPo/s640/Captura+de+pantalla+de+2013-05-22+11:59:38.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt7QdY-K_rLksKKlY0ABaRJt9RZm9Cf_VWDCHNg9OU4mEBrlDX5RzKUtTulNdaQrpG-91xMf1piT7k_ocfIHItoATdDYbnUb5GoggyVX3NkBXBA-Ih_BbhepNaO-xbrT35btOq2uYbMPo/s1600/Captura+de+pantalla+de+2013-05-22+11:59:38.png)

### Broadcast a todos los conectados

Este ejemplo es bastante interesante, ya que la idea es enviar un mensaje a todos los usuarios conectados. A diferencia del ejemplo anterior - donde el cliente espera una respuesta de la petición que ha hecho - este ejemplo solo espera que el servidor le diga algo. Notaremos que el cliente no tiene que hacer ni nada, ni tampoco estará consultando cada cierto tiempo al servidor si hay mensajes nuevos.

Lo que haremos es colocar en el servidor un EJB que cada cierto tiempo envíe una comunicación a los clientes. Para ello haremos que nuestro ServerEndPoint sea un ejb singleton, y colocamos un método programado para que envíe cada 10 segundos un mensaje.  Ahora, para saber quienes están conectados, debemos crear una lista de todas las sesiones. Cada vez que se ejecuta el evento `@OnOpen` se recibirá como parámetro la sesión y se agregará a una lista; y cada vez que se llame al evento `@OnClose`, haremos que cierra la conexión y quitamos el evento de la lista.

Aquí el código del Servidor:

<script src="https://pastebin.com/embed_js.php?i=6UFi1gHv"></script>
Código: [https://pastebin.com/6UFi1gHv](https://pastebin.com/6UFi1gHv)

Y el lado del cliente es lo más simple que puede haber:

<script src="https://pastebin.com/embed_js.php?i=ZuSZBkL9"></script>

Código: [https://pastebin.com/ZuSZBkL9](https://pastebin.com/ZuSZBkL9)

Ahora lo ejecutamos, abrimos desde un navegador, luego abrimos el mismo enlace desde otro navegador y veremos el efecto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCNGujKQ4ri89WvDEvcbvscXCOf_V_5_8dR8C8jkMFRdRDs961L9Bht6eghN4j-QeJts3b6zql8sDreNP8FMHo9jLOYJ6PdOk1KNUChQ0EfVl6eLUx-GWGg4F0Ky2bKQlj4hIqglwI47U/s640/Captura+de+pantalla+de+2013-05-22+15:29:46.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCNGujKQ4ri89WvDEvcbvscXCOf_V_5_8dR8C8jkMFRdRDs961L9Bht6eghN4j-QeJts3b6zql8sDreNP8FMHo9jLOYJ6PdOk1KNUChQ0EfVl6eLUx-GWGg4F0Ky2bKQlj4hIqglwI47U/s1600/Captura+de+pantalla+de+2013-05-22+15:29:46.png)

No se qué opinan ustedes, pero para mi es la mejor solución Cliente/Servidor que haya visto para Web.

### Conclusión

En este post solo se vió algo muy simple de implementar, pero podemos ir más allá. Por ejemplo, podemos notificar alertas a los clientes - sea web o mobil (que podríamos verlo en otro post) - enviar objetos (que también será tema de otro post), etc.

Mi opinión es que esta tecnología debería enseñarse a la nueva generación de desarrolladores web, y que AJAX sea tomado como un tema de historia.

### Referencias

Como yo no me invento estas cosas, naturalmente las he tomado de alguien. Arun Gupta ([@arungupta](https://twitter.com/arungupta))   ha prestando [varias presentaciones  sobre Java EE 7](http://www.slideshare.net/arungupta1/) que es muy conveniente revisarlas.

Además, me he basado de otros links del mismo autor y otros ejemplos.

- [WebSocket and Java EE 7 - Getting Ready for JSR 356 (TOTD #181)](https://blogs.oracle.com/arungupta/entry/websockets_and_java_ee_7)(Referencia antigua, pero válida para comprender el concepto)

- [Building WebSocket Apps in Java using JSR 356](http://www.slideshare.net/arungupta1/websocket-10-21153123)

- [Ejemplos de Tyrus](https://java.net/projects/tyrus/sources/source-code-repository/show), biblioteca que implementa el WebSocket API en GlassFish 4.0

### Código fuente

Y por si las dudas, aquí el código fuente del proyecto. Recuerden utilizar GlassFish 4.0 y que el IDE sea compatible con Java EE .

[https://java.net/projects/apuntes/downloads/download/web/WebSocketsDemoWeb.tar.gz](https://java.net/projects/apuntes/downloads/download/web/WebSocketsDemoWeb.tar.gz)

Luego subiré el código en el Mercurial de java.net.

Buen día y bendiciones a todos!
