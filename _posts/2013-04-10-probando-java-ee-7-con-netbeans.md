---
layout: post
title: "Probando Java EE 7 con NetBeans"
date: 2013-04-10T23:31:00.002Z
last_modified_at: 2013-04-10T23:31:24.082Z
author: "Diego Silva Límaco"
permalink: /2013/04/probando-java-ee-7-con-netbeans.html
canonical_url: https://www.apuntesdejava.com/2013/04/probando-java-ee-7-con-netbeans.html
tags:
  - "java ee"
  - "java ee 7"
  - "netbeans"
---

![](/assets/blogger/glassfish.jpg)

Ya se acerca JavaEE 7, y que mejor es ir probando sus funcionalidades. Así que comenzaré (y espero continuar) con una serie que habla sobre Java EE 7.

Para comenzar, podemos revisar la documentación dada por [Arun Gupta](http://blogs.oracle.com/arungupta) [@arungupta](https://twitter.com/arungupta) en [SlideShare](http://www.slideshare.net/arungupta1/):  [The Java EE 7 Platform: Productivity & HTML5 at JavaOne Latin America 2012](http://www.slideshare.net/arungupta1/the-java-ee-7-platform-productivity-html5-at-javaone-latin-america-2012)

Pero necesitamos el IDE y la implementación de Java EE 7. Para lo último necesitamos el GlassFish, que están desarrollando la versión 4. Lo podemos descargar desde aquí: [http://dlc.sun.com.edgesuite.net/glassfish/4.0/promoted/](http://dlc.sun.com.edgesuite.net/glassfish/4.0/promoted/) y buscamos la versión más reciente. A la fecha de este post, la última versión es [b83](http://dlc.sun.com.edgesuite.net/glassfish/4.0/promoted/glassfish-4.0-b83.zip).

NetBeans para JavaEE 7 lo podemos descargar desde aquí [http://bertram2.netbeans.org:8080/job/web-main-javaee7/](http://bertram2.netbeans.org:8080/job/web-main-javaee7/)

Pero no hay que descargar la ultima que se ve, sino la última que esté estable. Para saber cuál es cuál, revisemos el panel izquierdo y hacemos clic unicamente en el enlace que tiene el punto azul.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBIVEcwc9JUJkmcuGSzfv3EpGR3nCSquFWsxkp2FFkdi3IeizoJwS-j-g6qdUAIAYn9Mrq2U4UhXpDvQAJS641nUqYepU9mjFt2sBj-JPOkcQa80uqbP0H3iglXVEgxNnaj4XDSOukjiI/s320/10-04-2013+06-20-27+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBIVEcwc9JUJkmcuGSzfv3EpGR3nCSquFWsxkp2FFkdi3IeizoJwS-j-g6qdUAIAYn9Mrq2U4UhXpDvQAJS641nUqYepU9mjFt2sBj-JPOkcQa80uqbP0H3iglXVEgxNnaj4XDSOukjiI/s1600/10-04-2013+06-20-27+p.m..png)

Y hacemos clic en el .zip para descargarlo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-An5x9XYHEig9SJUS3uDkdEsHL__dyERcTy5WZEvNFYPFr9FYqfjZwUYG720jJH5m3Ba0g5oBFRhXcud0rJZIW-FzPXQK0AeusDAQ1cTmZs5fF8bIw48dSK00HOEM1mJX3iYmigtISlM/s400/10-04-2013+06-23-05+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-An5x9XYHEig9SJUS3uDkdEsHL__dyERcTy5WZEvNFYPFr9FYqfjZwUYG720jJH5m3Ba0g5oBFRhXcud0rJZIW-FzPXQK0AeusDAQ1cTmZs5fF8bIw48dSK00HOEM1mJX3iYmigtISlM/s1600/10-04-2013+06-23-05+p.m..png)

Ya sabemos que el GlassFish lo podemos descargar, descomprimir y ya está operativo. Lo mismo con el NetBeans.

Ahora, ejecutamos el NetBeans, y en el panel de Servicios (Ctrl+5), en la sección "Servers" agregamos un nuevo servidor, y seleccionamos a GlassFish 4 (buscamos en la carpeta donde hemos descomprimido el GlassFish) y listo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrnwX-mpMRV_7F35utE9xcNzOtLBzOTXv-R-uE5dGl6tshnacMXCM2PM8_cJIMAqFJg4QJi5qSb7W3mCKHSrvYWpej4VcNd8JwVqdwKSs3rQrU1NAkVVoymaMS9xKaTGJM3DsIX0YWa4M/s400/10-04-2013+06-25-58+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrnwX-mpMRV_7F35utE9xcNzOtLBzOTXv-R-uE5dGl6tshnacMXCM2PM8_cJIMAqFJg4QJi5qSb7W3mCKHSrvYWpej4VcNd8JwVqdwKSs3rQrU1NAkVVoymaMS9xKaTGJM3DsIX0YWa4M/s1600/10-04-2013+06-25-58+p.m..png)

Y ahora, cuando hagamos un proyecto, podemos seleccionar GlassFish 4 con Java EE 7.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj6ACJGskOuCEfNXdGNaEG0RmECPQiid7oC8d8ftGvzRN7D0nvoh13N-f7-kNAU43cYzvnFtuBqz9bnXmFULD_l1-JAXpFjfbZptlW1i_6aZ5qCtAhGIY8kExf_6Lq7RHBprto0sO3HWPA/s400/10-04-2013+06-27-46+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj6ACJGskOuCEfNXdGNaEG0RmECPQiid7oC8d8ftGvzRN7D0nvoh13N-f7-kNAU43cYzvnFtuBqz9bnXmFULD_l1-JAXpFjfbZptlW1i_6aZ5qCtAhGIY8kExf_6Lq7RHBprto0sO3HWPA/s1600/10-04-2013+06-27-46+p.m..png)

En el siguiente post haremos algunas pruebas de esta nueva plataforma.
