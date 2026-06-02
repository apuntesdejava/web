---
layout: post
title: "Iniciándose en RESTful Web Services"
date: 2008-07-17T20:15:00Z
last_modified_at: 2009-04-25T21:55:03.400Z
author: "Diego Silva"
permalink: /2008/07/iniciandose-en-restful-web-services.html
canonical_url: https://www.apuntesdejava.com/2008/07/iniciandose-en-restful-web-services.html
tags:
  - "netbeans 6.1"
  - "webservices"
  - "netbeans"
  - "restful"
---

(Traducción no oficial de [Getting Started with RESTful Web Services](http://www.netbeans.org/kb/61/websvc/rest.html))

[REpresentational State Transfer (REST)](http://es.wikipedia.org/wiki/Representational_State_Transfer) es un estilo de arquitectura para sistemas [hipermedia](http://es.wikipedia.org/wiki/Hipermedia) distribuidos, tales como la World Wide Web. El centro de la arquitectura RESTful es el contecpto de los recursos identificados por los identificadores de recursos universal (universal resource identifiers URIs). Estos recursos pueden ser manipulados usando un interfaz estándar, tales como el HTTP, y la información es intercambiada usando representaciones de estos recursos. En este tutorial, primero aprenderemos un poco acerca de REST y luego veremos como NetBeans 6.1  maneja este estilo de arquitectura.

## Introducción

Los servicios web RESTful son servicios construidos usando el estilo de arquitectura RESTful. El construir servicios web usando RESTful hace que se aproxime a una alternativa emergencia y popular usando tecnologías basadas en SOAP para desplegar servicios en internet, debido a que es liviando y tiene la capacidad de transmitir datos directamente desde HTTP.

El IDE permite el desarrollo rápido de servicios RESTfulsando la especificación [JSR311 - Java API for RESTful Web Services (JAX-RS)](http://jcp.org/en/jsr/detail?id=311) y [Jersey](https://jersey.dev.java.net/), la imeplementación del JAX-RS.

Además de construir servicios web RESTful, el IDE también permite probar, construir aplicaciones clientes que accedan a servicios web RESTful, y generando código para invocar a los servicios web (tanto RESTful como basado en SOAP).

## Generando Clases de Entidad desde una Base de datos

El objetivo de este ejercicio es crear un proyecto y generar clases entidad desde una base de datos.

- Seleccione File > New Project. Debajo de Categories, seleccione Web. Debajo de Projects, seleccione Web Application y clic en Next.

- En Project name, escriba CustomerDB.

- Seleccione GlassFish como servidor. Clic en Finish.

- Abra la ficha Services (Ctrl+5). Debajo de Databases, clic derecho en Java DB e iniciarlo.

- Volvemos al panel de proyectos (Ctrl+1). Haga clic derecho en el nodo del proyecto y seleccione New > Entity Classes from Database. Otra manera de hacer es seleccionar la categoría Persistence en el asistente de Nuevo Archivo (Ctrl+N)

- En el panel de las tablas de la base de datos, seleccione como fuente de datos jdbc/sample.

- Debajo de la sección de Tablas disponibles (Available Tables) seleccione CUSTOMER y haga clic en el botón "Add". La tabla DISCOUNT_TABLE también se agregará ya que está relacionada con la tabla CUSTOMER.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgH80Zmw7k0WioXyuQnU9VeajeNmZfZW0MOTEpDSnUZVkASDPbaUJD7kipW0V6LTL0lLwi6X1853kENSaR9QLAQNNEqb2Crpk5c6FI4ZTa8ZHf1O69kiYz5L2Am32bnQmlgxM2PEqF-HjON/s320/restful01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgH80Zmw7k0WioXyuQnU9VeajeNmZfZW0MOTEpDSnUZVkASDPbaUJD7kipW0V6LTL0lLwi6X1853kENSaR9QLAQNNEqb2Crpk5c6FI4ZTa8ZHf1O69kiYz5L2Am32bnQmlgxM2PEqF-HjON/s1600-h/restful01.jpg)Clic en Next.

- En la entrada del package, escriba customerdb. Como se ve acontinuación:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCOKpLNbN6JNorNAyPtcWF0ov37LUuu7WwTGpVFDW9z_fg34ZI_yy42afM-DLFviiS3puU2pQLc93rJmLbU5p2DQB5UMYu-vGssuwyY4y1sXuCxSdgvvV-KKEdPIUb_Wkacoox5t3wwmHQ/s320/restful02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCOKpLNbN6JNorNAyPtcWF0ov37LUuu7WwTGpVFDW9z_fg34ZI_yy42afM-DLFviiS3puU2pQLc93rJmLbU5p2DQB5UMYu-vGssuwyY4y1sXuCxSdgvvV-KKEdPIUb_Wkacoox5t3wwmHQ/s1600-h/restful02.jpg)

- Clic en Create Persistence Unit.  Llene los datos como se ve en el siguiente diálogo:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjz-3hUyFNQH1mzf1l3Wu1VNwO7Eux2Rto4gVcDoa4d_TqX-vwcZuIXTiRWIlVJ_md-SJ7eqiKYYKUfUjwuqlq-ZlOaKcOCNDk34xhY-yXaP58cSqpbN6Z37FVIKPM5Gld9djAcF4aVjNfs/s320/restful03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjz-3hUyFNQH1mzf1l3Wu1VNwO7Eux2Rto4gVcDoa4d_TqX-vwcZuIXTiRWIlVJ_md-SJ7eqiKYYKUfUjwuqlq-ZlOaKcOCNDk34xhY-yXaP58cSqpbN6Z37FVIKPM5Gld9djAcF4aVjNfs/s1600-h/restful03.jpg)Clic en Create y luego en Finish.

- Revise la ventana de proyectos.  Debería lucir así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghAA8bNWfSswHLogWLt2epW2Uf0ALJ7F8Qk1H03M7vZpehH6vXa-YA4ItBf_13Hnfvt9Y-4tcrgT_cLlIQIQkb0IcmJYMdpSYKL5R25UDSngAfZaujOq6hkq_I8wzhJVYW5rONVCqg3mus/s320/restful04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghAA8bNWfSswHLogWLt2epW2Uf0ALJ7F8Qk1H03M7vZpehH6vXa-YA4ItBf_13Hnfvt9Y-4tcrgT_cLlIQIQkb0IcmJYMdpSYKL5R25UDSngAfZaujOq6hkq_I8wzhJVYW5rONVCqg3mus/s1600-h/restful04.jpg)

## Generando Servicio Web RESTful desde las clases entidad

La meta de este ejercicio es generar servicios web RESTful desde las clases entidad que se crearon en la sección anterior.

- Presione Ctrl+N para crear un nuevo archivo. Seleccione la categoría Web Services y e

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5fN_yCjkfZ1RnFVztgp-RTKpgv3sZ97CWO-VsVNzDILuj7Hpie396qXVT3-QI6-yQ-1rI0siSSwXjKkBM454bQ3LnWNpwBLrzBD1TZpJ8JUoqwxfmlyNXLQATt0usVbhEcti24k3MYNWJ/s320/restful05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5fN_yCjkfZ1RnFVztgp-RTKpgv3sZ97CWO-VsVNzDILuj7Hpie396qXVT3-QI6-yQ-1rI0siSSwXjKkBM454bQ3LnWNpwBLrzBD1TZpJ8JUoqwxfmlyNXLQATt0usVbhEcti24k3MYNWJ/s1600-h/restful05.jpg)Clic en Next.

- En la ventana de selección de Clases Entidad, haga clic en "Add All>>". Clic en el botón Next.

- En el campo *Resource package* escriba customerdb.service, y en el campo *Converter Package*, escriba customerdb.converter.

Acepte todos los valores por defecto  como se muestran a continuación: [![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgceKiQIaYKb-HC9x2XFH8EngdMSSQxdEkYpTuqpviWAthN3NdiZiUsx_FeiFHgULXoc7YXUdhpo1g0A0aMoc9VXxxIO9FDnb3xe2wvk1bcg1MvNsD7TCLGt3-UeohzucQ6v2dQhQJHi4VR/s320/restful06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgceKiQIaYKb-HC9x2XFH8EngdMSSQxdEkYpTuqpviWAthN3NdiZiUsx_FeiFHgULXoc7YXUdhpo1g0A0aMoc9VXxxIO9FDnb3xe2wvk1bcg1MvNsD7TCLGt3-UeohzucQ6v2dQhQJHi4VR/s1600-h/restful06.jpg)

Aquí se puede ver lo que el IDE generará por nosotros. NetBeans usa el patrón del elemento del contenedor para generar las clases del recurso. Por ejemplo, para la clase entidad *Customer*, NetBeans genera un recurso de contenedor llamado *CustomersResource* y un recurso llamado *CustomerResource*. Además,por cada clase recurso, NetBeans generar una clase convertidor que se usará para generar la representación del recurso desde las instancias de entidad correspondientes, tales como *CustomerConverter* y *CustomerConverter*.

Es más, hay información adicional de la clase convertidora llamada convertidor de referencia, tal como *CustomerRefConverter*, que representará relaciones.

Clic en *Finish*.

- Ahora la ventana del proyecto lucirá algo así:[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQ2_uerFnUCfRKVdnVNH8mRYKjLj-i7VFS-6sSLWe1L_fyzYohYqa8QdeA0lzi4J5d3CyTatprGdvySUl1lfaj2Pk7T2SYg_6EWEpc-xlFybRnr7H4LPY3d4izuxLDpp1gWkGzwcOoWVuG/s320/restful07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQ2_uerFnUCfRKVdnVNH8mRYKjLj-i7VFS-6sSLWe1L_fyzYohYqa8QdeA0lzi4J5d3CyTatprGdvySUl1lfaj2Pk7T2SYg_6EWEpc-xlFybRnr7H4LPY3d4izuxLDpp1gWkGzwcOoWVuG/s1600-h/restful07.jpg)

El nodo *RESTful Web Services* muestra todos los servicios web RESTful de nuestro proyecto. El valor entre los corchetes, como [/customers/], es el valor para el URI de la plantilla. Podemos enrtar al código fuente haciendo doble clic en el nodo. Esta vista también muestra todos los métodos HTTTP y los métodos de ubicación de los subrecursos. También podemos hacer doble clic en los nodos para ver los métodos.

Ahora que ya se generaron las clases entidad y los servicios web RESTful, probemos la aplicación.

## Probando los servicios web RESTful

La meta de esta ejercicio es probar la aplicación que acabamos de crear.

- Clic derecho en el nodo del proyecto seleccionar *Test RESTful Web Services*. El servidor se iniciará y la aplicación será desplegada. Cuando haya terminado, el navegador web de nuestro sistema mostrará nuestra aplicación, con un enlace por cada servicio web.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhvnTAKYr89PbVm2gvYmZ2y04AYpiZyvlBPA4OIeC4pWHN0BniSukHBRphouywf-9wfj4COa6ASG2RtbbbGAAfueEyUEqzXpWGCj7YrxutiCX32StnPGd_yj9v8vhWM_mD1xnidnTqmbCKm/s320-r/restful21.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhyn1xryfc8679E5rR6VNXccBrXFXhDLGAQoj6mJ9ce3wcT4Cd7yS3IfSaF2Vyz8OU2rWh2CLe4W8bTBuYpFK1vplj2cM_V4gfIVPhZnrsxQtqkEpvg5zVmJ1wbyr_QzueOdrr5TULJTCpj/s1600-h/restful21.jpg)

En el lado izquierdo están los recursos. Aquí son llamados customers y discountCodes.

- Primero seleccionemos el recurso *customers*. Luego, de la lista *Choose method to test* seleccionemos "GET(application/json)" o "GET(application/xml)". Y hagamos clic en el botón "Test".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi8ITxGbAzBUv90102DIe3r0uPXTtLoyZm2Gbub3eDTEQt6WJurMvB0KDu_kGwypV3BxRz57V0fv6kKjaIUCQ7ZwSE-Wu41gUm-mtHDF-TbUWNG57vX9pc8d8aSmjVYCtnLB1c0pBrtg7E-/s320-r/restful22.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjraiaxj6I7lJjmDU94Hizgg3mpb3g7Fa0ZkaBhTX4eLVtkgTwTIKlNzU9SXOOT9Q1rg5ftx8S67Gj2WysENhMtNwqB81XyjGBX8DOM-Lo_gQFJszmleSYYOuJQ_Yv991dU_8S13boM5CNI/s1600-h/restful22.jpg)

Notemos que el resultado se muestra en la parte inferior de esta página estática. (Revisa el URL del navegador y verás que no es http://.. sino file:///)

En este resultado se muestran 4 fichas. La vista tabular (Tabular View) es una vista plana que muestra todos los URI en el documento resultante. Podemos hacerle clic a un url para ver el contenido.

La vista cruda (Raw view) muestra los datos que se obtuvieron del servicio web. Si hemos seleccionado application/xml se mostrarán en formato xml, y si hubieramos seleccionado application/json nos mostrará en formato JSON. La ficha Headers muestra información de la cabecera de la respuesta del servidor, y en la ficha Http Monitor nos muestra la petición HTTP que se envió así como la respuesta recibida.

- Salir del navegador y regresar al IDE.

## Agregando GoogleMap

El objetivo de este ejercicio es agregar una funcionalidad de Google Map a nuestro servicio web RESTful.

- Abrir la clase CustomerResource

- Agregar el siguiente código:

```java
<code>    @GET<br />    @ProduceMime(value="text/html")<br />    public String getGoogleMap(){<br />        <br />        return "";<br />    }<br /></code>
```

- Obtengamos una clave para usar Google Map desde aquí [http://www.google.com/apis/maps/signup.html](http://www.google.com/apis/maps/signup.html) El URL que escribiremos para que genere nuestra clave será http://localhost:8080

- En nuestro IDE, presionemos Ctrl+5 para ver el panel de servicios. Abramos el nodo *Web Services*, luego *Google*, después *Map Service*.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiL-77qPptndzseP_uUP6Ad71a13HZlmQ7ZZUCjSp2A_KHNf2GaDzvLWOXSgE5P-r2TxQKxk6_KjonVh9AkwW61FbF4AB4btIh1lSSKmsqrR9YobAnGZcspoP5pDjNUmh-Lj_kXXb6n1Tgs/s320-r/restful23.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDhhWYlMrPaHOPOD_NaxmvDjfDGzD6oZm70INAeNo18YMw0fALvTcJm7WINe1jPojDXEs_E7eGKOrIRJeNzdFHujyuQWU5iTcO6FGdXgrePb8YYNTpvTDPFAVZJDBVXtzE3Ujx2zUSU-_E/s1600-h/restful23.jpg)

- Arrastremos el nodo* getGoogleMap* y soltémoslo en el método que hemos creado en el paso 2. Justo antes del return "". El IDE nos mostrará una ventana con datos con ejemplo para ser utilizado en nuestra aplicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgAQI0D266tHp2vexcPYgHoyjm1MixsD6Ubdf1MX08rZru9fBecYRjuypgbiKsbZFh7mghHxhb3VVhfHBpTLZVUr8uFEMsLTK5eRBKESGIP45o-xl8G7uIDT3hKoy9p2BnfEIfBcvxC9R2y/s320-r/restful24.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjBGqK2es7ehckM4RiSB9THEM28bymfO7tetd64P4Hzlx_EH1XejVyth_49WpcNUB9r_Ghnc5_s2_YAyIjKjWveiC8C1HoG1VX11ppPU_5yvwLxHpARxWMzMUzDHEIkIOPWxS36frSMj78A/s1600-h/restful24.jpg)

Le damos clic en "OK" y el IDE agregará el siguiente código automáticamente.

```java
<code>    @GET<br />    @ProduceMime(value = "text/html")<br />    public String getGoogleMap() {<br />        try {<br /><br />            String address = "16 Network Circle, Menlo Park";<br />            java.lang.Integer zoom = 15;<br />            String iframe = "false";<br /><br />            RestResponse result = GoogleMapService.getGoogleMap(address, zoom, iframe);<br />        //TODO - Uncomment the print Statement below to print result.<br />        //System.out.println("The SaasService returned: "+result.getDataAsString());<br />        } catch (Exception ex) {<br />            ex.printStackTrace();<br />        }<br /><br />        return "";<br />    }<br /><br /></code>
```

El IDE también ha creado los paquetes *org.netbeans.saas* y *org.netbeans.saas.google* que contienen las siguientes clases y recursos

- RestConnection - Una clase que envuelve a HttpUrlConnection

- RestResponse - Un clase que envuelve las respuestas HTTP

- googlemapservice.properties - Un archivo de propiedades que almacenará la clave para manejar el GoogleMap.

- GoogleMapService - Un servicio que envuelve los métodos que usa RestConnection y llama al servicio GoogleMap.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiigyWvM1TMWCGgGVfw07an3Ay9UTzSG1Q4LOa3hlyA9KjCIHJ1fs5wRdstsdgsrmp2Yk_88FBVvk8EaB2E_tifXj74GDFp70iZjxvf1ZrCxN4pjOL2P7VtJoHZ5EtUwKajCWjNKse0uuBu/s320-r/restful25.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg_78QTfan31l08YzU4htYfuJEP3Muoaj9CwK8rUj5u5BsJeQsWRj9H02ouCDBdiSVcJXh6kgyWhtZbL2r61l83U0UfimrjmLcIxHnb1T4nHbT0vxtJTYRsibZPnSeFOv6ugf2ZdouhSZn6/s1600-h/restful25.jpg)

- En el bloque *try* de getGoogleMap() reemplacemos las líneas comentadas con lo siguiente:

```java
<code>return result.getDataAsString();</code>
```

Ahora nuestro método lucirá así:

```java
<code>    @GET<br />    @ProduceMime(value = "text/html")<br />    public String getGoogleMap() {<br />        try {<br /><br />            String address = "16 Network Circle, Menlo Park";<br />            java.lang.Integer zoom = 15;<br />            String iframe = "false";<br /><br />            RestResponse result = GoogleMapService.getGoogleMap(address, zoom, iframe);<br /><br />           <b> return result.getDataAsString();<br /></b>        } catch (Exception ex) {<br />            ex.printStackTrace();<br />        }<br /><br />        return "";<br />    }<br /><br /></code>
```

- Abrimos el archivo *googlemapservice.properties* y pegamos la clave del API que hemos generado en el paso 3.

- Hacemos clic derecho en el nodo del proyecto *CustomerDB* y seleccionamos *Test RESTful Web Services*. El IDE desplegará nuevamente la aplicación y la abrirá en el navegador web.

- Hacemos clic en el enlace *customers* del lado izquierdo. Luego hacemos clic en el botón *"Test"*. Se mostrará la tabla de los clientes.

- Desde esta tabla de resultados, hagamos clic justo donde dice /*customers/1/*. Se abrirá una página para probar el resultado de este cliente. Seleccionamos de la lista desplegable MIME la opción  text/html. Y le damos clic en *Test*. El GoogleMap se mostrará en la calle que le indicamos.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEig229e0mgQ188e0Nl-4RwaAU40hNhoUfS_v4ZhLsjsSzIU6Ooz664RTGXatv7LfVAS7wVgPidqVebPFyoKtW46bXsB_u1JKD8qsJyX8zAmgkWK8a4zEWLj-BhyphenhyphenafZhefih0bTLs-KYzQIZ/s320-r/restful26.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGzuMRgdUMeNTZMKs_Qf0HU4I85itRusphQNB4eX_vSN8QfnB3GjyaMJabMTZEWa-2xCOz4vX9rVBEWN79OzzqiHlc-rAhhxPiyV7sDIpkRyZvX7cIsJt3TqZVG4AIJUXZxvVUp578D7Rm/s1600-h/restful26.jpg)

Pudimos haber cambiado la dirección en el método getGoogleMap() para que apuntase a la dirección que querramos. Por ejemplo, Lima.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4kjaewUn9s5cZR_fdpBNQUdnLE-WWl3HfGwIts-QnZy8mJTuHfnYLQ7r_fK5KHzZ7Tn08RHsSyN8Rvt4sTGfVI0O3_wgMwXArJHQYiEdOZA7u1lEArcFJ0lI-nW8X_9f0-c-tZEzie19m/s320-r/restful27.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj28wCm3Rm6HjjoP137PCYpzxuLg7Pu2GyJdbhIa22xvY5CBFQvvIY9T-8p6ys17DiYApKBIoZMdNBpO24DMMOEKWHOLS73ZjikRnLctxTyg3i104ggCoA99bCcpo-kC5bkloWbbFvVHxch/s1600-h/restful27.jpg)

- La dirección que hemos puesto por hardcode se mostrará en todos los registros de la base de datos. Lo que haremos ahora será modificar el método getGoogleMap() para que muestre el mapa de cada registro del cliente según corresponda.

```java
<code>    @GET<br />    @ProduceMime(value = "text/html")<br />    public String getGoogleMap() {<br />        try {<br />            Customer c = getEntity();<br />            String address = c.getAddressline1() + " " + c.getAddressline2() + " " +<br />                    c.getCity() + " " + c.getState() + " " + c.getZip();<br /><br />            java.lang.Integer zoom = 15;<br />            String iframe = "false";<br /><br />            RestResponse result = GoogleMapService.getGoogleMap(address, zoom, iframe);<br /><br />            return result.getDataAsString();<br />        } catch (Exception ex) {<br />            ex.printStackTrace();<br />        }finally{<br />            PersistenceService.getInstance().close();<br />        }<br /><br />        return "";<br />    }<br /><br /></code>
```

- Nuevamente hacemos clic en "Test RESTful" y examinaremos todos los registros de los clientes. Este, por ejemplo, corresponde al cliente con id=149

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCETtl9dAkB6cPzn6PM2bcS2qiRYcOKpG4WQOxEJb09RpcEdnYtHLRkStaaKPXfpW9sXi1p4uNFLnnWQjZIMPKLD7tkWXD24ie8vn-llu53CjWGXTqBxN7niPw8-IQYiXbJsKkdGbdamGp/s320-r/restful28.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFLmGY4INfiXlWA7vgVqa8G_k6_70EcavhrRzHkI9f8y_gaeNnROWRtQQITXKaGm3uFx-mPl-1fYQgXd2d-L33G4_eXbYAsKYbxem9t2FF9zNAvSAsl1TbWP_sXn4Spy2zrDudPY5uUWEM/s1600-h/restful28.jpg)

## Recursos

La aplicación que utilicé para este ejemplo se puede descargar desde aquí [http://diesil-java.googlecode.com/files/customerdbRESTful.tar.gz](http://diesil-java.googlecode.com/files/customerdbRESTful.tar.gz).
