---
layout: post
title: "¿Para que los EJB?"
date: 2008-08-26T18:00:00.001Z
last_modified_at: 2015-12-15T16:35:01.065Z
author: "Diego Silva"
permalink: /2008/08/para-que-los-ejb.html
canonical_url: https://www.apuntesdejava.com/2008/08/para-que-los-ejb.html
tags:
  - "netbeans 6.5"
  - "java ee"
  - "jpa"
  - "netbeans 6.1"
  - "netbeans"
  - "tutorial"
  - "ejb"
---

Si hacemos una aplicación Web ¿para qué necesitamos los EJB, si todo lo podemos programar en los Servlets y los JSP?... y si programos una aplicación Desktop ¿para qué los EJB si todo lo podemos programar en las clases Swing? Pero si queremos una aplicación que sea funcional tanto en Web como en Desktop, donde la lógica de negocio debe ser la misma, y si se cambia la forma de realizar alguna rutina debe ser reflejada en en las dos aplicaciones. ¿qué hacemos?

¿Aún no está claro lo que hablo? Bueno, vayamos directo a la aplicación.

### Haciendo una aplicación Web que calcula áreas

Supongamos que queremos una aplicación web llamada AreasWeb que haga cálculos de área geométricas: el área del círculo, del pentágono regular, del triángulo y del trapecio. Los parámetros que necesitamos son los siguientes:

-  Para calcular el círculo necesitamos el **radio**.

-  Para el pentágono, la **altura**

-  Para el triángulo, la **base** y la **altura**

-  Y para el trapecio, la **base menor**, la **base mayor** y la **altura**.

#### La solución usando un JSP

Haremos cuatro formularios en un solo .jsp y en ese mismo .jsp mostraremos el resultado. Este es el JSP para nuestra solución:

```java
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
</head>
<body>
<h1>Calculando áreas</h1>
<form action="index.jsp?area=circulo" method="post">
  <fieldset>
      <legend>Área del círculo</legend>
      Radio: <input type="text" name="radio" value="${param.radio}">
      <input type="submit" value="Calcular">
      <%if ("circulo".equals(request.getParameter("area"))) {
      double radio=Double.parseDouble(request.getParameter("radio"));
      double area=Math.PI*Math.pow( radio,2.0);
      %><br/>
      El área es: <%=area%>
      <%}%>
  </fieldset>
</form>

<form action="index.jsp?area=pentagono" method="post">
  <fieldset>
      <legend>Área del pentágono</legend>
      Altura: <input type="text" name="altura" value="${param.altura}">
      <input type="submit" value="Calcular">
      <%if ("pentagono".equals(request.getParameter("area"))) {
      double altura=Double.parseDouble(request.getParameter("altura"));
      double area=((5.0*Math.pow(altura, 2))/4.0)*(1.0/Math.tan(Math.PI/5.0));
      %><br/>
      El área es: <%=area%>
      <%}%>
  </fieldset>
</form>
<form action="index.jsp?area=triangulo" method="post">
  <fieldset>
      <legend>Área del Triángulo</legend>
      Altura: <input type="text" name="altura" value="${param.altura}"><br/>
      Base: <input type="text" name="base" value="${param.base}"><br/>
      <input type="submit" value="Calcular">
      <%if ("triangulo".equals(request.getParameter("area"))) {
      double altura=Double.parseDouble(request.getParameter("altura"));
      double base=Double.parseDouble(request.getParameter("base"));
      double area=(base*altura)/2.0;
      %><br/>
      El área es: <%=area%>
      <%}%>
  </fieldset>
</form>

<form action="index.jsp?area=trapecio" method="post">
  <fieldset>
      <legend>Área del Trapecio</legend>
      Altura: <input type="text" name="altura" value="${param.altura}"><br/>
      Base 1: <input type="text" name="base1" value="${param.base1}"><br/>
      Base 2: <input type="text" name="base2" value="${param.base2}"><br/>
      <input type="submit" value="Calcular">
      <%if ("trapecio".equals(request.getParameter("area"))) {
      double altura=Double.parseDouble(request.getParameter("altura"));
      double base1=Double.parseDouble(request.getParameter("base1"));
      double base2=Double.parseDouble(request.getParameter("base2"));
      double area=(altura*(base1+base2))/2.0;
      %><br/>
      El área es: <%=area%>
      <%}%>
  </fieldset>
</form>

</body>
</html>
```

Toda la lógica de negocio está aquí. Ahorramos bastante código, ahorramos esfuerzo. Nada más hemos logrado.

**Problemas:**

-  Si queremos otra página en nuestra aplicación que querramos usar alguna de esas fórmulas, tendremos que volver a pegar las fórmulas en esa nueva página.

-  Si hay que hacer alguna modificación o corrección en una de las fórmulas, tendremos que revisar en todas las páginas que lo utilizan. De hecho, uno se nos podría escapar a nuestra revisión.

Bueno, podriamos hacer un servlet que siempre reciba los parámetros y guardar el resultado del área en una variable de sesión y mostrarlo en la página resultante.

### La solución usando Servlet

Pues aquí está el servlet, la clase se llama *web.AreaServlet* y su URL es */AreaServlet*:

```java
String tipoArea = request.getParameter("area");
    double area = 0.0;
    if ("circulo".equals(tipoArea)) {
        double radio = Double.parseDouble(request.getParameter("radio"));
        area = Math.PI * Math.pow(radio, 2.0);

    } else if ("pentagono".equals(tipoArea)) {
        double altura = Double.parseDouble(request.getParameter("altura"));
        area = ((5.0 * Math.pow(altura, 2)) / 4.0) * (1.0 / Math.tan(Math.PI / 5.0));
    } else if ("triangulo".equals(tipoArea)) {
        double altura = Double.parseDouble(request.getParameter("altura"));
        double base = Double.parseDouble(request.getParameter("base"));
        area = (base * altura) / 2.0;
    } else if ("trapecio".equals(tipoArea)) {
        double altura = Double.parseDouble(request.getParameter("altura"));
        double base1 = Double.parseDouble(request.getParameter("base1"));
        double base2 = Double.parseDouble(request.getParameter("base2"));
        area = (altura * (base1 + base2)) / 2.0;
    }
    request.setAttribute("area", area);
    request.setAttribute("formula", tipoArea);
    RequestDispatcher rd = request.getRequestDispatcher("respuesta.jsp");
    rd.forward(request, response);
```

El *index.jsp* ahora tiene menos código:

```java
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
<h1>Calculando áreas</h1>
<form action="AreaServlet?area=circulo" method="post">
    <fieldset>
        <legend>Área del círculo</legend>
        Radio: <input type="text" name="radio" value="${param.radio}">
        <input type="submit" value="Calcular">

    </fieldset>
</form>

 <form action="AreaServlet?area=pentagono" method="post">
    <fieldset>
        <legend>Área del pentágono</legend>
        Altura: <input type="text" name="altura" value="${param.altura}">
        <input type="submit" value="Calcular">

    </fieldset>
</form>
<form action="AreaServlet?area=triangulo" method="post">
    <fieldset>
        <legend>Área del Triángulo</legend>
        Altura: <input type="text" name="altura" value="${param.altura}"><br/>
        Base: <input type="text" name="base" value="${param.base}"><br/>
        <input type="submit" value="Calcular">

    </fieldset>
</form>

<form action="AreaServlet?area=trapecio" method="post">
    <fieldset>
        <legend>Área del Trapecio</legend>
        Altura: <input type="text" name="altura" value="${param.altura}"><br/>
        Base 1: <input type="text" name="base1" value="${param.base1}"><br/>
        Base 2: <input type="text" name="base2" value="${param.base2}"><br/>
        <input type="submit" value="Calcular">

    </fieldset>
</form>

</body>
</html>
```

Funciona, ahora cualquier página que llamemos a ese Servlet utilizando los respectivos parámetros, nos mostrará el resultado. Es más, puede ser llamado desde cualquier aplicación web, así no sea del mismo servidor.

**Problemas:**

-  Si queremos usar la misma lógica para calcular las áreas para una aplicación Desktop con Swing, no podremos, ya que un Swing no soporta servlets y nada web.

-  El resultado siempre se mostrará en *respuesta.jsp*, si queremos utilizar el mismo resultado en otra página, dependeríamos del formato utilizado en *respuesta.jsp*.

#### Creando una biblioteca que contenga la lógica del cálculo

Trataremos de solucionar el primer problema cuestionado en el anterior párrafo.

Crearemos una nueva biblioteca Java desde NetBeans:

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/7/7b/New-project_PorqueUsarEJB.jpg" width="600" /></td></tr>
</tbody></table>
Y la llamaremos *BibliotecaAreas*

Dentro crearemos una clase llamada *areas.CalculaAreas* la cual tendrá el siguiente código:

```java
package areas;

public class CalculaAreas {

  public static double circulo(double radio) {
      return Math.PI * Math.pow(radio, 2.0);
  }

  public static double pentagono(double altura) {
      return ((5.0 * Math.pow(altura, 2)) / 4.0) * (1.0 / Math.tan(Math.PI / 5.0));
  }

  public static double trapecio(double altura, double base1, double base2) {
      return (altura * (base1 + base2)) / 2.0;
  }

  public static double triangulo(double altura, double base) {
      return (base * altura) / 2.0;
  }
}
```

Agregamos este proyecto como biblioteca del proyecto Web:

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/9/93/Props-webarea_PorqueUsarEJB.jpg" width="600" /></td></tr>
</tbody></table>
Y el método de nuestro servlet cambiará un poco así:

```java
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      String tipoArea = request.getParameter("area");
      double area = 0.0;
      if ("circulo".equals(tipoArea)) {
          double radio = Double.parseDouble(request.getParameter("radio"));
          area = CalculaAreas.circulo(radio);

      } else if ("pentagono".equals(tipoArea)) {
          double altura = Double.parseDouble(request.getParameter("altura"));
          area = CalculaAreas.pentagono(altura);
      } else if ("triangulo".equals(tipoArea)) {
          double altura = Double.parseDouble(request.getParameter("altura"));
          double base = Double.parseDouble(request.getParameter("base"));
          area = CalculaAreas.triangulo(altura, base);
      } else if ("trapecio".equals(tipoArea)) {
          double altura = Double.parseDouble(request.getParameter("altura"));
          double base1 = Double.parseDouble(request.getParameter("base1"));
          double base2 = Double.parseDouble(request.getParameter("base2"));
          area = CalculaAreas.trapecio(altura, base1, base2);
      }
      request.setAttribute("area", area);
      request.setAttribute("formula", tipoArea);
      RequestDispatcher rd = request.getRequestDispatcher("respuesta.jsp");
      rd.forward(request, response);

  }
```

¿Qué ganamos? Pues que ahora la lógica que calcula las áreas está en fuera de nuestra aplicación principal, y tenemos las siguientes ventajas:

-  Podemos agregar esta biblioteca a otros proyectos, de la misma manera cómo la agregamos a la aplicación web.

-  Si deseamos modificar la fórmula de alguna área, lo haremos en la biblioteca, y los demás proyectos que utilizan nuestra biblioteca no sufrirán cambios.

**Problema:**

Si hacemos cambios en esta biblioteca, habría que actualizar todas las aplicaciones con el nuevo .jar de nuestra biblioteca.

#### La solución usando EJB

Usando una analogía: podemos decir que es mucho más eficiente y económico tener una impresora en red para N equipos, que una impresora por cada computador. Es más fácil dar mantenimiento a un solo recurso, que a varios sabiendo que están todos sobre una red.

De la misma manera funcionan los EJB. Los EJB tienen la lógica de negocio para una determinada tarea. Es muy similar a la biblioteca que hemos creado, pero se aloja sobre un Contenedor de EJB, de tal manera que cualquier aplicación Java EE pueda utilizarlo. Si se hace alguna modificación en el EJB, no tendremos que actualizar las aplicaciones que lo utiliza, ya que estas siempre obtendrán el EJB que está en el Contenedor EJB.

Crearemos un nuevo proyecto (Mayúscula+Ctrl+N) que consistirá en un módulo EJB:

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/f/fe/New-ejb_PorqueUsarEJB.jpg" width="600" /></td></tr>
</tbody></table>
y llamaremos *AreasEJBModule*.

Luego creamos un nuevo archivo (Ctrl+N) que será un *Session bean*

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/7/7e/New-session_bean_PorqueUsarEJB.jpg" width="600" /></td></tr>
</tbody></table>
Tendrá las siguientes propiedades:

-  Nombre: **Calculadora**

-  Paquete: **ejb**

-  Tipo de sesión: **Stateless**

-  Create Interface:  **remote**

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/8/87/New-session_bean1_PorqueUsarEJB.jpg" width="600" /></td></tr>
</tbody></table>
Nuestra interfaz *CalculadoraRemote* debe tener las siguientes declaraciones:

```java
package ejb;

import javax.ejb.Remote;

@Remote
public interface CalculadoraRemote {

  double pentagono(double altura);

  double circulo(double radio);

  double trapecio(double altura, double base1, double base2);

  double triangulo(double altura, double base);
}
```

Y nuestra clase *CalculadoraBean* debe estar implementado de la siguiente manera:

```java
package ejb;

import javax.ejb.Stateless;

@Stateless
public class CalculadoraBean implements CalculadoraRemote  {

 public  double circulo(double radio) {
      return Math.PI * Math.pow(radio, 2.0);
  }

  public  double pentagono(double altura) {
      return ((5.0 * Math.pow(altura, 2)) / 4.0) * (1.0 / Math.tan(Math.PI / 5.0));
  }

  public  double trapecio(double altura, double base1, double base2) {
      return (altura * (base1 + base2)) / 2.0;
  }

  public  double triangulo(double altura, double base) {
      return (base * altura) / 2.0;
  }
}
```

**Sugerencia:** También se pudo haber agregado el proyecto *BibliotecaAreas* a nuestro EJB para reutilizar los métodos.

Seleccionamos clic derecho sobre el nodo del proyecto EJB, y seleccionamos *Undeploy and Deploy * para desplegar el módulo en nuestro contenedor EJB (por ejemplo, Glassfish). ![deploy.jpg](http://wiki.netbeans.org/wiki/images/b/bf/Deploy_PorqueUsarEJB.jpg)

Después de haber desplegado el EJB, vayamos a nuestro proyecto web, y quitamos la referencia al proyecto *BibliotecaAreas* de la sección *Libraries* de las propiedades del proyecto Web.

Ahora, abrimos el Servlet, hagamos clic derecho sobre el fondo del editor del código fuente y seleccionemos *Enterprise Resources > Call Enterprise Bean*. En la ventana que aparece, seleccionamos *CalculadoraBean* ![call-bean.jpg](http://wiki.netbeans.org/wiki/images/4/4b/Call-bean_PorqueUsarEJB.jpg)

Vemos que se agregado una nueva propiedad con una anotación en nuestro servlet:

```java
@EJB
  private CalculadoraRemote calculadoraBean;
```

Con esta anotación, la aplicación obtendrá las referencia a nuestra lógica de cálculos. Así, nuestro servlet tendrá este nuevo código:

```java
package web;

import ejb.CalculadoraRemote;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AreaServlet extends HttpServlet {

  @EJB
  private CalculadoraRemote calculadoraBean;

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
   * @param request servlet request
   * @param response servlet response
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      String tipoArea = request.getParameter("area");
      double area = 0.0;
      if ("circulo".equals(tipoArea)) {
          double radio = Double.parseDouble(request.getParameter("radio"));
          area = calculadoraBean.circulo(radio);

      } else if ("pentagono".equals(tipoArea)) {
          double altura = Double.parseDouble(request.getParameter("altura"));
          area = calculadoraBean.pentagono(altura);
      } else if ("triangulo".equals(tipoArea)) {
          double altura = Double.parseDouble(request.getParameter("altura"));
          double base = Double.parseDouble(request.getParameter("base"));
          area = calculadoraBean.triangulo(altura, base);
      } else if ("trapecio".equals(tipoArea)) {
          double altura = Double.parseDouble(request.getParameter("altura"));
          double base1 = Double.parseDouble(request.getParameter("base1"));
          double base2 = Double.parseDouble(request.getParameter("base2"));
          area = calculadoraBean.trapecio(altura, base1, base2);
      }
      request.setAttribute("area", area);
      request.setAttribute("formula", tipoArea);
      RequestDispatcher rd = request.getRequestDispatcher("respuesta.jsp");
      rd.forward(request, response);

  }
//.... sigue
```

Ejecutamos la aplicación y *Voila!*

#### Un paso más adelante... con Web Services

Pero, si queremos usar la lógica de negocio en una aplicación que no sea web, y más aún, que no sea Java. Aquí entran los **Web Services**

No entraremos en detalle sobre la historia de esta tecnología.

Hacemos clic derecho sobre el nodo del proyecto *AreasEJBModule* y seleccionamos *New > Other*. Seleccionamos  *Web Services | Web Service*

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/d/d3/New-ws_PorqueUsarEJB.jpg" width="600" /></td></tr>
</tbody></table>
Y tendrá las siguientes propiedades:

-  Web Service Name: **Calculadora**

-  Package: **ws**

-  Create Web Service **from Session Bean: Enterprise Beans#CalculadoraBean** (hacemos clic en el botón *Browse* para seleccionar CalculadoraBean)

Hacemos nuevamente clic derecho sobre el ícono del proyecto *AreasEJBModule* y seleccionamos *Undeploy and deploy* para desplegar el módulo en Glassfish.

Para probar si funciona bien nuestro Web Service, hacemos clic derecho sobre el ícono de nuestro Servicio Web y seleccionamos *Test Web Service*: ![test-ws.jpg](http://wiki.netbeans.org/wiki/images/1/1b/Test-ws_PorqueUsarEJB.jpg)

Se abrirá nuestro navegador web mostrando una página donde se muestran todos nuestros métodos de nuestro Servicio Web, con entradas de texto que podemos escribir para enviar parámetros:

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/f/f2/Ws-test1_PorqueUsarEJB.jpg" width="700" /></td></tr>
</tbody></table>
Podemos escribir algunos valores para probar si funcionan correctamente nuestros métodos.

<table border="0" class="imageplugin"> <tbody>
<tr><td><img src="http://wiki.netbeans.org/wiki/images/1/13/Ws-test2_PorqueUsarEJB.jpg" width="700" /></td></tr>
</tbody></table>
En la misma página de prueba hay un enlace ([http://localhost:8080/CalculadoraService/Calculadora?WSDL](http://localhost:8080/CalculadoraService/Calculadora?WSDL)) al WSDL (Lenguaje descriptor del Servicio web) de nuestro servicio web. Este WSDL es el que se utilizará en otras aplicaciones (como .Net, Delphi, etc) que desean *consumir* nuestro servicio web.

### Los proyectos

A continuación se listan los proyectos utilizados en este artículo:

-  [http://diesil-java.googlecode.com/files/BibliotecaAreas.tar.gz](http://diesil-java.googlecode.com/files/BibliotecaAreas.tar.gz)

-  [http://diesil-java.googlecode.com/files/AreasEJBModule.tar.gz](http://diesil-java.googlecode.com/files/AreasEJBModule.tar.gz)

-  [http://diesil-java.googlecode.com/files/AreasWeb.tar.gz](http://diesil-java.googlecode.com/files/AreasWeb.tar.gz)

-  [http://diesil-java.googlecode.com/files/AreasWSCliente.tar.gz](http://diesil-java.googlecode.com/files/AreasWSCliente.tar.gz)
