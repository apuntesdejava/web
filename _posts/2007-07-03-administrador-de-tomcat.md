---
layout: post
title: "Administrador de Tomcat"
date: 2007-07-03T15:00:00Z
last_modified_at: 2009-04-25T21:55:03.277Z
author: "Diego Silva"
permalink: /2007/07/administrador-de-tomcat.html
canonical_url: https://www.apuntesdejava.com/2007/07/administrador-de-tomcat.html
tags:
  - "tomcat"
  - "web"
---

Quizás el Tomcat no es muy bien visto porque no tiene una interfaz de administración tan amigable como el de IIS.

Pero esto es totalmente falso. Desde las primeras versiones, Tomcat ha tenido un administrador vía web. Pero por razones de seguridad el acceso era bloqueado.

Quizás todos los hemos visto, pero no le hemos dado importancia. Cuando iniciamos el tomcat, se nos muestra una página como esta.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLRgM5eoAGTzGrTcKWa_V-qZHvF1Eqw8kd1rOmmMJlW1Wzp4XVGPs1PRaDsO87CU_RH2clXUuqBIfuI9Kn4HwT1aQeZfiVDQc1D9i4_QK6asUkTAHawpzDPCl8Q9OaVE5TVuHRTfmJw4CX/s320/tomcat-00.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLRgM5eoAGTzGrTcKWa_V-qZHvF1Eqw8kd1rOmmMJlW1Wzp4XVGPs1PRaDsO87CU_RH2clXUuqBIfuI9Kn4HwT1aQeZfiVDQc1D9i4_QK6asUkTAHawpzDPCl8Q9OaVE5TVuHRTfmJw4CX/s1600-h/tomcat-00.jpg)Vemos un bloque llamado "Administration" y dentro un enlace que dice "Tomcat Manager". Y cuando se trata de ingresar allí, pide un usuario y una clave que ignoramos.

Pues bien, si vemos en esta misma página, está la explicación.

Editemos el archivo `$CATALINA_HOME/conf/tomcat-users.xml` y agreguemos una línea como esta:

```java
<code><?xml version='1.0' encoding='utf-8'?><br /><tomcat-users><br /><role rolename="manager"/><br /><role rolename="admin"/><br /><user username="admin" password="admin" roles="admin,manager"/><br /></tomcat-users><br /><br /></code>
```

Reiniciamos el Tomcat, y tratamos de entrar nuevamente al Tomcat Manager utilizando el usuario admin con contraseñoa admin.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt2pWp2emAtA4RXAB81AsC9N-rwxdfYkTVQAWlcYEM3Tgm0OUOCT4zrPbgMyfWCT0TmJRkc6JaN3ssaeO5q21Yhl5Zan2jknsUYkgloYoAcR2Qpa0K5TswdsbqyCg21OaaAt7y9iAOjfmp/s320/tomcat-01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt2pWp2emAtA4RXAB81AsC9N-rwxdfYkTVQAWlcYEM3Tgm0OUOCT4zrPbgMyfWCT0TmJRkc6JaN3ssaeO5q21Yhl5Zan2jknsUYkgloYoAcR2Qpa0K5TswdsbqyCg21OaaAt7y9iAOjfmp/s1600-h/tomcat-01.jpg)
Desde aquí podemos detener una aplicación en ejecución, reiniciarla, replegarla (desinstarla), y crear una nueva aplicación web. Incluso podemos cargar un nuevo .war
