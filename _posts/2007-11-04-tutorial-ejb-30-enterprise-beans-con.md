---
layout: post
title: "Tutorial: EJB 3.0 Enterprise Beans con NetBeans 5.5"
date: 2007-11-04T23:22:00Z
last_modified_at: 2009-04-25T22:07:33.882Z
author: "Diego Silva"
permalink: /2007/11/tutorial-ejb-30-enterprise-beans-con.html
canonical_url: https://www.apuntesdejava.com/2007/11/tutorial-ejb-30-enterprise-beans-con.html
tags:
  - "web"
  - "java ee"
  - "jpa"
  - "netbeans"
  - "tutorial"
  - "ejb"
---

Uno de los puntos fuertes e importantes de programar con Java Enteprise es la centralización del código de negocio usando EJBs.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEga8OUjym7HiLJTfveA9_Md3LY9JrspWjC5ZNXS93LWxxYiO4uRZJXYRDmrd8J-HVCeFm2sSFoA-lbw2_gPQmifsx1_tFCyMnRx1d53nhzmDm-IXnygspVctPcgH2r7s7P8V1ICzJmixV5_/s320/j2ee.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEga8OUjym7HiLJTfveA9_Md3LY9JrspWjC5ZNXS93LWxxYiO4uRZJXYRDmrd8J-HVCeFm2sSFoA-lbw2_gPQmifsx1_tFCyMnRx1d53nhzmDm-IXnygspVctPcgH2r7s7P8V1ICzJmixV5_/s1600-h/j2ee.jpg)De esta manera, cualquier aplicación (ya sea web o desde una aplicación cliente desktop) siempre tendrán la misma lógica.

El problema era que hasta antes de la versión 3.0 de EJB la programación era realmente pesada. Aprender lo que eran los beans de sesión (con estado y sin estado), crear interfaces y usar clases como   javax.ejb.SessionBean, codificando los archivos de despliegue (y que eran diferentes entre los diferentes contenedores como JBoss, Jonas, etc) y no sé que tanto más... era un lío. Personalmente no me apetecía aprenderlo... ni usando los IDE más sofisticados como NetBeans, JBuilder, JDevelopment... nada.. me quedaría programando en web y listo.

Pero no pude huir fácilmente... aún la necesidad de utilizar un solo código de negocio para varias aplicaciones me rondaba.

Hasta que salió el Java EE 5.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgizJviEDzmo_WsuMNWkiAwhwNyEWzh3fGofeItoIfgaHcRoXMnikc1IM6UTZCemouMVrdk68PEx8hJzjMImkQJ3mb_wC-mLbhtMO22k6MgNYAX8OXM5SWbeVZbX9E1ZWWxG2zVsCypLnYh/s320/jee5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgizJviEDzmo_WsuMNWkiAwhwNyEWzh3fGofeItoIfgaHcRoXMnikc1IM6UTZCemouMVrdk68PEx8hJzjMImkQJ3mb_wC-mLbhtMO22k6MgNYAX8OXM5SWbeVZbX9E1ZWWxG2zVsCypLnYh/s1600-h/jee5.jpg)

Tuve mis dudas, pensé que sería lo mismo que antes pero más pesado. Pero no. Ahora está todo más simplificado, porque utiliza muchas características de Java SE 5.0. Una de ellas, la de usar anotaciones para simplificar código que se utilizaba en una archivo de despliegue.

Leí el tutorial ["EJB 3.0 Enterprise Beans"](http://www.netbeans.org/kb/55/ejb30.html) de [netbeans.org](http://netbeans.org/). y es lo que me ha motivado el traducirlo en este post.

Necesitamos para ello

-

(Obviamente) NetBeans 5.5 ó  5.5.1 instalado (a la publicación de este post, aún no ha salido oficialmente la versión 6, así que usaré lo que está en versión estable)

-

NetBeans Enterprise Pack. El cual  se puede obtener desde aquí:  [http://www.netbeans.org/products/enterprise/](http://www.netbeans.org/products/enterprise/)

Comencemos ahora

## Creando un proyecto de aplicación empresarial

“*El objetivo de este ejercicio es crear un proyecto de aplicación empresarial llamada NewsApp el cual contendrá un módulo EJB y un módulo web. La aplicación NewsApp usa un bean message-driven para recibir y procesar mensajes enviados por un servlet a la cola. La aplicación usa servlets para enviar mensajes al bean message-driven y para mostrar mensajes.”*

### Creando una aplicación empresarial

-

Seleccione File > New Project del menú principal. O  presione Ctrl + Mayus + N.

-

Seleccione Enterprise Application desde la categorìa  Enterprise tal como se muestra en la siguiente  ventana.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh36OD5QV2k0gnBpckCJIrq6C895JiCANBoWfo5NMyZWcCkI0nxMGLlIogriwZuND_Px4uo0XlCWOF5XMrlS5bxLBJa8qECWwa8MY0FaSAtkhXOpdISm2jFAC7dnVRD-QzanL1ifeEKedAW/s320/Pantallazo-New+Project.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh36OD5QV2k0gnBpckCJIrq6C895JiCANBoWfo5NMyZWcCkI0nxMGLlIogriwZuND_Px4uo0XlCWOF5XMrlS5bxLBJa8qECWwa8MY0FaSAtkhXOpdISm2jFAC7dnVRD-QzanL1ifeEKedAW/s1600-h/Pantallazo-New+Project.png)

Haga clic en Next.

-

Escriba como nombre del proyecto NewsApp y establezca como  servidor a Sun Java System Application Server.

-

Establezxca la versión de J2EE a Java EE 5, y  seleccione Create EJB Module y Create Web Application Module, si no  está seleccionado.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFJk34l6uVeaWWnzFjP1Vs3F23FHLxhIQaUfcjTMAgVVVVn0SKPV5WQlFKg2m-pI2fb8T3yMq-jsk3hyphenhyphenTcFLMtpjECIHJcEWqqDfvOjZDDpvr_MfnBI2O3zhjgdltjkUvora7dpXhTj4lK/s320/Pantallazo-New+Enterprise+Application.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFJk34l6uVeaWWnzFjP1Vs3F23FHLxhIQaUfcjTMAgVVVVn0SKPV5WQlFKg2m-pI2fb8T3yMq-jsk3hyphenhyphenTcFLMtpjECIHJcEWqqDfvOjZDDpvr_MfnBI2O3zhjgdltjkUvora7dpXhTj4lK/s1600-h/Pantallazo-New+Enterprise+Application.png)

-

Haga clic en Finish.

### Resumen

“*En este ejercicio hemos creado una aplicación empresarial Java EE 5 que contiene un módulo EJB y un módulo web.”*

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhwAGAs6p0FHPcnakRvnM5QE5c1pf0Ebl0lJzU528qOVny_TSH8MKIdHU_Se_2z7FziHe9IWUyPXNAfuhGw_1Xt3dnOHYJ2_rGRm6pUoa69ZlnzToiDxGN8kzYSeBr01cob7jw_uqGiItt4/s320/Pantallazo-NetBeans+IDE+5.5.1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhwAGAs6p0FHPcnakRvnM5QE5c1pf0Ebl0lJzU528qOVny_TSH8MKIdHU_Se_2z7FziHe9IWUyPXNAfuhGw_1Xt3dnOHYJ2_rGRm6pUoa69ZlnzToiDxGN8kzYSeBr01cob7jw_uqGiItt4/s1600-h/Pantallazo-NetBeans+IDE+5.5.1.png)

## Codificando el módulo EJB

“*En este ejercicio crearemos objetos en el módulo EJB. Crearemos una clase entidad, un bean message-driven y una fachada (façade) de sesión. También crearemos una unidad de persistencia que proporcionará el contenedor con información para administrar nuestras entidades, y los recursos del servicio de mensajería java (JMS) que manejará nuestros beans message-driven”.*

### Creando una Unidad de Persistencia

Primero crearemos una unidad de persistencia que define el origen de datos y el administrador de entidades que se usarán en nuestro proyecto.

-

Hacer clic derecho en el  módulo EJB y seleccionar New > File /  Folder
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhiC_rKC1OR7yU1If8tRSt37Va61NQITz1wuWkYSlhuCibM0uSGRosbUyC5gpFavKycD8UF80CnzZH2xkwUSAi5WCEOqqkceD-dSN-MApwoDz1_dc3EWFBfAZA7o-1Lh5-B_P9UthaCpkzs/s320/NewsApp-ejb-new.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhiC_rKC1OR7yU1If8tRSt37Va61NQITz1wuWkYSlhuCibM0uSGRosbUyC5gpFavKycD8UF80CnzZH2xkwUSAi5WCEOqqkceD-dSN-MApwoDz1_dc3EWFBfAZA7o-1Lh5-B_P9UthaCpkzs/s1600-h/NewsApp-ejb-new.jpg)

- De la categoría Persistence seleccionamos Persistence Unit.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhU8tLMgW9yV5Kc6LgcoVMcgXPdizmrJbwpU7GV72aSwNi1yBREThljVomDI7i67gkB6LlC4nhWfiGEaPWnPLZnw3XMEI7NFYZrD1OeurarWJ2UimbnHH4tJjEdpcjbkom4rt5SNJbBMpS/s320/Pantallazo-New+File.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhU8tLMgW9yV5Kc6LgcoVMcgXPdizmrJbwpU7GV72aSwNi1yBREThljVomDI7i67gkB6LlC4nhWfiGEaPWnPLZnw3XMEI7NFYZrD1OeurarWJ2UimbnHH4tJjEdpcjbkom4rt5SNJbBMpS/s1600-h/Pantallazo-New+File.png)Hacemos clic en "Next".
- Utilizaremos los valores por defecto que se muestra en la ventana.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjC26DIAwGMgiTMZOw4OtiyPBzHziQwc2oAAz5YsCVuYMpaG5CD4l9X8c1xvGJNzEH1eIP0VwQVOQSb_PkS6hPquYk1HuqnQ7B4A_5eFq4vSLO7oO4BVeShifrQk7CrLGtADxp5qEjmsm_T/s320/Pantallazo-New+Persistence+Unit.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjC26DIAwGMgiTMZOw4OtiyPBzHziQwc2oAAz5YsCVuYMpaG5CD4l9X8c1xvGJNzEH1eIP0VwQVOQSb_PkS6hPquYk1HuqnQ7B4A_5eFq4vSLO7oO4BVeShifrQk7CrLGtADxp5qEjmsm_T/s1600-h/Pantallazo-New+Persistence+Unit.png)Además, seleccionamos como Data Source el valor jdbc/sample.
- Hacemos clic en Finish.
El IDE habrá creado el archivo persistence.xml y lo mostrará en el editor de código en vista de diseño.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgoAdfzva6pc9EZafjOPldgYixSLUjzUl1NOejiN2JiOzZiSb2GyFj_hEJQRw0JHs3mLf2vt2WZgnJIDnWHsJELj98bQSa_VAFMgYgz39Lcstkr01rh6efBPsUOSRCq2yE2XEFyO23TbnHt/s320/Pantallazo-NetBeans+IDE+5.5.1+-+NewsApp-ejb.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgoAdfzva6pc9EZafjOPldgYixSLUjzUl1NOejiN2JiOzZiSb2GyFj_hEJQRw0JHs3mLf2vt2WZgnJIDnWHsJELj98bQSa_VAFMgYgz39Lcstkr01rh6efBPsUOSRCq2yE2XEFyO23TbnHt/s1600-h/Pantallazo-NetBeans+IDE+5.5.1+-+NewsApp-ejb.png)
Cerrar el archivo persistence.xml.

### Creando la clase entidad NewsEntity

En este ejercicio crearemos la clase entidad NewsEntity. Para conocer más sobre lo que es una clase entidad, revisar las siguientes entradas:

- [Usando el API de persistencia en aplicaciones de escritorio (Introducción)](/2007/06/usando-el-api-de-persistencia-en.html)
- [API de Persistencia en NetBeans 5.5](/2007/06/api-de-persistencia-en-netbeans-55.html)
Para crear la clase *NewsEntity*, haremos lo siguiente:

- Clic derecho sobre el módulo EJB en la venta de proyectos, y seleccionar *New > File / Folder* para abrir el asistente de *New File*
- De la categoría *Persistence*, seleccione *Entity Class*
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrLTotXvNEr0DV-5FxI8AHv2Kf_ksj3nA2ulXiNopuy51vr9P5SXo3qMghv97ZKabPI9EXQRSIGI-_HSyJY0nLbIA9krybzuGliMhFCoFwOPwRQ-8yu2rfXxtlxp6aUbDCx4pnuG-F5kWB/s320/newentity0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrLTotXvNEr0DV-5FxI8AHv2Kf_ksj3nA2ulXiNopuy51vr9P5SXo3qMghv97ZKabPI9EXQRSIGI-_HSyJY0nLbIA9krybzuGliMhFCoFwOPwRQ-8yu2rfXxtlxp6aUbDCx4pnuG-F5kWB/s1600-h/newentity0.jpg)
Clic en *Next*
- Escriba como nombre de la clase NewsEntity y como paquete *ejb* y dejar el tipo de la clave primaria con el valor *Long*
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhDh-J2pGQiPHwwbig3xqahgHjUGkKC1AINs-LWOUHgTYz2qrwhzc-MKnocsLOK-Qtc-3MHSwRSz_Ri0IRfxb_tCTsbDolNHHfoVYRwhFYp9mIA3WAoO9BkyXeMFOGO-UQvnBg2LVRwwI5/s320/newentity1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhDh-J2pGQiPHwwbig3xqahgHjUGkKC1AINs-LWOUHgTYz2qrwhzc-MKnocsLOK-Qtc-3MHSwRSz_Ri0IRfxb_tCTsbDolNHHfoVYRwhFYp9mIA3WAoO9BkyXeMFOGO-UQvnBg2LVRwwI5/s1600-h/newentity1.jpg)
Clic en Finish
Agregue dos propiedades de tipo String: body y title. Puede usar el nodo de "Bean Patterns" de la clase para hacerlo más rápido. Debería quedar así:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgjQdqlm4Fe_Dv98pJDAapkAM6IEe7_IwniY83VhfGbDfFpZdcE6ZJ8uW8_wf9FeCtzD6tkM7ktpPhiEeH1eMDlHfLhEYgpYLAGhtEDT517cICXUGblhq9Ib_TITt8D5trstCfVNQhV5nh/s320/newentity2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgjQdqlm4Fe_Dv98pJDAapkAM6IEe7_IwniY83VhfGbDfFpZdcE6ZJ8uW8_wf9FeCtzD6tkM7ktpPhiEeH1eMDlHfLhEYgpYLAGhtEDT517cICXUGblhq9Ib_TITt8D5trstCfVNQhV5nh/s1600-h/newentity2.jpg)

### Creando el bean Message-Driven NewMessage

Ahora crearemos el bean message-driven NewMessage en nuestró módulo EJB. Usaremos el asistente New Message-Driven para crear el bean y los recursos JMS necesarios.
Para crear el bean message-driven usaremos el asistente del IDE. Para ello haremos lo siguiente:

- Clic derecho en el módulo EJB, seleccionar New > File /Folder.
- De la categoría Enterprise seleccionamos Message-Driven Bean
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiD7OII36FwQ9OTuM2Mn5saOymueyGRk_NjgSvGb68y9dFMHmh6fFXXBLn3l_ShM_tT4lHJ4PTGguR7Y6h4-t6a2HdlIoRw0dCvACSiHpiYicoetXmWWJNo8bb-MkOUfb7cwxb-6usk79Wp/s320/newmdb0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiD7OII36FwQ9OTuM2Mn5saOymueyGRk_NjgSvGb68y9dFMHmh6fFXXBLn3l_ShM_tT4lHJ4PTGguR7Y6h4-t6a2HdlIoRw0dCvACSiHpiYicoetXmWWJNo8bb-MkOUfb7cwxb-6usk79Wp/s1600-h/newmdb0.jpg)Clic en Next
- Escribimos como nombre NewMessage, como paquete ejb,  y como Destination Type el valor Queue seleccionado, tal como se ve en la siguiente imagen:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEid-jQgGGaWWYcQYebv5UqiyET08qYbgv1WsCmpNsRfA9K2iFkWBxsQiaaDT-mCIDsZD-REzpmiKbo_QVmogiw-1vBteh04VzxjspbBdmZ7xENFN-XKbgzTl5dhPVmOINqSt54V6HP1v9-c/s320/newmdb1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEid-jQgGGaWWYcQYebv5UqiyET08qYbgv1WsCmpNsRfA9K2iFkWBxsQiaaDT-mCIDsZD-REzpmiKbo_QVmogiw-1vBteh04VzxjspbBdmZ7xENFN-XKbgzTl5dhPVmOINqSt54V6HP1v9-c/s1600-h/newmdb1.jpg)Clic en Finish
Al finalizar, la clase bean message-driven NewMessage.java ha sido creado, y se abre su código fuente en el editor de código.
Notará que existe la siguiente anotación:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmxMxjWC6G-gbBvWk4W1Ac50dNS1ewNV6DJcIbekuPCw2NpOE66lVQb5x1SnSHysXxe0mqR1_dHTkdBUbfJ1UOP5kWpZjRMH6kUUBHRIEpyUjdIo8gj-Yj7cglqu57XcuBxElilGUyO8n3/s320/jms0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmxMxjWC6G-gbBvWk4W1Ac50dNS1ewNV6DJcIbekuPCw2NpOE66lVQb5x1SnSHysXxe0mqR1_dHTkdBUbfJ1UOP5kWpZjRMH6kUUBHRIEpyUjdIo8gj-Yj7cglqu57XcuBxElilGUyO8n3/s1600-h/jms0.jpg)Esta anotación dice al contenedor que el componente es un bean message-driven (bean manejador de mensajes) y cual es el recurso JMS usado por el bean. Cuando el IDE genera la clase, el nombre del mapeo del recurso (jms/NewMessage) está derivado del nombre de la clase (NewMessage.java). El recurso JMS está mapeado al nombre JNDI del destino desde el cual el bean recibirá los mensajes. El asistente New Message-Driven Bean ha creado el recurso JMS por nosotros. El API EJB 3.0 nos permite buscar objetos en nombres de spacio JNDI desde la clase bean que queramos sin necesidad de configurar descriptores de despliegue que especifican los recursos JMS.

Las especificaciones de EJB 3.0 nos permite usar anotaciones para introducir recursos directamente en las clases. Ahora usaremos anotaciones para introducir el recurso MessageDrivenContext dentro de nuestra clase, y luego insertaremos el recurso PersistenceContext el cual será usado por el API EntityManager que maneja la persistencia de entidades. Agregaremos las anotaciones a la clase desde el editor de código.

- Agregamos las siguientes líneas después de la declaración de la clase.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgvWRKEUeNtX9XI7RUNnIoqzVGVnCDsZY9_Nn3fA73sEvxx6P3vYyx_Fq5jue62mBlp96q3sg9TIUKhkhpoLCPCeFGMl9hj_SyIiJC1C7gAkai2N5RfFromjU9SFsmDt84toA5lvknLIp0z/s320/jms1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgvWRKEUeNtX9XI7RUNnIoqzVGVnCDsZY9_Nn3fA73sEvxx6P3vYyx_Fq5jue62mBlp96q3sg9TIUKhkhpoLCPCeFGMl9hj_SyIiJC1C7gAkai2N5RfFromjU9SFsmDt84toA5lvknLIp0z/s1600-h/jms1.jpg)Recomiendo usar el autollenado del IDE presionando Ctrl + Espacio cuando se escriba la anotación y el tipo MessageDrivenContext.
- En el fondo del código fuente hacemos clic derecho, luego seleccionamos Persistence > Use Entity Manager.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiF6jJHaYOdxCy9uprXE525vksueAomrg-ysxSSkrZTmCAOHiSjpyD5wlJA0Wq8-x6iCGeHWxyxSfum6H4hyna_BzBM5sLoNgOZmM2uo0d7Vy4qLkIS3lHyXObSVsCK01u58gCKpYEba6Fw/s320/jms2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiF6jJHaYOdxCy9uprXE525vksueAomrg-ysxSSkrZTmCAOHiSjpyD5wlJA0Wq8-x6iCGeHWxyxSfum6H4hyna_BzBM5sLoNgOZmM2uo0d7Vy4qLkIS3lHyXObSVsCK01u58gCKpYEba6Fw/s1600-h/jms2.jpg)Esto convertirá el código a lo siguiente:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgAdqakVo7ImSK8vigrjkZDQe2MM2sRsuH6jfvjgQk5xL4s_N8aDuVgGfu1gc5mZAGm8_Xc69BT43-LVVk_GfciTw8Q7waRFW76yzq5llR7N0-Eiwx177GWikCrVIsUe7jmUp4vjKH947k/s320/jms3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgAdqakVo7ImSK8vigrjkZDQe2MM2sRsuH6jfvjgQk5xL4s_N8aDuVgGfu1gc5mZAGm8_Xc69BT43-LVVk_GfciTw8Q7waRFW76yzq5llR7N0-Eiwx177GWikCrVIsUe7jmUp4vjKH947k/s1600-h/jms3.jpg)
- Cambiar el nombre del método persist() a save() y modificar el contenido para que luzca así:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-jJ4XTZK-a3bymq-3tzQxZKbx5OSK_LgrcifefnWUAa5U7eqqiPR2B__Cj8lVg-qSnYjijx8NdZv1bvz5OwJLV4_Ef6c5yLxbUZojY806Y1pDEeyW-g85FfX5u7L6_EB2sM_5ep1C6aM1/s320/jms4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-jJ4XTZK-a3bymq-3tzQxZKbx5OSK_LgrcifefnWUAa5U7eqqiPR2B__Cj8lVg-qSnYjijx8NdZv1bvz5OwJLV4_Ef6c5yLxbUZojY806Y1pDEeyW-g85FfX5u7L6_EB2sM_5ep1C6aM1/s1600-h/jms4.jpg)
- Modificar el método onMessage() para que luzca así:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNevRGIhMsY-aJ8lmuDzX7NMBt3CrBG3fHaOefkPrHkHlskXVPhH7muWixyTR5uhM4XMyAODBGwzg7qbsKDqEogYStjvDlyL2_o2gCRtPTOTqCmw2v7hIKOoDPBm5wrsJ2zQNjcM7YVe0R/s320/jms5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNevRGIhMsY-aJ8lmuDzX7NMBt3CrBG3fHaOefkPrHkHlskXVPhH7muWixyTR5uhM4XMyAODBGwzg7qbsKDqEogYStjvDlyL2_o2gCRtPTOTqCmw2v7hIKOoDPBm5wrsJ2zQNjcM7YVe0R/s1600-h/jms5.jpg)
- Grabamos el archivo.

### Creando el Bean de Sesión

Ahora crearemos una fachada de sesión para la clase entidad NewsEntity. Para ello, hagamos lo siguiente:

- Clic derecho sobre el módulo EJB y seleccionar New > File / Folder.
- De la categoría Persistence, seleccionar Session Beans for Entity Classes
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi77sAm3ERgt2aR-TUeESq_R72YI2Ve841lb9feoihePUerFolP3r5BOygWpsBPTlLRmvHdcSzQ4v6hrONkk0XZAwijiaZyXxExCSVBIR4RhP_FmmR7oowcTYg4DcoIDEP4uBnh1ihqigj2/s320/fachada0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi77sAm3ERgt2aR-TUeESq_R72YI2Ve841lb9feoihePUerFolP3r5BOygWpsBPTlLRmvHdcSzQ4v6hrONkk0XZAwijiaZyXxExCSVBIR4RhP_FmmR7oowcTYg4DcoIDEP4uBnh1ihqigj2/s1600-h/fachada0.jpg)Clic en Next
- De la lista de clases entidad disponible, seleccionar NewsEntity y haga clic en Add.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrks4Q6I6WePDFmcwGM4rmZbAs84NpXAHGwzB5qNzM1w3HkFdd3XO2EskFx4RZ5M7OtUO1u7ywiDFu2z7bme9j7X1Cvmg_q6gaUyOJMlL9HX9QkOitgbajwid7F4AuT4xCOuWpDLzxR5gU/s320/fachada1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrks4Q6I6WePDFmcwGM4rmZbAs84NpXAHGwzB5qNzM1w3HkFdd3XO2EskFx4RZ5M7OtUO1u7ywiDFu2z7bme9j7X1Cvmg_q6gaUyOJMlL9HX9QkOitgbajwid7F4AuT4xCOuWpDLzxR5gU/s1600-h/fachada1.jpg)
Clic en Next
- Verificar que el paquete sea ejb y que la interfaz local se crearán.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFFUASKTq5JIgByu5BLFH61d-0WomAzHUE36qdvFIPVsFYj_QEpOnfE0YK4kQKrZ0yTJDaZP8X8ZPkXD9SY3_uNhpUQ_Gx-JKaBw_i2hDj8_XmzNYAXydISa_qUjpPdbUT5-FHOM0Ok-kk/s320/fachada2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFFUASKTq5JIgByu5BLFH61d-0WomAzHUE36qdvFIPVsFYj_QEpOnfE0YK4kQKrZ0yTJDaZP8X8ZPkXD9SY3_uNhpUQ_Gx-JKaBw_i2hDj8_XmzNYAXydISa_qUjpPdbUT5-FHOM0Ok-kk/s1600-h/fachada2.jpg)Clic en Finish

 Al finalizar, la clase fachada de sesión NewsEntityFacade.java  se habrá creado y abierto en el editor de código. El IDE también creará la interfaz local NewsEntityFacadeLocal.java

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhxFEPezy9wba-VOiQNTAClWwaVhDqTiCOU0W6zYXem_d_D5zTBlUcy_q71LGdsnrYYQQZrtzBllCNbayq9JPNU2gpHQF8UvfneEJJKMCvhmvzq1ghanrmBC6lDU0ZiDOuwqZE-6akHIr8q/s320/fachada3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhxFEPezy9wba-VOiQNTAClWwaVhDqTiCOU0W6zYXem_d_D5zTBlUcy_q71LGdsnrYYQQZrtzBllCNbayq9JPNU2gpHQF8UvfneEJJKMCvhmvzq1ghanrmBC6lDU0ZiDOuwqZE-6akHIr8q/s1600-h/fachada3.jpg)La tecnología EJB 3.0 simplifica la creación de beans de sesión reduciendo considerablemente el código necesario. Puedes ver que la anotación @Stateless se está usando para declarar la clase como un componente bean de  sesión sin estado y que la clase no necesita una implementación de javax.ejb.SessionBean. El código también está mucho más limpio porque con la tecnología EJB 3.0 los métodos de negocio ya no necesitan de excepciones verificadas (o sea, que utilice alguna sentencia throws)

Puedes ver que el recursos PersistenceContext fue insertada directamente al componente bean de sesión cuando se creó la fachada de sesión.

### Resumen

En este ejercicio, hemos codificado una clase entidad y un bean manejador de mensajes (message-driven) en el módulo EJB. Luego hemos creado una fachada de sesión para la clase entidad. También hemos creado los recursos JMS que serán usados por nuestra aplicación.

## Codificando el módulo Web

Ahora crearemos dos servlets: ListNews y PostMessage. Se encargarán de listar los registros y agregar mensajes respectivamente.

### Creando el servlet ListNews

En este ejercicio crearemos un servlet simple para mostrar nuestros datos. Usaremos anotaciones para llamar a nuestro bean de entidad desde nuestro servlet.

- Clic derecho sobre el módulo web, y seleccionar *New > Servlet*

- Escribimos ListNews para el nombre de la clase, y escribimos web como nombre de paquete.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOBZoVPmvGlLfOMphwchQ0wPitH8UJ_IAacTcUD2kQ7_xgpSaw50gzD4HAqX0tAPQ1CV-D8hlrIvdJ-Ycu_n_zGKBRCridC7G9teKirDNockiOkBLzh_-dl5XNEdZieoD9Ru6QPWr_4q_Z/s320/servlet-ListNews0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOBZoVPmvGlLfOMphwchQ0wPitH8UJ_IAacTcUD2kQ7_xgpSaw50gzD4HAqX0tAPQ1CV-D8hlrIvdJ-Ycu_n_zGKBRCridC7G9teKirDNockiOkBLzh_-dl5XNEdZieoD9Ru6QPWr_4q_Z/s1600-h/servlet-ListNews0.jpg)Clic en Finish

Con esto, la clase ListNews.java se abrirá en el editor de código. En él haremos lo siguiente.

- Clic derecho en el código fuente y seleccionar Enterprise Resources >  Call Enterprise Bean.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjo_uY1q5c_hYiQoM1F-GfTY9sj8krO2_ZojHTGnwttWtfZf69z0mp1DkjqqExI9dHaLQoHwStaVjlvz_Owv0CJrNMAg3HdkMQ25F70jWxqruw02-pKzMu4_fT4MM0KcYmGZCN_1JNrvEL/s320/servlet-ListNews1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjo_uY1q5c_hYiQoM1F-GfTY9sj8krO2_ZojHTGnwttWtfZf69z0mp1DkjqqExI9dHaLQoHwStaVjlvz_Owv0CJrNMAg3HdkMQ25F70jWxqruw02-pKzMu4_fT4MM0KcYmGZCN_1JNrvEL/s1600-h/servlet-ListNews1.jpg)
- En la ventana de diálogo Call Enterprise Bean, seleccionar NewsEntityFacade y hacer clic en OK.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBrm0Zi_f-lUJyG9D9TF086xZXOv_lHF5VHZvR0CIhaiCDZ372eLwxh5xdyWLdLsXpZpp0sm21HVmsQTVQZGD2qPENl_IluGvV57iOnDaLhtJUn3h4g97JKizyCzWH5cW9WYMgVBjYGxEW/s320/servlet-ListNews2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBrm0Zi_f-lUJyG9D9TF086xZXOv_lHF5VHZvR0CIhaiCDZ372eLwxh5xdyWLdLsXpZpp0sm21HVmsQTVQZGD2qPENl_IluGvV57iOnDaLhtJUn3h4g97JKizyCzWH5cW9WYMgVBjYGxEW/s1600-h/servlet-ListNews2.jpg)
Con esto, el recurso bean de entidad será insertado en el servlet usando la anotación @EJB
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhLpLBUn1wW64GKlCYd3OhvmLOICIdOT7WP-otQjOcEpzIwGKIPJU2SQb7XsdU6xf-dVJcfuyIhImrZY81AItPniAO1ZhPUJeC7dmf6Wl2nCYC7MMR1s_U8BGSfp8XlA8r4oJ4RGZo4bbea/s320/servlet-ListNews3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhLpLBUn1wW64GKlCYd3OhvmLOICIdOT7WP-otQjOcEpzIwGKIPJU2SQb7XsdU6xf-dVJcfuyIhImrZY81AItPniAO1ZhPUJeC7dmf6Wl2nCYC7MMR1s_U8BGSfp8XlA8r4oJ4RGZo4bbea/s1600-h/servlet-ListNews3.jpg)
- Modificar el método proccessRequest() con el siguiente contenido:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpEDKL7UaKRzuaLfUVhSkjjxm86a94y1nYXdmxNQDsf_2M_bDzmMNDRMqunLmtsRp0MXXlMCe4y9Qy-Za2jBhlzSWyAlKAV_ftsAhjM5Jpws9vYrQBhg5z4xwpv3D5S4bu5zX1qLhoyYEk/s320/servlet-ListNews4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpEDKL7UaKRzuaLfUVhSkjjxm86a94y1nYXdmxNQDsf_2M_bDzmMNDRMqunLmtsRp0MXXlMCe4y9Qy-Za2jBhlzSWyAlKAV_ftsAhjM5Jpws9vYrQBhg5z4xwpv3D5S4bu5zX1qLhoyYEk/s1600-h/servlet-ListNews4.jpg)No olvidar escribir los nombres  de las clases presionando Ctrl  + Espacio para abrir el autollenado, y de paso hace los imports necesario. También podría presionar Alt + Mayúsculas + F para generar los imports necesarios.
- Guardamos los cambios del archivo.

### Creando el servlet PostMessage

Ahora creamores el servlet *PostMessage* que se encargará de enviar mensajes al contenedor EJB. Usaremos anotaciones para insertar recursos JMS al servlet, especificando el nombre de la variable y el nombre de su mapeo. Luego agregaremos el código para enviar el mensaje JMS y mostraremos un formulario web para agregar un mensaje.

- Clic derecho sobre el proyecto módulo web y seleccionar New > Servlet
- Escribir PostMessage para el nombre de clase, y web para el nombre del paquete.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEisz6uGIXOmlJ_JLwtlClnH9472-NKh5ZMMMYHkJkJf4Z9yDDc0tizDWXNZnK2c-TzYCjoBtbCwhGkKuF9az2W9bxaPYgSEMBjrKdCX-Hb-AO_umFaTKj5MzOtT2vWJ3QptxINIRMgef3Hr/s320/servlet-postMessage0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEisz6uGIXOmlJ_JLwtlClnH9472-NKh5ZMMMYHkJkJf4Z9yDDc0tizDWXNZnK2c-TzYCjoBtbCwhGkKuF9az2W9bxaPYgSEMBjrKdCX-Hb-AO_umFaTKj5MzOtT2vWJ3QptxINIRMgef3Hr/s1600-h/servlet-postMessage0.jpg)Clic en Finish
Al terminar, la clase PostMessage.java se abrirá en el editor de código. Ahora haremos lo siguiente en el editor:

- Escribimos las siguientes anotaciones para insertar los recursos ConnectionFactory y Queue seguido de la declaración de sus respectivas variables.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmCI9hNV1z77d_tnjl1F70f7gkFBcEiIofFKfHFqadt84xdEmEnj3pJ4hIhA9iUvpQW-uQ19KjK_0Dvrm3cdbe6fa2DW0mU6x4sOgv2SLI6HCCiRwzhrFvnOOdU4MdNhgMop20aTCWxwCB/s320/servlet-postMessage1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmCI9hNV1z77d_tnjl1F70f7gkFBcEiIofFKfHFqadt84xdEmEnj3pJ4hIhA9iUvpQW-uQ19KjK_0Dvrm3cdbe6fa2DW0mU6x4sOgv2SLI6HCCiRwzhrFvnOOdU4MdNhgMop20aTCWxwCB/s1600-h/servlet-postMessage1.jpg)
- Ahora agregaremos el siguiente código que permitirá leer los valores de los parámetros enviados por el formulario, creará un objeto NewsEntity  y lo enviará al JMS.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqyoo-mh6DZDzFdwZ38pc1O36w_x2SBpxgjTElO3K9kQVt7K_y7gfB1hnC1eMQN6XEQu_DLEqjCgugw88MCTEDYuv3uYQtOh66zXN9v9WTv4NuHJeiHZHl6VmouaBvixePuafyAN3JfAJX/s320/servlet-postMessage2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqyoo-mh6DZDzFdwZ38pc1O36w_x2SBpxgjTElO3K9kQVt7K_y7gfB1hnC1eMQN6XEQu_DLEqjCgugw88MCTEDYuv3uYQtOh66zXN9v9WTv4NuHJeiHZHl6VmouaBvixePuafyAN3JfAJX/s1600-h/servlet-postMessage2.jpg)
- Ahora editamos la salida que dará el servlet, que será el formulario. Este código debe estar después del código anterior. Ambos hacen el método processRequest()

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5KVXHgE6Mm9FqYeH8Pk1hGt9Nkkq08QFu-EJrWxHMJFjB-Op8EuUKWNRE9BbFbI4c44LBwtg2GTjYa1zshU6CrOoSfINVDKhAp8iv5YgOIeP-rzQG_27NM31rYm3skxeOLHkg8WVN35KO/s320/servlet-postMessage3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5KVXHgE6Mm9FqYeH8Pk1hGt9Nkkq08QFu-EJrWxHMJFjB-Op8EuUKWNRE9BbFbI4c44LBwtg2GTjYa1zshU6CrOoSfINVDKhAp8iv5YgOIeP-rzQG_27NM31rYm3skxeOLHkg8WVN35KO/s1600-h/servlet-postMessage3.jpg)
- Guardamos los cambios.

## Ejecutando el proyecto

Ahora, nos toca apreciar la melodía de la orquesta. Como queremos que se muestre el listado de nuestros datos (que es el servlet /ListNews) haremos lo siguiente.

- Clic derecho sobre el nodo de la aplicación NewsApp y seleccionamos Properties.
- Seleccionamos Run en el panel Categories
- En el campo Relative URL, escribimos /ListNews
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjWjfNENUof5EL2GvFyjgSagZKyesZImNN-tAu4TBhj_OQ7bxHmEFvlc2AOqWpIMPvrsRez-WTpPuH8-UlPs1XV_PSZ9KfI7qFkmhF3s1IKKn4MaBrrkDmwsLr_MjGjYLbpFP-maWlupyUq/s320/runejb0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjWjfNENUof5EL2GvFyjgSagZKyesZImNN-tAu4TBhj_OQ7bxHmEFvlc2AOqWpIMPvrsRez-WTpPuH8-UlPs1XV_PSZ9KfI7qFkmhF3s1IKKn4MaBrrkDmwsLr_MjGjYLbpFP-maWlupyUq/s1600-h/runejb0.jpg)
- Clic en OK
- En  la ventana de proyectos, clic derecho sobre el nodo de la aplicación enterprise NewsApp y seleccionar Run Project.
Con esto, se creará la tabla NEWSENTITY en la base de datos sample de Derby (podemos presionar las teclas Ctrl + 5 y ver dentro del nodo Databases la conexión a la base de datos jdbc:derby://localhost:1527/sample. Abrimos esa conexión - usuario app / password app - y podemos ver la tabla creada, y ver sus registros), se cargará el contenedor EJB, y el contenedor web.

En nuestro navegador se verá el listado de registros (la primera vez no habrá nada, claro)  y al hacer clic en Add new message nos presentará el formulario para registrar un mensaje.

Pruébalo... y piensa dónde más lo puedes utilizar. Tus aplicaciones enterprise serán mucho más fáciles de hacer.

## Investiga

Nunca encontrarás todo lo que necesitas en una web. Solo encontrarás partes que juntándolas harás algo nuevo. Así que, trata de modificar la aplicación para que funcione con JSF.

## Recursos

El proyecto que desarrollé lo puedes descargar de aquí: [http://diesil-java.googlecode.com/files/newsapp.tar.gz](http://diesil-java.googlecode.com/files/newsapp.tar.gz)
