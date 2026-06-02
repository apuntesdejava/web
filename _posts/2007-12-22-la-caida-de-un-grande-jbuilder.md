---
layout: post
title: "La caida de un grande - JBuilder"
date: 2007-12-22T16:37:00Z
last_modified_at: 2009-04-25T21:55:03.654Z
author: "Diego Silva"
permalink: /2007/12/la-caida-de-un-grande-jbuilder.html
canonical_url: https://www.apuntesdejava.com/2007/12/la-caida-de-un-grande-jbuilder.html
tags:
  - "java"
  - "opinion"
---

Yo era un consumidor de los productos Borland desde que existió Turbo Pascal 5.5. Con la venida de los Windows, Borland decidió subir un poco más de nivel evolucionando  Turbo Pascal  a Delphi que todas luces era mucho mejor que Visual Basic 3.0 (creo que fue por el año 1993) Tenía todo lo necesario para que fuese una aplicación completa para Win32: orientado a objetos, usa el API directo de Windows (sin ningún runtime como lo tiene Visual Basic), no sé.. era EL software para desarrollo de Windows.  Pero perdió terreno porque le faltó a Borland lo que tiene (o lo que es) Microsoft: PUBLICIDAD. La mejor versión de Delphi fue la 7.0, aún hay gente que lo usa, y a pesar que Borland ya puesto todo su esfuerzo para poner a Delphi 2007 sobre cualquier versión previa... parece que no es suficiente. ¿Como pudieron los de Microsoft poner a el Visual Studio .Net sobre todo el studio  6.0? Simple... publicidad.

Recuerdo también antes que saliera el Windows 95 (que decía ser de 32 bits, cuando realmente no lo era, sino hasta subversiones posteriores) IBM tenía su OS/2. Y en lugar de hacer publicidad extrema con su sistema operativo (que era realmente impresionante) se dedicó a cuestionar al Windows 95... más publicidad para Microsoft sin ningún esfuerzo. Todos sabemos que Windows es malo.. totalmente malo y cada vez peor... pero la gente lo recuerda bien, y si piensa en un computador siempre pensará en Windows.

Cuando me topaba con un programador (o estudiante de programación) siempre mencionaba Visual como si fuera lo único que existiera: "¿usas visual?"... "tengo un programa en visual"... "¿sabes visual?" y yo le respondía: qué visual? visual basic? visual objects? visual fox?. Algunos respondian, otros no. El poder recordación de la palabra Visual era tan fuerte que la gente lo usaba con naturalidad sin saber de lo que hablaban.

En fin, ya me estoy desviando del tema de este post.

Borland apostó muy bien por darle todo su esfuerzo a un IDE para Java: JBuilder. Desde la versión 3 que comencé a usar me pareció espectacular, sorprendente.  Con dos clic se tenía lo que necesitaba. Aunque era pesado, era muy bueno.

Su versión final fue la 2006, pero pareciera que ya no querian seguir perdiendo esfuerzo en rehacer un IDE cuando ya en el mercado existían varios... y los más usados son libres!

Para la versión 2007 decidieron dejar su IDE y usar uno ya hecho, solo habría ponerle algunas bibliotecas y otras opciones y voila! un JBuilder nuevo. Y el último.

Eclipse - para mi - es malo. No es muy intuitivo como lo era JBuilder. Se necesitan de muchas bibliotecas para hacer algo simple, y como lei en un artículo en la web: uno baja 20 modulos de Eclipse y no se sabe que hacen. Una aplicación con JSF en JBuilder 2006 era simple, tanto de hacer como de desplegar. En Eclipse (y también en JBuilder 2007) se necesita descargar bibliotecas adicionales! OMG! tanto pesa el instalador y aún el instalador y necesita descargar más cosas de internet!

Lo peor fue que JBuilder 2007 está basado en Eclipse 2.5... ahora Eclipse está en la versión 3 Muchas bibliotecas (como el ex Mylar ahora Mylin) ya no existen, y por tanto el update de Eclipse no está del todo completo. ¿Como solucionar ese problema de dependencia de JBuilder? Fácil, crear una biblioteca llamada JGear que se anexe al Eclipse.

¿Y JBuilder?

Para el 2007, Borland creó la divisón CodeGear que se dedicaría más a la parte de desarrollo. Ahí fueron a parar Delphi, JBuilder, Interbase entre otros.

Para mi JBuilder dejó de existir. Ahora se volvió una biblioteca que no sé si la gente lo quiera comprar. Yo creo que uno más usa un programa que un componente. Así que aún prevalecerán Eclipse y NetBeans.
