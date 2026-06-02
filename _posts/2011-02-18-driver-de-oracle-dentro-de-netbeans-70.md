---
layout: post
title: "Driver de Oracle dentro de NetBeans 7.0"
date: 2011-02-18T20:58:00Z
last_modified_at: 2011-02-18T20:58:21.035Z
author: "Diego Silva Límaco"
permalink: /2011/02/driver-de-oracle-dentro-de-netbeans-70.html
canonical_url: https://www.apuntesdejava.com/2011/02/driver-de-oracle-dentro-de-netbeans-70.html
tags:
  - "netbeans 7.0"
  - "base de datos"
  - "oracle"
  - "netbeans"
---

[![]({{ '/assets/blogger/ora-nb-001.png' | relative_url }})]({{ '/assets/blogger/ora-nb-001.png' | relative_url }})

Acabo de bajar el [NetBeans 7.0 Beta 2](http://netbeans.org/community/releases/70/) con la [traducción en español](http://bits.netbeans.org/netbeans/7.0/community/daily/latest/) y comencé a probar la conectividad con Oracle. Había leído que el manejo de conexiones desde el IDE estaba mejorado (sobre todo con Oracle, ¿por que será?) y como estaba viendo un proyecto con Oracle (muchos oracle en un solo párrafo) decidí probarlo.

Para empezar, como toda conexión desde el IDE, vamos al panel de "Prestaciones". La manera más rápida es presionando las teclas Ctrl+5. Y en ese momento aparecerá el panel con los nodos de servicios (o prestaciones) para el IDE. Entre ellos está el nodo "Bases de datos".

[![]({{ '/assets/blogger/ora-nb-002.png' | relative_url }})]({{ '/assets/blogger/ora-nb-002.png' | relative_url }})

Y como podemos ver, ya están preconfigurados los controladores para Oracle OCI y Thin. Así que trataremos de crear una conexión utilizando ese controlador. Le damos clic derecho y seleccionamos "Usar este controlador".

[![]({{ '/assets/blogger/ora-nb-003.png' | relative_url }})]({{ '/assets/blogger/ora-nb-003.png' | relative_url }})

Pero el IDE nos dirá que no hay controladores disponibles (si es la primera vez que usamos este IDE aparecerá este mensaje).

[![]({{ '/assets/blogger/ora-nb-004.png' | relative_url }})]({{ '/assets/blogger/ora-nb-004.png' | relative_url }})

Nos sugiere de donde bajarlo, pero como ya lo había bajado anteriormente, simplemente le doy clic en "Agregar" y uso el .jar del Oracle JDBC.

[![]({{ '/assets/blogger/ora-nb-005.png' | relative_url }})]({{ '/assets/blogger/ora-nb-005.png' | relative_url }})

Después, clic en "Siguiente" para ver las propiedades de la conexión. Yo opté por un servidor oracle que tengo disponible, por ello el SID puse ORCL, pero si usan el Oracle Express, el SID será XE.

[![]({{ '/assets/blogger/ora-nb-006.png' | relative_url }})]({{ '/assets/blogger/ora-nb-006.png' | relative_url }})

Hacemos clic en "Test Connection" (Ajá!, falta traducir este botón) y si está todo bien, nos mostrará el mensaje "Connection succeded" (otro más)

Clic en "Siguiente", y el IDE nos confirmará el esquema que va a utilizar.

[![]({{ '/assets/blogger/ora-nb-007.png' | relative_url }})]({{ '/assets/blogger/ora-nb-007.png' | relative_url }})

Luego clic en "Terminar" y listo: Nuestro IDE ya está conectado a la base de datos. Espero que también pueda ver StoredProcedures, como el JDeveloper `:)`
