---
layout: post
title: "DBF2Java Library mudado"
date: 2015-05-07T19:41:00.002Z
last_modified_at: 2015-05-07T19:41:58.492Z
author: "Diego Silva Límaco"
permalink: /2015/05/dbf2java-library-mudado.html
canonical_url: https://www.apuntesdejava.com/2015/05/dbf2java-library-mudado.html
---

[![dbf 2 java]({{ '/assets/blogger/foxpro.png' | relative_url }})]({{ '/assets/blogger/foxpro.png' | relative_url }})

Hace muchos años (si son más de 5, ya son muchos) hice una biblioteca para manejar archivos DBF en Java. Esto fue porque necesita importar archivos DBF creados por FoxPro (¿alguien recuerda ese programa?). Como yo venía de una cantera que todo se trabajaba con DBF, entonces mi idea era hacer una biblioteca en Java que hiciera los mismos comandos de Fox en Java... bueno, casi todos. Así que solo hice la versión de leer registros, mas no terminé la parte de escribir registros.

Lo publiqué en un post anterior ([http://www.apuntesdejava.com/2007/09/dbf-2-java-library.html]({{ '/2007/09/dbf-2-java-library.html' | relative_url }})) y el código fuente estaba publicado en esta dirección:

[https://code.google.com/p/dbf2java-library](https://code.google.com/p/dbf2java-library)

...y, por los cambios que están haciendo en Google, lo he mudado acá:

[https://bitbucket.org/apuntesdejava/dbf2java-lib](https://bitbucket.org/apuntesdejava/dbf2java-lib)

Sinceramente no pensé que tendría acogida esta biblioteca. Hay usuarios que les gustaba y les iba bien... y también hay usuarios que actualmente reportan fallas, sobretodo cuando son tablas que tienen más de 94 campos. (Hijito! en mish tiemposh máshimo ushábamos 60 camposh! cof cof cof!)

En fin, ese código ya toca su repintada, peinada, despulgada y ponerlo bonito para que aún sirva.

Si alguien quiere ayudar en mantener el código, encantado estaré en recibir su apoyo.
