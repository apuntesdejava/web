---
layout: post
title: "Payara Micro"
date: 2017-04-01T23:54:00.002Z
last_modified_at: 2018-01-10T23:41:26.580Z
author: "Diego Silva Límaco"
permalink: /2017/04/payara-micro.html
canonical_url: https://www.apuntesdejava.com/2017/04/payara-micro.html
description: "Un simple jar menos de 70MB que permite ejecutar aplicaciones Java EE puros sin necesidad de montar un GlassFish (o Payara) completo."
tags:
  - "restful"
  - "microservicios"
  - "payara"
  - "payaramicro"
  - "java ee"
---

[![]({{ '/assets/blogger/Payara-Micro.jpg' | relative_url }})]({{ '/assets/blogger/Payara-Micro.jpg' | relative_url }})

Ya estamos en una época en que no necesitamos de grandes servidores de aplicaciones para hacer funcionar una pequeña aplicación. Montar todo un entorno es cada vez más simple. Por ejemplo se está usando Docker para montar un entorno especializado únicamente para un fin: o base de datos, o servidor de aplicaciones, etc. Así se ahorran costos para configurar grandes entornos.

En el mundo de Java EE, hay alternativas para hacer aplicaciones más pequeñas y no depender de todo un servidor. De esta manera podemos tener microservicios en lugar de una aplicación monolítica. Spring Boot es una alternativa: unos cuantos scripts y ya tenemos una aplicación Spring listo para ejecutarse desde cualquier contenedor standalone.

Pero en este post escribiré de otra propuesta: [Payara Micro](http://www.payara.fish/payara_micro).

Un simple jar menos de 70MB que permite ejecutar aplicaciones Java EE puros sin necesidad de montar un GlassFish (o Payara) completo. Todo se ejecuta desde consola, tan simple como esto:

```java
java -jar payara-micro-4.1.1.171.1.jar --logo --deploy rest-demo-services-1.0.war
```

(El parámetro `--logo` es opcional, pero al usarlo queda bien bonito cuando arranca)

[![]({{ '/assets/blogger/2017-04-01_18-40-01.png' | relative_url }})]({{ '/assets/blogger/2017-04-01_18-40-01.png' | relative_url }})

Ahora, Payara también puede ser ejecutado desde un programa Java, de la siguiente manera:

<script src="https://bitbucket.org/apuntesdejava/payara-micro-demo/src/master/payara-micro-programmatically-app/src/main/java/com/apuntesdejava/payaramicro/programmatically/EmbeddedPayara01.java?embed=t"></script>

Por otro lado, también se puede desplegar un .war, además de establecer en qué puerto se va a ejecutar.

<script src="https://bitbucket.org/apuntesdejava/payara-micro-demo/src/master/payara-micro-programmatically-app/src/main/java/com/apuntesdejava/payaramicro/programmatically/DeployWar.java?embed=t"></script>

Y si tu aplicación fue desplegada por maven, y está instalada en tu repositorio local (o desde cualquier repositorio) también puedes ejecutarlo desde un programa java.

<script src="https://bitbucket.org/apuntesdejava/payara-micro-demo/src/master/payara-micro-programmatically-app/src/main/java/com/apuntesdejava/payaramicro/programmatically/DeployFromMaven.java?embed=t"></script>

En esta dirección está el código fuente para puedan bajarlo y jugar con él.

[https://bitbucket.org/apuntesdejava/payara-micro-demo](https://bitbucket.org/apuntesdejava/payara-micro-demo)

También incluye scripts para probar el [servicio](https://bitbucket.org/apuntesdejava/payara-micro-demo/src/master/rest-demo-services) que está publicado.

En post siguientes veremos cómo integrarlo con otros servicios, otras capas y orientarlo todo el desarrollo para microservicios.

**Si te gustó, dale like; si te es útil, comparte... es gratis.**
