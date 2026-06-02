---
layout: post
title: "Sugerencias para realizar un proyecto"
date: 2009-08-26T16:16:00Z
last_modified_at: 2009-08-26T16:16:26.087Z
author: "Diego Silva"
permalink: /2009/08/sugerencias-para-realizar-un-proyecto.html
canonical_url: https://www.apuntesdejava.com/2009/08/sugerencias-para-realizar-un-proyecto.html
tags:
  - "opinion"
  - "off topic"
---

He estado desaparecido por un tiempo. Tanto que a mi blog le han crecido telarañas. ¿Por qué? Porque estaba liado con tres proyectos, además de mi trabajo, además de mi licenciatura en la univ. (que por cierto, hoy acabo!)

Y en todo este tiempo, he aprendido algunos puntos para hacer mejor los proyectos.

No pretendo mostrar los top-10, ni top-5 de hacer un proyecto perfecto... solo quiero opinar y compartir de cómo debería hacerse un proyecto de acuerdo a mi experiencia.

Comencemos:

- **Documenta todo los acuerdos con el cliente**. Esto suena trillado..unos dirían "es obvio". Sí, es obvio.. pero por eso mismo que es obvio, a veces lo ignoramos. Si quieres ser más exquisito, usa un formato como sugiere RUP, o XP. La cuestión es que en cada reunión con el cliente, se debe documentar lo que se debe hacer y lo que NO se debe hacer. Esto es define el ALCANCE DEL PROYECTO.

- **Utiliza alguna herramienta electrónica SIMPLE para documentar** desde el Alcance del proyecto, hasta los avances del desarrollo del proyecto. Sugiero que sea SIMPLE. Puedes usar el MS Project, Primavera, dotProject, etc. Son efectivos y son muy visuales. Pero el punto exacto es que se debe documentar lo que se tiene que hacer y qué ya se hizo. Puedes usar el [Google Sites](http://sites.google.com/), o si tienes un host, instala un wiki. Si tienes un host propio, instala el [jspwiki](http://www.jspwiki.org/). Así trabajan en NetBeans.

- **Utiliza SIEMPRE un sistema de control de versiones.** Un compañero de trabajo guardaba todo su proyecto en su disco duro, hasta que se malogró. Se logró recuperar los archivos y ponerlos en un disco temporal. Pero cuando se trató de restaurar del disco temporal a uno nuevo, hubieron carpetas (justo el del proyecto principal) que no se pudieron restaurar. Es una historia muy larga... pero puedo resumir que después de algunos días se pudo recuperar el código fuente.  Puedes usar el [Project Hosting de Google Code](http://code.google.com/intl/es-ES/projecthosting/), y ocultar la parte de "explorar código", para que tu código no pueda ser accedido por terceros (si es que no quieres que tu código sea accedido por terceros). También puedes usar tu pendrive (USB) para que sea el repositorio de tu código fuente de manera local. Lo importante es guardarlo bajo un esquema de control de versiones tales como Mercurial o SVN. Si no usas un IDE que utilice SVN o Mercurial, existen herramientas como [TortoiseSVN](http://tortoisesvn.tigris.org/) y [TortoiseHG](http://bitbucket.org/tortoisehg/stable/wiki/Home) (para SVN y Mercurial respectivamente), que hace que el explorador de tu Windows (si usas windows) haga el control de versiones. Es muy interesante, y lo recomiendo mucho.

- **Separa un momento para agradecer a Dios.** Gracias a Dios tienes un proyecto entre manos. ¿Por qué no una pequeña oración sincera a quien permitió que tuvieras ese proyecto y que te deje tener un ingreso?

- **No juntes dos o más proyectos para desarrollarlos a la vez.** Primero acaba uno, para luego hacer el otro. Si quieres hacer tres proyectos, y cada uno toma dos meses en hacerse. Mejor has uno por uno. Porque si lo haces todo junto, los tres proyectos durarán dos meses, pero no terminarán después de dos meses... sino después de seis meses. La duración del proyecto no asegura la fecha de culminación de él.

- **Si eres casado, utiliza a tu esposa como la mejor *tester *de tu proyecto**. Esto tiene beneficios por partida doble.

- Tienes alguien de confianza que te puede decir exactamente lo que está bien o mal del producto que estás desarrollando. La puedes tener 24 horas al día, y no te cobra!. Y si es de las que les gusta el Internet.. con mucha más razón, porque verá tu software desde el punto de vista de usuario. Si te dice cosas que podría despreciar tu proyecto, no te molestes... considera sus puntos de vista... estarás muy agradecido por las opiniones de ella.

- Ella se sentirá útil hacía ti. Una mujer siempre quiere ser útil hacía su pareja. Y si su pareja le dice "no, tú no lo hagas, yo lo hago solo" cuando ella quiere ayudar, ella se sentirá rechazada. No estoy diciendo que haga todo nuestro trabajo. Solo digo que hay que darle lugar a nuestra esposa ya que es nuestra [AYUDA IDÓNEA](http://www.biblegateway.com/passage/?search=G%C3%A9nesis%202:18-23&version=RVR1960) de entre toda la creación.

- **En tus tiempos libres (cuando no tienes un proyecto entre manos) revisa otras aplicaciones o páginas web, así no tengan que ver con los proyectos que estás acostumbrado a hacer.** Eso te daría más ideas para desarrollar los nuevos proyectos. Quizás haya un ícono, o alguna acción especial que no es común pero efectiva para ciertas circunstancias... y que podría estar en tus proyectos.**

**

- **Si tienes familia: del tiempo que estás con tu ella, separa un tiempo prudente para realizar tu proyecto. **No al revés: no separes un tiempo del desarrollo de tu proyecto para estar con tu familia. Si tienes hijos, una línea óptima de código no hará que ellos tengan una sonrisa.

- **Utiliza siempre pruebas unitarias.** Recuerda que cuando construyen un auto, no lo prueban cuando todo esté construido. Sino prueban cada parte en *standalone* (como el motor, el sistema de ventilación, etc), y luego lo ensamblan todo para hacer la prueba final. Existen el [JUnit](http://www.junit.org/) (para Java),  [PHPUnit](http://www.phpunit.de/) (para PHP), [.NetUnit](http://sourceforge.net/projects/dotnetunit/) (Para .Net), [JMeter](http://jakarta.apache.org/jmeter/) (para diversos componentes.. muy bueno).

- **Implementa *log *en la aplicación**. Eso te permitirá saber qué está haciendo la aplicación en un determinando momento. Si bien es cierto que implica hasta duplicar la cantidad de líneas de código, lo estarás bien agradecido, ya que si hubiera un problema, no tendrías porque desarmar la aplicación para ver qué pasa, tienes un control en producción de lo que está haciendo, y puedes hasta tener un histórico del acceso que está pasando en tu aplicación, tanto que podría enviarte un mail si hay un error fatal. Existe el [log4j](http://logging.apache.org/log4j/1.2/index.html), [Commons logging](http://commons.apache.org/logging/), y el [Java Log](http://java.sun.com/javase/6/docs/api/java/util/logging/package-summary.html).

Estos son algunos. Espero que te sea de utilidad.
