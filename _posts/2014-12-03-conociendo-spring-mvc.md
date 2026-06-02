---
layout: post
title: "Conociendo Spring MVC"
date: 2014-12-04T01:48:00.003Z
last_modified_at: 2014-12-04T01:48:56.834Z
author: "Diego Silva Límaco"
permalink: /2014/12/conociendo-spring-mvc.html
canonical_url: https://www.apuntesdejava.com/2014/12/conociendo-spring-mvc.html
tags:
  - "spring"
  - "tomcat"
  - "web"
  - "java ee"
  - "mvc"
  - "netbeans"
---

[![](/assets/blogger/spring1.png)](/assets/blogger/spring1.png)

En este post veremos de qué se trata el Spring MVC (como para descansar un poco de JSF). No es que sea JSF mejor que MVC ni viceversa. Sino es para conocer ambas propuestas. Además, en el nuevo Java EE 8 aparecerá un framework llamado MVC 1.0 que lucirá mucho al Spring MVC. (Igual que JPA a Hibernate)

### Preparando el proyecto

Para comenzar, desde nuestro IDE favorito (NetBeans) crearemos un proyecto Maven web.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjn1VAIbQrOJpQ7UWHKomS80WzTMYwQPpCgq8DuGqPiHMZyriPDE-NPhzGGoEV8ppxwjRmQGZ06n8DCixgyVHWPfbUd3m7FcThDEqFa3qcjb8_8Z3rtoPp4lqnBRhOAg0q9luzCtiDbo1w/s1600/24-11-2014+08-20-00+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjn1VAIbQrOJpQ7UWHKomS80WzTMYwQPpCgq8DuGqPiHMZyriPDE-NPhzGGoEV8ppxwjRmQGZ06n8DCixgyVHWPfbUd3m7FcThDEqFa3qcjb8_8Z3rtoPp4lqnBRhOAg0q9luzCtiDbo1w/s1600/24-11-2014+08-20-00+p.m..png)

Y le ponemos las propiedades que tendrá nuestro proyecto

<table><tbody>
<tr><td>ProjectName:</td><td>spring-mvc-store</td></tr>
<tr><td>GroupId: </td><td>com.apuntesdejava</td></tr>
<tr><td>Package:</td><td>com.apuntesdejava.spring.mvc.store</td></tr>
</tbody></table>

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMpkJCw_VQxMZSVn63gtFsyV0k93lImVd4d9g3UkZlu20NGv9IQttm8lfQ9T8LTwzKBXzuCsy4-Ae0vzDUOgriamLyXhdWSQUpXTFixIK6T43V5iM8MCdRsnmsMQthJ3aDaoRMun_nziA/s1600/24-11-2014+08-21-04+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMpkJCw_VQxMZSVn63gtFsyV0k93lImVd4d9g3UkZlu20NGv9IQttm8lfQ9T8LTwzKBXzuCsy4-Ae0vzDUOgriamLyXhdWSQUpXTFixIK6T43V5iM8MCdRsnmsMQthJ3aDaoRMun_nziA/s1600/24-11-2014+08-21-04+p.m..png)

Y elegimos dónde queremos que se ejecute el proyecto. Yo voy a intentar ejecutar en Tomcat 8

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiTWNwcykx5rtTsOPaRu31s9kG6-hN47dkzaUfF8oydDL3xEIJldP8gh-It5JehyphenhyphenoMtTAkfSHdraQBtn2_rhdUIZH4MoiAteD5kgd8FDG8P559a_9tGQHisizwPtKkT1U-TM_ecWkaCb0w/s1600/24-11-2014+08-23-42+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiTWNwcykx5rtTsOPaRu31s9kG6-hN47dkzaUfF8oydDL3xEIJldP8gh-It5JehyphenhyphenoMtTAkfSHdraQBtn2_rhdUIZH4MoiAteD5kgd8FDG8P559a_9tGQHisizwPtKkT1U-TM_ecWkaCb0w/s1600/24-11-2014+08-23-42+p.m..png)

Clic en "Finish" y ya estamos listos para comenzar.

Ahora, agregaremos la dependencia del Spring MVC

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhumm974xnElI1c7-_DUp64H2OHFcfbzWnnDgu8crVib-_Dyn3-pYzmURnoEy9Dqw5qD2rb75WithJ2T03t0a_g3-Z4VEpeQhQ-sU3X3ww28uMGnn0EpXLEJQ3DV_HW7W-IOUAyrsXqvrE/s1600/24-11-2014+08-25-40+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhumm974xnElI1c7-_DUp64H2OHFcfbzWnnDgu8crVib-_Dyn3-pYzmURnoEy9Dqw5qD2rb75WithJ2T03t0a_g3-Z4VEpeQhQ-sU3X3ww28uMGnn0EpXLEJQ3DV_HW7W-IOUAyrsXqvrE/s1600/24-11-2014+08-25-40+p.m..png)

Podemos como cadena de búsqueda (campo query) el valor "spring-webmvc" y nos mostrará varios resultados. Seleccionaremos el que dice "org.springframework"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifB49NTYkUOACPNSd0A5tRypprRO3bxtvj4rX5c2w_ySA_LGOPva8TJPMNlcdwQtbYQ_SJgkfTgFkVIHa_T99a2WIaLqz7KqKZQa8bDsmzDcqDOSqhUO8SIs-bN6hWULVle9bv27JbZho/s1600/24-11-2014+08-27-38+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifB49NTYkUOACPNSd0A5tRypprRO3bxtvj4rX5c2w_ySA_LGOPva8TJPMNlcdwQtbYQ_SJgkfTgFkVIHa_T99a2WIaLqz7KqKZQa8bDsmzDcqDOSqhUO8SIs-bN6hWULVle9bv27JbZho/s1600/24-11-2014+08-27-38+p.m..png)

y clic en "Add"

Y, por la maravilla del Maven, se agregarán las bibliotecas faltantes.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg6pE0_c8s4nzK4EsshOZ0fL8lYIdTOs9cmNVHK5jyK6AwWHxr7VChVur2YZnHPxI-yfl-wD0uXuDEqALmEZsLAn8a6pYwM6hTt3yXVwn7ewLdQQmLG46trvYlcv3q1EgyTFboq-43wmRM/s1600/24-11-2014+08-28-41+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg6pE0_c8s4nzK4EsshOZ0fL8lYIdTOs9cmNVHK5jyK6AwWHxr7VChVur2YZnHPxI-yfl-wD0uXuDEqALmEZsLAn8a6pYwM6hTt3yXVwn7ewLdQQmLG46trvYlcv3q1EgyTFboq-43wmRM/s1600/24-11-2014+08-28-41+p.m..png)

### Creando una página de bienvenida

Ahora, crearemos una página de bienvenida. Esta estará asociada a un controlador (porque debemos recordar lo que es el [MVC](http://es.wikipedia.org/wiki/Modelo%E2%80%93vista%E2%80%93controlador)). Así que crearemos primero nuestra vista (jsp) llamada "welcome.jsp" y lo colaremos en una subcarpeta de "Web Pages" llamada "jsp"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiKerVJN6DtZGkLjrQpPFrgashf2fRuc3dkdlwuZU2Qhf-poPKXXPt_jedmRHLIRQq6n-RNwR5EneBjxAdh4IeT1GRhA3Hr9Ulaad5LcLcg-SHHRJ_UVYUBZpKtKa2xrj9l93kItSJV8cw/s1600/27-11-2014+09-51-27+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiKerVJN6DtZGkLjrQpPFrgashf2fRuc3dkdlwuZU2Qhf-poPKXXPt_jedmRHLIRQq6n-RNwR5EneBjxAdh4IeT1GRhA3Hr9Ulaad5LcLcg-SHHRJ_UVYUBZpKtKa2xrj9l93kItSJV8cw/s1600/27-11-2014+09-51-27+p.m..png)

Y el contenido será el siguiente

```java
<%--
    Document   : welcome
    Created on : Nov 24, 2014, 8:31:13 PM
    Author     : dsilva
--%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
<title>Welcome</title>
</head>
<body>
  <section>
    <div class="jumbotron">
      <div class="container">
        <h1> ${greeting} </h1>
        <p> ${tagline} </p>
      </div>
    </div>
  </section>
</body>
</html>
```

Además, crearemos nuestra clase controladora en la carpeta "Source Packages"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNOhRyEKvELDxOl9g6OFY3Z6xerdDijc9C-HpbypiCnUqJ0ryny7a1INsBxcTWIUAuOrb6MZDs9amo6m52nGD4kuussWTKTVFIqzdHyXjzJ8UqYv7oJp263wis2sACVPvc7wXFZM_wzSE/s1600/24-11-2014+08-35-21+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNOhRyEKvELDxOl9g6OFY3Z6xerdDijc9C-HpbypiCnUqJ0ryny7a1INsBxcTWIUAuOrb6MZDs9amo6m52nGD4kuussWTKTVFIqzdHyXjzJ8UqYv7oJp263wis2sACVPvc7wXFZM_wzSE/s1600/24-11-2014+08-35-21+p.m..png)

```java
package com.apuntesdejava.spring.mvc.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author dsilva
 */
@Controller
public class HomeController {
    @RequestMapping("/")
    public String welcome(Model model){
        model.addAttribute("greeting", "Bienvenido a la tienda virtual!");
        model.addAttribute("tagline", "Un aporte de apuntesdejava.com");
        return "welcome";
    }

}
```

### Pegando todas las piezas con la clase DispatcherServlet

Hasta aquí ya tenemos las partes principales de la aplicación: la vista y la clase controladora. Pero aún la aplicación no funciona. Nos falta pegarlo todo con un Servlet que se encargará de recibir las peticiones del usuario y que lo distribuirá a las clases controladoras. Este servlet es `org.springframework.web.servlet.DispatcherServlet`

Siendo un servlet, este debe tener un nombre (claro) y el URL que deberá manejar. Como toda la aplicación web es todo el URL, lo que haremos será mapear desde la raiz ("/").

Así que -primero - crearemos el archivo `web.xml` desde el IDE.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjB7rTkF_-G6PuOWU8llULEXvLqHP37ud0lQNQp2DvOlIAqqgU4VOWHg-09f5qJ3a2FyoHZv3AEwO6NViN4kVwmz2sqaUy4LJ66wqMURyeujzatHk8Mqg0jx5wvRmd1udFuYOwIMc3qyS4/s1600/27-11-2014+09-23-52+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjB7rTkF_-G6PuOWU8llULEXvLqHP37ud0lQNQp2DvOlIAqqgU4VOWHg-09f5qJ3a2FyoHZv3AEwO6NViN4kVwmz2sqaUy4LJ66wqMURyeujzatHk8Mqg0jx5wvRmd1udFuYOwIMc3qyS4/s1600/27-11-2014+09-23-52+p.m..png)

Clic en Next y luego en Finish.

Al final, tendremos el editor con el siguiente contenido.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgZak_uutNtPsTcVkdHA_U_tqs_I9F68wXgAmjBirxp1Vyn9NJQBvzPX0jnH1EI3ZuU7LU6egRIsxuqBAf3igS7hap0ncBt5RJTLwi1aoJciTrc0QD9-ID_EXa4lkK0Hs_XBqMz8RgEq4Y/s1600/27-11-2014+09-25-17+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgZak_uutNtPsTcVkdHA_U_tqs_I9F68wXgAmjBirxp1Vyn9NJQBvzPX0jnH1EI3ZuU7LU6egRIsxuqBAf3igS7hap0ncBt5RJTLwi1aoJciTrc0QD9-ID_EXa4lkK0Hs_XBqMz8RgEq4Y/s1600/27-11-2014+09-25-17+p.m..png)

Podemos ir a la sección (botón superior) llamado "Servlets" y hacer clic en "Add Servlet Element...".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjVRey1_X5tuvrRtbaS_e9MFLspVZu3GDtXiJ_QaR-PNFIkR7w2cHADsIyInwa4VGMf6FneSUDJAcHQdsSzKA_rAmKenCPTllK5sLY_rjmhEMh-TX_lMmCvFnLMd2-EDIralQsNcBLIR8M/s1600/27-11-2014+09-26-43+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjVRey1_X5tuvrRtbaS_e9MFLspVZu3GDtXiJ_QaR-PNFIkR7w2cHADsIyInwa4VGMf6FneSUDJAcHQdsSzKA_rAmKenCPTllK5sLY_rjmhEMh-TX_lMmCvFnLMd2-EDIralQsNcBLIR8M/s1600/27-11-2014+09-26-43+p.m..png)

Y escribir los siguientes valores en los campos

<table>
<tbody>
<tr><td>Servlet name</td><td>DefaultServlet</td></tr>
<tr><td>Servlet class</td><td>org.springframework.web.servlet.DispatcherServlet</td></tr>
<tr><td>URL Pattern</td><td>/</td></tr>
</tbody></table>

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFPunOQzqbD7HkTsnCT3r-FC_ESCrq5d2XKNBOe4doxKhOv7xkKX642QQlirA-PsdBloI2F848h350PUqgUFdDYy3gZkmNCJzmIhbNRkjXayGnwwHmgPEuhrx5mkDCmU8ZSPatMOY-m3c/s1600/27-11-2014+09-29-34+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFPunOQzqbD7HkTsnCT3r-FC_ESCrq5d2XKNBOe4doxKhOv7xkKX642QQlirA-PsdBloI2F848h350PUqgUFdDYy3gZkmNCJzmIhbNRkjXayGnwwHmgPEuhrx5mkDCmU8ZSPatMOY-m3c/s1600/27-11-2014+09-29-34+p.m..png)

Clic en "OK"

Ahora, necesitamos crear el archivo `DefaultServlet-servlet.xml` en la misma carpeta donde se encuentra el archivo `web.xml` (es decir en `WEB-INF`)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg_goCHBZtnh2JfjNF96kNWXG9lm0bFUPuRxCrFflP82OxY0iCQONoAwiupS-8U2yMbLv56wvgv-NSdNS-rdGdVKrcTb3cXDT98j4gdWqG7GFJ8vwg4hqPDj4OkoX-ftVqehzjMKCOtECs/s1600/03-12-2014+07-39-14+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg_goCHBZtnh2JfjNF96kNWXG9lm0bFUPuRxCrFflP82OxY0iCQONoAwiupS-8U2yMbLv56wvgv-NSdNS-rdGdVKrcTb3cXDT98j4gdWqG7GFJ8vwg4hqPDj4OkoX-ftVqehzjMKCOtECs/s1600/03-12-2014+07-39-14+p.m..png)

Y el contenido es el siguiente:

```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"

       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
    http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.1.xsd
    http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.1.xsd">

    <mvc:annotation-driven/>
    <context:component-scan base-package="com.apuntesdejava.spring.mvc.store"/>
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>
</beans>
```

(Quería hacerlo usando el asistente de NB para generar las etiquetas en base a un xmlns, pero no me salió, así que a copiar no más)

Lo ejecutamos, y saldrá esto

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGmOvVFUcI88sg3WJlMiMzQK63GHGtBT1I-8iEf_undEuH9XngclxiEHV9dUAqSAf2O9c6RzDm3S8IbDC_-mWDUGGxiUti83esOEWEPnQpYnuU2DvBPZCNPDaGQrrPqQ3T3LTPB6EmM1Q/s1600/03-12-2014+07-41-57+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiGmOvVFUcI88sg3WJlMiMzQK63GHGtBT1I-8iEf_undEuH9XngclxiEHV9dUAqSAf2O9c6RzDm3S8IbDC_-mWDUGGxiUti83esOEWEPnQpYnuU2DvBPZCNPDaGQrrPqQ3T3LTPB6EmM1Q/s1600/03-12-2014+07-41-57+p.m..png)

Y como estamos usando el Bootstrap, la página es responsive.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjcDMpW-0XbGTM4GkmzAPun68qI8wUWChLC0yFkqpFEctmay_Dd59UkISaBIH_2FtDVemaQuwmBbiwPznglx_fPvWGKhuel5WWz6jUZTKEjW-MjRapVNANCrcH5RjY7f3CBOoHF2dwHaHA/s1600/03-12-2014+07-50-21+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjcDMpW-0XbGTM4GkmzAPun68qI8wUWChLC0yFkqpFEctmay_Dd59UkISaBIH_2FtDVemaQuwmBbiwPznglx_fPvWGKhuel5WWz6jUZTKEjW-MjRapVNANCrcH5RjY7f3CBOoHF2dwHaHA/s1600/03-12-2014+07-50-21+p.m..png)

### ¿Cómo funciona esto?

- Cuando se llamó a la página, se está llamando a la raíz del contexto (en este caso, es `/spring-mvc-store`). Recordemos que hemos mapeado el servlet `org.springframework.web.servlet.DispatcherServlet` con el URL en la raíz (`/`)

- Ahora, el servlet buscará la configuración el archivo que termine con `-servlet.xml` en la carpeta WEB-INF. Este archivo .xml debe tener el mismo nombre del servlet. Es decir, el servlet que contenía a la clase `DispatcherServlet` tenía por nombre `DefaultServlet`, por tanto buscará al archivo `DefaultServlet-servlet`. Así de simple (por ahora)

- Este archivo .xml es el manejador de beans que utilizará el spring para instanciar los objetos. Analicemos este código: en la línea 11 le dice que se usará anotaciones de mvc, luego en la línea 12 dice que todas las clases que están en el paquete `com.apuntesdejava.spring.mvc.store` se les aplicará todas las anotaciones que tengan (en un rato más lo veremos). Y en el bean de la línea 13 es en sí el que se encargará de interpretar las peticiones y cómo deberá manejar los archivos de vista.

```java
<mvc:annotation-driven/>
    <context:component-scan base-package="com.apuntesdejava.spring.mvc.store"/>
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
```

¿Cómo lo va hacer? Fácil: buscará todos los archivos que están dentro de `/WEB-INF/jsp/` y que terminen con `.jsp`, de tal manera que si se le pide que llame a la página "lista-principal", este bean sabrá que se encuentra en `/WEB-INF/jsp/lista-principal.jsp`

- ¿Cómo llama a la clase `HomeController`? Porque allí tiene una anotación que está mapeada con "/", por tanto (línea 13). Spring sabe que esa clase es la controladora porque tiene la anotación `@Controller`.

```java
@Controller
public class HomeController {
    @RequestMapping("/")
    public String welcome(Model model){
        model.addAttribute("greeting", "Bienvenido a la tienda virtual!");
        model.addAttribute("tagline", "Un aporte de apuntesdejava.com");
        return "welcome";
    }

}
```

- Ahora bien, tiene un método llamado "welcome" que está mapeado a la raíz. Por tanto, este método se ejecutará cuando se llame a la página raiz de la aplicación web. Este método debe devolver una String que será la página que quiere que se muestre al usuario. Además, el método tiene un parámetro de tipo `org.springframework.ui.Model`. Aquí estamos guardando los atributos que se usará en la vista (análogo a request.setAttribute de un servlet). Y terminamos con un `return "welcome";`

- Estos atributos que estamos guardando (`greeting`,`tagline` de las líneas 15 y 16 de la clase controladora) son los que se usarán en el archivo `welcome.jsp`, como ya se habrán dado cuenta hasta acá. Bastaría con ver las líneas 17 y 18 del jsp para que noten de qué se trata

```java
<div class="jumbotron">
      <div class="container">
        <h1> ${greeting} </h1>
        <p> ${tagline} </p>
      </div>
    </div>
```

Ahora, antes de terminar este primer post de Spring MVC: ¿cómo podemos poner el .xml en un lugar diferente al que está por omisión? Porque, como vimos en el punto 2, este debe ser el mismo nombre del servlet. Por ejemplo, supongamos que por orden lo pongamos dentro de una subcarpeta llamada spring/webcontext

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEwozQuRoJUbgdRvDMviD17V2tAwFGmz4OxCi_EC9cTDafgy2ruoixQNklT9B6f_RVRIcHNv0OQWHPw42rqdgIyDb1glo343U7H2grRPLXRKW7HKfmJ0CyVgI2mX4kzWeaCWvapw9XE8k/s1600/03-12-2014+08-36-40+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEwozQuRoJUbgdRvDMviD17V2tAwFGmz4OxCi_EC9cTDafgy2ruoixQNklT9B6f_RVRIcHNv0OQWHPw42rqdgIyDb1glo343U7H2grRPLXRKW7HKfmJ0CyVgI2mX4kzWeaCWvapw9XE8k/s1600/03-12-2014+08-36-40+p.m..png)

Por tanto, debemos modificar un poco la configuración del servlet en nuestro archivo web.xml, agregando parámetros de inicialización

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghgu_ulLZ5n5i-LXguqdad6htSHzncRs16w0jw9-JMOrC2puSvvhTB5HfcftGBEqTeO5MchKF8yVqYRCwJEQ_KOZiVPO-_63PVvfbMFfmwE3elDekhF1uVWsHHEjtldESXWD4-w7h8yuw/s1600/03-12-2014+08-31-22+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghgu_ulLZ5n5i-LXguqdad6htSHzncRs16w0jw9-JMOrC2puSvvhTB5HfcftGBEqTeO5MchKF8yVqYRCwJEQ_KOZiVPO-_63PVvfbMFfmwE3elDekhF1uVWsHHEjtldESXWD4-w7h8yuw/s1600/03-12-2014+08-31-22+p.m..png)

Hacemos clic en Add y agregamos los siguientes valores

<table>
<tbody>
<tr><td>Parameter name</td><td>contextConfigLocation</td></tr>
<tr><td>Parameter value</td><td>/WEB-INF/spring/webcontext/DispatcherServlet-context.xml</td></tr>
</tbody></table>

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEik7oZp1xf8xE_QxG1V1uzYwc58YoWZ9ixMlgR0XWr94k_7rCyysbM5iJiKJmsX01AV_I1ySRZI5JWJdPEi9jr1lj7uJukSaIiY35sCfICJy-Yyg6AXGJWxlu2lqN3MN6sqvbCPpaTC9cw/s1600/03-12-2014+08-33-31+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEik7oZp1xf8xE_QxG1V1uzYwc58YoWZ9ixMlgR0XWr94k_7rCyysbM5iJiKJmsX01AV_I1ySRZI5JWJdPEi9jr1lj7uJukSaIiY35sCfICJy-Yyg6AXGJWxlu2lqN3MN6sqvbCPpaTC9cw/s1600/03-12-2014+08-33-31+p.m..png)

El nombre del archivo .xml ya es arbitrario, el único requisito que debe cumplir es que esté bien configurado en el archivo web.xml

### Es todo por ahora

Al menos estamos conociendo una alternativa más para crear aplicaciones web.

El código fuente del proyecto que se mostró acá lo pueden descargar desde este link [https://java.net/projects/apuntes/downloads/download/web/spring-mvc/spring-mvc-store.tar.gz](https://java.net/projects/apuntes/downloads/download/web/spring-mvc/spring-mvc-store.tar.gz)

[Un día deberíamos hacer un proyecto interesante entre toda la comunidad para toda la comunidad, para hacer algo más agresivo y no hacer estos tutoriales de comprar perritos y gatitos, ¿no creen?]

### Bibliografía

Para este (y los siguientes tutoriales) me he basado del siguiente libro que está bien interesante [Spring MVC Beginner's](https://www.packtpub.com/application-development/spring-mvc-beginner%E2%80%99s-guide).

[Quería hacer en un solo post todo el resumen del libro, pero - vamos - el tiempo lo tengo un poco limitado]

*Si te gustó, hazlo saber.. y si crees que es útil, compártelo. Es gratis*
