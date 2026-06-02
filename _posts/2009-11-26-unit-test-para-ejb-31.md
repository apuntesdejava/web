---
layout: post
title: "Unit Test  para EJB 3.1"
date: 2009-11-27T03:30:00.042Z
last_modified_at: 2009-11-27T03:30:00.208Z
author: "Diego Silva"
permalink: /2009/11/unit-test-para-ejb-31.html
canonical_url: https://www.apuntesdejava.com/2009/11/unit-test-para-ejb-31.html
tags:
  - "netbeans 6.8"
  - "ejb 3.1"
  - "java ee"
  - "netbeans"
  - "java ee 6"
  - "ejb"
---

NetBeans 6.8 viene con una (de muchas) característica novedosa: Pruebas Unitarias para EJB 3.1.

Para ello, primero recordemos lo siguiente:

- EJB 3.1 es parte de Java EE 6

- Glassfish V3 implementa Java EE 6

- NetBeans 6.8 tiene soporte para Java EE 6, y por tanto también a Glassfish V3

Hecha esta aclaración, probemos lo siguiente: Hacer un módulo ejb para GF3 llamado **CalculadoraModule**.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh85FxOjUZx9dpLvqxVDFZkJl_nIbyE5pSG5Ufe7CDGPwcC3EqZM2wZBGTPeQ37U-83ZeN142hMs87jQ2kyspyfnBeLLgysv3jC2vbzt8JLf1Fx-TMUBZGLnpYTMTyUJ9utbHNgpZGqPrRy/s320/ejb1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh85FxOjUZx9dpLvqxVDFZkJl_nIbyE5pSG5Ufe7CDGPwcC3EqZM2wZBGTPeQ37U-83ZeN142hMs87jQ2kyspyfnBeLLgysv3jC2vbzt8JLf1Fx-TMUBZGLnpYTMTyUJ9utbHNgpZGqPrRy/s1600-h/ejb1.jpg)

Ahora, recordemos algunas de las características del EJB 3.1:

- Existen los @Singleton que son como un Stateless pero único y perpetuo en el contenedor. Permite también sincronización para evitar "datos cruzados".

- Ya no requiere de una interfaz como local o remote, puede ser una clase y nada más.

- Para acceder a través de un JDNI no se necesitará de direcciones raras según sea el contenedor. Todas serán "globales" para un mismo estándar.

Hecho el recordatorio, crearemos un SessionBean pero que sea Singleton y que no sea ni local ni remote. Este Bean se llamará "SeriesBean"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh3hPBfDQ8-RcqpGoPYenytav18XQx0jIvpZp9sOxoSFLx3ILPyMk2iH4BJ6HdzbRP1_TAs0r0TgxiORYegF861_HlIHCbd51ueg1bOVlyk4rbTg65C7V6HajQGVq9n6nwYFX6sYas1OWWl/s400/ejb2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh3hPBfDQ8-RcqpGoPYenytav18XQx0jIvpZp9sOxoSFLx3ILPyMk2iH4BJ6HdzbRP1_TAs0r0TgxiORYegF861_HlIHCbd51ueg1bOVlyk4rbTg65C7V6HajQGVq9n6nwYFX6sYas1OWWl/s1600-h/ejb2.jpg)

Para nuestro ejemplo, crearemos un método llamado "factorial" que hace justamente eso: calcular el factorial

```java
<code>package ejb;

import javax.ejb.LocalBean;
import javax.ejb.Singleton;

@Singleton
@LocalBean
public class SeriesBean {

    public long factorial(long base) {
        if (base < 1) {
            return 1;
        }
        return factorial(base - 1) * base;
    }
}

</code>
```

Con la clase recién creada y seleccionada, entramos a la opción del menú principal: Tools > Create JUnit Tests. Seleccionamos a JUnit 4.x. Luego, en la ventana de creación de la prueba, seleccionar al menos las siguientes opciones: Method Access Level: Public, Generated Code: Default Method Bodies

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSdnca50AG-4xb7TXZx0EOp8MX6TUcaud7BARiIEV9rLhN7pFnwr2xMJmtqvzVNI2E7gE-jOj7ymoQdMkg8hMSsbxX5fRF1efpgjNRnag6JmBhu951dXgT3VT43nhtl64bMTIR0ZfLLnDV/s320/ejb3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjSdnca50AG-4xb7TXZx0EOp8MX6TUcaud7BARiIEV9rLhN7pFnwr2xMJmtqvzVNI2E7gE-jOj7ymoQdMkg8hMSsbxX5fRF1efpgjNRnag6JmBhu951dXgT3VT43nhtl64bMTIR0ZfLLnDV/s1600-h/ejb3.jpg)

Clic en OK, y veamos la clase que ha creado.

```java
<code>
package ejb;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

public class SeriesBeanTest {

    public SeriesBeanTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }

    @Test
    public void testFactorial() throws Exception {
        System.out.println("factorial");
        long base = 0L;
        SeriesBean instance = (SeriesBean)javax.ejb.embeddable.EJBContainer.createEJBContainer().getContext().lookup("java:global/classes/SeriesBean");
        long expResult = 0L;
        long result = instance.factorial(base);
        assertEquals(expResult, result);
        fail("The test case is a prototype.");
    }

}
</code>
```

Modifiquemos un poco el código para ver si es cierto que nos ha creado un JUnit para un EJB.

```java
<code>
    @Test
    public void testFactorial() throws Exception {
        System.out.println("factorial");
        long base = 20;
        SeriesBean instance = (SeriesBean)javax.ejb.embeddable.EJBContainer
                .createEJBContainer()
                .getContext()
                .lookup("java:global/classes/SeriesBean");
        long expResult = 2432902008176640000L;
        long result = instance.factorial(base);
        assertEquals(expResult, result);
    }

</code>
```

Ejecutamos la prueba con Alt+F6 y listo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj2tv4vhswY1LSSvQxAVIdYPtRA9XdOlIZLRIXv2VbQG0YajJDGxLC8l0zIUgFg0FuY8Y9uTAn6Kp-RX72HOYtjVi5eFJUowkpg3tVl_Cz30jxxFLpzkHR-9cUhjBjOV7jIpZe44qzPIQxA/s640/ejb4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj2tv4vhswY1LSSvQxAVIdYPtRA9XdOlIZLRIXv2VbQG0YajJDGxLC8l0zIUgFg0FuY8Y9uTAn6Kp-RX72HOYtjVi5eFJUowkpg3tVl_Cz30jxxFLpzkHR-9cUhjBjOV7jIpZe44qzPIQxA/s1600-h/ejb4.jpg)

Ahora podemos crear y probar EJBs con más comodidad.
