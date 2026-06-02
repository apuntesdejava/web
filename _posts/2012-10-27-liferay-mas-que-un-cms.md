---
layout: post
title: "Liferay, más que un CMS"
date: 2012-10-28T00:51:00Z
last_modified_at: 2012-10-28T00:51:21.586Z
author: "Diego Silva Límaco"
permalink: /2012/10/liferay-mas-que-un-cms.html
canonical_url: https://www.apuntesdejava.com/2012/10/liferay-mas-que-un-cms.html
tags:
  - "liferay"
  - "articulos"
  - "comentarios"
---

[![](/assets/blogger/heading.png)](/assets/blogger/heading.png)

Estamos desarrollando una Intranet 2.0 en una reconocida empresa, utilizando para ello Liferay. Y es que usar Liferay como un Sistema de Gestión de Contenido, no sería lo más justo para tal plataforma. Se puede hacer muchas cosas con este aplicativo.

Los [Transportes Metropolitanos de Barcelona implementa Liferay](http://www.cms-spain.com/articulo/12733/wcm-web-content-management/transportes/transportes-metropolitanos-de-barcelona-implementa-liferay-portal-para-realizar-su-nuevo-sitio-web-) para su sitio web, la [Caja Rural también implementa su portal Interno para los empleados](http://www.cms-spain.com/articulo/12836/rrhh/banca-y-finanzas/caja-rural-monta-su-portal-interno-para-empleados-con-liferay), de la misma manera la [Consejería de Sanidad de Valencia](http://www.cms-spain.com/articulo/12863/ecm-enterprise-content-management/hospitales-y-clinicas/la-consejeria-de-sanidad-de-valencia-monta-sus-portales-internos-y-publicos-con-liferay) utiliza Liferay para su Intranet y Extranet. Cisco Quad era una implementación de Liferay para su red social (digo "era" porque ahora se llama [Webex Social](http://www.pcmag.com/article2/0,2817,2405992,00.asp), con otro enfoque) y algunos [logos más](http://www.liferay.com/products/liferay-portal/stories/logos), son buenos ejemplos en donde se pueden apreciar la versatilidad de este producto.

Liferay tiene cuatro niveles de personalización, desde el más básico, hasta el más complejo.

- Orientados al Look & Feel: (Themes y Layouts)

- Desarrollo de portlets personalizados

- Cambios de comportamientos (Hooks y Ext)

- Código fuente

Algunas características de Liferay que es necesario conocer para sacarle el mejor partido a la plataforma:

- El portlet de Chat, que viene como ejemplo en la descarga, incluye el código fuente, y - cambiando un parámetro de su archivo de propiedades - se puede conectar a un servidor [XMPP](http://xmpp.org/xmpp-software/servers/).

- Tiene interfaz de WebService SOAP y RESTful. Recomiendo el RESTful, son más ligeros y  más fácil de usar.

- Si no te gusta el framework Ajax que utiliza (Alloy UI), puedes agregarle el JQuery o el que quieras, sin modificar el código fuente.

- Puedes cambiar el comportamiento de las páginas, como por ejemplo, cambiar el visor de video, utilizando Hooks, sin necesidad de cambiar el código fuente.

- Puedes depurar el código fuente de Liferay desde NetBeans (utilizando el Attach Debug)

- Puedes desarrollar portlets, hooks, ext, themes y depurarlos desde Eclipse usando el plugin [Liferay IDE](http://www.liferay.com/downloads/liferay-projects/liferay-ide) (disponible desde el Eclipse Marketplace).

- Cuenta con un workflow para todas las publicaciones (blog, wiki, biblioteca de documentos, etc) o de los portlets que desarrolles. Puede ser el kaleo, el jBPM, entre otros.

- La configuración y puesta en producción es tan simple (copiar unos jars y desplegar el .war) que fácilmente se puede instalar en la nube. Ejemplo: en [Jelastic](http://blog.jelastic.com/2011/10/31/how-to-deploy-liferay-portal-to-jelastic-cloud/).

Un libro que recomiendo mucho es el "[Liferay User Interface Development](http://www.packtpub.com/liferay-user-interface-development/book)", además es bueno consultar en los foros, blogs y wiki de Liferay, y las preguntas respondidas en [Stack Overflow](http://stackoverflow.com/search?q=liferay).

Espero que consideren esta plataforma para el desarrollo de sus siguientes aplicaciones institucionales y corporativas. Ya no tienen que reinventar la pólvora en el aspecto de la seguridad y autenticación, look & feel, webservices, etc.... y sobretodo, es Java.
