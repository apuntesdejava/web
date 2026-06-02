---
layout: post
title: "Recomendaciones para el manejo de excepciones"
date: 2013-01-23T00:25:00.002Z
last_modified_at: 2013-01-23T00:25:47.801Z
author: "Diego Silva Límaco"
permalink: /2013/01/recomendaciones-para-el-manejo-de.html
canonical_url: https://www.apuntesdejava.com/2013/01/recomendaciones-para-el-manejo-de.html
tags:
  - "logging"
  - "tips"
  - "log4j"
---

[![]({{ '/assets/blogger/exclamation-mark.jpg' | relative_url }})]({{ '/assets/blogger/exclamation-mark.jpg' | relative_url }})

Cuando se programa, es necesario manejar las excepciones, controlarlas y aprovechar su información.

Considero que hay tres malas prácticas que se deben evitar cuando queremos usar un método que lanza un excepción manejada.

Antes de continuar con este apunte, vamos a repasar lo que es una excepción.

Las excepciones son caminos alternos que puede tener un programa. Es mal llamado "error", ya que un programa solo hace lo que le indican. El que tiene el error es el usuario o el programador.

Si tratamos de manejar todos los flujos alternos de un proceso, nuestro programa se llenará de puros "if" y se perdería el flujo principal de la rutina. Consideremos este pequeño fragmento para poder abrir un archivo, si usamos puros "if"

```java
private InputStream openFile(String fileName){
  if (FileSystemUtil.isExists(fileName)){ //supongamos que existe esta clase
    return new FileInputStream(fileName);
  }
  long status=FileSystemUtil.create(fileName);
  switch(status){
    case NO_ENOUGH_SPACE: System.err.println("no hay espacio");
    case LOCKED_PATH: System.err.println("Carpeta bloqueda");
//....
  }
  return null;

}
```

Y luego, el método que llama este anterior método, debería poder identificar cual fue el error, o peor aún, nos atreveríamos a tener una variable global para saber qué error sucedió. Y el método solo debería abrir y/o crear el archivo.

Ahora, si usamos excepciones, puede reducirse a esto:

```java
private InputStream openFile(String fileName)throws NoEnoughSpaceException,LockedPathException{
  InputStream is=null;
  try{
    is= FileInputStream(fileName); //tratamos de abrirlo
  }catch(FileNotExistsException ex){ //si manda excepcion de no existe..
    is=FileSystemUtil.create(fileName);//.. tratamos de abrirlo.. y puede devolver alguna excepcion

    }
  }
  return is; //devuelve lo que haya pasado en la rutina
}
```

Entonces, el método que lo llama podría terminar así:

```java
//..
   try{
     InputStream is=openFile(fileName); //aqui puede lanzar una excepcion...
     procesar(is); //... y si no, continua con el proceso
   }catch(NoEnoughSpaceException ex){ //.. pero si pasa alguna excepcion...
    System.err.println("Error de hay espacio"); //.. mostramos los mensajes...

   }catch(LockedPathException ex){
    System.err.println("Error de carpeta bloqueda");
    unlockPath(); //.. y quizas hasta desbloquear la carpeta.
   }
//..
```

Así el código es más ligero y entendible.

Ahora bien, hay dos tipos de excepciones: las **manejables **y las **no manejables**.

Las **manejables **son las que necesariamente tienen que estar dentro de un try/catch o el método que lo invoca debe tener la clausula "throws" con las clases excepciones que se tiene que devolver. Las excepciones manejables son clases que se heredan de `java.lang.Exception`.

Las **no manejables** son las que no es obligatorio atraparlas por un `try/catch`. Estas clases heredan de `java.lang.RuntimeException`.

**¿cuándo usar uno u otro?** Depende del diseño del programa: si es necesario, la ponemos manejable..  y sino, no.

**Las malas prácticas** que considero las peores para el manejo de excepciones, son las siguientes.

- **No poner nada en el catch**. Esto es típico de novato, y es que hay que entenderlo.. aún no sabe la importancia de un catch. Por ejemplo, quiere hacer una conexión a base de datos, y justo no tiene el driver o no está bien la contraseña... el programa lanza la excepción, y como no sale nada en la pantalla, piensa "no tiene error, pero mi programa no se conecta".. y comienza a buscar en los foros para ver la solución.

- **Excepciones genéricas**. Es vez de colocar un catch por cada excepcion que lanza, se mal acostumbra atraparlo con la clase Exception (la clase padre de toda excepcion). Entonces, cuando suceda una excepción, no se sabrá qué hacer. Esta mala práctica está asociada con otra igual de peor: la de colocar mensajes escuetos en el catch. Mensajes como

```java
try{
    //...
  }catch(Exception ex){
    System.out.println("Error");
  }
```

Dudo mucho que así uno pueda detectar su posible error.

- **throws, throws y más throws.** Esto lo he visto generalmente en aplicaciones web. Cuando hay una excepción en un método, en vez de tratarla, le ponen un throws a su método, y luego al que lo llamó le pone otro throws.. y así.. al final no tiene ni un catch. El programador pensará que no habrá problema... pero cuando aparezca el mensaje "ERROR EXCEPTION" en su misma página, además de entrar en pánico, tendrá una mala impresión ante su jefe o cliente.

**Mis recomendaciones**.

Primero... evitar lo anterior. El punto 2 es era un poco más pesado, porque si en un método podemos capturar cerca de 10 excepciones, hacer 10 catch uno de bajo de otro, realmente aburre. Pero, en **Java 7 **ya esto se puede manejar de una manera más simple: Si vas a manejar las excepciones de la misma manera, agrupalas así en el catch.

```java
try{
    //...
  }catch(Exception1 | Excepcion2 | Exception3 ex){ //nuevo en java 7
    System.out.println("Error ");
  }
```

Otra recomendación que doy, es, evitar imprimir el sabanón de la pila de llamadas. **Solo si es necesario**, hacer esto

```java
try{
    //...
  }catch(Exception1   ex){
    ex.printStackTrace();
  }
```

Ya que así se podría saber donde ocurrió el error y quien lo llamó.

Pero si no es necesario obtener todo el sabanón, mostrar solo el mensaje de error:

```java
try{
    //...
  }catch(Exception1   ex){
    System.err.println("Error :"+ex.getMessage());
  }
```

Y mi última recomendación: no usar `System.err` ni `System.out` para mostrar el mensaje de error. En su lugar usar algún Logger. Puede ser el `java.util.Logger` o el Log4j (que hace tiempo publiqué un [artículo aquí]({{ '/2006/02/log4j.html' | relative_url }}), y aún es válido). Lo importante de usar un logger, es que los mensajes de errores ya están separados por niveles importancia, y si es necesario mostrar algún nivel, se puedes activar o desactivar de acuerdo al caso. Y cuando entre en producción, no mostraría ni un mensaje, o solo lo necesario. Recomiendo leer el artículo [Log4j]({{ '/2006/02/log4j.html' | relative_url }}) para más detalles de esto.

Espero que les sea de utilidad.

Nos vemos en el siguiente apunte
