---
layout: post
title: "Nuestro primer Portlet en Liferay"
date: 2010-07-20T05:00:00.002Z
last_modified_at: 2011-02-19T23:00:15.417Z
author: "Diego Silva"
permalink: /2010/07/nuestro-primer-portlet-en-liferay.html
canonical_url: https://www.apuntesdejava.com/2010/07/nuestro-primer-portlet-en-liferay.html
tags:
  - "netbeans 6.9"
  - "liferay"
  - "portalpack"
  - "tutorial"
  - "netbeans"
  - "portlets"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)

Hasta el momento hemos visto cómo [configurar Liferay sobre un Servidor Glassfish v3 para producción](/2010/07/instalacion-de-liferay-en-un-servidor.html). Esto nos permite tener un Portal en blanco listo para que nosotros le configuremos todo. Es decir, el Liferay que viene preconfigurado con el GF, Tomcat o Jetty que está disponible en la [página de descarga de liferay.com](http://www.liferay.com/es/downloads/liferay-portal/overview), tiene contenido preparado, textos de ejemplo, temas, aplicaciones completas, etc. Además que viene configurado con HSQLDB. Si al preconfigurado le cambiamos el acceso a la base de datos para que utilice el MySQL o cualquiera, en ese momento todo el contenido del Portal estará en blanco.

Recomiendo la versión preconfigurada de liferay para conocer un poco cómo funciona, y además, para usarlo como caja de arena para probar nuestros portlets.

En este post veremos cómo hacer un Portlet para Liferay usando NetBeans 6.x

Quizás te preguntarás por qué quiero usar más GlassFish que Tomcat, así sea para una aplicación web simple. No tengo nada en contra de Tomcat, fue mi primer contenedor Servlet/JSP que utilicé (exactamente la versión 3). Es rápido y simple de usar. Pero para mi me es un problema cuando quiero gestionar con base de datos. Tomcat maneja su [Pool de conexiones](http://tomcat.apache.org/tomcat-6.0-doc/jndi-datasource-examples-howto.html) de manera eficiente, pero configurarlo no es muy agradable que digamos (editar un archivo .xml que es parte del .war no creo que sea muy portable si quiero pasar de desarrollo a producción sin editar nada) Mientras que en[GlassFish la configuración del DataSource](http://docs.sun.com/app/docs/doc/821-1751/ablih?l=en&a=view) se hace desde la misma consola del servidor.
Bueno, esto fue un offtopic del post, explicando porqué uso más GlassFish que Tomcat.

Comencemos con la preparación de nuestro NetBeans para desarrollar un portlet:

### Configurando NetBeans con un Servidor Liferay+Glassfish v3

Previamente ya debe estar instalado los [plugins del PortalPack, que lo vimos en un post anterior](/2010/07/instalando-portal-pack-en-netbeans-69.html).

- **Abrimos nuestro NetBeans **y vayamos al panel de Prestaciones (Services) con Ctrl+5. Abrimos el nodo "Servidores" y hacemos clic derecho sobre ese nodo, seleccionando la opción "Agregar Servidor".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhL3BKcmErx9OvNFsckt8N7DU9hqOcVzvy5EnfWmlEtbt-dyEopCPKJw7IUW1_lEpJwC1HHKeXdaoEkAlcN_e6WOF_E8KCYrsMhNW7TRzuJmIFULyJOl8Xd9Sm59WNn5L1A1pW-IizC1Sp5/s320/liferay-porlet2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhL3BKcmErx9OvNFsckt8N7DU9hqOcVzvy5EnfWmlEtbt-dyEopCPKJw7IUW1_lEpJwC1HHKeXdaoEkAlcN_e6WOF_E8KCYrsMhNW7TRzuJmIFULyJOl8Xd9Sm59WNn5L1A1pW-IizC1Sp5/s1600/liferay-porlet2.jpg)

- **Seleccionamos de la lista** "Liferay Portal Server 5.1.x/5.2.x" y hacemos clic en Siguiente.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj1sx3GGqlejcVIrZ1rCDGUcLT8XAlq5kbFdIrLWxl6nC28laFeYVlXWwMTC2rJtxwzWHRtFDGMRCSuX2HZIswWiRx5dkZfp90Bjjk8uCDf9-KCir8HSa-DboY2l_U5pGP82dUuwkDAdBpS/s400/liferay-porlet3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj1sx3GGqlejcVIrZ1rCDGUcLT8XAlq5kbFdIrLWxl6nC28laFeYVlXWwMTC2rJtxwzWHRtFDGMRCSuX2HZIswWiRx5dkZfp90Bjjk8uCDf9-KCir8HSa-DboY2l_U5pGP82dUuwkDAdBpS/s1600/liferay-porlet3.jpg)

- Seleccionamos el tipo de Servidor a GlassFish, y el GlassFish Home a "C:\glassfishv3\glassfish".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-ZH0fPESEoiPH3GyteRO2zBymGXYjq6N29JLsJb7XEE-hENnFwV9zLL50pNsdXkQMtJPlLsOF9HQOM-yKkY6ok_0FCtI66qtv5Jl3URIkCfdjKqqcdUzM3iMkax89680Tei_BOO4EBeVm/s400/gf-nb-add.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-ZH0fPESEoiPH3GyteRO2zBymGXYjq6N29JLsJb7XEE-hENnFwV9zLL50pNsdXkQMtJPlLsOF9HQOM-yKkY6ok_0FCtI66qtv5Jl3URIkCfdjKqqcdUzM3iMkax89680Tei_BOO4EBeVm/s1600/gf-nb-add.jpg)

- Clic en "Siguiente". Dejamos los valores por omisión, y clic en "Terminar"

### Ejecutando Liferay desde NetBeans

Bien, ahora que ya tenemos nuestro NetBeans configurado con Liferay, será bueno primero iniciar el Liferay para ver sobre donde vamos a trabajar. Para ello, hacemos clic derecho sobre el ícono del Liferay que hemos acabado de agregar al NetBeans, y seleccionamos "Start".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgR5E3ikTkJaIt7ssLBlQ1hHDLxndwpKpwA03D7Bwudg-b47c05DQ_k9ugTAWPB2-5hi_CtPbiFIR1B6qfmugkpgXxL69cbsrGcjgnVbH9UZIMtT8Q2LJJ2WhuB5fvAcBUOV1WBqp_fLgtP/s320/liferay-porlet5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgR5E3ikTkJaIt7ssLBlQ1hHDLxndwpKpwA03D7Bwudg-b47c05DQ_k9ugTAWPB2-5hi_CtPbiFIR1B6qfmugkpgXxL69cbsrGcjgnVbH9UZIMtT8Q2LJJ2WhuB5fvAcBUOV1WBqp_fLgtP/s1600/liferay-porlet5.jpg)

... y si tienes un computador tan lento como el que tengo en la oficina, en unas horas en unos momentos, se mostrará el Liferay en el navegador.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhW5hWKVHe4y24r-QOxhKc4jbDXftpqSFVp6bow5fSIWmF8ekGWGK5thd87FIvEn-zWIH3Bb_lQjPr7hxKLfxsYLrk_C9RaSEPM1pNq1q19j12AVy0KWcfKcO7yxT4tFOn2yOoX11249Jxx/s400/portlet-web09.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhW5hWKVHe4y24r-QOxhKc4jbDXftpqSFVp6bow5fSIWmF8ekGWGK5thd87FIvEn-zWIH3Bb_lQjPr7hxKLfxsYLrk_C9RaSEPM1pNq1q19j12AVy0KWcfKcO7yxT4tFOn2yOoX11249Jxx/s1600/portlet-web09.jpg)

### Nuestro primer portlet básico

Un portlet es en realidad una aplicación web que se distribuye en .war y que tiene archivos .xml de despliegue adicionales. Como aplicación web, también cuenta con su ruta de contexto (context-path), sus configuraciones del web.xml y demás. Ahora con la versión JavaEE6, también puede contener EJB 3.1, ya que - como acabo de decir - es una aplicación web. Solo que esta aplicación web no se desplegará desde la consola del contenedor web, sino desde el mismo contenedor de portlets, en este caso, desde liferay.

#### Creando un proyecto web

- Así que comencemos creando una aplicación web desde Archivo > Nuevo proyecto > Java Web > Web Application.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi1DRmikeVYpnn8nupXBo2ik6eD3ahVwPGLxh5jYcKSmcFGlD-AMpajRyvpw3yWaDWgX_vUAEzZgqQt4k_mYKshM5LzRhXrp0CirFtY6eM38T1NRfjVoVJw8esIKKDz68KGrDDADlaXMDvw/s400/portlet-web01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi1DRmikeVYpnn8nupXBo2ik6eD3ahVwPGLxh5jYcKSmcFGlD-AMpajRyvpw3yWaDWgX_vUAEzZgqQt4k_mYKshM5LzRhXrp0CirFtY6eM38T1NRfjVoVJw8esIKKDz68KGrDDADlaXMDvw/s1600/portlet-web01.jpg)

- Clic en Siguiente. Luego indicamos el nombre del proyecto y su ubicación. Le ponemos que se llamará SimplePortlet, y tomar la ubicación predeterminada.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiJkEV-DvgQWzvCwhBgUweL9VrL3ARmB5qHjY120-qQB_fDzAxuX0qOxqeWNhVOzRSj0Ab7M5s6EWLWL3XJgiB6Y6yCSkgUgSMktk93lTZ1QfViM4Lyt6S1fCLeceuYxY9hw-xP95A4-kKR/s400/portlet-web02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiJkEV-DvgQWzvCwhBgUweL9VrL3ARmB5qHjY120-qQB_fDzAxuX0qOxqeWNhVOzRSj0Ab7M5s6EWLWL3XJgiB6Y6yCSkgUgSMktk93lTZ1QfViM4Lyt6S1fCLeceuYxY9hw-xP95A4-kKR/s1600/portlet-web02.jpg)

- Clic en Siguiente. Seleccionamos el servidor donde se desplegará. En este caso seleccionamos el que acabamos de agregar al IDE hace un momento. Notar que cuenta la versión del Java EE y la ruta de contexto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSkjHwJRfK9GYQt-CzzztapOkQuNTI_apdLitBlEA5_5JU4zGtmh8mQyO5yucovT6Ap82dZSnonEEhXLJ7AnYOrmWufVdwUI1LPUwXCxkaj23Y2VVDksBaxt5UuWP1iKKkA9SUFLYCqIvY/s400/portlet-web03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSkjHwJRfK9GYQt-CzzztapOkQuNTI_apdLitBlEA5_5JU4zGtmh8mQyO5yucovT6Ap82dZSnonEEhXLJ7AnYOrmWufVdwUI1LPUwXCxkaj23Y2VVDksBaxt5UuWP1iKKkA9SUFLYCqIvY/s1600/portlet-web03.jpg)

- Clic en Siguiente. Cuando nos pida los "Frameworks" a utilizar, activamos el que dice "Portlet Support". Y más abajo dice "Create Portlet". Lo dejamos desactivado para crearlo posteriormente.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgP1Gx9rUPt2q01Wb_2Gy1jono27IgkfY0D81Ze0h1aIzi6X4xtRvGwnuhjQcSPfF3_wH0wrQI-_ZtKDvzzY4Y_X5tKKgfdNQrAigUy8_6VIgkZiEfCUdfDMBqiOFXJNs1uNjpUOfxX2oet/s400/portlet-web04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgP1Gx9rUPt2q01Wb_2Gy1jono27IgkfY0D81Ze0h1aIzi6X4xtRvGwnuhjQcSPfF3_wH0wrQI-_ZtKDvzzY4Y_X5tKKgfdNQrAigUy8_6VIgkZiEfCUdfDMBqiOFXJNs1uNjpUOfxX2oet/s1600/portlet-web04.jpg)

- Clic en Terminar.
Vemos que es un proyecto web mas archivos .xml adicionales....

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEinXpdrOmALsQJoX_FOHV-Tx8fnXBedKtIaYSF-ULbdL6KqVji_1JKpOJVuRjuBA1-v8K2J-4MQw6zt7imt0h3m7YpuxuyzkLdBHuKH-deSYIEwIviXMryp11-w1uavwv3tIhIoIRoNY_U0/s320/portlet-web05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEinXpdrOmALsQJoX_FOHV-Tx8fnXBedKtIaYSF-ULbdL6KqVji_1JKpOJVuRjuBA1-v8K2J-4MQw6zt7imt0h3m7YpuxuyzkLdBHuKH-deSYIEwIviXMryp11-w1uavwv3tIhIoIRoNY_U0/s1600/portlet-web05.jpg)

Insisto diciendo que es un proyecto web, para que no sea chocante tratar de pensar que es otro tipo de proyecto y no se hagan preguntas como:

- ¿Puedo ponerle mis imágenes? ¿Dónde?
- ¿Puedo usar .css?
- ¿Puedo poner .js?
- ¿Dónde pongo las clases?
- etc... etc.. etc
Este proyecto podrá tener más de un portlet. Así que comenzaremos a crear el primero.

#### Creado un portlet

**Advertencia**: Al momento de hacer este post, encontré problemas para desplegar un portlet desde NetBeans + PortalPack al Liferay/GFv3. Esto es porque el PortalPack considera que el Servidor a utilizar es Liferay/GFv2 o Tomcat. Utiliza el JSR88 para desplegarlo sobre GFv2, y este JSR88 ya no está disponible para GFv3. En resumen. Si utilizas el Liferay+GFv2, el despliegue será inmediato. Pero para este post haremos la manera no cómoda pero que funciona: desplegar el Portlet desde la Consola de Liferay.

- Hagamos clic en Nuevo > Archivo nuevo (Ctrl+N) y seleccionamos Portlets > Portlet

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiqU92BW1E3pP6B853wBQjzaE_PvL_XL_wJbmeZ513GYzaIWgFLG75zdYwUsru87CIlxkly5dWYkLi6JIdz3__-qp30Fjt1RclWVrpRtV7_a-ecz91PL_LSZOcYvXv4d1S0IxUVZD5AdCry/s400/portlet-web06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiqU92BW1E3pP6B853wBQjzaE_PvL_XL_wJbmeZ513GYzaIWgFLG75zdYwUsru87CIlxkly5dWYkLi6JIdz3__-qp30Fjt1RclWVrpRtV7_a-ecz91PL_LSZOcYvXv4d1S0IxUVZD5AdCry/s1600/portlet-web06.jpg)

- Clic en Siguiente. Luego escogemos como nombre de la clase Portlet `FactorialPorlet` del paquete `portlets`. Eso es solo la característica de la clase. Pero esta clase debe tener características como Porlet, por ejemplo el nombre, descripción, etc. Así que pongamos los siguientes valores:

- PortletName: FactorialPortlet
- Portlet Display Name: Factorial Portlet
- Porlet Description: Portlet que calcula el factorial
- Portlet title: Factorial en Portlet
- Portlet Short Title: Factorial
- Activar los checks  "Edit" y "Help". Estas serán páginas adicionales que interactuará con el usuario.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqsAlGLZNLCkR_l7E7v0PDorErPS39DluWhXkN9AlQsx7ZtaxRdRPjcmI5MZrBTWRIh8DjHH91Efv8I5HogRpdr-Sc7bZU1Lk2h3E25DnsytzC458NFc9PJIOChaT341xuAUWOPiQLrh5_/s400/portlet-web07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqsAlGLZNLCkR_l7E7v0PDorErPS39DluWhXkN9AlQsx7ZtaxRdRPjcmI5MZrBTWRIh8DjHH91Efv8I5HogRpdr-Sc7bZU1Lk2h3E25DnsytzC458NFc9PJIOChaT341xuAUWOPiQLrh5_/s1600/portlet-web07.jpg)

- Clic en Siguiente. Activamos el check para que nos cree los .jsp correspondientes.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh7uKDHIyP4wShXYEfXTo9LX8osC1hut-bWRUouM3y_l2MLNaFGSred8t71ktAqRkYXX5wi10BVyCuLWo8oWVBg6okP5H-FcN4BefpLTBG9-HpufRPhtYIfceZYpQ3us-Bq2KdA30XJEUa9/s400/portlet-web08.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh7uKDHIyP4wShXYEfXTo9LX8osC1hut-bWRUouM3y_l2MLNaFGSred8t71ktAqRkYXX5wi10BVyCuLWo8oWVBg6okP5H-FcN4BefpLTBG9-HpufRPhtYIfceZYpQ3us-Bq2KdA30XJEUa9/s1600/portlet-web08.jpg)

- Clic en Terminar.

Con esto nos habrá creado una clase `FactorialPortlet`, y dentro de WEB-INF/jsp estarán los archivos .jsp que serán utilizados para el interfaz de usuario.

Vemos que hay dos métodos que nos llaman la atención (que nos recuerdan al doGet y doPost de los Servlets) `processAction()`, `doView`, `doEdit` y `doHelp`. Estos métodos son invocados por el Portal para mostrar una página dependiendo de la petición que haya hecho el usuario. Si solo quiere ver, se ejecutará el `doView`, si va a editar las preferencias del portlet, ejecutará `doEdit`, y si quiere ver la ayuda del portlet, se ejecutará `doHelp`. Pero cuando se quiere atender una petición, se ejecutará el método `processAction()`. Notemos que dentro está la clase `PortletRequestDispatcher` que no es más que una especialización de la clase `RequestDispatcher` utilizada en los servlet bajo el modelo MVC. Así que, aquí no hay modo de fallar `:)`.

Ahora, editemos el archivo `FactorialPortlet.java` para que calcule el Factorial. Primero, el método que hace el cálculo.

```java
<code>    static long factorial(long base) {        if (base < 2) {            return 1;        }        return base + factorial(base - 1);    }</code>
```

Y, editemos el método `processAction()` para leer un parámetro de la web, lo calculamos, y lo mostramos al usuario.

```java
<code>    public void processAction(ActionRequest request, ActionResponse response) throws PortletException, IOException {        String numero = request.getParameter("numero");        System.out.println("Parametro leido:" + numero);        if (numero != null && !numero.isEmpty()) {            try {                long $numero = Long.parseLong(numero);                long factorial = factorial($numero);                System.out.println("resultado:" + factorial);                request.setAttribute("factorial", factorial);            } catch (NumberFormatException ex) {                ex.printStackTrace();            }        }    }</code>
```

Ahora, nos falta el formulario. Abramos el archivo `FactorialPortlet_view.jsp`, y escribamos el siguiente código:

```java
<code><%@page contentType="text/html"%><%@page pageEncoding="UTF-8"%><%@ page import="javax.portlet.*"%><%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%><h3>Cálculo de factorial</h3><form action="<portlet:actionURL/>" method="post">    Ingrese un número:    <input type="text" name="numero" /><br/>    <button type="submit">Calcular</button>    <div>        Resultado: ${factorial}    </div></form></code>
```

La mayor parte del formulario nos es conocido: tiene input, botones, imprime resultado, etc. Pero el tag `<portlet:actionURL/>` quizás no sea claro, pero puede darnos la idea de qué es. Este tag devuelve la ubicación del mismo portlet dentro de toda la página de portlets. Me explico mejor:

Recordemos que cuando hacemos un formulario en JSP, siempre el `action` debe apuntar a una dirección web que recibirá los parámetros del formulario: puede ser un Servlet u otro JSP. Ahora, ¿qué pasaría si tuvieramos varios forms en una misma página que apuntan a diferentes direcciones? ¿Cómo hacemos para que diferencie que un formulario es diferente a otro y diferenciar las peticiones? Pues, hacer que el url del action sea totalmente diferente. Pues bien, bajo la misma lógica, el tag `<portlet:actionURL/>` nos ahorra saber cuál es el URL del Portlet que debemos ejecutar, además que le pone una identificación única para diferenciarlos de los demás Portlets.

#### Creando el archivo de despliegue

Para crear un archivo .war que contiene el Portlet, es bastante simple. Es tan igual como cuando se crea un archivo. Clic derecho el ícono de proyecto, y seleccionar Limpiar y Construir (Clean and Build).

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7BR_MaidpomrFsB1XK35WT_29uPvyetTCcLGrpp-IMy3l_qF-9eOIyqVnwSjE7__KZFv_WdxEN4RmEjiJKvdecdDVig2iAnn_EwzLtOAEiYbzauBs2wKLZDjbjT3Irbh9LGHcaSxr1jAv/s320/portlet-web10.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7BR_MaidpomrFsB1XK35WT_29uPvyetTCcLGrpp-IMy3l_qF-9eOIyqVnwSjE7__KZFv_WdxEN4RmEjiJKvdecdDVig2iAnn_EwzLtOAEiYbzauBs2wKLZDjbjT3Irbh9LGHcaSxr1jAv/s1600/portlet-web10.jpg)

Con esto, nos creará un archivo .war. Veamos donde lo creado en el panel de Salida (Ctrl+4) del NetBeans.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgT7Hl2An2-7TppiuBGA4lqqx7tAc3M9TnKkdiYnVddx9JHKeyEpoD8gXYoVwY7k79_Cl9ydU-jL97hwD3XNN_9aTcmTbGPEC8wkL7uh6DMeqiW61aEh-2fL6O3Xbyu-iV-EeAh27yApine/s640/portlet-web11.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgT7Hl2An2-7TppiuBGA4lqqx7tAc3M9TnKkdiYnVddx9JHKeyEpoD8gXYoVwY7k79_Cl9ydU-jL97hwD3XNN_9aTcmTbGPEC8wkL7uh6DMeqiW61aEh-2fL6O3Xbyu-iV-EeAh27yApine/s1600/portlet-web11.jpg)

#### Desplegando el .war

Para desplegar un .war tenemos dos maneras: la larga, y la corta. Solo mencionaré la forma corta. Es simple: basta con copiar el .war en la carpeta "deploy" del GlassFish...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZSv31DGd3sTqczznEexZzJAumP0XRfvtjbatxc2XLno2YNgyJ5JkefGPLFTA6M16tUJydQH9UpgRRut-FWSVuK9XRbNvNBxHuzBnKOKmQAu9iXQZ8Cb_DTDuW-o1xqrkh7HsooMt2b3cv/s320/portlet-web16.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZSv31DGd3sTqczznEexZzJAumP0XRfvtjbatxc2XLno2YNgyJ5JkefGPLFTA6M16tUJydQH9UpgRRut-FWSVuK9XRbNvNBxHuzBnKOKmQAu9iXQZ8Cb_DTDuW-o1xqrkh7HsooMt2b3cv/s1600/portlet-web16.jpg)

...esperamos unos segundos y el archivo desparecerá. Esperamos unos segundos más y estará desplegado en el Servidor.

#### Colocando el Portlet en el Portal

Primero debemos iniciar la sesión (por omisión es **test@liferay.com** con contraseña **test**). Luego, en el parte superior derecha está menú "dock", al que le damos clic y seleccionamos "Add application"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAQXSMuPqnIbcYR7YAXtCZrLIEqkTyLjMkeKkY6MzKHSOWhJawNmiWlSq4FTDSnmyFs1pxsEU3Qv4kH6CsAj784_f4Rch7lGnJzaHePs0nnD-mg4QgvVY6WZHQ3aE0AgWz-vJTw7EBEJTv/s320/portlet-web12.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhAQXSMuPqnIbcYR7YAXtCZrLIEqkTyLjMkeKkY6MzKHSOWhJawNmiWlSq4FTDSnmyFs1pxsEU3Qv4kH6CsAj784_f4Rch7lGnJzaHePs0nnD-mg4QgvVY6WZHQ3aE0AgWz-vJTw7EBEJTv/s1600/portlet-web12.jpg)

Esto hará que se muestre un panel en la margen izquierda y veamos una ventana con todas los portlets disponibles, agrupados por categorías. Nuestro portlet está en la categoría "User_Portlets".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj98ad2_cDywNfT-jZgNmTxqcWtGxiYiTQVS7TIA4Tv29rf_6G-z_eJQUPwrhNfKR-gVbhKEjBZdumUwMPNvEjZ55pWKLjSCDRQDSn-tMK-LyfhMmbN9PyvHyw302jvImXNbLSgbGf0HvyO/s320/portlet-web15.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj98ad2_cDywNfT-jZgNmTxqcWtGxiYiTQVS7TIA4Tv29rf_6G-z_eJQUPwrhNfKR-gVbhKEjBZdumUwMPNvEjZ55pWKLjSCDRQDSn-tMK-LyfhMmbN9PyvHyw302jvImXNbLSgbGf0HvyO/s1600/portlet-web15.jpg)

Le damos clic en "Add" para agregar el Portlet, o si gustamos, lo arrastramos y lo soltamos en cualquier parte de la página.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRnsi9fOBC4176XhRkbbxUF-j-Pi2WxiWoSjqpIE-woroMN-GC-y4cpEhtLK8S2LyIDBVNbdcGj6sUu79ur4n5z5painOW6i55WK9Zypwexl3ZO-g5w93s38nUEzSxZfyBoYXn6QYc-TRu/s400/portlet-web17.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRnsi9fOBC4176XhRkbbxUF-j-Pi2WxiWoSjqpIE-woroMN-GC-y4cpEhtLK8S2LyIDBVNbdcGj6sUu79ur4n5z5painOW6i55WK9Zypwexl3ZO-g5w93s38nUEzSxZfyBoYXn6QYc-TRu/s1600/portlet-web17.jpg)

Y lo hacemos funcionar...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZKLWc_d81xR_0BGuMfE9qPmQpKQZ0HCuKVNk8HfdvV-fNJcd86Y8brxdn3gg5O0TdVywxY4CSSDs3xZbjtt0oXG99CXCIyV2iS77CjERlquP-ApWRv-zDL2hiiO_iNrq0it_hcPHCfrUT/s320/portlet-web18.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZKLWc_d81xR_0BGuMfE9qPmQpKQZ0HCuKVNk8HfdvV-fNJcd86Y8brxdn3gg5O0TdVywxY4CSSDs3xZbjtt0oXG99CXCIyV2iS77CjERlquP-ApWRv-zDL2hiiO_iNrq0it_hcPHCfrUT/s1600/portlet-web18.jpg)

**Nota:** Para cambiar la categoría del Portlet, debemos editar el archivo `liferay-display.xml` desde NetBeans.

### Conclusión

Este post me fue lo más accidentando que me he atrevido a hacer. Pudo haber sido más simple o más completo, pero a medida que hago el tutorial, también construyo el proyecto para asegurarme que todo lo que digo sea correcto. Pero me encontré con problemas de versiones, componentes faltantes, y más cosas no esperadas. Quería terminar con el .JSF, pero ya no me dio el  tiempo. Será para otro post. (También tengo que hacer cosas en donde trabajo.) En fin. Este post me motivó hacerlo ya que implementé el Liferay para el Site de la oficina donde trabajo. Aún no está del todo terminado, hicimos un par de portlets que funcionan bien, solo nos falta hacer un par más, implementar un nuevo Theme con los colores de la oficina y listo. Así que cada cosa que encuentro, lo voy colocando en mi blog.

Un tip importante que aprendí cuando hemos desarrollado los portlets de manera rápida (ya que mi computador es bastante lento para desplegar un .war en liferay),  es:

- Cambiar en las propiedades del proyecto a para que utilice el GlassFish v3 en lugar del Liferay
- Desarrollar, probar, ejecutar, depurar como si se tratase de una aplicación web. Considerando los elementos de portlets, adaptar la aplicación para que funcione sin él. (Recordar que el método processAction() es similar a un Servlet, así que convendría utilizar un servlet por mientras.
- Luego, cuando esté listo, acomodar los tags de la aplicación para pasar a liferay.
- Cambiar en las propiedades del proyecto para que utilice Liferay en lugar de GlassFish v3.
- Construir el .war
- Desplegar el .war al Liferay.
 Se pueden agregar más servlets, componentes JQuery, Ajax, Dojo, etc.

Espero que te haya hecho de utilidad.

El proyecto que utilicé en este post está aquí: [http://java.net/downloads/apuntes/samples/web/SimplePortlet.tar.gz](http://java.net/downloads/apuntes/samples/web/SimplePortlet.tar.gz)
