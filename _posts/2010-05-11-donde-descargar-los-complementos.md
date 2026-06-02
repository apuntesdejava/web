---
layout: post
title: "Dónde descargar los complementos (plugins) curiosos de NetBeans"
date: 2010-05-11T14:55:00.004Z
last_modified_at: 2010-05-11T17:24:10.874Z
author: "Diego Silva"
permalink: /2010/05/donde-descargar-los-complementos.html
canonical_url: https://www.apuntesdejava.com/2010/05/donde-descargar-los-complementos.html
tags:
  - "netbeans"
  - "plugins"
  - "trucos"
---

En mi post "[Plugins curiosos para NetBeans 6.8]({{ '/2009/10/plugins-curiosos-para-netbeans-68.html' | relative_url }})"olvidé mencionar cómo descargar estos plugins.

Realmente no pertenecen exclusivamente a la versión 6.8. Son complementos que están en fase de desarrollo, son útiles, pero no están en producción. Pero son muy buenos. Estos están disponibles en la versión de desarrollo de NetBeans.

Ahora, les diré cómo incluirlos en cualquier versión de NetBeans. Si el complemento a descargar no es compatible con la versión del IDE que se tiene, se emitirá un mensaje de error.

- Desde el menú del IDE, entrar a Herramientas > Complementos (Tools > Plugins)

- Seleccionar la ficha "Configuración" (Settings). Es la última.

- Hacer clic en el botón "Agregar" (Add). En la ventana que se muestra, agregar un nombre que identifica a la lista de complementos y el URL de donde se descargan los complementos.

- Clic en Aceptar. Se vuelve a la ventana de Complementos.

- Seleccionar la ficha "Complementos disponibles" (Available Plugins) Segunda ficha, clic en el botón "Volver a cargar el catálogo" (Reload catalog)... y ahí se visualizará todos los complementos que se acaban de agregar.

Ahora, ¿qué URLs a agregar en el paso 3?

Aquí les doy dos:

- **Nombre:** Additional Development Plugins

**URL:** http://updates.netbeans.org/netbeans/updates/dev/uc/final/main/catalog.xml.gz

- **Nombre:** Latest Development Build

**URL:** http://deadlock.netbeans.org/hudson/job/nbms-and-javadoc/lastStableBuild/artifact/nbbuild/nbms/updates.xml.gz

Espero que les sea de utilidad.

Ah! En ese post mencioné el "Goto implementation". En la versión 6.9 de NetBeans ya es parte del IDE y no es un complemento. Es muy útil para navegar entre herencias de clases. En el NB 6.9 no se tiene que hacer clic derecho sobre el código para saltar, sino viene como marcas en el editor, lo que lo hace más amigable.
