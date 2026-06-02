---
layout: post
title: "EJB 3.1 en Porlets de Liferay"
date: 2010-10-12T05:00:00Z
last_modified_at: 2010-10-12T05:00:00.354Z
author: "Diego Silva"
permalink: /2010/10/ejb-31-en-porlets-de-liferay.html
canonical_url: https://www.apuntesdejava.com/2010/10/ejb-31-en-porlets-de-liferay.html
tags:
  - "glassfish"
  - "glassfish v3"
  - "liferay"
  - "ejb 3.1"
  - "ejb"
  - "portlets"
  - "tips"
  - "trucos"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhB4gqrVvVDiJHNhKPT7rwu_fdLN5nDC56gm__kPeh3uh6NApY-TO-YhrP7X4lrdE52MHBEk8CMG-aypHI3lt4V3xJcwaDZiePnvey0A22sxD6TwWLjRm032qVLPAJo3KVn0l_l7npE4eKx/s1600/beans1.gif)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhB4gqrVvVDiJHNhKPT7rwu_fdLN5nDC56gm__kPeh3uh6NApY-TO-YhrP7X4lrdE52MHBEk8CMG-aypHI3lt4V3xJcwaDZiePnvey0A22sxD6TwWLjRm032qVLPAJo3KVn0l_l7npE4eKx/s1600/beans1.gif)

Ya que GlassFish v3 es compatible con Java EE6, y permite módulos web con componentes [EJB](http://www.oracle.com/technetwork/java/index-jsp-140203.html)(por la característica propia de EJB 3.1).. y además Liferay puede ser instalado sobre GlassFish v3... y... los portlets son módulos web con otro archivo de despligue ¿los portlets para Liferay/GFv3 deberían permitir EJB 3.1?

Pues la respuesta es sencilla: Sí. Pero cuando uno desarrolla un portlet con EJB 3.1 y lo trata de desplegar sobre Lfieray 6.0, no funciona. Por alguna razón no despliega correctamente la aplicación, lanza errores de clases de SpringFramework faltantes, etc. Lo curioso es que si se despliega sobre Liferay 5, sí funciona correctamente. Entonces ¿qué pasa?. Pues bien, leyendo un poco los mensajes de error y después de varias pruebas.. pude dar con la solución.

Para comenzar, el error que lanza es el siguiente:

```java
<code>Error in annotation processing: java.lang.NoClassDefFoundError: org/springframework/transaction/PlatformTransactionManager</code>
```

Pero si examinamos la carpeta `lib` del módulo de liferay, sí están las bibliotecas de Spring.

La solución a este problema es el siguiente: debemos copiar ciertas bibliotecas de Spring a la carpeta `lib` del dominio donde está instalado el  Liferay. Para evitar conflictos de versión del Spring, copiemos los siguientes archivos .jar del .war de Liferay a `$GLASSFISH_HOME/domains/domain1/lib`.

- aopalliance.jar

- aspectj-rt.jar

- aspectj-weaver.jar

- commons-logging.jar

- spring-aop.jar

- spring-asm.jar

- spring-beans.jar

- spring-context.jar

- spring-core.jar

- spring-expression.jar

- spring-transaction.jar

Ahora sí, podemos desplegar portlets que contienen EJB con total normalidad.

Pero! (no tan rápido), como las clases portlets (descendientes de `javax.portlet.GenericPortlet`) no son parte del estándar de un módulo web, entonces no podrá utilizarse un EJB con la notación `@EJB` (lo que sí funciona en un Servlet). Entonces ¿cómo instanciar EJB?:

Pues habrá que utilizar el JNDI dentro del módulo, de la siguiente manera:

```java
<code>
Context c = new InitialContext();
EjbFacade facade= c.lookup("java:global/NombrePorlet/NombreEjbFacade!paquete.ejb.NombreEjbFacade");
</code>
```

Algo más explicado sobre cómo acceder a las clases EJB 3.1 se encuentra en este post: [Cliente remoto de EJB 3.]({{ '/2010/05/cliente-remoto-de-ejb-31-en-glassfish.html' | relative_url }})1

Espero que les sea de utilidad.
