---
layout: post
title: "Autenticación y Autorización de aplicaciones Java Web"
date: 2015-03-26T18:37:00.001Z
last_modified_at: 2018-01-10T23:43:18.803Z
author: "Diego Silva Límaco"
permalink: /2015/03/autenticacion-y-autorizacion-de.html
canonical_url: https://www.apuntesdejava.com/2015/03/autenticacion-y-autorizacion-de.html
tags:
  - "glassfish"
  - "seguridad"
  - "jdbcrealm"
  - "java ee"
  - "netbeans"
  - "video"
---

[![Autenticación y Autorización de aplicaciones Java Web](/assets/blogger/Swrd.gif)](/assets/blogger/Swrd.gif)

**Autenticación** es el proceso de asegurar que un usuario es quien dice ser. Comúnmente se le da la seguridad usando un id de usuario y su respectiva contraseña.

**Autorización** es el proceso de asegurar que ciertos usuarios tengan un perfil específico para acceder a ciertos recursos autorizados.

En este vídeo veremos cómo implementar la autenticación y autorización en una aplicación web típica. **Pero**... nosotros no programaremos a la base de datos, tampoco cómo deberá acceder ciertas páginas usando alguna condición "if", nada de eso. Lo que haremos será configurar el GlassFish para que se encarga de buscar en la base de datos, y permitir el acceso a recursos (o carpetas) de nuestra página web.

### Materiales

Usaremos

- GlassFish 4

- NetBeans 8

- MySQL 5.6 (En realidad, funcionaría con cualquier base de datos)

### Base de datos

En nuestra base de datos debemos tener al menos dos tablas, una que tendrá los usuarios y la contraseña encriptada (con SHA-256), y otra con los grupos asociados a los usuarios que tendrán los permisos. En nuestro ejemplo tendremos tres usuarios (user1,user2 y user3) y dos grupos (admin y user). Los que pertenecen al grupo "admin" podrán acceder a los recursos que (configuraremos después) estarán en la carpeta "admin", y lo mismo para los usuarios del grupo "user".

Aquí el script de la base de datos.

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/resources/data-example.sql?embed=t"></script>

En MySQL podemos generar la contraseña encriptada de la siguiente manera

```java
UPDATE user_
   SET password=sha2(userId,256);
```

NOTA: No existe función para descriptar el SHA-256, así que ni pregunten ni averiguen, es, justamente, encriptada con alta seguridad.

### Configuración del GlassFish

Necesitamos configurar la autenticación Realm de GlassFish. En el vídeo se muestra de la manera visual, pero también se puede hacer la línea de comandos.

Aquí está el script (para Windows) para crear la conexión a la base de datos...

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/resources/create-pool-connection.bat?embed=t"></script>

... y para la autenticación

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/resources/create-auth-resource.bat?embed=t"></script>

### Aplicación web

Nuestra aplicación web es simplemente:

- El home

- El index de la carpeta "admin"

- El index de la carpeta "user"

- El formulario de inicio de sesión

- Y el mensaje de error en un inicio de sesión.

Aquí el código del home

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/src/main/webapp/index.html?embed=t"></script>

Como se puede ver, solo son enlaces a la página de inicio de cada carpeta. Estas carpetas estarán protegidas y la manera de protegerlas lo usaremos usando el archivo `web.xml`

Aquí tenemos el archivo `web.xml`

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/src/main/webapp/WEB-INF/web.xml?embed=t"></script>

Como vamos a desplegar en GlassFish, necesitamos el archivo de despliegue de GlassFish. Aquí se asociarán los grupos de usuarios contra los roles que hemos establecido en `web.xml`. Aquí está el código fuente:

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/src/main/webapp/WEB-INF/glassfish-web.xml?embed=t"></script>

La página de inicio de sesión debe tener ciertos valores, en el formulario, y en los campos de inicio de sesión. Por lo demás, es como cualquier HTML.

<script src="https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/src/main/webapp/login/login_form.jsp?embed=t"></script>

<iframe allowfullscreen="" frameborder="0" height="600" src="https://www.youtube.com/embed/LiWSSOkduYo" width="800"></iframe>

Para mayor información técnica, revisar la siguiente documentación

- [Java EE Security: Advanced Topics](https://docs.oracle.com/javaee/7/tutorial/security-advanced.htm#GJJWX)

- [Using the JDBC Realm for User Authentication](https://docs.oracle.com/javaee/7/tutorial/security-advanced003.htm#BABEJJDE)

- [Securing HTTP Resources](https://docs.oracle.com/javaee/7/tutorial/security-advanced004.htm#BABGEJJJ)

- [Configuring Security Using Deployment Descriptors](https://docs.oracle.com/javaee/7/tutorial/security-advanced007.htm#GKHRL)

### Código fuente

Y el código fuente lo puedes explorar aquí:

[https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/](https://bitbucket.org/apuntesdejava/blog/src/tip/demo-auth-web/)

 Y descargar desde aquí:

[https://java.net/projects/apuntes/downloads/download/web/demo-auth-web.tar.gz](https://java.net/projects/apuntes/downloads/download/web/demo-auth-web.tar.gz)
