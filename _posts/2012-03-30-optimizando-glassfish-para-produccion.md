---
layout: post
title: "Optimizando GlassFish para producción"
date: 2012-03-30T16:09:00.001Z
last_modified_at: 2012-03-30T16:09:40.214Z
author: "Diego Silva Límaco"
permalink: /2012/03/optimizando-glassfish-para-produccion.html
canonical_url: https://www.apuntesdejava.com/2012/03/optimizando-glassfish-para-produccion.html
tags:
  - "jdk"
  - "server"
  - "glassfish"
  - "java"
  - "java ee"
  - "documentacion"
  - "tips"
  - "trucos"
---

![]({{ '/assets/blogger/glassfish-duke.jpg' | relative_url }})

Gracias a un Tweet de Edwin Ilovares (@_edwini) me hizo recordar en publicar un post que lo tenía pendiente desde hace un tiempo, y es sobre la optimización de GlassFish.

Cuando se descarga el GlassFish, este está optimizado para desarrollo. Está preparado para continuos deploy y undeploy,create y remove resources, debug, etc.

Ya que GlassFish está hecho 100% en Java, entonces la configuración principal consiste en cómo debe utilizar el JVM. Para ello entremos a la consola del administrador (http://localhost:4848) y vayamos a la opción: Configuraciones > server-config > Configuración de JVM

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody>
<tr><td style="text-align: center;"><a href="/assets/blogger/gf-tunning-01.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="/assets/blogger/gf-tunning-01.png" /></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Configuración del servidor dentro de la consola de GlassFish</td></tr>
</tbody></table>
Luego, se mostrarán varias pestañas sobre la configuración del servidor. Pero debemos ir directamente a los parámetros de JVM.

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody>
<tr><td style="text-align: center;"><a href="/assets/blogger/gf-tunning-02.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="207" src="/assets/blogger/gf-tunning-02.png" width="320" /></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Configuración del JVM para el servidor GlassFish</td></tr>
</tbody></table>
Desde ahí ya podemos ver una opción que llama la atención... es el parámetro "-client". Debemos ponerlo en "-server". Si el GlassFish está ejecutándose sobre un JVM de 64bits, siempre lo tomará como opción "-server". Con esta opción (-server) haremos que el JVM se centre en el modo de producir datos, y no le dé prioridad en la depuración, validación de datos (como los asserts), etc. La opción "-server" es una mejora de la opción JIT (Just in Time) que permitía ejecutar una aplicación java casi a nivel de código de máquina... o sea, súper veloz.

Otras opciones que se debe considerar en la optimización del JVM son los espacios de memoria. En mi experiencia, recomiendo que se tenga separados el servidor de java en un equipo distinto al que tendrá la base de datos. Comúnmente caemos en tener ambos servidor (Java EE y Base de datos) en un servidor. Si bien esta configuración funciona, por obvias razones el sistema operativo no le está dando toda la prioridad del rendimiento a un solo servicio. Si deseamos tener un servicio Java EE que no dé problemas, mejor invirtamos un poco más para los recursos de hardware. Bien, volviendo al punto de la memoria del JVM, los parámetros para ajustar los límites de memoria son los siguientes:

**-Xms999** Es el tamaño inicial de la memoria para la aplicación. El valor 999 se puede poner como 1024M para 1024 MegaBytes. Es decir, el parámetro debe ser **-Xms1024M **(incluye el guión inicial)

**-Xmx999** Es el tamaño máximo de la memoria para la aplicación. El valor 999 se puede poner como 4096M para 4GB de memoria. Es decir, el parámetro debe ser **-Xmx4096M **(incluye el guión inicial). Ojo, debes reservar espacio para la memoria del sistema operativo y sus servicios (por ello es necesario que el servidor solo se dedique a un solo servicio, en este caso, para el GlassFish). Y, es una de las razones porque prefiero un servidor Linux sin entorno gráfico para usar un Java EE server: el entorno gráfico consume demasiados recursos de memoria.

Para evitar los errores fatales de "Out of memory exception" debemos configurar también el tamaño máximo de espacio para generación permanente (Permanent Generation Heap). Esto es algo complicado de explicar si uno no ha programado con punteros en C/C++. Trataré de explicarlo:

Cuando un programa se ejecuta (cualquiera, sea java o c/c++) éste ocupa un espacio de memoria. Cuando el programa llama a un método/función, las variables locales se guardan en una "pila" de llamadas. Imaginemos en una pila de platos: primero se pone abajo los primeros en llegar, y encima se ponen los siguientes...  y cuando se sacan, salen primero los de arriba hasta llegar al último. Esta es la misma manera como se ejecutan los métodos / funciones en los lenguajes de programación. La función m1() llama a m2() y este a m3(). Cuando termina de ejecutarse m3(), regresa el flujo a m2(), y cuando termina este vuelve el control del flujo a m1(). (Y si hay una excepción en m3(), terminará en m2() y también en m1()... esto es porque cuando hay un exception en Java aparece una sábana de errores donde se encontró el error) Volviendo al "heap", este espacio donde se ejecutan los métodos pertenece al área de memoria "stack" (pila). Las variables declaradas en un método, cuando termina de ejecutarse el método, el valor se pierde (esta es la razón por la que siempre hay que inicializar las variables locales de un método). Ahora bien, todos los objetos que se crean durante la ejecución de la aplicación,  se crean en un espacio de memoria llamado "montón" (heap) Ahí no hay orden, es como un salón donde se guardan cosas donde haya espacio, pero todos tienen un identificador para poder llegar a ellas. Cada cierto tiempo pasa el encargado de limpiar el espacio, y si encuentra un objeto que nadie lo utiliza, lo bota. Este encargado de limpieza se llama "Garbage collector" y se ejecuta cada cierto tiempo. Nadie sabe cuando se ejecuta y no se puede ordenar desde programa cuando tiene que ejecutarse. Este gran salón donde se guardan cosas debe ser lo suficientemente grande para poder guardar los objetos de la ejecución del proyecto. Este parámetro se llama "MaxPermSize".

Ahora, no solo debemos hacer que este espacio sea muy grande. También implica que debemos optimizar nuestro código. Y uno de los puntos principales para optimizar el uso del Heap es no creando objetos a cada instante. ¿Te imaginas que por un usuario que ingresa al sistema se creen varios objetos cuando se pudo usar solo uno para todos? ¿Y si está en producción, cuantos usuarios entran a la vez y crean muchos más objetos? Obviamente, el Heap "explota". Un par de tips para optimizar esto:

- Si vas a usar un método que no necesites de los campos del objeto, es mejor que el método sea un "static". Por ejemplo:

```java
class Suma{
   public static int suma(int a,int b){
      return a+b; //no hay campos a procesar, solo se utilizan los parámetros.
   }
}
```

- Para concatenar una cadena, no usar la clase String, en su lugar usar [StringBuilder](http://docs.oracle.com/javase/7/docs/api/java/lang/StringBuilder.html).

- Usar el patrón [Singleton](http://es.wikipedia.org/wiki/Singleton)si un objeto lo vas a usar a lo largo de todo el proyecto. Esto se puede hacer a "[mano](http://www.javabeginner.com/learn-java/java-singleton-design-pattern)" o usando el [Spring Framework](http://static.springsource.org/spring/docs/3.1.x/spring-framework-reference/html/beans.html#beans-factory-scopes-singleton).

- Si usas bases de datos, usar un [Pool de Conexiones](http://docs.oracle.com/javaee/6/tutorial/doc/bncjj.html),a fin de que el mismo servidor te dé la conexión hecha y no que nuestra aplicación intente conectarse cada vez.

(Fiuuu! no pensé que esta parte sería tan larga de escribir)

Más opciones de JVM están aquí (en inglés): [http://docs.oracle.com/javase/6/docs/technotes/tools/windows/java.html](http://docs.oracle.com/javase/6/docs/technotes/tools/windows/java.html)

... y más opciones para el rendimiento de la JVM, esto lo podemos ver aquí (en inglés): [http://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html#PerformanceTuning](http://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html#PerformanceTuning)

Pero recuerda: la configuración debe ser tratada como un afinamiento de un instrumento musical. Configura, luego prueba; si no funciona, sigue ajustando y sigue probando hasta que quede perfecto.

**Bendiciones..!!**
