---
layout: post
title: "Permisos por usuario para recursos de Liferay"
date: 2012-08-27T15:39:00.002Z
last_modified_at: 2012-08-27T15:39:31.704Z
author: "Diego Silva Límaco"
permalink: /2012/08/permisos-por-usuario-para-recursos-de.html
canonical_url: https://www.apuntesdejava.com/2012/08/permisos-por-usuario-para-recursos-de.html
tags:
  - "liferay"
  - "tips"
---

[![](/assets/blogger/heading.png)](/assets/blogger/heading.png)

A partir del **Liferay **5, los permisos a los recursos (blog, foro, contenido, etc) se hacen a través de "Roles". Es decir, si se quería compartir un solo archivo a una sola persona, habría que crear un "Rol" donde esté esa persona. Eso es algo complicado de mantener, si es que estamos usando el Liferay como una intranet y se les permite  a los usuarios que compartan información únicamente a ciertos usuarios.

[![](/assets/blogger/compartiendo-recursos-6.png)](/assets/blogger/compartiendo-recursos-6.png)

Pues estuve revisando la documentación y encontré lo siguiente:

Se deberá establecer en portal-ext.properties la siguiente propiedad:

**permissions.user.check.algorithm=4**

Luego, iniciamos el Liferay y nos mostrará este mensaje en la consola del contenedor Java EE (En mi caso, estoy usando Tomcat 7)

[![](/assets/blogger/log-warn-lr4.png)](/assets/blogger/log-warn-lr4.png)

El mensaje es claro. Así que entramos al Panel de Control de Liferay, y seleccionamos en Servidor > Administrador del servidor.

[![](/assets/blogger/administrador-del-servidor.png)](/assets/blogger/administrador-del-servidor.png)

Luego, la ficha "Migración de datos"

[![](/assets/blogger/migracion-de-datos.png)](/assets/blogger/migracion-de-datos.png)

.. vamos a la parte inferior de la página, y veremos la sección **Convertir a algoritmo de permisos antiguo**... activamos el check "Generar roles personalizados"

[![](/assets/blogger/generar-roles-personalizados.png)](/assets/blogger/generar-roles-personalizados.png)

Hacemos clic en "Ejecutar"

Esperamos a que "cocine"

[![](/assets/blogger/tomcat-procesando.png)](/assets/blogger/tomcat-procesando.png)

Luego reiniciamos el Liferay.

Y luego elegimos un porlet y seleccionamos "Configuración"

[![](/assets/blogger/nuevo-configurar.png)](/assets/blogger/nuevo-configurar.png)

Y listo.. como antes. Aunque tengo mis dudas de que sea eficiente (por las advertencias que he leído), lo revisaré qué tal va.
