---
layout: post
title: "Empaquetar una aplicación para distribuir, desde NetBeans"
date: 2010-06-08T05:00:00.001Z
last_modified_at: 2016-04-16T00:04:16.379Z
author: "Diego Silva"
permalink: /2010/06/empaquetar-una-aplicacion-para.html
canonical_url: https://www.apuntesdejava.com/2010/06/empaquetar-una-aplicacion-para.html
description: "Uno de los tantos motivos por lo que utilizo NetBeans en lugar de otro IDE, es que utiliza la Apache Ant para compilar, crear .jar .war .ear, javadoc, etc.. prácticamente para todo, y solo usando un archivo .xml. Y lo mejor es que se puede personalizar el .xml a nuestro antojo.  En este post se va a explicar cómo empaquetar una aplicación Swing en un archivo .zip para ser distribuido a los usuarios finales."
tags:
  - "swing"
  - "ant"
  - "tutorial"
  - "netbeans"
  - "tips"
  - "trucos"
---

[![]({{ '/assets/blogger/ant-logo.png' | relative_url }})]({{ '/assets/blogger/ant-logo.png' | relative_url }})

Uno de los tantos motivos por lo que utilizo NetBeans en lugar de otro IDE, es que utiliza la [Apache Ant](http://ant.apache.org/) para compilar, crear .jar .war .ear, javadoc, etc.. prácticamente para todo, y solo usando un archivo .xml. Y lo mejor es que se puede personalizar el .xml a nuestro antojo.

En este post se va a explicar cómo empaquetar una aplicación Swing en un archivo .zip para ser distribuido a los usuarios finales.

### ¿Qué hace NetBeans?

Si al hacer una aplicación Swing con NetBeans utilizamos diversas bibliotecas adicionales, el IDE nos puede crear una carpeta lista para distribuir a los usuarios incluyendo todas los .jars necesarios. Para ello hacemos clic derecho sobre el ícono del proyecto y seleccionamos "Build" (o Clean and Build)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg81yocnJ3LA8JJQf8BPxyazPZw4cWvo55175TO6ZxccGDF8szdJ3oevegNlIHLrbH_yAZGsF1vYWJKsXcaVGkE3s6Me2kMfjRVBP5Wsn81aQJf51HJburAkUCvB4eay50JuLfxFodTVEiz/s320/ant01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg81yocnJ3LA8JJQf8BPxyazPZw4cWvo55175TO6ZxccGDF8szdJ3oevegNlIHLrbH_yAZGsF1vYWJKsXcaVGkE3s6Me2kMfjRVBP5Wsn81aQJf51HJburAkUCvB4eay50JuLfxFodTVEiz/s1600/ant01.jpg)

 Al hacer esto, el NetBeans compila, y construye la carpeta "dist" para distribuir. Esta carpeta se encuentra en la misma carpeta del proyecto. Podemos verla en el panel "Files" del NetBeans (Teclas Ctrl+2)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhl0sosbhIk5N-GHg3dF6wlTVy0zB_TgEx2T4_pfll8KVTIsaBe7djl627rzjbYLcXHwHy-ym3WwTu_iZ3n4wFGkTC7fmHgIuoBR0JdOLXQWg_Q7EVopeTGOqxT1Ihyphenhyphen9a8mfi_onkK__-V1/s1600/ant02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhl0sosbhIk5N-GHg3dF6wlTVy0zB_TgEx2T4_pfll8KVTIsaBe7djl627rzjbYLcXHwHy-ym3WwTu_iZ3n4wFGkTC7fmHgIuoBR0JdOLXQWg_Q7EVopeTGOqxT1Ihyphenhyphen9a8mfi_onkK__-V1/s1600/ant02.jpg)

Ahora bien ¿qué hacemos con ese .jar? En el README.TXT lo explica. Pero NetBeans también lo dice en el panel "Output" (Ctrl+4) después de construir la aplicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoYAqBcsa6-IWwBuS7snzaaDceZpiiWsa2ASaHNYWKNeGoR03TxhNq0h-IXikax62v7_5lue_CHVDnrjJTbXcIfeaQZORb6UQEuduXJqfZbkNmCaeicm-COZBqZjyion9DSCA6hYpc_CDp/s400/ant03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoYAqBcsa6-IWwBuS7snzaaDceZpiiWsa2ASaHNYWKNeGoR03TxhNq0h-IXikax62v7_5lue_CHVDnrjJTbXcIfeaQZORb6UQEuduXJqfZbkNmCaeicm-COZBqZjyion9DSCA6hYpc_CDp/s1600/ant03.jpg)

"Para ejecutar esta aplicación desde la línea de comandos sin usar Ant, intente:..." y luego dice cuál es el comando que se tiene que hacer.

Si copiamos esa línea, abrimos la ventana del Símbolo del Sistema, y pegamos esa instrucción para ejecutarlo, pues nos ejecutará la aplicación sin problemas. Es más, se podría copiar a los usuarios finales este directorio "dist" y decirles que si quieren ejecutarlo hagan esto: abrir una ventana del Símbolo del Sistema, escribir esa instrucción  y listo.........creo que al usuario no le va a gustar hacer esto ¿Por qué no mejor hacer un programa que al hacer doble clic ya se ejecuté? Buena idea.

### Creando un .bat

De por sí, se puede hacer doble clic al archivo .jar para ejecutar la aplicación, pero funciona si es que en el computador del usuario no tiene algún descompresor de archivos asociado a los archivos .jar. Por ejemplo, si se tiene instalado el WinRAR, al hacer doble clic sobre el archivo .jar, en lugar de que se ejecute, se abrirá el WinRAR y mostrará el contenido del .jar... esto no es lo que queremos. La mejor manera es crear un archivo .bat que haga la llamada al comando java -jar bla bla

Esto le podemos decir al NetBeans que lo haga. Para ello, entramos al panel "Files" (Ctrl+2) y buscamos el archivo `build.xml`. Este es una extensión al .xml que utiliza el NetBeans para construir la aplicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKAXclApv930gIDlUBKoa8SZ6lB1qDa85Y2E99J1XxG1R3QD4FRUslSN1EKEYhOeNCL4W3QY2t4cGand4K1wOeU0Orn4nUGbPXG_BGQuvs5x6qBNkCF6zlt6hqC9hyI-69fB995pkBc_bC/s1600/ant04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKAXclApv930gIDlUBKoa8SZ6lB1qDa85Y2E99J1XxG1R3QD4FRUslSN1EKEYhOeNCL4W3QY2t4cGand4K1wOeU0Orn4nUGbPXG_BGQuvs5x6qBNkCF6zlt6hqC9hyI-69fB995pkBc_bC/s1600/ant04.jpg)

 Abrimos este archivo, lo revisamos un poco (todo está comentado y hay algunas instrucciones) y pondremos el tag `<target name='-post-jar'/>` que nos permitirá realizar una tarea después de que el NetBeans haya creado el .jar

```java
<code>    <target name="-post-jar">        <echo file="${dist.dir}/run.bat">java -jar ${application.title}.jar</echo>    </target> </code>
```

El tag de la tarea `[](http://ant.apache.org/manual/Tasks/echo.html) ` crea una salida a la consola, pero con el atributo `file` le estamos diciendo que la salida lo haga a un archivo. Para saber cuáles son los valores de las variables utilizadas en la construcción del proyecto, podemos revisar el archivo `nbproject/project.properties`.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhrbSgJPbqC0GBU6ILw1NWsL4m7QZdIAaKWU3SIM7e5dwF4_tWGuR8PSFKXuqM11VhOsklq_hVIjKt71bQjfrA0AyFi8N-VYF7dtJZNp8UOIbBFWb0N7-RKxqgsZ-Y9bPkt-oC9hgIhqIyW/s1600/ant04a.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhrbSgJPbqC0GBU6ILw1NWsL4m7QZdIAaKWU3SIM7e5dwF4_tWGuR8PSFKXuqM11VhOsklq_hVIjKt71bQjfrA0AyFi8N-VYF7dtJZNp8UOIbBFWb0N7-RKxqgsZ-Y9bPkt-oC9hgIhqIyW/s1600/ant04a.jpg)

Por ello utilicé las variables `dist.dir, application.title`.

Ahora bien, hagamos un "Build" al proyecto y veamos lo que hizo en la carpeta `dist`.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj9y0O34BbaQniqc0AhyeZKuGtcA1AHEczrVdBF6MjF3_C_I2QpCT8zCsslUlvDWDqk1BUR_QJowAVQy01BBvg1SfzsWwUMHL7NfhO7yS4C7mKx9nBRgjrjGyvCjQPpOeQ1XvQqQtW4erv6/s1600/ant05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj9y0O34BbaQniqc0AhyeZKuGtcA1AHEczrVdBF6MjF3_C_I2QpCT8zCsslUlvDWDqk1BUR_QJowAVQy01BBvg1SfzsWwUMHL7NfhO7yS4C7mKx9nBRgjrjGyvCjQPpOeQ1XvQqQtW4erv6/s1600/ant05.jpg)

 Y si vemos el contenido será justamente lo que hemos pensado. Abrimos una ventana del explorador de windows, y le damos doble clic al .bat. Listo, usuario satisfecho.

Pero.. sale una ventana negra fea con el comando de ejecución de la aplicación. Bueno, esto se puede solucionar. Podemos reemplazar la instrucción

```java
<code><echo file="${dist.dir}/run.bat">java -jar ${application.title}.jar</echo></code>
```

Por

```java
<code><echo file="${dist.dir}/run.bat"><span style="color: blue;">start javaw</span> -jar ${application.title}.jar</echo></code>
```

El comando de Windows `start` permite ejecutar una aplicación y "soltarlo" para que se ejecute como un proceso más del Sistema Operativo. Y el comando `javaw` es un comando adicional al JRE que permite ejecutar una aplicación java sin mostrar una ventana del Símbolo del Sistema.

Bien, ahora solo nos bastaría con copiar a los usuarios finales el .bat, el .jar y las bibliotecas adicionales so hubiera. Lo empaquetamos y se lo enviamos.

¿Hay un poco de flojera para comprimir los archivos? ¿y si me falta uno?

### Creando un .zip

El Ant también permite comprimir archivos usando la tarea [](http://ant.apache.org/manual/Tasks/zip.html). Es realmente fácil.

Creamos el siguiente tag después del `<echo />`.

```java
<code>        <zip destfile="${dist.dir}/${application.title}.zip" basedir="${dist.dir}" /></code>
```

Hagamos "Clean and Build" al proyecto, y listo, ya tenemos nuestro archivo .zip para enviar a los usuarios finales.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-P5m-EUAcMHprExmCqcMx6MMyY7QI3J5WdzGA27S4HMRRhbaTka7dkXS5alW828RzNkjk2Z9tpcaj_03GGpkXe24HhEicxnNzaI694FENRzJ5GO0A3DsT5iEkbgvxBF27M6Mxw9wJsLBb/s1600/ant06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj-P5m-EUAcMHprExmCqcMx6MMyY7QI3J5WdzGA27S4HMRRhbaTka7dkXS5alW828RzNkjk2Z9tpcaj_03GGpkXe24HhEicxnNzaI694FENRzJ5GO0A3DsT5iEkbgvxBF27M6Mxw9wJsLBb/s1600/ant06.jpg)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjn4wWlm6wYItnyO6ZS7xhZqeFxCXTZRy9k0MfrKBzfrnWqUp1SV-ZTN_nSk-sfpEBrLyCV-LrDmF6VxTi5YhRATfFAA8alakz3yqV-ChU8T_IXly_7GSUm3bHKAV_EHD2Vh08H_1dBsMmp/s400/ant07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjn4wWlm6wYItnyO6ZS7xhZqeFxCXTZRy9k0MfrKBzfrnWqUp1SV-ZTN_nSk-sfpEBrLyCV-LrDmF6VxTi5YhRATfFAA8alakz3yqV-ChU8T_IXly_7GSUm3bHKAV_EHD2Vh08H_1dBsMmp/s1600/ant07.jpg)

Y les decimos "Estimados bla bla bla, descompriman el achivo .zip para ejecutar la aplicación".

¿También tenemos flojera de enviar el mail a los usuarios? `:)`

### Documentación

Si deseas conocer más tareas que vienen incluidas en el ANT, revisa la siguiente página.

- Apache Ant User Manual: [http://ant.apache.org/manual/index.html](http://ant.apache.org/manual/index.html)

Ahí está la tarea `mail`

### Proyecto

Y como de costumbre, aquí está el proyecto utilizado en este ejemplo:

- [http://java.net/downloads/apuntes/samples/netbeans/DemoSwingAntCustomized.tar.gz](http://java.net/downloads/apuntes/samples/netbeans/DemoSwingAntCustomized.tar.gz)
