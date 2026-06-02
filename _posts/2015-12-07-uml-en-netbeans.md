---
layout: post
title: "UML en NetBeans"
date: 2015-12-07T22:57:00Z
last_modified_at: 2016-04-13T22:45:14.879Z
author: "Diego Silva Límaco"
permalink: /2015/12/uml-en-netbeans.html
canonical_url: https://www.apuntesdejava.com/2015/12/uml-en-netbeans.html
description: "NetBeans permite programación orientada a objetos como Java y C++. Ahora bien, siendo un IDE muy bueno, debería permitirnos manejar UML para modelar nuestros objetos ¿cierto?  Pues bien, aquí les muestro como instalar un plugin en NetBeans que nos permita escribir UML de una manera no convencional. (Mejor que arrastrar y soltar los artefactos en el lienzo.. ya verán)"
tags:
  - "netbeans"
  - "uml"
  - "plugins"
  - "diagramas"
---

[![](/assets/blogger/UML-Logo.jpg)](/assets/blogger/UML-Logo.jpg)

NetBeans permite programación orientada a objetos como Java y C++. Ahora bien, siendo un IDE muy bueno, debería permitirnos manejar UML para modelar nuestros objetos ¿cierto?

Pues bien, aquí les muestro como instalar un plugin en NetBeans que nos permita escribir UML de una manera no convencional. (Mejor que arrastrar y soltar los artefactos en el lienzo.. ya verán)

## Instalación del plugin

Debemos instalar en nuestro IDE el plugin "PlantUML-NB" que lo podrás descargar desde esta dirección:

[https://sourceforge.net/projects/plantumlnb/](https://sourceforge.net/projects/plantumlnb/)

Al dar clic en "Download" obtendremos el archivo **PlantUML-NB-XX.nbm** (donde XX es la versión del plugin).

Luego, en nuestro IDE entramos a la opción "Tools > Plugins".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7pSsxIFjuJ6jCDKgdiO0Gwlhq0htwF1-LQJPSTP21qzx_lW5tfs9B9ZXVYUjN8bv9LtGjQxuKPtcSeEfZangTth1H-QESAGgivExt0wMztOrbMN4dxT4S4Rfs2xvj_51djN30nNCaLWI/s1600/07-12-2015+05-12-02+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7pSsxIFjuJ6jCDKgdiO0Gwlhq0htwF1-LQJPSTP21qzx_lW5tfs9B9ZXVYUjN8bv9LtGjQxuKPtcSeEfZangTth1H-QESAGgivExt0wMztOrbMN4dxT4S4Rfs2xvj_51djN30nNCaLWI/s1600/07-12-2015+05-12-02+p.m..png)

Seleccionamos la ficha "Downloaded" y hacemos clic en el botón "Add plugins..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjIUFqTDYBn-hzVeLeL59vwOXMvFEaS85NNl9rlN7NxLjyqn3ydK3pxNqhb-yytDjZ_wemdZ-L_zsP0DK-ovh70u2YDz8r49A_wDxLcUt24cjVqr4WwW91tco7YpOj8pEEkp88auzyyd9A/s1600/07-12-2015+05-14-30+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjIUFqTDYBn-hzVeLeL59vwOXMvFEaS85NNl9rlN7NxLjyqn3ydK3pxNqhb-yytDjZ_wemdZ-L_zsP0DK-ovh70u2YDz8r49A_wDxLcUt24cjVqr4WwW91tco7YpOj8pEEkp88auzyyd9A/s1600/07-12-2015+05-14-30+p.m..png)

Y seleccionamos el archivo .nbm que acabábamos de descargar.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEe45bEefXfh3EZc3yORbEr6Px76KFTTmik6CNcUvvhvUHRMsJOhgValt2bMyRdOcAoLHM6njJXM43D7eYX1aRD16n1EtZHy-mWKBZe1W-4Pe2O1sM0oLbCMDtaid-n2c5v2LRCUXlkN8/s400/07-12-2015+05-16-17+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEe45bEefXfh3EZc3yORbEr6Px76KFTTmik6CNcUvvhvUHRMsJOhgValt2bMyRdOcAoLHM6njJXM43D7eYX1aRD16n1EtZHy-mWKBZe1W-4Pe2O1sM0oLbCMDtaid-n2c5v2LRCUXlkN8/s1600/07-12-2015+05-16-17+p.m..png)

Clic en "open". Y listo, ya está el Plugin para instalar....

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3ykHVP2II0dCRbXRtfIwdHiKH14kKzv1qlX6plm1s1rO8_wbDc3E8QF0r1VFDWgMLKmP8GMYEcl3NpAXsOpKMJydDvCifAOHFef_RcgcyT7qZDZeMqVWp7VveR6aQ7bh6M9i7b311ssA/s400/07-12-2015+05-17-14+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3ykHVP2II0dCRbXRtfIwdHiKH14kKzv1qlX6plm1s1rO8_wbDc3E8QF0r1VFDWgMLKmP8GMYEcl3NpAXsOpKMJydDvCifAOHFef_RcgcyT7qZDZeMqVWp7VveR6aQ7bh6M9i7b311ssA/s1600/07-12-2015+05-17-14+p.m..png)

... solo necesitamos hacer clic en "Install". **Confirmamos todas** las ventanas que vienen después. Y si nos pide reiniciar, le decimos que "sí".

Bien, con esto solo hemos instalado el Plugin.

## ¿Qué es PlantUML?

PlantUML es una herramienta OpenSource que permite crear gráficos vectoriales usando un lenguaje propio. Como dije, nada de Arrastrar-y-soltar. No, solo debemos escribir unos textos casi como el HTML y el motor de PlantUML nos creará el gráfico respectivo.

Por ejemplo, si escribimos una cadena como esta

```java
@startuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
@enduml
```

El motor de PlantUML nos genera esta imagen

![](http://plantuml.com/imgp/sequence.png)

Más ejemplos aquí: [http://plantuml.com/sequence.html](http://plantuml.com/sequence.html)

Con esto en claro, sigamos con la instalación.

## Instalación de graphviz

Este plugin necesita del graficador para que muestre lo procesado en nuestro IDE. Este graficador lo podemos descargar desde [http://www.graphviz.org/Download..php](http://www.graphviz.org/Download..php) y en el margen izquierdo están listados el instalador para el respectivo sistema operativo.

Se descarga, se instala como cualquier otro aplicativo. Y listo. Ahora, debes buscar dónde está el ejecutable `dot.exe.` En Windows es posible que se encuentre aquí: `c:\Program Files (x86)\GraphvizX.X\bin`

Ahora, teniendo la ubicación del dot.exe en claro, regresemos al IDE, y entremos a la opción: Tools > Options > Miscellaneous > PlantUML, e indicar la ubicación de dot.exe.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEilm0HVr-eEsqWRbJ17ibyJxzlu7_ovN7hRdtoDEg1n5QWNXnuZ9Ap1w2SsHaa4Fh-ym9mLdxKXg4QraDEyzp_hTAwbik_PeOs8sX3_q_Wt1V0YvT9l8aKw34gnHXkgczz-U7kXBq4cpNA/s400/07-12-2015+05-37-05+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEilm0HVr-eEsqWRbJ17ibyJxzlu7_ovN7hRdtoDEg1n5QWNXnuZ9Ap1w2SsHaa4Fh-ym9mLdxKXg4QraDEyzp_hTAwbik_PeOs8sX3_q_Wt1V0YvT9l8aKw34gnHXkgczz-U7kXBq4cpNA/s1600/07-12-2015+05-37-05+p.m..png)

Clic en "OK".

## Diagramando en UML

Bien, ya estamos listos para crear nuestro primer diagrama. Para comenzar, debemos tener cualquier proyecto creado. Luego, seleccionamos File > New File (o Control+N) y en "Categorías" seleccionamos "PlantUML" y a la derecha "New PlantUML Diagram"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEieTnKwNXsc5sKv8IN-L3ieeeDF6cKC8JbaxgUfB3ItbtVTMdJIELAk1UWiV7iPzmhOaINjl4lcRRZe0LXVQBRG8DYfriL2dBATzlcvtZ92FCcLMMv-VOudn8rI5wWf3rFgHA0RxG1_xx8/s400/07-12-2015+05-40-19+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEieTnKwNXsc5sKv8IN-L3ieeeDF6cKC8JbaxgUfB3ItbtVTMdJIELAk1UWiV7iPzmhOaINjl4lcRRZe0LXVQBRG8DYfriL2dBATzlcvtZ92FCcLMMv-VOudn8rI5wWf3rFgHA0RxG1_xx8/s1600/07-12-2015+05-40-19+p.m..png)

Clic en "Next", indicarle un nombre de archivo... el que sea... y clic en "Finish".

Listo, ya tenemos nuestro IDE listo para poder crear nuestro diagrama.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi9FHGpIJ6qGL-GzQKl_EuxrmJb7THpLZ7w1BUbu0ndVBuc1i2ts4BF9FlJdePSXeKcCxZY7Ko17pQPRScmzyZYDs47IcNTMD7PnpWWyNQSOQ7Ka7sCLU0plgQzUgC8s-eMXkOfxMDMWi4/s320/07-12-2015+05-42-01+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi9FHGpIJ6qGL-GzQKl_EuxrmJb7THpLZ7w1BUbu0ndVBuc1i2ts4BF9FlJdePSXeKcCxZY7Ko17pQPRScmzyZYDs47IcNTMD7PnpWWyNQSOQ7Ka7sCLU0plgQzUgC8s-eMXkOfxMDMWi4/s1600/07-12-2015+05-42-01+p.m..png)

En el panel izquierdo podremos editar todo nuestro lenguaje de UML, y cada vez que grabemos, en el lado derecho se mostrará el gráfico interpretado de nuestras anotaciones.

```java
@startuml
autonumber
Usuario -> UI: Ingresa producto, cantidad
UI -> CCProductos: Busca
CCProductos --> UI: Cantidad de productos disponible
UI --> Usuario: Cantidad disponible

@enduml
```

Al grabar la anotación, el motor nos generará este gráfico.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiALiy7plfArIMNChQJQXQ0-wb-MZoVBUXWoV7ippJbsgbaSGcHVFVYCrdiIrDcS6Ex7fdKaTWE3D0lR9q-Qjt0mq50q61yy2b0MAZqOl1aUctg1U2I477R7swJMPuY3Oike-pPXtQQyoA/s640/07-12-2015+05-48-58+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiALiy7plfArIMNChQJQXQ0-wb-MZoVBUXWoV7ippJbsgbaSGcHVFVYCrdiIrDcS6Ex7fdKaTWE3D0lR9q-Qjt0mq50q61yy2b0MAZqOl1aUctg1U2I477R7swJMPuY3Oike-pPXtQQyoA/s1600/07-12-2015+05-48-58+p.m..png)

Más ejemplos de Diagrama de secuencia, podemos encontrar aquí: [http://plantuml.com/sequence.html](http://plantuml.com/sequence.html)

También podemos hacer Diagramas de Caso de Uso ([http://plantuml.com/usecase.html](http://plantuml.com/usecase.html))

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgY9Wqbbt4Ztr8BChuvc6yUH-1dY07RvcrMpM7IEVCLoGKAP0UDxKzFLuhI8pOEjQaoS7OOuVPd9yIWeV_aDp-isstXBUF_XxsUIJUY-ChQyT-L7_WVGkzXffFKZx9oCXHuNhyphenhyphenWJK9ofgQ/s640/07-12-2015+05-50-34+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgY9Wqbbt4Ztr8BChuvc6yUH-1dY07RvcrMpM7IEVCLoGKAP0UDxKzFLuhI8pOEjQaoS7OOuVPd9yIWeV_aDp-isstXBUF_XxsUIJUY-ChQyT-L7_WVGkzXffFKZx9oCXHuNhyphenhyphenWJK9ofgQ/s1600/07-12-2015+05-50-34+p.m..png)

Diagramas de Clase ([http://plantuml.com/classes.html](http://plantuml.com/classes.html))

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhlVQsbkxjOXQQRtJOr1F3ug0BUo64SD9Hg0R_8Mz7Em-P3LSSwTimSFziQnBXwIpYnPH6f1K_6vp9Dn002coqWsjMMkGiyja8-fabo_ZQqzCs2oSALUcKNG6ek-HMBPO9qTHoxTDGnwAY/s640/07-12-2015+05-51-48+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhlVQsbkxjOXQQRtJOr1F3ug0BUo64SD9Hg0R_8Mz7Em-P3LSSwTimSFziQnBXwIpYnPH6f1K_6vp9Dn002coqWsjMMkGiyja8-fabo_ZQqzCs2oSALUcKNG6ek-HMBPO9qTHoxTDGnwAY/s1600/07-12-2015+05-51-48+p.m..png)

Diagrama de actividades ([http://plantuml.com/activity.html](http://plantuml.com/activity.html)):

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizrlV73g7kKM3yKNykm_rlgeEkmt0-KEe89x0Z3idApf6CfiwctjyvFCMmNbJozSz18NVBSng81YLbFR_T8PpsEofkfcA9elw2ZlFJRx1LkQhyS6fwM-lCda4TVrL84E87GsGysU70Vfk/s640/07-12-2015+05-53-37+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizrlV73g7kKM3yKNykm_rlgeEkmt0-KEe89x0Z3idApf6CfiwctjyvFCMmNbJozSz18NVBSng81YLbFR_T8PpsEofkfcA9elw2ZlFJRx1LkQhyS6fwM-lCda4TVrL84E87GsGysU70Vfk/s1600/07-12-2015+05-53-37+p.m..png)

... y más. Por ahí leí que también se podían hacer diagramas para BPM.

Bueno, esto es todo por ahora.

**Si te gustó el post, dale Like o +1;**

**Si te fue útil, compártelo.. es gratis.**

#### Facebook

<iframe src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1157295824281714&width=500" width="500" height="263" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>

#### Twitter

>

Convierta su IDE [@netbeans](https://twitter.com/netbeans) NetBeans en un editor de [#UML](https://twitter.com/hashtag/UML?src=hash) con [@PlantUML](https://twitter.com/PlantUML) [https://t.co/lL4y9HtzvH](https://t.co/lL4y9HtzvH)

&mdash; Apuntes de Java (@apuntesdejava) [13 de abril de 2016](https://twitter.com/apuntesdejava/status/720363946771902465)

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
