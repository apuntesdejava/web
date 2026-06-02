---
layout: post
title: "Instalando Liferay 6 en GlassFish v3"
date: 2010-09-10T00:00:00.001Z
last_modified_at: 2010-11-04T18:19:48.571Z
author: "Diego Silva"
permalink: /2010/09/instalando-liferay-6-en-glassfish-v3.html
canonical_url: https://www.apuntesdejava.com/2010/09/instalando-liferay-6-en-glassfish-v3.html
tags:
  - "glassfish"
  - "tutorial"
  - "glassfish v3"
  - "portlets"
  - "liferay"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)

Retomando los tutoriales, ahora vengo con lo de la instalación de Liferay 6 en GlassFish v3.

La verdad, es casi lo mismo que está explicado en el anterior post "[Instalación de Liferay en un servidor GF v3 para producción]({{ '/2010/07/instalacion-de-liferay-en-un-servidor.html' | relative_url }})", con la excepción de que se debe considerar algunos cambios:

Los archivos se deben descargar de aquí (al momento que se escribió este post, la versión disponible es la 6.0.5): [https://sourceforge.net/projects/lportal/files/Liferay Portal/6.0.5/](https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.0.5/)

[](http://draft.blogger.com/goog_791314962)

Dentro hay varios archivos, los principales que vamos a utilizar para desplegar el liferay son los siguientes:

- Bibliotecas de dependencias: [https://sourceforge.net/projects/lportal/files/Liferay Portal/6.0.5/liferay-portal-dependencies-6.0.5.zip/download](https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.0.5/liferay-portal-dependencies-6.0.5.zip/download)

- .War del portal: [https://sourceforge.net/projects/lportal/files/Liferay Portal/6.0.5/liferay-portal-6.0.5.war/download](https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.0.5/liferay-portal-6.0.5.war/download)

**Nota:**

- No se necesitará el archivo `XercesImpl.jar`.

- Se debe reemplazar un archivo del GlassFish. Este archivo se llama `commons-codec-repackaged.jar` y se encuentra dentro de `$GLASSFISH_HOME/glassfish/modules`. En su lugar debe estar la biblioteca `commons-codec.jar`. Esta se puede obtener desde aquí: [http://commons.apache.org/codec/](http://commons.apache.org/codec/) (Exactamente, desde aquí: [http://commons.apache.org/codec/download_codec.cgi](http://commons.apache.org/codec/download_codec.cgi))

- Cuando se configure el Pool de Conexiones para LiferayPool, poner `emulateLocators=false`

Todo lo demás, es exactamente lo mismo como se explicó en el anterior post. Hasta también podeis usar el `portal-ext.properties` para utilizar la base de datos como Pool de Conexiones: [http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252Fportal-ext.properties](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252Fportal-ext.properties).

¿Y la migración desde una versión anterior?  La verdad me está resultando difícil. A mi me interesa, ya que tengo un portal que quiero migrarlo a esta nueva versión. Así que ya os avisaré cuando lo haya logrado.
