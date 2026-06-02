---
layout: post
title: "Cliente remoto de EJB 3.1 (en GlassFish V3)"
date: 2010-05-04T23:58:00.003Z
last_modified_at: 2010-05-06T15:38:16.670Z
author: "Diego Silva"
permalink: /2010/05/cliente-remoto-de-ejb-31-en-glassfish.html
canonical_url: https://www.apuntesdejava.com/2010/05/cliente-remoto-de-ejb-31-en-glassfish.html
tags:
  - "glassfish"
  - "netbeans 6.9"
  - "glassfish v3"
  - "ejb 3.1"
  - "tutorial"
  - "netbeans"
  - "ejb"
---

Leyendo el FAQ de EJB ([https://glassfish.dev.java.net/javaee5/ejb/EJB_FAQ.html](https://glassfish.dev.java.net/javaee5/ejb/EJB_FAQ.html)) quiero comentar cómo crear un cliente EJB sin necesidad de desplegarlo en el mismo en servidor. Realmente es muy simple:

### 1. Crear el Módulo EJB.

Creo que esta opción es demasiada fácil. En resumen, he creado un módulo llamado `CalculadoraEJBModule`. Este nombre es importante que lo utilizaremos al final en el cliente. Este módulo tiene la interfaz remota del ejb `ejb.CalculadoraBeanRemote` y su implementación `ejb.CalculadoraBean`

Aquí la interfaz:

```java
<code>package ejb;
import javax.ejb.Remote;

@Remote
public interface CalculadoraBeanRemote {

    long factorial(long num);

}
</code>
```

y aquí la implementación:

```java
<code>package ejb;

import javax.ejb.Stateless;

@Stateless
public class CalculadoraBean implements CalculadoraBeanRemote {

    @Override
    public long factorial(long num) {
        if (num < 1) {
            return 1L;
        }
        return factorial(num - 1) * num;
    }
}

</code>
```

### 2. Desplegar el módulo

Nada más que hacer "deploy" al módulo desde el NetBeans, y listo, ya está publicado en nuestro servidor (por ahora en el local)

### 3. Hacer una aplicación Java común

Notar que no estoy mencionando hacer una cliente EJB de Java. No. En este caso haremos una aplicación común Java, como si fuera un Swing, o de consola. Nada más. Para nuestro ejemplo lo llamaremos `CalculadoraCliente`. Y la clase `Main` tendrá el siguiente código:

```java
<code>package calculadoracliente;

import ejb.CalculadoraBeanRemote;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class Main {

    static final Logger LOGGER = Logger.getLogger(Main.class.getName());

    public static void main(String[] args) {
        try {
            CalculadoraBeanRemote remote = (CalculadoraBeanRemote) new InitialContext()
                .lookup("java:global/CalculadoraEJBModule/CalculadoraBean");
            long base = 10L;
            long num = remote.factorial(base);
            LOGGER.log(Level.INFO, "factorial de {0}={1}", new Object[]{base, num});
        } catch (NamingException ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        }
    }
}

</code>
```

Notar la línea del `InitialContext().lookup()`, específicamente en su parámetro donde se le indica el nombre del EJB en el servidor. Para resumir la explicación, está compuesta por tres partes:

- **`java:global`**: Es utilizado a partir de la especificación EJB 3.1, donde ya todos los EJB tendrán un mismo nombre JNDI. Antes cada proveedor de EJB daban por su lado y provocaba confusiones y nada de portabilidad entre proveedores

- **`CalculadoraEJBModule`**: Es el nombre del módulo. Como en este caso es un módulo autónomo (no es parte de un Enterprise Application .EAR) se pone su nombre. Pero si fuera parte de un EAR, entonces debería anteponerse el nombre del EAR (sin la extensión .ear)

- **`CalculadoraBean`**: Esto es fácil. Sí, es el nombre del Bean, descrito con @Stateless/@Stateful/@Singleton

Algo más e importante, es necesario agregar un .jar que contenga la interfaz del EJB a este proyecto. En NetBeans bastará con agregar  al proyecto del cliente el proyecto del EJB como biblioteca.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjMtW0AIKUkxafeYly5UG6_V7sYoK1kbNWq9qlDu6nCT9xxHuM_U8ZpTAPoflkfPYcnIXSDdcq90EQob2fXEsxjs4gAQv47IJxBOv4qDfdQlxKtoj0cQXeBSO5BO435q_CxUXUnLil7iQF/s640/ejbcliente01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjMtW0AIKUkxafeYly5UG6_V7sYoK1kbNWq9qlDu6nCT9xxHuM_U8ZpTAPoflkfPYcnIXSDdcq90EQob2fXEsxjs4gAQv47IJxBOv4qDfdQlxKtoj0cQXeBSO5BO435q_CxUXUnLil7iQF/s1600/ejbcliente01.jpg)

### 4. Agregar el .jar de GlassFish en el cliente

Este paso es necesario para poder utilizar toda la batería de GlassFish en el cliente. Debería agregarse unicamente el archivo `gf-client.jar` que se encuentra en el directorio `$GLASSFISH_HOME/modules/`.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiKbXLHBLrJMuk9WklBJDcALO-WP4eRF667PpytU-K5tN52egwxp-EHGmFdCtHSwfR8kHKCBDup33aqfxCDTbB4qAbh0fTJ-WJbECZsDds74bhmR8rKjKpfzOBXQlq3LXD4Yi-VQ_cIckBy/s640/ejbcliente02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiKbXLHBLrJMuk9WklBJDcALO-WP4eRF667PpytU-K5tN52egwxp-EHGmFdCtHSwfR8kHKCBDup33aqfxCDTbB4qAbh0fTJ-WJbECZsDds74bhmR8rKjKpfzOBXQlq3LXD4Yi-VQ_cIckBy/s1600/ejbcliente02.jpg)

### 5. Ejecutar el cliente

Y voilá!... la aplicación funcionando.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDJU_dM5t-2qVCPNVOagsg27S4oXPqd0DDGh0LXCitB08k3NrvqwR36uN7jzW-1TeOzHM-X7g6Msu_TwNhTymo1fd0U9YEx5nRY_24jiW5nr6YC4wM6IhtOoVgk_NGdXFLgfL-kyNzOqeD/s640/ejbcliente03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDJU_dM5t-2qVCPNVOagsg27S4oXPqd0DDGh0LXCitB08k3NrvqwR36uN7jzW-1TeOzHM-X7g6Msu_TwNhTymo1fd0U9YEx5nRY_24jiW5nr6YC4wM6IhtOoVgk_NGdXFLgfL-kyNzOqeD/s1600/ejbcliente03.jpg)

*¿Y si el cliente está en otro computador?*

No os preocupéis, que para todos hay.

### 4a. Configurar un parámetro de ejecución en el cliente indicando la ubicación del servidor

Por omisión el parámetro es "localhost". Pero ¿cuál es el parámetro? Es una propiedad de ejecución llamado `org.omg.CORBA.ORBInitialHost` Es necesario agregar esto en las propiedades del proyecto cliente.

```java
<code>-Dorg.omg.CORBA.ORBInitialHost=<i>SERVIDOR_EJB</i></code>
```

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0m6Mcla43CqYC1SkvUv3M0U9ByXnhws7yZdyyCFUuYCZWWAGnmcWy39o6vtIMPMwdF3-v1SQ2wD3FrXkuHgc366D0q3FPD94QK3YgtsEokqTfYMGTQ73ii9h0FrNGomC146vLGDEFW8Sn/s640/ejbcliente04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0m6Mcla43CqYC1SkvUv3M0U9ByXnhws7yZdyyCFUuYCZWWAGnmcWy39o6vtIMPMwdF3-v1SQ2wD3FrXkuHgc366D0q3FPD94QK3YgtsEokqTfYMGTQ73ii9h0FrNGomC146vLGDEFW8Sn/s1600/ejbcliente04.jpg)

*¿Y si configuré mi GlassFish para que usara otro puerto para EJB?*

Usar la propiedad `org.omg.CORBA.ORBInitialPort` en el cliente.

Por omisión es el 3700.

## Código fuente

Los proyectos usados para este ejemplo están aquí:

- [CalculadoraEJBModule.tar.gz](https://apuntes.dev.java.net/files/documents/10908/149991/CalculadoraEJBModule.tar.gz) El módulo EJB

- [CalculadoraCliente.tar.gz](https://apuntes.dev.java.net/files/documents/10908/149990/CalculadoraCliente.tar.gz): El cliente
