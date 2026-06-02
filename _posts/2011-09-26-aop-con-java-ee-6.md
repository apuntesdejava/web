---
layout: post
title: "AOP con Java EE 6"
date: 2011-09-26T12:00:00Z
last_modified_at: 2016-05-19T16:22:54.459Z
author: "Diego Silva Límaco"
permalink: /2011/09/aop-con-java-ee-6.html
canonical_url: https://www.apuntesdejava.com/2011/09/aop-con-java-ee-6.html
description: "Implementando AOP en aplicaciones Java EE."
tags:
  - "aop"
  - "java"
  - "java ee"
  - "netbeans 7.0"
  - "netbeans"
  - "java ee 6"
---

[![]({{ '/assets/blogger/banner-aop.png' | relative_url }})]({{ '/assets/blogger/banner-aop.png' | relative_url }})

En un anterior [Post]({{ '/2008/06/aop-programacion-orientada-aspectos-con.html' | relative_url }}) hablé sobre [AOP](http://es.wikipedia.org/wiki/Programaci%C3%B3n_orientada_a_aspectos) usando [Spring](http://www.springsource.org/). Es un post algo antiguo, y me había basado de un [artículo publicado](http://www.javaranch.com/journal/2008/04/Journal200804.jsp#a2) en [JavaRanch](http://www.javaranch.com/).

Esa vez fue usando el famoso Framework Spring, pero esta vez mencionaré como funciona el AOP desde Java EE6. Creo que ya existía desde la versión EE 5, pero no importa, aquí lo mencionamos para el deleite de todos.

A diferencia del Spring, es que este AOP funciona desde un contenedor Java EE, y sobretodo, en un EJB. En Spring funciona desde cualquier aplicación que tenga la biblioteca Spring.

Así que, para que funcione nuestro ejemplo, debemos crear un módulo EJB.. pero esta vez - a diferencia de otros tutoriales - crearemos una Aplicación Enterprise (EA) con un módulo EJB y WAR. El EA se llama aop-ea, y los módulos se llaman aop-ejb y aop-war respectivamente.

[![]({{ '/assets/blogger/aop-01.png' | relative_url }})]({{ '/assets/blogger/aop-01.png' | relative_url }})

Luego, en nuestro módulo EJB crearemos una clase común y silvestre llamada `MonitoreoInterceptor` y tendrá el siguiente contenido:

```java
package com.apuntesdejava.aop.ejb.interceptor;

import java.lang.reflect.Method;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.interceptor.AroundInvoke;
import javax.interceptor.InvocationContext;

public class MonitoreoInterceptor {
    static final Logger LOGGER=Logger.getLogger(MonitoreoInterceptor.class.getName()); //para mostrar el log

    @AroundInvoke //Define un método interceptor que se interpondrá en los métodos del EJB
    public Object seguimientoMetodo(InvocationContext invocationContext) throws Exception{
        Object objetoInterceptado=invocationContext.getTarget();
        Method metodoInterceptado=invocationContext.getMethod();
        // para mostrar el metodo que se va a ejecutar
        LOGGER.log(Level.INFO, "Ejecutando m\u00e9todo: {0}.{1}()",
                new Object[]{objetoInterceptado.getClass().getName(), metodoInterceptado.getName()});

        Object o=invocationContext.proceed(); //hacemos ejecutar el método, o si hay otro interceptor, le damos la posta
        // la variable devuelta es el resultado del método, o NULL si es un método VOID

        LOGGER.log(Level.INFO, "Saliendo del m\u00e9todo: {0}.{1}()",
                new Object[]{objetoInterceptado.getClass().getName(), metodoInterceptado.getName()});

        LOGGER.log(Level.INFO, "EL m\u00e9todo devuelve el valor: {0}", o);

        return o; //que continue la secuencia
    }

}
```

Solo aquí hemos definido el interceptor. Ahora, crearemos un EJB en el móduglo EJB con un par de métodos y lo interceptamos con la clase que acabamos de crear.

```java
package com.apuntesdejava.aop.ejb.facade;

import com.apuntesdejava.aop.ejb.domain.Persona;
import com.apuntesdejava.aop.ejb.interceptor.MonitoreoInterceptor;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.interceptor.Interceptors;

@Stateless
public class PersonaFacade {

    private static List<Persona> personas = new ArrayList<Persona>();

    @Interceptors({MonitoreoInterceptor.class}) //le colocamos un conjunto de interceptores
    public void nuevo(Persona p) { //el método es uno común y corriente.
        personas.add(p);
    }

    @Interceptors({MonitoreoInterceptor.class})// tambien le colocamos un conjunto de interceptores
    public List<Persona> lista() { //este método devuelve algo
        return personas;
    }
}
```

Y desde un Servlet llamamos al EJB como si fuera cualquier EJB común.

**Uno de los grandes beneficios es que no necesitaremos que heredar código para hacer algo repetitivo**, ni repetir el código en todo lugar donde se necesite. Por ejemplo, si queremos monitorear el acceso a ciertas partes de la lógica de negocio, lo colocamos en el Interceptor, y si queremos cambiar la manera cómo vamos a manejar el monitereo, pues claro.. cambiamos solo un interceptor.

```java
//...
@WebServlet(name = "ListaServlet", urlPatterns = {"/ListaServlet"})
public class ListaServlet extends HttpServlet {

    @EJB
    private PersonaFacade personaFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Persona> lista = personaFacade.lista();
        request.setAttribute("lista", lista);
        RequestDispatcher rd = request.getRequestDispatcher("/lista.jsp");
        rd.forward(request, response);
    }

//...
```

Además, también podemos ejecutarlo desde un Cliente EJB... Con algunas consideraciones en el EJB, tenemos el siguiente código para el cliente EJB:

```java
//...
public class Main {

    @EJB
    private static PersonaFacadeRemote personaFacade;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Persona p1 = new Persona(1, "Ana");
        Persona p2 = new Persona(1, "Bernardo");
        Persona p3 = new Persona(1, "Carl");
        personaFacade.nuevo(p1);
        personaFacade.nuevo(p2);
        personaFacade.nuevo(p3);
    }
}
```

El resultado en el Servidor es el siguiente..

[![]({{ '/assets/blogger/aop-02.png' | relative_url }})]({{ '/assets/blogger/aop-02.png' | relative_url }})

Y listo!.. ya estoy monitoreando los métodos!!

Este post  no pretendió ser un tutorial de  EJB, por lo que me he saltado muchas cosas. El objetivo de este post es solo mostrar como funciona el AOP. Para la creación de un EJB con cliente lo veremos en otro artículo.

El código fuente de este post, incluyendo el cliente de EJB se puede descargar desde aquí: [http://kenai.com/projects/apuntes/downloads/download/AOP/aop-ea.tar.gz](http://kenai.com/projects/apuntes/downloads/download/AOP/aop-ea.tar.gz)

Más información sobre los Interceptors, aquí, en la documentación de Java EE 6: [http://download.oracle.com/javaee/6/tutorial/doc/gkeed.html](http://download.oracle.com/javaee/6/tutorial/doc/gkeed.html)

### Twitter

>

Implementando AOP en Aplicaciones [#JavaEE](https://twitter.com/hashtag/JavaEE?src=hash).
Aplicable desde [#Java](https://twitter.com/hashtag/Java?src=hash) EE 6[https://t.co/mCSheNGonp](https://t.co/mCSheNGonp)

&mdash; Apuntes de Java (@apuntesdejava) [19 de mayo de 2016](https://twitter.com/apuntesdejava/status/733330926256705536)

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### Facebook

<iframe src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1179874765357153&width=500" width="500" height="354" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
