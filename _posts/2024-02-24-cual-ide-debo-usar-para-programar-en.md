---
layout: post
title: "¿Cuál IDE debo usar para programar en Java?"
date: 2024-02-25T04:59:00.004Z
last_modified_at: 2024-02-25T04:59:46.408Z
author: "Diego Silva Límaco"
permalink: /2024/02/cual-ide-debo-usar-para-programar-en.html
canonical_url: https://www.apuntesdejava.com/2024/02/cual-ide-debo-usar-para-programar-en.html
description: "IntelliJ, NetBeans, Eclipse.. he allí el dilema"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSWgN3efatiBbb0whXxp2t55l8F_CTC6IJw2zERZSWbOZdrwdq-iLc-RlDV6UIhXfF8SUMhn1Kvtimz/pub?w=1600&h=900)](https://docs.google.com/drawings/d/e/2PACX-1vSWgN3efatiBbb0whXxp2t55l8F_CTC6IJw2zERZSWbOZdrwdq-iLc-RlDV6UIhXfF8SUMhn1Kvtimz/pub?w=1600&h=900)

   Cuando comenzamos a programar en Java, quizás uno de los grandes dilemas
  es ¿con qué software haremos nuestro programas?

  Escuchamos, nos invitan, nos mencionan, y hasta nos persuaden (creo que no han
  llegado a amenazarnos) que debamos usar cierto IDE y no otro (a menos que sea
  una política de la empresa)

  En esta publicación analizaremos qué es y no es un IDE, mencionaremos y
  analizaremos los más conocidos, y veremos cuál es el "mejor".

Spoiler: No hay un mejor IDE. Todo depende de:

- Las funcionalidades que necesite el programador.

- Las capacidades que el IDE tenga para el programador

- La capacidad que tenga el programador.

  Quizás existan más condiciones, pero estas son las que yo considero
  importante.

## ¿Qué es un IDE?

  IDE son las siglas en inglés de
  [Entorno de Desarrollo Integrado](https://en.wikipedia.org/wiki/Integrated_development_environment), Es una aplicación software que está diseñado para facilitar el desarrollo
  de software. Es decir, de "caja" (out-of-box) ya está preparado con las
  características propias para desarrollar una aplicación.

#### ¿Qué debe tener un IDE?

Las características básicas que debe tener un IDE son:

- Un editor de código

- Herramientas de compilación

- Herramientas de depuración

## IDE más conocidos para Java

Con estos conceptos, vamos a mencionar y describir los IDE más conocidos

### Eclipse IDE

-
    Web Site: [https://eclipseide.org/](https://eclipseide.org/)

-
    Página de descarga:
    [https://www.eclipse.org/downloads/packages/](https://www.eclipse.org/downloads/packages/)

  Existe una versión ejecutable para cada plataforma. Es decir, una para MacOS,
  para Linux y otra para Windows

  Ni bien se inicia la aplicación, pregunta por un directorio que funcionará
  como Workspace, es decir, el directorio de trabajo.

  [![](/assets/blogger/eclipse_VJx6wEBQGa.png)](/assets/blogger/eclipse_VJx6wEBQGa.png)

  Originalmente, allí, en ese directorio, se deberían guardar todos los
  proyectos que deberían usarse para el trabajo actual. Si se necesita cambiar a
  otro contexto de trabajo, se debería cambiar a otro workspace donde existirían
  otros proyectos. Aún debería usarse esa manera, pero actualmente ya se pueden
  agregar proyectos que están fuera de la carpeta del workspace.

  Muchos IDE otros IDE usaron Eclipse como base, por ejemplo Liferay Studio,
  [STS IDE](https://spring.io/tools), etc. Pero
  consiste el mismo Eclipse IDE con plugin. Por ejemplo, para convertir el
  Eclipse en STS, vamos a Help > Eclipse Marketplace

  [![](/assets/blogger/eclipse_xkoS9QYMYf.png)](/assets/blogger/eclipse_xkoS9QYMYf.png)

Escribimos "Sprint Tools 4" y lo buscamos, y le damos en "Install"

  [![](/assets/blogger/eclipse_LvcBzF4lSG.png)](/assets/blogger/eclipse_LvcBzF4lSG.png)

  ... confirmamos todos las ventanas que aparecen, y... (después de reiniciar)
  al hacer "Nuevo proyecto" nos aparecerá esta opción"

  [![](/assets/blogger/eclipse_95LHH5QuwK.png)](/assets/blogger/eclipse_95LHH5QuwK.png)

Es decir, ya estará todas las funcionalidades del ecosistema de Spring para
Eclipse.

#### Pros

- Tiene un ecosistema activo de Plugins

- Es un IDE que tiene mucho tiempo de desarrollo

-
      Por tanto, es muy usado por muchos desarrolladores (ha sobrevivido al
      tiempo)

- Es gratis

#### Contras

-
      Si eres nuevo, quieres configurarlo, y no tienes paciencia, vas muerto...
      no es para ti.

-
      En mi experiencia, hay plugins que no me ha muy bien que terminan por
      congelarse la aplicación (el de Liferay, por ejemplo), ni que decir la
      versión del IDE para Linux.

-
      Tiene su propio organizador de proyectos, a parte de Maven y Gradle. Esto
      podría confundir al programador.

### Apache NetBeans

-
      Web Site [https://netbeans.apache.org/](https://netbeans.apache.org/)

-
      Página de descarga [https://netbeans.apache.org/download/](https://netbeans.apache.org/download/)

  Originalmente de Sun Microsystems, luego adoptado por herencia a Oracle, pero
  finalmente entregado a la fundación Apache.

  [![](https://i.imgur.com/QfkOycv.png)](https://i.imgur.com/QfkOycv.png)

  Tiene 3 organizaciones de proyectos (que lo veremos en una futura publicación)
  Maven, Gradle y el antiguo Ant. Además, permite la creación de proyectos
  C/C++, PHP y Web HTML.

  [![](https://i.imgur.com/M1auMeR.png)](https://i.imgur.com/M1auMeR.png)

### Pros

-
    Es 100% portable. La misma aplicación (.zip) puede ser ejecutado para
    Windows, MacOS y Linux

-
    Permite abrir varios proyectos a la vez y agruparlos en "grupos de
    proyectos" sin necesidad de tener un workspace. Estos grupos de proyectos
    puede abrir los proyectos que se encuentran en una carpeta, pueden ser los
    que se abran en el momento, o proyectos que dependan de otros.
![](https://i.imgur.com/Lv58m8q.png)

-
    Está continuamente actualizado por la comunidad Apache (entre lo que pensé
    este artículo y escribí, ya salió la versión 21)

- Es gratis

### Contras

-
    No existen muchos plugin disponibles, a pesar que existe documentación para
    que uno cree los suyos.

-
    Hay funcionalidades que están desactualizadas, como el plugin para Jira.

### IntelliJ IDEA

-
      Web site: [https://www.jetbrains.com/idea/](https://www.jetbrains.com/idea/)

-
      Página de descarga [https://www.jetbrains.com/idea/download/](https://www.jetbrains.com/idea/download/)

  Para muchos el IDE estrella, pero para otros un IDE desafiante. Se hizo más
  popular cuando se migró el Android Studio de Eclipse a IntelliJ.
  Definitivamente es más rápido, la nueva interfaz de usuario es más intuitiva
  (porque se parece a un editor de texto conocido) y más fácil de encontrar las
  opciones en comparación a Eclipse (que su interfaz no ha cambiado casi nada
  desde que se creó) y a NetBeans (que ha tenido ligeros cambios, pero en
  esencia sigue siendo el mismo)

#### Pros

-
      Existen dos presentaciones: la
      [Edición Comunidad](https://www.jetbrains.com/idea/download/download-thanks.html?code=IIC)
      que no te cuesta nada y que puedes hacer buenos proyectos Java, incluyendo
      Android Studio que corre sobre esta edición... pero si quieres hacer
      proyectos realmente completos en Java (entiéndase Jakarta EE) necesitas la
      [edición Ultimate](https://www.jetbrains.com/idea/download/download-thanks.html) que te puede costar aproximadamente
      [USD 17 al mes](https://www.jetbrains.com/idea/buy/?section=personal&billing=monthly).

-
      Existen muchos plugins muy actualizados y muy buenos que hacen la vida muy
      fácil al programador

-
      El editor de código es muy inteligente, predictivo, y ayuda en la
      navegación en el código para encontrar las referencias entre las
      declaraciones.

-
      El editor mismo te sugiere las mejoras en el código que se puede hacer.

#### Contras

-
      Si quieres usar al 100% de las capacidades de Java en el IDE, necesitarías
      la edición Ultimate. Por ejemplo, Spring Boot sí puedes utilizar en la
      edición Community, pero sacarías más partido si usaras la versión
      Ultimate. Si deseas usar Jakarta EE (que no es lo mismo que Spring),
      necesitarías Ultimate. Solo mira estas dos pantallas de creación de
      proyecto.

Esta es la de crear proyecto de la edición Comunity

  [![](https://i.imgur.com/aaQYjm4.png)](https://i.imgur.com/aaQYjm4.png)

Y esta es la de crear proyecto de la edición Ultimate.

  [![](https://i.imgur.com/dQsJkd6.png)](https://i.imgur.com/dQsJkd6.png)

  ¿Se nota en el margen izquierdo cuántos tipos de proyectos y cuáles son los
  que se puede generar con la edición Comunidad y la edición Ultimate? Pues
  bueno, si quieren usar uno u otro, depende del programador.

## ¿Cuál IDE usar?

  Esa respuesta depende del programador, pero como dije al inicio del artículo,
  depende del uso. Yo no recomiendo que se use un IDE para todo. Total, Java es
  Java, así que no importa en que IDE uses, siempre terminará en bytecodes,
  empaquetados en .jar o .war. En mi caso, para mis proyectos personales uso
  NetBeans, cuando quiero usar Liferay uso IntelliJ porque su plugin funciona
  muy bien allí a diferencia del respectivo de Eclipse. Y a veces mi propios
  proyectos los abro en IntelliJ o en Fleet, de paso para probarlo e ir
  notificando el uso a los creadores y dar mis apreciaciones.

  En fin, no hay que estar aferrados a un IDE 100% porque habrán veces que
  necesitemos usar funcionalidades que no existan en otro.... por ejemplo, una
  vez me tocó trabajar con ADF, así que me tocó usar JDeveloper, no tuve otra
  opción, pero tampoco me volví fanático de ese IDE.

## ¿Y Visual Studio Code?

No es IDE... punto

#### pe.. pe.. pero...

No lo es, y lo demostraré con dos puntos:

-
      Por definición, el IDE es un ENTORNO de desarrollo INTEGRADO. Es decir, ya
      VIENE TODO INTEGRADO. Y los ejemplos que hemos visto, las funcionalidades
      de edición, compilación y depuración ya están integradas.... a Visual
      Studio Code hay que AGREGARLE el plugin de Java. Si no, no diría esto al
      inicio:

        [![](https://i.imgur.com/h4wNs3N.png)](https://i.imgur.com/h4wNs3N.png)

-

        La misma página de
        [Microsoft define a Visual Studio Code como un editor de código](https://code.visualstudio.com/docs/supporting/faq), no como un IDE. Visual Studio sí es un IDE, pero Code no lo es. Creo
        que de ahí viene la confusión.

        [![](https://i.imgur.com/k8XtCfg.png)](https://i.imgur.com/k8XtCfg.png)

## Conclusión

No nos peleemos por decir cuál es el mejor IDE, o cuál IDE (o editor de código) debamos usar. Mientras seámos productivos en Java, y el cliente y usuario estén felices, y nosotros contentos, que ese sea el correcto.
