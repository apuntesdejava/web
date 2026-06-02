---
layout: post
title: "Actualización de GlassFish v3 a v3.0.1"
date: 2010-06-22T05:00:00.012Z
last_modified_at: 2010-06-22T05:00:02.487Z
author: "Diego Silva"
permalink: /2010/06/actualizacion-de-glassfish-v3-v301.html
canonical_url: https://www.apuntesdejava.com/2010/06/actualizacion-de-glassfish-v3-v301.html
tags:
  - "glassfish"
  - "glassfish v3"
  - "tips"
---

[![Sparky V3](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhI8JTZy_YRF8wkEul2eKVCMfHpwugWjzdMYAztsPYjOhyphenhyphenRsubfd6flS9Lb9V4vVsfOZNZTHaywj2sa2hyphenhyphenSrLI10982_feocCHDOO2XtwMjJsP4NoUWE69z55QIiWA74CnpXPbaLwHGLqO_/s320/sparky_v3_blue.gif)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhI8JTZy_YRF8wkEul2eKVCMfHpwugWjzdMYAztsPYjOhyphenhyphenRsubfd6flS9Lb9V4vVsfOZNZTHaywj2sa2hyphenhyphenSrLI10982_feocCHDOO2XtwMjJsP4NoUWE69z55QIiWA74CnpXPbaLwHGLqO_/s1600/sparky_v3_blue.gif)

Junto con el lanzamiento de NetBeans 6.9, Oracle también lanzó GlassFish v 3.0.1 (que también viene incluido en el NB 6.9)

Ahora, si ya tenemos en producción un GFv3 con todas las aplicaciones configuradas, JDBC Resources puesto a punto... ¿cómo le hacemos para actualizar a la versión  3.0.1?

Tranquilos, no hay que temer.. aquí está la solución

Desde la línea de comandos, entramos al directorio `$GLASSFIS_HOME\bin` y ejecutamos lo siguiente:

```java
<code>
[root@host bin]# <span style="color: blue;"><b>./pkg list</b></span></code>
```

Y si es la primera vez que vamos a ejecutar esta opción, le respondemos que "sí"

```java
<code>The software needed for this command (pkg) is not installed.

When this tool interacts with package repositories, some system information
such as your system's IP address and operating system type and version
is sent to the repository server. For more information please see:

http://wiki.updatecenter.java.net/Wiki.jsp?page=UsageMetricsUC2

Once installation is complete you may re-run this command.

Would you like to install this software now (y/n): y

Proxy: Using system proxy settings.
Install image: /opt/glassfishv3
Installing pkg packages.
Initialization complete.

Software successfully installed. You may now re-run this command (pkg).

</code>
```

Ahora, volvemos a ejecutar el comando **`pkg list`** y nos mostrará los paquetes instalados en el nuestro servidor

```java
<code>
NAME (PUBLISHER)                              VERSION         STATE      UFIX
felix                                         2.0.2-0         installed  ----
glassfish-appclient                           3.0-74.2        installed  ----
glassfish-cmp                                 3.0-74.2        installed  ----
glassfish-common                              3.0-74.2        installed  ----
glassfish-common-full                         3.0-74.2        installed  ----
......
pkg-toolkit-incorporation                     2.3.2-38.2791   installed  ----
python2.4-minimal                             2.4.4.0-38.2791 installed  ----
</code>
```

Necesitamos la herramienta de actualización, esto se hace así:

```java
<code>
[root@host bin]# <span style="color: blue;"><b>./pkg install updatetool</b></span>

DOWNLOAD                                  PKGS       FILES    XFER (MB)
Completed                                  2/2     899/899      9.0/9.0

PHASE                                        ACTIONS
Install Phase                              1045/1045</code>
```

Bien, ahora ejecutaremos nuevamente el "list", y nos mostrará los paquetes instalados y cuales cuenta con una actualización (tienen el subfijo "u"):

```java
<code>
[root@host bin]# ./pkg list
NAME (PUBLISHER)                              VERSION         STATE      UFIX
felix                                         2.0.2-0         installed  u---
glassfish-appclient                           3.0-74.2        installed  u---
glassfish-cmp                                 3.0-74.2        installed  u---
glassfish-common                              3.0-74.2        installed  u---
glassfish-common-full                         3.0-74.2        installed  u---
......
pkg-toolkit-incorporation                     2.3.2-38.2791   installed  ----
python2.4-minimal                             2.4.4.0-38.2791 installed  ----
updatetool                                    2.3.2-38.2791   installed  ----
wxpython2.8-minimal                           2.8.10.1-38.2791 installed  ----
</code>
```

Falta un poco... ahora instalamos la nueva versión de la imagen, así:

```java
<code>
[root@host bin]# <b><span style="color: blue;">./pkg image-update</span></b>
DOWNLOAD                                  PKGS       FILES    XFER (MB)
Completed                                40/40     306/306    56.5/56.5

PHASE                                        ACTIONS
Removal Phase                                  43/43
Install Phase                                  34/34
Update Phase                                 877/877</code>
```

Listo!!

Reiniciamos el GlassFish, y tendremos hasta nueva cara desde el inicio:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhviM4Ft0Ro5YlGuJdLF1boCn0P6LSJI3Dky6ZmrYL59bHveJThyrKqR9qwQ9jt6U7_t_swAkuhy_CrDguVfv_OS7QOhM3c_89B0NNMHL5-NV2NpftxXXHvJNsGsQBh8NDIxXXWS0vmrJes/s400/gf301.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhviM4Ft0Ro5YlGuJdLF1boCn0P6LSJI3Dky6ZmrYL59bHveJThyrKqR9qwQ9jt6U7_t_swAkuhy_CrDguVfv_OS7QOhM3c_89B0NNMHL5-NV2NpftxXXHvJNsGsQBh8NDIxXXWS0vmrJes/s1600/gf301.jpg)

Esto es también válido para Windows.
