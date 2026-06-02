---
layout: post
title: "JSF Facelets + Senna"
date: 2014-10-07T17:12:00Z
last_modified_at: 2014-10-09T15:11:34.241Z
author: "Diego Silva Límaco"
permalink: /2014/10/jsf-facelets-senna.html
canonical_url: https://www.apuntesdejava.com/2014/10/jsf-facelets-senna.html
tags:
  - "senna"
  - "jsf"
  - "jsf 2.2"
  - "web"
  - "ajax"
---

![JSF Facelets + Senna](http://sennajs.com/images/logo.svg)

Estuve revisando la biblioteca "[Senna](http://sennajs.com/)" que permite cargar parte de una página sin necesidad de cargar toda la página, y se me ocurrió combinarlo con JSF Facelets. Así que en este post veremos cómo se hace

La idea es la siguiente: tenemos una página usando plantillas (con facelets) y cada vez que hacemos clic en una opción de menú, se carga tooooda la página incluyendo las mismas opciones y las mismas plantillas, para ver solo cambiar una parte.

Por una parte está bien, ya que al hacer clic en el enlace, la dirección que aparece en el navegador cambia a esa página, y así podemos compartir ese enlace a los amigos. Pero por otro lado está mal, porque tendría que cargar todo el contenido cada vez que navegamos de una opción a otra. Si usamos AJAX, (en conjunción con - por ejemplo - jquery para obtener el contenido de la otra página usando el comando .get ) nos resolvería la primera parte del problema, pero no nos resuelve el cambio de dirección en el navegador.

Así que para esto, hagamos un ejemplo con facelets (que es la manera de generar plantillas en JSF). Para ver un ejemplo de cómo usar los facelets, revisemos el post anterior [Tutorial JSF 2.2: Facelets](/2013/12/tutorial-jsf-22-sesion-4-facelets-parte.html).

Aquí tenemos la plantilla, común y corriente:
<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/e12b654372f364b538157ad7debc1ffa5d0521fd/jsf-senna-app/src/main/webapp/WEB-INF/template/senna.xhtml?embed=t"></script>

Aunque aquí he incluido las llamadas a las bibliotecas de Senna (opcional en este caso) no afecta al funcionamiento de la página.

***Actualización:** En Firefox funciona sin problema ejecutar el sennajs desde su código fuente en github, pero desde Google Chrome y MSIE no, por tanto, hay que bajar la biblioteca y colocarlo en el proyecto.*

Y aquí un ejemplo de una página usando la plantilla

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/e12b654372f364b538157ad7debc1ffa5d0521fd/jsf-senna-app/src/main/webapp/index.xhtml?embed=t"></script>

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/e12b654372f364b538157ad7debc1ffa5d0521fd/jsf-senna-app/src/main/webapp/pagina3.xhtml?embed=t"></script>

Es más, podemos usar formularios

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/e12b654372f364b538157ad7debc1ffa5d0521fd/jsf-senna-app/src/main/webapp/pagina2.xhtml?embed=t"></script>

Con esto podríamos hacer una prueba de ejecución y - con ayuda del Firebug o cualquier monitoreador de llamadas de HTTP en el navegador (vamos, con la tecla F11) - podemos ver qué pasa cuando hacemos clic en cada opción superior:

Primera página:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhVZNKX6X4z-FhqXJUWi_GJA5LBuDMxv6Q0GzeXAxfJagX35rJZ4Sy0kg6Yxq4LnIFZ00AWrvoVcXfOVgjJdL0IACKzjHjxH3-ELASJ-VLm1UgxHifJ1KQAX56JM10rspCVow0AgPgKq2Y/s1600/07-10-2014+11-29-32+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhVZNKX6X4z-FhqXJUWi_GJA5LBuDMxv6Q0GzeXAxfJagX35rJZ4Sy0kg6Yxq4LnIFZ00AWrvoVcXfOVgjJdL0IACKzjHjxH3-ELASJ-VLm1UgxHifJ1KQAX56JM10rspCVow0AgPgKq2Y/s1600/07-10-2014+11-29-32+a.m..png)

Clic en la página 2:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg0zsKcrVp1YwGxKb4GFGhWvaXJu0ycROM9JUWwpZhJAtGFSlGKUnRwTvhMq2WgC3HThIaru_oAGJ6V8UXSBjZ6xcZQZLHDQ-J27DYB6rm2gqEgBFdAd5859n-zds40cmBg2w0rCHb1iQg/s1600/07-10-2014+11-31-15+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg0zsKcrVp1YwGxKb4GFGhWvaXJu0ycROM9JUWwpZhJAtGFSlGKUnRwTvhMq2WgC3HThIaru_oAGJ6V8UXSBjZ6xcZQZLHDQ-J27DYB6rm2gqEgBFdAd5859n-zds40cmBg2w0rCHb1iQg/s1600/07-10-2014+11-31-15+a.m..png)

Como podemos ver, siempre carga toda la página html, y eso que estamos usando muy poco contenido, pero técnicamente vuelve a cargar TODO el html, todos los tags, todas las cabeceras, etc. Y solo queremos que cargue la parte del contenido principal... y que cada vez que cargue, la dirección de la página en el navegador cambie. Aquí vamos a crear un archivo javascript para que nos haga el milagro.

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/0d068ff02d2787d7c28ec4ff9586a0ac60c3e2eb/jsf-senna-app/src/main/webapp/resources/js/app.js?embed=t"></script>

Y esto lo agregamos en nuestra plantilla, que sea al final de la página:

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/0d068ff02d2787d7c28ec4ff9586a0ac60c3e2eb/jsf-senna-app/src/main/webapp/WEB-INF/template/senna.xhtml?embed=t"></script>

Solo mirar la línea 37 para incluir el arhivo. js, y nada más!

Ahora probemos:

Página inicial... carga como debería ser:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgILi7Po6q3zDWKMByT_78UjEHdwJ6vfRpfvxTCBGg73aIbt2wztNKDW5f01fAwMQVSkNJF3wviyijrr1DUPNzU6eRvwhX2K9Eb6vnnQP-Z6yoYAcQ47yxyw6lgWWxpgXYquXQBhuud6bI/s1600/07-10-2014+11-36-59+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgILi7Po6q3zDWKMByT_78UjEHdwJ6vfRpfvxTCBGg73aIbt2wztNKDW5f01fAwMQVSkNJF3wviyijrr1DUPNzU6eRvwhX2K9Eb6vnnQP-Z6yoYAcQ47yxyw6lgWWxpgXYquXQBhuud6bI/s1600/07-10-2014+11-36-59+a.m..png)

Clic en la tercera página:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhG6rnFHYM0ywI2O3yylDl6Mah_jDWvvvPSgOu3Ypcnt7OQ8yIpWJnmwlXwbNIzbwQlfFlUAOlJZih775ctSqQMrCoa5JIXDTOPJlO6QGhTheEG4gf_17pVzzf9IOWOSftu0bHHvlvwCtA/s1600/07-10-2014+11-38-20+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhG6rnFHYM0ywI2O3yylDl6Mah_jDWvvvPSgOu3Ypcnt7OQ8yIpWJnmwlXwbNIzbwQlfFlUAOlJZih775ctSqQMrCoa5JIXDTOPJlO6QGhTheEG4gf_17pVzzf9IOWOSftu0bHHvlvwCtA/s1600/07-10-2014+11-38-20+a.m..png)

oooh!!! cargó solo el contenido y la dirección de la web cambió!!

y ahora, el formulario...(página 2)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgY2UjbaxQ7wi_bv56mOViEPbPTjWlsyBq1eEPCPUk8uTdEiOBqssfz771QX8GFgOTYwNJ7o_xnDKZiRaDg0TmzEUpt-oQfTf6zhcZ9w_nEG73LMNAVKAZXxgShK1-Yz6EGF-e_43pbXvU/s1600/07-10-2014+11-42-51+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgY2UjbaxQ7wi_bv56mOViEPbPTjWlsyBq1eEPCPUk8uTdEiOBqssfz771QX8GFgOTYwNJ7o_xnDKZiRaDg0TmzEUpt-oQfTf6zhcZ9w_nEG73LMNAVKAZXxgShK1-Yz6EGF-e_43pbXvU/s1600/07-10-2014+11-42-51+a.m..png)

... y cargó!! Y eso que no han visto ejecutando el formulario.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEik9mFww6ye7Gp6RjPkL5JLm80W4_5tEXO0lnNswrw4Kr2NxShwOslu9HqmCIyJeu78bidSh4VN9NVFSVTCGl8zLAY9zVVmBrFN-UL4AHkzUa-QRRFvlFbZD6BK5RCjAXB6we0oyg-xcZo/s1600/07-10-2014+11-46-29+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEik9mFww6ye7Gp6RjPkL5JLm80W4_5tEXO0lnNswrw4Kr2NxShwOslu9HqmCIyJeu78bidSh4VN9NVFSVTCGl8zLAY9zVVmBrFN-UL4AHkzUa-QRRFvlFbZD6BK5RCjAXB6we0oyg-xcZo/s1600/07-10-2014+11-46-29+a.m..png)

Vamos, aquí sí se debe cargar todo el contenido, porque es un submit de JSF, a menos que hagan un cambio usando `<f:ajax />`

Y si nos aburre declarar página por página en el .js que se debe aplicar el Senna, entonces podemos usar patrones.

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/5af1713ba18d74d3da38427d1436f80fed4a008c/jsf-senna-app/src/main/webapp/resources/js/app.js?embed=t"></script>

Y si no quieres que todos los enlaces sean susceptibles al Senna, entonces podemos anularlos de la siguiente manera: agregamos una clase cualquiera al tag que queremos anular (por ejemplo los que tengan el class no-senna... línea 24)...

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/e685dbcfe4996947cc495e042a757c6fa157d3ad/jsf-senna-app/src/main/webapp/WEB-INF/template/senna.xhtml?embed=t"></script>

... y le decimos al Senna que no los considere usando una búsqueda de css.

<script src="https://bitbucket.org/apuntesdejava/tutorial-jsf/src/6c025870f38c7c5997b3c9c952b43d0de2832363/jsf-senna-app/src/main/webapp/resources/js/app.js?embed=t"></script>

### Bibliografía

Para más información, revisar la documentación misma de Senna [http://sennajs.com/docs/](http://sennajs.com/docs/). Aquí solo di algunos alcances.

### Código fuente

Como siempre, aquí paso el código fuente...

[https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-senna-app/](https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-senna-app/)

... para que lo exploren o el proyecto entero para que lo bajen

[https://java.net/projects/apuntes/downloads/download/web/jsf-senna-app.tar.gz](https://java.net/projects/apuntes/downloads/download/web/jsf-senna-app.tar.gz)

*Si te gustó, hazlo saber.. y si crees que es útil, compártelo. Es gratis*
