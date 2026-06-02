---
layout: post
title: "Bugzilla desde NetBeans 6.7"
date: 2009-06-15T01:18:00.001Z
last_modified_at: 2009-06-15T05:50:25.506Z
author: "Diego Silva"
permalink: /2009/06/bugzilla-desde-netbeans-67.html
canonical_url: https://www.apuntesdejava.com/2009/06/bugzilla-desde-netbeans-67.html
tags:
  - "netbeans 6.7"
  - "bugzilla"
  - "netbeans"
  - "tutorial"
---

Por fin NetBeans tiene comunicación con un Issue tracker.

Hasta el momento han mencionado cómo conectarse con  Kenai, un repositorio de proyectos como Google Code o SourceForge.  Pero hay quienes manejamos problemas unicamente con el Bugzilla.

En este post comentaré cómo conectarse a un servidor Bugzilla desde NetBeans 6.7 (aunque para este post, lo estoy haciendo con una versión de desarrollo del IDE).

**Paso 0**

Tener el NetBeans 6.7. En las versiones anteriores no existe la configuración de Issue Trackers, ni con plugins.

**Paso 1**

Abrir el panel de Servicios (Ctrl+5), y en el nodo "Issue trackers", darle clic derecho y seleccionar (la única opción que existe) "Create Issue tracker..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiiSNmCY6C9-IKPq4S3Rza61RGeLIaKn3WiHd-McRPeliiuxu_Dld9TzE73axKLYAwQI1QtvKwUoDiHXaP5g0vGxLtDwXoy4GhVprfMaaHwuRdoNNk4028AA2VdQoXIqrTtAILfivq0G30W/s320/bugzilla01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiiSNmCY6C9-IKPq4S3Rza61RGeLIaKn3WiHd-McRPeliiuxu_Dld9TzE73axKLYAwQI1QtvKwUoDiHXaP5g0vGxLtDwXoy4GhVprfMaaHwuRdoNNk4028AA2VdQoXIqrTtAILfivq0G30W/s1600-h/bugzilla01.jpg)

**Paso 2**

Ahora, en la ventana que se nos muestra, debemos escribir los datos del servidor Bugzilla que queremos acceder. Yo usaré como ejemplo, el bugzilla de Gnome.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhroMQdvzVLXkFeGcLI7tbjjBfisxmyRZAKxPk8q7mHrqZE5ES7thoTPe2jJUq-D-DmRjl8JSQd-zaqRu_Xq8a2Jcs6S1ADaduqIsFxFDaG6wsxRGzcNCaX5hoNRrTf2SqUUzvOdxp5qvMu/s400/Pantallazo-Create+Issue+Tracker.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhroMQdvzVLXkFeGcLI7tbjjBfisxmyRZAKxPk8q7mHrqZE5ES7thoTPe2jJUq-D-DmRjl8JSQd-zaqRu_Xq8a2Jcs6S1ADaduqIsFxFDaG6wsxRGzcNCaX5hoNRrTf2SqUUzvOdxp5qvMu/s1600-h/Pantallazo-Create+Issue+Tracker.png)

Hacer clic en el botón "Validate" para comprobar si los datos escritos y listo. Clic en el botón "OK", y ya podemos acceder al bugzilla, ya sea para consultar incidentes:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhk4a6im4_6uFciWYOzxzsPa3xrIVN8hVYSRi2UUfp1oooU664wFKMundkv0HqyVpdprYLjDTf6EuN9ZMWS63gn-cDT88g8wn-D6I1Kl9PeR3DrPavDsvZcSNJeH8ESohkHS6GeAntCUC3U/s400/Pantallazo-NetBeans+IDE+Dev+200906131401.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhk4a6im4_6uFciWYOzxzsPa3xrIVN8hVYSRi2UUfp1oooU664wFKMundkv0HqyVpdprYLjDTf6EuN9ZMWS63gn-cDT88g8wn-D6I1Kl9PeR3DrPavDsvZcSNJeH8ESohkHS6GeAntCUC3U/s1600-h/Pantallazo-NetBeans+IDE+Dev+200906131401.png)

... o para reportar un nuevo incidente

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEikp8fVXBifBOv0WunVLKNl2cUsPobVUWOgrzoPEF8_YbQZ2iSP8xxQsh9iIjAo7_o_FCuxZY25O5wyY3xrn4Ksmj7ABYtcxPDvbClIapDUEoVmNF3N6bWhz6Ok4-EQX5rCrHW2WUz6xrOy/s400/Pantallazo-NetBeans+IDE+Dev+200906131401-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEikp8fVXBifBOv0WunVLKNl2cUsPobVUWOgrzoPEF8_YbQZ2iSP8xxQsh9iIjAo7_o_FCuxZY25O5wyY3xrn4Ksmj7ABYtcxPDvbClIapDUEoVmNF3N6bWhz6Ok4-EQX5rCrHW2WUz6xrOy/s1600-h/Pantallazo-NetBeans+IDE+Dev+200906131401-1.png)
