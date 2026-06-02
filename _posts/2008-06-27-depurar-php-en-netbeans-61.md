---
layout: post
title: "Depurar PHP en NetBeans 6.1"
date: 2008-06-27T17:42:00Z
last_modified_at: 2009-04-25T21:55:03.385Z
author: "Diego Silva"
permalink: /2008/06/depurar-php-en-netbeans-61.html
canonical_url: https://www.apuntesdejava.com/2008/06/depurar-php-en-netbeans-61.html
tags:
  - "php"
  - "netbeans 6.1"
  - "netbeans"
  - "web"
---

Como lo prometí en el anterior post: [Usando NetBeans IDE Early Access for PHP](/2008/05/usando-netbeans-ide-early-access-for.html) comentaré sobre cómo depurar la ejecución del PHP desde NetBeans.

## Antes de empezar...

Algo que no mencioné en mi anterior post. Tenemos que establecer la ubicación del intérprete del PHP. Si estamos en Windows, necesitamos saber dónde se encuentra el php.exe. Si estás utilizando algún WAMP, búscalo dentro de la carpeta donde se instaló el wamp.

Yo tengo el PHP en *c:\opt\php-5.2.5-Win32*

Ahora, dentro del NB, entramos a Tools > Options, y seleccionamos la opción "Misceláneas"; y dentro seleccionamos la ficha PHP. En la entrada  "PHP 5 Interpreter", debemos especificar la ubicación exacta del php.exe.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjhp3awjEE-jIwsu_xK_3luIT53lbKv7yRdDYGxdFmKdJp_ErqamLJKStjEaGnuxd2H92UG28PWDGSL0oRLQwHMlf0QIfox5SiMfIB5yyxJWX1XF_bfonSQxe1pCI-Lr6UzsDh2-X2BQQrr/s400-r/php_nb.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHLKu_X6gl9ku5ROE0X6f0lA4dcJo0TsWsRgBwaKudrdS-PXrRZ-CXRaHzhbU2JL9Xj0xEnbM0NrPsOjxIqPewGPjMzbCTSBzVxePnM241MqeGLGew-C4zzXRx2FwL94imb97MIEtpR1MQ/s1600-h/php_nb.png)

Hacemos clic en "Ok".

Para probar, hagamos un proyecto simple de PHP, creemos un archivo llamado test.php que contendrá el siguiente código:

test.php<style type="text/css"><br /><br />BODY {<br /><br />	COLOR: #000000; FONT-FAMILY: Monospaced; BACKGROUND-COLOR: #ffffff<br /><br />}<br /><br />TABLE {<br /><br />	COLOR: #000000; FONT-FAMILY: Monospaced; BACKGROUND-COLOR: #e9e8e2<br /><br />}<br /><br />.ST0 {<br /><br />	FONT-WEIGHT: bold; FONT-FAMILY: Monospaced<br /><br />}<br /><br />.line-number {<br /><br />	BACKGROUND-COLOR: #e9e8e2<br /><br />}<br /><br />.ST2 {<br /><br />	COLOR: #ce7b00<br /><br />}<br /><br />.ST1 {<br /><br />	COLOR: #0000e6<br /><br />}<br /><br /></style>

```java
<span class="line-number">1</span> <span class="ST0"><br /><br /><span class="line-number">2</span><?php     <span class="ST1">print</span> <span class="ST2">"La versión del PHP es "</span>.phpversion();<br /><br /><span class="line-number">3</span> <span class="ST0">?></span><br /><br /><span class="line-number">4</span> <br /><br /><span class="line-number">5</span> <br /><br /></span>
```

Le damos clic derecho al archivo desde el explorador de proyectos, y seleccionamos "Run in command line". Esto debería mostrar algo similar a esto en el panel inferior de Output del NB.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQhbL_YrdDpxGMBCv4QFIrUr1nJffSl3hDfUxx33NHnP1dv99NBCV8B34Px-I24f62e1jbNPMBZ-IhaJHnskz9ruVFdyxYRhV9L5JGLIRoMmMg9XPtiKikD4YC_aTAlOg_tdvFl0zPcRS7/s400-r/php_output.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhnkdnG6NU3caHHbFA7f7IRSe-w_hQbg9-Wypyhj38Q18yMd8ihQd0nl9mgk0TqTEPkjgV8aHvn_j8aEXonHDbmQMAleLHRcF9z7ml7iCGDgVcpLhwtTFHzDX6r3Tj2pQki_Lu6cvfsD6qN/s1600-h/php_output.png)

## xdebug

Necesitamos descargar el [xdebug](http://xdebug.org/). Es una herramienta de depuración para PHP, y NB está preparado para usarlo.

Buscamos la versión adecuada para nuestro PHP. En mi caso, como el PHP que estoy usando es la 5.2.5, debería usar la versión [PHP 5.2.1 - 5.2.6](http://xdebug.org/link.php?url=xdebug203-52-win).

Guardamos el archivo en la subcarpeta "ext" de PHP. Puede estar en cualquier lado, pero esta es la mejor ubicación para ello.

Ahora editaremos el archivo *php.ini* y agregaremos las siguientes líneas al final

```java
zend_extension_ts="C:/opt/php-5.2.5-Win32/ext/php_xdebug-2.0.3-5.2.5.dll"<br /><br />xdebug.remote_enable=1<br /><br />
```

Notar cómo se está indicando la ruta del archivo .dll. No son con backslash ("\") sino con slash ("/"). Guardamos el archivo php. ini y listo.

Reiniciamos el ApacheServer para que recargue la configuración del PHP.

## Depurando aplicaciones PHP

No es cosa del otro mundo hacer esto. NB soporta breakpoints, depuración de variables, etc.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0iBVdG5mI-HW62j8MIA0fQ9TZ1UUkli2zfJncOFJSWyj1JRiaCEj0RxMM7tO_5z3rlVJQ6UZL31TIRNRq2A3wvBGG0g5dk4awZf5FA-optlCP8K2vOGk6RV2PPnd6rdTgfQhBf4YXRR2_/s400-r/php_depurando.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7jvu_ZimUiEasGaE1eodRdaGYZc1ODf-NgI1VY5K8ThTo96Cqcs4j7syk2j3LfrCO1JWvQlxI1prjIrO7l_QkqhSsO5f4E9f7hY2Aa-7vv89d661994SVniN8SdkU7g5nhIVNKYw4qGKk/s1600-h/php_depurando.png)
