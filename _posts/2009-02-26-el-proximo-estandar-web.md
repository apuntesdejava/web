---
layout: post
title: "El próximo estándar web"
date: 2009-02-26T14:55:00Z
last_modified_at: 2009-04-25T21:55:03.098Z
author: "Diego Silva"
permalink: /2009/02/el-proximo-estandar-web.html
canonical_url: https://www.apuntesdejava.com/2009/02/el-proximo-estandar-web.html
tags:
  - "noticias"
  - "web"
  - "off topic"
---

(Fuente: [http://www.pc-actual.com/actualidad/noticia/2009/02/26/El-proximo-estandar-Web](http://www.pc-actual.com/actualidad/noticia/2009/02/26/El-proximo-estandar-Web))

Desde su nacimiento, la Web ha ido evolucionando, pasando de ser una red de documentos simples entrelazados a principios de los ochenta a una granestructura para ejecutar aplicaciones y servicios

En ocasiones, los fabricantes del software que permite acceder a la Web, los conocidos navegadores, han incluido en sus productos extensiones de manera unilateral, como las **etiquetas propietarias en** el lenguaje **HTML**, dando lugar a incompatibilidades entre navegadores.

Éste fue el origen de todos los problemas para los diseñadores web, que tenían que comprobar el navegador empleado por el usuario para adaptar el código o bien decantarse por uno de ellos e indicar en las páginas qué programa debía ser utilizado para verlas correctamente.

Aunque se trata de una excepción a la regla, en casos contados, esas extensiones unilaterales han terminado siendo aceptadas, explícita o implícitamente, por el resto de la industria y han alcanzado el nivel de cuasi estándar. El caso más claro es el objeto **XMLHttpRequest**, introducido por **Microsoft** en** Internet Explorer** y con el que actualmente cuentan todos los navegadores, siendo el pilar de las técnicas **AJAX**.

A fin de ofrecer una mayor funcionalidad y mejor experiencia de usuario, acercando el funcionamiento de las aplicaciones web al de los programas clásicos con interfaz nativa, surgieron las denominadas **RIA** (**Rich Internet Applications**) y, con ellas, los motores necesarios para ejecutarlas en los navegadores: **Adobe Flash Player**, **Microsoft Silverlight**, **Adobe AIR**, etc.

El inconveniente de todas estas soluciones, de cara a las empresas que desarrollan aplicaciones web, es la dependencia que crean respecto de un fabricante, aparte de la obligación que transfieren a los clientes de instalar un cierto complemento en sus navegadores, un *runtime* que puede no estar disponible para todas las combinaciones de sistemas operativos/navegador.

**Nuevos elementos de la versión 5 de HTML**

La actual versión de HTML cuenta como únicos elementos estructurales con las **secciones div **y los **párrafos de texto**, los diferentes niveles de encabezado tienen más una finalidad visual que de definición de estructura, un repertorio claramente insuficiente para la composición de documentos cada vez más extensos. En HTML 5 resultará mucho más fácil estructurar dichos documentos gracias a cinco nuevos elementos: **header**, **section**, **article**, **nav** y** footer**.

Cualquier sección del documento se delimitará entre las marcas **<section****>****** y **</section****>******, pudiendo existir secciones anidadas. En el interior de cada sección, pueden separarse artículos independientes, por ejemplo, entradas de un blog, a través de las marcas **<article****>****** y ******<****/article****>******, así como introducir enlaces de navegación a otros documentos recurriendo a las marcas ******<****nav****>****** y ******<****/nav****>******.

Por su lado, mediante las marcas ******<****header****>****** y ******<****/header****>****** se delimitarán los encabezados, por ejemplo precediendo a una sección, mientras que ******<****footer****>****<****/footer>**, como es fácil imaginar, establecerían el pie de sección.

El modelo de distribución de contenidos se completa con el nuevo elemento **address**, cuya finalidad es acoger la información de contacto relativa al contenido de una página o una sección. Habitualmente, se introducirá como elemento anidado dentro del bloque** footer** asociado a un bloque **section**.

El texto y las imágenes habituales en cualquier página se complementan, cada vez con mayor frecuencia, con **contenidos multimedia**, principalmente en forma de audio y vídeo. Existen multitud de complementos o *plug-ins* para conseguir que un navegador reproduzca prácticamente cualquier formato, cada uno de ellos con sus especificidades, limitaciones e incompatibilidades. HTML 5 agrega los nuevos elementos **audio** y **vídeo** estableciendo claramente cuáles son los formatos que, como mínimo, debe ser capaz de procesar el navegador.

**Camino hacia la Web semántica e interactiva**

La cantidad de información disponible en la Web crece de manera exponencial, hasta tal punto que prácticamente es imposible obtener siquiera una aproximación del número de documentos a los que se puede acceder desde un navegador. El mayor problema que plantea esta abundancia estriba en la dificultad de encontrar aquello que interesa, de ahí el éxito de los servicios de búsqueda que mejor funcionan.

A pesar de que la separación clara entre **contenido y estilo**, que se consigue gracias a **HTML y CSS**, facilita hasta cierto punto el proceso de búsqueda, aún es posible mejorar mucho en este sentido, siendo éste el objetivo de la denominada Web semántica. HTML 5 incorporará una serie de elementos nuevos con los que quiere contribuir a dar forma a ese nuevo concepto, elementos que permiten marcar el tipo de contenido, como **meter**, **progress**, **time**, **dialog**, **figure** y **aside**.

También es importante, desde una perspectiva funcional, incrementar la interactividad de las interfaces web, campo en el que HTML 5 agrega técnicas hoy totalmente comunes en las interfaces GUI nativas, como son las de arrastrar y soltar o deshacer/rehacer contenidos modificados.

Uno de los elementos de mayor interés en este sentido es **datagrid**, un control pensado para facilitar la visualización y edición de datos con estructura de lista, tabular o de árbol y que cuenta con los métodos y eventos necesarios para insertar nuevas filas y columnas, detectar cambios en los datos, etc. En las celdillas de esta rejilla de datos es posible introducir no solamente datos simples, sino también otros elementos HTML, como, por ejemplo, el elemento **menu**, pensado para ofrecer listas de comandos.

En la misma dirección de mejorar la interactividad, aportan su granito de arena elementos como **command**, **details** y **bb**. El primero representa cualquier comando ejecutable por parte del usuario, pudiendo tomar la forma de botón de radio, caja de selección, etc. Con el segundo es posible incluir en los documentos información adicional, no mostrada por defecto, que el usuario puede hacer visible cuando le interese.

El elemento **bb**, mucho menos detallado en el actual borrador de especificación, serviría para invocar a funciones específicas soportadas por un cierto navegador, como podría ser la conversión de una aplicación web corriente en una aplicación accesible sin conexión.

**Comunicación y almacenamiento**

Los navegadores que implementen HTML 5 harán lo mismo con el nuevo **DOM2**, una remodelación del modelo de objetos accesible desde los guiones, normalmente escritos en JavaScript, ejecutados en el navegador. Es en este campo donde seguramente se encuentran las novedades más importantes de cara a los desarrolladores de aplicaciones.

La comunicación entre el cliente, la interfaz web compuesta de HTML 5, CSS y JavaScript, y el lado servidor se verá facilitada gracias a la nueva interfaz **WebSocket**, de tipo más genérico que **XMLHttpRequest**.

También se abren las puertas a la comunicación entre documentos (interfaces) ejecutándose en el mismo navegador, a través del envío y recepción de mensajes. Asimismo, se habilita un nuevo mecanismo para que el cliente reciba asíncronamente eventos generados por el servidor, sin una actualización completa de la página, a través de la interfaz **RemoveEventTarget**.

En la actualidad, las aplicaciones web utilizan datos recuperados de un servidor y los devuelven al servidor para su almacenamiento, lo cual impide su funcionamiento en caso de no tener disponible una conexión. Hay herramientas desplegadas, como es el caso de **Adobe AIR** o **Google Gears**, que ofrecen mecanismos para el almacenamiento y recuperación de datos en el cliente a esas aplicaciones. Con HTML 5, dichas herramientas ya no serán necesarias, gracias a las cachés de aplicación.

La nueva interfaz **ApplicationCache** permite detectar a una aplicación la existencia de esa caché, comprobar los elementos que contiene, recuperarlos y actualizarlos. La caché de cada aplicación se asociará de manera única con una URL.

Además de la caché de aplicación y el usual sistema de almacenamiento y recuperación de *cookies* en el cliente, DOM2 también aportará una nueva interfaz, llamada **Storage**, implementada por dos objetos distintos: sessionStorage y localStorage.

La información almacenada en un **sessionStorage** está accesible para cualquier página procedente de la misma aplicación, mientras que **localStorage** representará un depósito privado para una página. En ambos casos, se cuenta con las operaciones apropiadas para agregar, comprobar, recuperar y eliminar pares clave-valor.

Finalmente, en cuanto a las funciones relacionadas con el tratamiento de datos en el cliente, hay que mencionar la posibilidad de utilizar bases de datos a través del método **openDatabase()** y la interfaz** Database**, aunque con ciertas limitaciones.

**Resumiendo**

Los objetivos propuestos tanto por el **W3C** como por el **WHATWG** en el actual borrador del futuro HTML 5, cuyos puntos fundamentales se han recogido en este artículo, deben interpretarse como buenas noticias para desarrolladores y diseñadores. A todos ellos nos hará la vida más fácil, al no tener que recurrir a complementos externos para conseguir la funcionalidad que necesitamos en nuestras aplicaciones.

Por el momento, no obstante, una buena parte de esos propósitos son solamente buenas intenciones. Pasarán varios años hasta que HTML 5 se convierta en una recomendación oficial, primero, y sea completamente implementada por los principales navegadores mucho tiempo después. El futuro, sin embargo, tiene un matiz indudable: el navegador se convertirá en la plataforma principal para la ejecución de aplicaciones.

**Evolución del HTML 5**

HTML 4 surgió en 1997, con ligeras modificaciones en 1999, por lo que la evolución del lenguaje de descripción de contenidos en la Web lleva invariable desde hace una década. El actual trabajo en HTML 5 está promovido por el **WHATWG **(**Web Hypertext Application Technology Working Group**), un grupo del que forman parte empresas como **Mozilla Foundation** (**Firefox**), **Apple** (**Safari**) y **Opera**.

A pesar de que Microsoft no contribuyó a la fundación de esta entidad, el futuro **Internet Explorer 8 **implementará ciertas partes de HTML 5. El último borrador data del 24 de octubre pasado (**[www.w3.org/html/wg/html5](http://www.w3.org/html/wg/html5)**), recogiendo una versión preliminar de la especificación en la que se lleva trabajando desde el año 2003 y que, posiblemente, no vea la luz, en su versión definitiva, hasta dentro de bastante tiempo.

Se estima que la especificación alcance el grado de Candidate Recomendation en torno a 2012. Esto no es óbice, sin embargo, para que los fabricantes de navegadores vayan incorporando en sus productos algunos de los avances propuestos. De hecho, en algunos de ellos ya es posible encontrar innovaciones concretas, como el objeto **canvas**.

HTML 5 es una evolución de HTML 4 y, al igual que éste, cuando se expresa en sintaxis XML se denomina XHTML. De hecho, el objetivo del W3C es que HTML 5 sustituya ciertos aspectos de XHTML 1.0, incorporando al tiempo especificaciones ya finalizadas y estables, como la de **Web Forms 2.0**. La evolución de XHTML 2.0, por el contrario, seguirá un camino independiente.

 La nueva versión de HTML vendrá también acompañada de una actualización de **DOM **(**Document Object Model**), a la que se denominará **DOM2**. Con HTML 5 y DOM2, se persigue que los diseñadores/desarrolladores puedan crear aplicaciones tipo RIA con independencia de fabricantes, apoyándose en servicios ofrecidos por el navegador sin precisar extensión alguna.
