---
layout: post
title: "Lo que se viene con JDK 7 & NetBeans 7"
date: 2010-11-16T05:00:00.123Z
last_modified_at: 2010-11-16T05:00:05.966Z
author: "Diego Silva"
permalink: /2010/11/lo-que-se-viene-con-jdk-7-netbeans-7.html
canonical_url: https://www.apuntesdejava.com/2010/11/lo-que-se-viene-con-jdk-7-netbeans-7.html
tags:
  - "jdk"
  - "java"
  - "java 7"
  - "netbeans 7.0"
  - "netbeans"
  - "jdk 7"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhygE5TOY_Bjl6lmsmXjc6lgmzH6m7FS0LLAukX2m2QMPfXNcXhxSGyA0MuBqi2OSliLtP72VXYm47cK8jyaa89_B47cEsYlPnVysjtwMvn2sLd-c5ef7neoNdIsojtawInwgzS76wRFkKH/s200/netbeans-logo.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhygE5TOY_Bjl6lmsmXjc6lgmzH6m7FS0LLAukX2m2QMPfXNcXhxSGyA0MuBqi2OSliLtP72VXYm47cK8jyaa89_B47cEsYlPnVysjtwMvn2sLd-c5ef7neoNdIsojtawInwgzS76wRFkKH/s1600/netbeans-logo.png)

Se dice que el número 7 es el número de la perfección, y para el mundo Java este número no está lejos de serlo.

Está cerca el JDK 7, con muchas mejoras en la sintaxis, y casi a la par también sale el NetBeans 7 con su respectiva compatibilidad.

En este post mostraré algunas características de estos software.

(Mientras termino la continuación del RESTful para objetos, voy mostrando esto)

## Descargando e instalando JDK 7

Primero, debemos descargar el JDK, y este lo podemos obtener de aquí

[http://dlc.sun.com.edgesuite.net/jdk7/binaries/](http://dlc.sun.com.edgesuite.net/jdk7/binaries/)

... bajo el título **Windows Offline Installation, Multi-language JDK file**

[jdk-7-ea-bin-b118-windows-i586-11_nov_2010.exe](http://www.java.net/download/jdk7/binaries/jdk-7-ea-bin-b118-windows-i586-11_nov_2010.exe)

**Nota: Esta es la versión disponible a la fecha de este post. Si no existe, buscar dentro de [http://download.java.net/jdk7/](http://download.java.net/jdk7/).**

La instalación del JDK no es cosa del otro mundo, ya que el instalador siempre nos dice qué opción debemos elegir... y hasta creo que es mucho más rápida.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiPghX1MnBcF-uLtNWh4YwbrxCWehAsU_tYfzA7XRMkaw0BTeFzwEQKTCnx-7VnwqSbqP6dY5eZXh3f2z3p9dnqGsk64RuQg9ahRkYsaLTWsK8Moo9kyHk7nu67zRcHEX4yLUrGS5MaNf4z/s320/jdk7-01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiPghX1MnBcF-uLtNWh4YwbrxCWehAsU_tYfzA7XRMkaw0BTeFzwEQKTCnx-7VnwqSbqP6dY5eZXh3f2z3p9dnqGsk64RuQg9ahRkYsaLTWsK8Moo9kyHk7nu67zRcHEX4yLUrGS5MaNf4z/s1600/jdk7-01.jpg)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi26Y0jxT1d7-8Xoiwr4-qdztCclrmlYjTyxckJofbFiCOhda0kvw1u8_iV5y_VuHdbhw_UViq8lvUxcfxUzWbsJSrKhV-lG6q3We6uBJDwdXDpyd2-IUAqkM4uZY5BdxzIZ0XXCRj9lQ2Q/s320/jdk7-02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi26Y0jxT1d7-8Xoiwr4-qdztCclrmlYjTyxckJofbFiCOhda0kvw1u8_iV5y_VuHdbhw_UViq8lvUxcfxUzWbsJSrKhV-lG6q3We6uBJDwdXDpyd2-IUAqkM4uZY5BdxzIZ0XXCRj9lQ2Q/s1600/jdk7-02.jpg)

Luego comprobamos que la instalación fue correcta, escribiendo en la línea de comandos `java -version`

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjXCGrJf5__g2SELHpr3lQsCSGO7zQwx8DftnhuH4ej9aslbsLbguP_PjwcadyoAjfTTLhdqtCBFy8IZ6CqOxD1OCBj1Q2_ys3kMcOkee07KOfc8FGPVy7F1gtBZCosALC7sFBTLMn4fgk_/s1600/jdk7-03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjXCGrJf5__g2SELHpr3lQsCSGO7zQwx8DftnhuH4ej9aslbsLbguP_PjwcadyoAjfTTLhdqtCBFy8IZ6CqOxD1OCBj1Q2_ys3kMcOkee07KOfc8FGPVy7F1gtBZCosALC7sFBTLMn4fgk_/s1600/jdk7-03.jpg)

Ojo, yo aún tengo instalado el JDK 6, y si deseo utilizarlo, cambio la ruta de la variable JAVA_HOME.

Aquí quiero hacer una notación importante. La variable de entorno JAVA_HOME debe apuntar a la carpeta o directorio que tiene el subdirectorio "bin" del Java. Por ejemplo, en este momento tengo mi variable establecida así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSHv_zmK_BhIyTlXvwOzkqgE63rl9wM31l4z6gQgXCem2ueP2VdU3EmviYwaCIcMtiBorahl63xIy1IW4tN4NRJpIR5KWUwu7ZT7fIp5q3mTbNEvRbGR-oA5eaeeWBBDloktOfNJqP1QJ5/s1600/jdk7-04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiSHv_zmK_BhIyTlXvwOzkqgE63rl9wM31l4z6gQgXCem2ueP2VdU3EmviYwaCIcMtiBorahl63xIy1IW4tN4NRJpIR5KWUwu7ZT7fIp5q3mTbNEvRbGR-oA5eaeeWBBDloktOfNJqP1QJ5/s1600/jdk7-04.jpg)

a pesar que ya tengo instalado la versión JDK 7.. incluso el compilador puedo utilizar la versión 6,

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgSoWOj3FoQodTxYIMA-w_Wv-34_8kXS1uDDvS1d-iDRnASMmjlP3p0CC6MXJQB0uS47xG4fOI15iUSW50QZ9_2zy-3dJD6VIRb9ruyJtQ15zpQXF2R7GX1Esx67ckAQTUjjkJqSQmOt6Cv/s1600/jdk7-05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgSoWOj3FoQodTxYIMA-w_Wv-34_8kXS1uDDvS1d-iDRnASMmjlP3p0CC6MXJQB0uS47xG4fOI15iUSW50QZ9_2zy-3dJD6VIRb9ruyJtQ15zpQXF2R7GX1Esx67ckAQTUjjkJqSQmOt6Cv/s1600/jdk7-05.jpg)

para utilizar la nueva versión, debo cambiar la variable de entorno al directorio de la versión 7.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEib3tJ0XYGXD_ewhLsWG3CzNuAjZhSWcse0udt-brp-Jwc-8RcZ1A1qh6953cjYdqWyndk-pJ-n3FUF_1tMHhS2ej3E-pMJjwjakFON2INb6QYwPQg812r2XzFyY8DUC90PITJzS-YLpS8g/s640/jdk7-06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEib3tJ0XYGXD_ewhLsWG3CzNuAjZhSWcse0udt-brp-Jwc-8RcZ1A1qh6953cjYdqWyndk-pJ-n3FUF_1tMHhS2ej3E-pMJjwjakFON2INb6QYwPQg812r2XzFyY8DUC90PITJzS-YLpS8g/s1600/jdk7-06.jpg)

Para cambiar el valor de la variable de entorno en Windows, entrar a las propiedades de la PC (una manera más rápida es presionando las teclas Win+Pausa) y buscando la opción "Variables de Entorno". Para XP, Vista, 7 cada ventana son diferentes, así que no diré cómo son las ventanas.

## Descargando e instalando NetBeans 7.0

A la fecha de este post, el NetBeans 7.0 está en la etapa M2, así que descargaremos esta versión desde aquí:

[http://bits.netbeans.org/netbeans/7.0/m2/](http://bits.netbeans.org/netbeans/7.0/m2/)

Personalmente, cada vez que quiero probar una versión del NetBeans, elijo la opción ".zip", ya que solo descargado y descomprimo el contenido y listo! ya tengo el NetBeans instalado (Eclipse, no te creas en ser el único)

Pero para asegurarnos de que el NetBeans utilizará el JDK7, debemos modificar el archivo de configuración del IDE. Este se encuentro en el subdirectior "etc" de NetBeans. El nombre del archivo es "netbeans.conf", y agregamos esta línea

```java
<code>netbeans_jdkhome="C:\Archivos de programa\Java\jdk1.7.0"</code>
```

.. y luego le damos doble clic al `netbeans.exe` para ejecutar el IDE.

Luego de leer la licencia, memorizarla y aceptarla, ya podemos disfrutar del IDE NetBeans 7 + JDK 7

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjf1c2O6E-skoJETLSt51p5pcMSbiklG5SGoy5t91Rv8nWZPSe_gIanUi_vT5FcnUlTxuJUGWrlppHABQUBdqRuf_MAstcUJmHbwLYAdR2VaDXhZsIQmW8o78YhyphenhyphenMDj69uxlJwWLyINS8qX/s320/jdk7-07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjf1c2O6E-skoJETLSt51p5pcMSbiklG5SGoy5t91Rv8nWZPSe_gIanUi_vT5FcnUlTxuJUGWrlppHABQUBdqRuf_MAstcUJmHbwLYAdR2VaDXhZsIQmW8o78YhyphenhyphenMDj69uxlJwWLyINS8qX/s1600/jdk7-07.jpg)

Ahora, crearemos un nuevo proyecto de Aplicación Java, y veremos que por omisión la clase prinicipal que contiene el método `public static void **main()**` ya no es `Main` ya que ocasionaba muchas confusiones para los principiantes, sino es el mismo nombre del proyecto. Ojo, puede ser cualquier nombre, pero aquí el NetBeans sugiere ese nombre.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhF3E9M_nrVPtJr1HhTdWXjSGN05ehiSUD2l2Uv47kJ-Fyu1IMznqASGGs4fWh_UGx3Y7KGxn-jUIqDiRr45A5Cg9CMyk_ZwuV3M8NdWHunSEe1M4TAQZMLPIlSFNJTLXo9tDE8V6SNXjbw/s640/jdk7-08.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhF3E9M_nrVPtJr1HhTdWXjSGN05ehiSUD2l2Uv47kJ-Fyu1IMznqASGGs4fWh_UGx3Y7KGxn-jUIqDiRr45A5Cg9CMyk_ZwuV3M8NdWHunSEe1M4TAQZMLPIlSFNJTLXo9tDE8V6SNXjbw/s1600/jdk7-08.jpg)

Luego, entramos a las propiedades del proyecto, y cambiamos la versión del código fuente a utilizar en nuestro proyecto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGohujmf2uWvA-uVn3PMr2zgQXMehhZhqTzKLHozrcfdpfZZbjx89Wjde6JC41VRzypw_ron16ElU91gZK4hfsXFcCZvN3EaQuzKQwXkrjsPXUkvN8sSv8YhL8vfrepiDLdf4_FnCJmUKY/s640/jdk7-09.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGohujmf2uWvA-uVn3PMr2zgQXMehhZhqTzKLHozrcfdpfZZbjx89Wjde6JC41VRzypw_ron16ElU91gZK4hfsXFcCZvN3EaQuzKQwXkrjsPXUkvN8sSv8YhL8vfrepiDLdf4_FnCJmUKY/s1600/jdk7-09.jpg)

## Características nuevas de JDK 7 en NetBeans 7.0

Aquí vienen las características más esperadas que todo el mundo se quejaba de que Java no tena y que vienen a nuestra salvación.

### switch con cadenas

Esta es - creo yo - la que muchos esperábamos: usar cadenas en `switch`. Por definición, los `switch` solo permiten una variable de tipo escalar (nativo), como el char, int, byte, etc... es decir, los String no "juegan". Entonces, solo con los Strings usábamos "if" encadenados, como aquí:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh32CGxIiQqVMjtFOuugwRQXow6PBYob-3W3-OSoAnI8u4Q0ZTLwIC5vy3YDcHss6fwDeisYjZQGoaEfUWSmuWgHbAolTo0myRYol5_GEfB8sSoKzKw_MaTlyt7qtM-DTCc5i1P9nkX0G9d/s1600/jdk7-10.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh32CGxIiQqVMjtFOuugwRQXow6PBYob-3W3-OSoAnI8u4Q0ZTLwIC5vy3YDcHss6fwDeisYjZQGoaEfUWSmuWgHbAolTo0myRYol5_GEfB8sSoKzKw_MaTlyt7qtM-DTCc5i1P9nkX0G9d/s1600/jdk7-10.jpg)

Pero aquí NetBeans nos muestra una sugerencia: cuando pasamos el ratón por el foquito del margen izquierdo nos dice

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwlWRvDp9cLodWJB9XI8l2yF_8EqyQkRdLtxgomrrtZppvsfrENFkrkMbkiTAAqizMaasEcnfuPBM7yJQhwkDrl3WtsbZVshDou2g1N8b-3udcEskfAyLL0TqQAUg8AEflLGgm66aqk1-D/s1600/jdk7-11.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiwlWRvDp9cLodWJB9XI8l2yF_8EqyQkRdLtxgomrrtZppvsfrENFkrkMbkiTAAqizMaasEcnfuPBM7yJQhwkDrl3WtsbZVshDou2g1N8b-3udcEskfAyLL0TqQAUg8AEflLGgm66aqk1-D/s1600/jdk7-11.jpg)

.. y al seleccionar la opción.. adivinen qué sucede...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiNWJJQ3HV3OBjqsVTH_VyfUXYLEsoHxYspjFDKG7Fblnv10oHsT6Nspzj3IvlIyKgJgLqiOOlVm6Ew1GjXyy_pG-xUjIAQsXX0DzFjc_mjZ18t_0RGI5AmRVMrj3IG-SUQA1Kx5Zh6tYQS/s1600/jdk7-12.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiNWJJQ3HV3OBjqsVTH_VyfUXYLEsoHxYspjFDKG7Fblnv10oHsT6Nspzj3IvlIyKgJgLqiOOlVm6Ew1GjXyy_pG-xUjIAQsXX0DzFjc_mjZ18t_0RGI5AmRVMrj3IG-SUQA1Kx5Zh6tYQS/s1600/jdk7-12.jpg)

### Operador "diamante": anulando Genericos redundantes

En la versión Java 1.5 aparecieron los [Genéricos](http://download.oracle.com/javase/1.5.0/docs/guide/language/generics.html), una notación importante para asegurar los tipos de las colecciones. Es decir, antes en un List podía tener String, objetos persona, Integer, arreglos.. etc... y para obtener un elemento debía hacerse "casting". Pero en la versión 5, con los genéricos, se podía declarar un tipo para una colección y asegurar que el objeto devuelto siempre era del mismo tipo declarado y evitaba hacer "cast".

```java
<code>List<Persona> personas=new ArrayList<Persona>();</code>
```

Pero había un problema: el tipo de la colección que se estaba instanciando debería ser del mismo tipo de la declaración. Es decir, no se podía hacer esto:

```java
<code>List<Persona> personas=new ArrayList<Empleado>();</code>
```

por más que `Empleado` sea subclase de `Persona`. Se puede utilizar caracteres comodines, pero eso es otra historia. El asunto es que para una declaración simple como la mencionada antes, debería usarse siempre el mismo tipo en la instanciación. Entonces, si ya fue declarado con un tipo, ¿Ya no debería mencionarlo en la instanciación? Pues, aquí NetBeans nos sale a la ayuda.

Antes:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjIBHo7aLV4QiAri5SKyHo1i6IKso2TKHTCdNZ0kL2D6gmwbc64nwA60BNq1zvzxYjlRz0SgtL7RfglLj0WmJ9RmujAZK5wDVQG5IkJoSTo_-8pMLM_pqVZrdYUYL6FvmANfZZyjGC1yn-M/s1600/jdk7-13.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjIBHo7aLV4QiAri5SKyHo1i6IKso2TKHTCdNZ0kL2D6gmwbc64nwA60BNq1zvzxYjlRz0SgtL7RfglLj0WmJ9RmujAZK5wDVQG5IkJoSTo_-8pMLM_pqVZrdYUYL6FvmANfZZyjGC1yn-M/s1600/jdk7-13.jpg)

Después:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCFSek2kLddZxmTPWp1Qp3QBQ0Bl87x-JPbqd0-A69VQbFM4_3tv9c__sWSnRge0MpgqbAb_ZjqznQy3_6eVq3CSkWmWDRQ2qfVOl2aXSdbfoVuJEwzDMlnjwgCKBPyKC_c2jvEpswlBXg/s1600/jdk7-14.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCFSek2kLddZxmTPWp1Qp3QBQ0Bl87x-JPbqd0-A69VQbFM4_3tv9c__sWSnRge0MpgqbAb_ZjqznQy3_6eVq3CSkWmWDRQ2qfVOl2aXSdbfoVuJEwzDMlnjwgCKBPyKC_c2jvEpswlBXg/s1600/jdk7-14.jpg)

### Multicatch

¿Tienes una código que contiene muchos catch, y según la recomendación de Jav se debería usar un catch específico por cada excepción para manejarla de manera específica.... y en tu código en todos los catch se hace lo mismo.. y quieres evitar de usar la clase `Exception`? No te preocupes. Aquí aparecen los multicatch. Supongamos este código:

```java
<code>
        File f=new File("d://temp.xml");
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document d = builder.parse(f);
        } catch (SAXException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (ParserConfigurationException ex) {
            ex.printStackTrace();
        }

</code>
```

El IDE nos sugerirá algo en el primer "catch".

Antes:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjRyuoBzV8SHi3CJu0jLnsG1-TogB46PvAWlm8tBjNoTOQeYJFY5hxX_cMMAJ5orYnr4R3lcM6kwFf1saD3LBOBTMgkuz_GHLoGzCGZlZw5kUUMwJMgzY_0EQx_GROLUpPiSbtsLpO2du5/s1600/jdk7-15.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjRyuoBzV8SHi3CJu0jLnsG1-TogB46PvAWlm8tBjNoTOQeYJFY5hxX_cMMAJ5orYnr4R3lcM6kwFf1saD3LBOBTMgkuz_GHLoGzCGZlZw5kUUMwJMgzY_0EQx_GROLUpPiSbtsLpO2du5/s1600/jdk7-15.jpg)

Después:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLUPmkBmODx5CLLp9sIKkg8qJZHwK1A_ElFcJExOaBgHM1yCJschfG0enoYcTCDz7Fg2pKbsjQ_eBMlv7V25z2w4cUFEQOWs9nCpy17Ca3r3GgpKukapVShuBC-tdQMLwHQVWrtKig_K5l/s1600/jdk7-16.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLUPmkBmODx5CLLp9sIKkg8qJZHwK1A_ElFcJExOaBgHM1yCJschfG0enoYcTCDz7Fg2pKbsjQ_eBMlv7V25z2w4cUFEQOWs9nCpy17Ca3r3GgpKukapVShuBC-tdQMLwHQVWrtKig_K5l/s1600/jdk7-16.jpg)

Estos fueron algunos.. más información de NB 7.0 lo podeís ver aquí:

[http://wiki.netbeans.org/NewAndNoteworthyNB70](http://wiki.netbeans.org/NewAndNoteworthyNB70)

Hasta el siguiente apunte!!
