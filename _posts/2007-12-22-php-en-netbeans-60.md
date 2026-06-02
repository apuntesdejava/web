---
layout: post
title: "PHP en NetBeans 6.0"
date: 2007-12-23T02:24:00Z
last_modified_at: 2009-04-25T21:55:03.299Z
author: "Diego Silva"
permalink: /2007/12/php-en-netbeans-60.html
canonical_url: https://www.apuntesdejava.com/2007/12/php-en-netbeans-60.html
tags:
  - "php"
  - "netbeans"
---

PHP es un lenguaje de programación basado en scripts muy popular, fácil de aprender, de desplegar, es multiplataforma (igual que java, solo necesita de un programa que interprete el lenguaje para que lo convierta a la plataforma ya sea Linux, Windows o cualquiera), y sobretodo... es libre.

No tiene un IDE específico, por lo que es necesario navegar por la documentación para recordar las sentencias... a menos que uno tenga buena memoria para recordarlas todas. Lo que está de moda en los IDEs es la coloración de sintaxis y el autollenado de sentencias.

Existen varios IDEs que están apostando por este lenguaje que no es nada nuevo. Uno de ellos es [CodeGear](http://www.codegear.com/) con su [Delphi for PHP](http://www.codegear.com/products/delphi/php). Y [Eclipse](http://www.eclipse.org/) tiene un subproyecto que esta trabajando en un plugin para manejar PHP llamado [PHP Development Tools](http://www.eclipse.org/pdt/).

La gente de NetBeans - por su puesto - no se queda atrás. Por lo que en el NetBeans 6.0 han puesto a disposición un plugin (a la fecha de este post) en versión beta.

Veremos como configurarlo, y haremos una simple aplicación con PHP. No voy a dedicarme a enseñar PHP, ya que este blog no es para aprender PHP :P

## Instalando el plugin de PHP

En el NetBeans 6.0 entramos a la opción Tools > Plugins y buscamos de la sección "Available Plugins" a PHP de categoría Scripting. Activamos su check...
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCQ5w4BUyj3NW35rjiyGFM1zs5N7yfT86V0wKqQp3uVNTFGKI_WuA5Iv_nOSWYTFzQj3L7CH6NJDaF2XaCSnhkYt_dL6BXD9P0EoFZbLlpx9zXTwzTvCpC-kw-01T01y7uHps6f3CncVxJ/s320/Pantallazo-Plugins.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCQ5w4BUyj3NW35rjiyGFM1zs5N7yfT86V0wKqQp3uVNTFGKI_WuA5Iv_nOSWYTFzQj3L7CH6NJDaF2XaCSnhkYt_dL6BXD9P0EoFZbLlpx9zXTwzTvCpC-kw-01T01y7uHps6f3CncVxJ/s1600-h/Pantallazo-Plugins.png)

...  y hacemos clic en el botón Install. Aceptamos las ventanas que se nos muestra, descargará lo necesario del plugin (el plugin en sí, así como su documentación, etc)...
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjv3Q-UgLoEMF4XxkCoAQLSqC-VsFEFsotb4mpASg5pusEMEmwR0XdgMXJpFqAbSrRbR09Jml1YWvk2Nr2WQXJtkt9vlglcjWHQfr_pW7jRZPxRQLulOrTwAE1toNWqnvfirmhnKAgwNotY/s320/Pantallazo-NetBeans+IDE+Installer.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjv3Q-UgLoEMF4XxkCoAQLSqC-VsFEFsotb4mpASg5pusEMEmwR0XdgMXJpFqAbSrRbR09Jml1YWvk2Nr2WQXJtkt9vlglcjWHQfr_pW7jRZPxRQLulOrTwAE1toNWqnvfirmhnKAgwNotY/s1600-h/Pantallazo-NetBeans+IDE+Installer.png)
... y aceptamos reiniciar el IDE para cargar el plugin.

## Configurando nuestro computador para que funcione PHP

El PHP necesita de un servidor web para que funcionen los scripts. PHP puede configurarse sobre Apache Server (muy recomendado) o sobre IIS. Así que nos centraremos en instalar el Apache Server con el PHP.

### Apache + PHP sobre Linux

Si eres un linuxero, no tienes porque leer esta parte, pero aún así, es bueno recodarlo: si usas Centos, Fedora o similar.. usa el comando yum. Si usas Ubuntu, Debian o similar, usa apt

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyf5_oRNP4L10yUQCDCwp8kRHbixxqXba-rcVKC89D0Q9JxP29Kkbt6snnNHASNQ8U4T_aSuAsWyc3bYb6SnNDIQ1wJFuE_-AyEkCnXXVt6w0VThh1v-FaEkWI3Oet2l2hh5775fCr_Ypc/s320/Pantallazo-diego@diego-desktop:+%7E.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyf5_oRNP4L10yUQCDCwp8kRHbixxqXba-rcVKC89D0Q9JxP29Kkbt6snnNHASNQ8U4T_aSuAsWyc3bYb6SnNDIQ1wJFuE_-AyEkCnXXVt6w0VThh1v-FaEkWI3Oet2l2hh5775fCr_Ypc/s1600-h/Pantallazo-diego@diego-desktop:+%7E.png)
Probemos como se ve en el navegador, y recordemos la carpeta que se publica.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhXZ_cDsvFPSKr6IzlMYzYdWD_O_oFWWBXTkhTu4EHafS7J0FRDLUTMtgnGIuNaAV5PUfV0TcvLCytfu2ko11eYxVXJTSn8koItcwXpWNafbCNgNnMQlhbk5Zfr__625h8tR27PZ_wrfvwZ/s320/Pantallazo-Mozilla+Firefox.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhXZ_cDsvFPSKr6IzlMYzYdWD_O_oFWWBXTkhTu4EHafS7J0FRDLUTMtgnGIuNaAV5PUfV0TcvLCytfu2ko11eYxVXJTSn8koItcwXpWNafbCNgNnMQlhbk5Zfr__625h8tR27PZ_wrfvwZ/s1600-h/Pantallazo-Mozilla+Firefox.png)... aquí se publica en /apache2-default

### Apache + PHP sobre Windows

Existen software ya empaquetados que permiten instalar toda la plataforma WAMP (Windows + Apache + MySQL + PHP) y no tendríamos que preocuparnos en como configurar estos software. Uno de ellos es [WampServer](http://www.wampserver.com/en/). Pero personalmente opino que es mejor que uno mismo lo configure. Solo bastaría descargar el [Apache Server](http://httpd.apache.org/), el [PHP 5](http://www.php.net/) (el que está en .zip) y leer la documentación de como[instalarlo en windows con apache2](http://www.php.net/manual/es/install.windows.apache2.php).

## Creando proyecto en Netbeans 6.0

Creamos un nuevo proyecto y seleccionamos en las categorías a PHP, como proyecto a "PHP Project".
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhw1hghGe0Drriko1cahD1nLFuIL5b7e4VHfp2yM408OAYsczRWK1nU0yXaLoWfp7-6DcBoAuVPzbcZhJ7AcdAWKykuhSpckfA_anH80IJkulkH19cKiH4reE6PJI5IY7zeJyVRyf0cZxiT/s320/Pantallazo-New+Project.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhw1hghGe0Drriko1cahD1nLFuIL5b7e4VHfp2yM408OAYsczRWK1nU0yXaLoWfp7-6DcBoAuVPzbcZhJ7AcdAWKykuhSpckfA_anH80IJkulkH19cKiH4reE6PJI5IY7zeJyVRyf0cZxiT/s1600-h/Pantallazo-New+Project.png)... clic en "Next".
Escribimos como nombre de proyecto HelloPhpProject. También indicamos en que carpeta deseamos crear el proyecto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjtHW01fOSuzWU6M45reKVdXh9_noVvgs5wA2LppkE2IOFJhWQO0bIhOEB87KKpVJ1TvW0-uR05wxIkXQ3FJtVKHGwxfGnxcNdCKBdNOnEpk2qqLbmWTMXR9UpGSJdFIrFuna1SJ1wQBnMA/s320/Pantallazo-New+PHP+Project.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjtHW01fOSuzWU6M45reKVdXh9_noVvgs5wA2LppkE2IOFJhWQO0bIhOEB87KKpVJ1TvW0-uR05wxIkXQ3FJtVKHGwxfGnxcNdCKBdNOnEpk2qqLbmWTMXR9UpGSJdFIrFuna1SJ1wQBnMA/s1600-h/Pantallazo-New+PHP+Project.png)... clic en "Next".
A continuación nos mostrará qué servidor web se usará.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEicphZd96hIY6aQ2-zPtR-5L-WnOximTiCNHZkLNaOSmQ5MrD7cYo4Z1FZNR91FvlGhAMDViBhx9JjMA0wKnNgB1pL7OABZgrdp1LlJFTq2-a28CbzsiRiSR2XbPRErcAq8xr4MmmD9BBed/s320/Pantallazo-New+Project-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEicphZd96hIY6aQ2-zPtR-5L-WnOximTiCNHZkLNaOSmQ5MrD7cYo4Z1FZNR91FvlGhAMDViBhx9JjMA0wKnNgB1pL7OABZgrdp1LlJFTq2-a28CbzsiRiSR2XbPRErcAq8xr4MmmD9BBed/s1600-h/Pantallazo-New+Project-1.png)
Ya que es nuestra primera vez que estamos usando el NetBeans para PHP, haremos clic en "Manage".

Nos mostrará la ventana para registrar el servidor web. Hay dos tipos de publicación: si está accesible desde una unidad de disco (por mapeo de una carpeta remota o si está en nuestro computador) o si es accesible vía ftp. Esto es lo que nos esta preguntando en esta ventana.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgypa__JCq2SjtvTH02cTaTXttcK_owJmgTmFxS81d08YaVMkOiedYJWrJczvrWE_ayDu7geTSJxtjLymkZLlbJkRRZHGfgkAZISQoom91MWJ3RyHkX6SJ9mhhliLDSI0dIOpcNuE6dM8io/s320/Pantallazo-Add+New+Web+Server+Record.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgypa__JCq2SjtvTH02cTaTXttcK_owJmgTmFxS81d08YaVMkOiedYJWrJczvrWE_ayDu7geTSJxtjLymkZLlbJkRRZHGfgkAZISQoom91MWJ3RyHkX6SJ9mhhliLDSI0dIOpcNuE6dM8io/s1600-h/Pantallazo-Add+New+Web+Server+Record.png)
Así que escribiremos en Connection name "Local Web Server" y como tipo de servidor "Local web Server with file Access", ya que tenemos el apache server en nuestro computador.  Clic en 'Next'.

Luego nos pide el archivo de configuración de Apache Server. Como estoy en Ubuntu, le selecciono el apache2.conf

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiU9GYaiE7k_P8DCHRpWueIIqDEm_yC2PbWIiQGCEDcir27bf1xKzfQT9txpBbMsgwib-TxxE6TOI-TKSvP1GSCAMpLWtNQahqaEdAGT4i7ZmZCqjnpFT_tH_5qs_3NiPUcMnmMQ09JGwzo/s320/Pantallazo-Add+New+Web+Server+Record-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiU9GYaiE7k_P8DCHRpWueIIqDEm_yC2PbWIiQGCEDcir27bf1xKzfQT9txpBbMsgwib-TxxE6TOI-TKSvP1GSCAMpLWtNQahqaEdAGT4i7ZmZCqjnpFT_tH_5qs_3NiPUcMnmMQ09JGwzo/s1600-h/Pantallazo-Add+New+Web+Server+Record-1.png)Esto es porque buscará cierta configuración sobre directorios virtuales y demás. Pero en Ubuntu se usa apache2.2 y pues la configuración está delegada a otros archivos, y eso no lo puede interpretar el NetBeans... por eso aún es beta.

Clic en "Next"

Colocaremos el nombre del servidor y el puerto que utilizará, así como la carpeta que utilizará para la publicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiFvnPCZioHIiLcBG4n5uyQuWKFXwF3UsvTQOKhlc04XniVIwQHD4qZvX2AhGWrqnQbjMWX-Co9jkiN4fxyf__5FLbNZUDcLfqwNsxXj9tNu4Y15saYbVevSz_Y52CdJm_RHn3OYkmfX_N4/s320/Pantallazo-Add+New+Web+Server+Record-2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiFvnPCZioHIiLcBG4n5uyQuWKFXwF3UsvTQOKhlc04XniVIwQHD4qZvX2AhGWrqnQbjMWX-Co9jkiN4fxyf__5FLbNZUDcLfqwNsxXj9tNu4Y15saYbVevSz_Y52CdJm_RHn3OYkmfX_N4/s1600-h/Pantallazo-Add+New+Web+Server+Record-2.png)
Esta información lo usará el NetBeans al lanzar la aplicación para ejecutarla.
Clic en 'Next'.

Ahora, indicaremos la carpeta de nuestro disco donde estarán ubicados los archivos que se publicarán.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2hLU_WzHhQ3L-mLaTUf7fIBtL-cq3ttXFTvJpvNkmrjWN6YWYSCXIRuqwZ-1ZCMwqhEHBJtrGFys1D_NtaHVSkf6Vt7qrmFig_sCwFXEABL8Joq3p6QtsAmzdrL-M7NqxmZ6rnbJ33i4N/s320/Pantallazo-Add+New+Web+Server+Record-3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2hLU_WzHhQ3L-mLaTUf7fIBtL-cq3ttXFTvJpvNkmrjWN6YWYSCXIRuqwZ-1ZCMwqhEHBJtrGFys1D_NtaHVSkf6Vt7qrmFig_sCwFXEABL8Joq3p6QtsAmzdrL-M7NqxmZ6rnbJ33i4N/s1600-h/Pantallazo-Add+New+Web+Server+Record-3.png)
Recordemos que debe ser la carpeta que está asociada a la carpeta pública de internet. En el caso de ubuntu, este se encuentra en /var/www/apache2-default
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgxiVSQH8kFD0ehOQ0UKM3CEH6uevLxd1fEIE2pEeokTWXmLVc0GkkhVhM8HOBp6XKUxPq4jgEzRDM85cUuhsY5NdWzbT_juO-CfMX-sDr_u-TOHqHU1wew-eGw86rUnAjKgYsRlEmmvCpX/s320/Pantallazo-Select+Document+Root+Directory.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgxiVSQH8kFD0ehOQ0UKM3CEH6uevLxd1fEIE2pEeokTWXmLVc0GkkhVhM8HOBp6XKUxPq4jgEzRDM85cUuhsY5NdWzbT_juO-CfMX-sDr_u-TOHqHU1wew-eGw86rUnAjKgYsRlEmmvCpX/s1600-h/Pantallazo-Select+Document+Root+Directory.png)Clic en 'Finish'.
Nota: Recordemos tener los permisos necesarios para guardar archivos.

Ahora que ya hemos creado nuestro configuración del servidor web para NetBeans, lo seleccionamos:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrlUfPuKOAUbIBQ09-hf5vz_xgIl7zld0gaDqf7aSpKkBzUT4F6kmmh3kT9hHg4Z22PY8LzaB-bIUEIbgaidkyxyuZY_mKSoam2w9I41QRy8cpjstKWHYpCmGY3YDM4LX97CsvJbjDjS77/s320/Pantallazo-Manage+Web+Servers.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrlUfPuKOAUbIBQ09-hf5vz_xgIl7zld0gaDqf7aSpKkBzUT4F6kmmh3kT9hHg4Z22PY8LzaB-bIUEIbgaidkyxyuZY_mKSoam2w9I41QRy8cpjstKWHYpCmGY3YDM4LX97CsvJbjDjS77/s1600-h/Pantallazo-Manage+Web+Servers.png)
Clic en 'OK'

Ahora veremos como lucirá la aplicación en ejecución.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8rECeRYBVbUGM873Re0Z1wY9YjFs7Iecvgpg4bOND_tWtCSsF4kcH_lGU4Rnax8hEm7EjQoUA_krVkPp7_9fJBYf6kRDFmOKh7fllQ06MV28vX8Qxsz1CqRRcveAIRAa8uj972am9sImT/s320/Pantallazo-New+Project-2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8rECeRYBVbUGM873Re0Z1wY9YjFs7Iecvgpg4bOND_tWtCSsF4kcH_lGU4Rnax8hEm7EjQoUA_krVkPp7_9fJBYf6kRDFmOKh7fllQ06MV28vX8Qxsz1CqRRcveAIRAa8uj972am9sImT/s1600-h/Pantallazo-New+Project-2.png)La ruta del contexto es /HelloPhpProject
La ruta web será: http://localhost:80/apache2-default/HelloPhpProject
y se creará la carpeta para los archivos: /var/www/apache2-default/HelloPhpProject

Estamos de acuerdo que así será y tiene mucho sentido que así debe funcionar.

Clic en 'Finish'
Y ya, tenemos nuestro proyecto de PHP con un index.php listo para editar.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjMCnDMOYIeVy-zAVGsu1jwnS3zHMfOF6bZ6deCaBxvClK2GgCVcJQrlpmjQ3AdkAEDEZJN1FGUgZJ31MQBp5hLNBE8KS-cf5TP_bo2Wl8Bb1Daw2EiryCk4y9Bpx_2nDKgfaevwQXLtNBL/s320/Pantallazo-HelloPhpProject+-+NetBeans+IDE+6.0.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjMCnDMOYIeVy-zAVGsu1jwnS3zHMfOF6bZ6deCaBxvClK2GgCVcJQrlpmjQ3AdkAEDEZJN1FGUgZJ31MQBp5hLNBE8KS-cf5TP_bo2Wl8Bb1Daw2EiryCk4y9Bpx_2nDKgfaevwQXLtNBL/s1600-h/Pantallazo-HelloPhpProject+-+NetBeans+IDE+6.0.png)

## Haciendo nuestro primer formulario

No es cosa del otro mundo programar en PHP, así que haremos una simple aplicación que consistirá en un formulario donde se registran nombres y se muestra una lista de los mismos.

Pues bien, escribiremos un formulario con una sola entrada llamada nombre.

Vemos que al escribir los tags, el IDE nos mostrará las sugerencias y los atributos de los mismos.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiAPQ0uYIhS8kUjgXGh5i3VKeN3Sb0Yap_RZltOri9-po_tmQMzLjlrAmbLfm1i5ZHjUEzyphvdmnyeZnZUklkELXVwCrkrkZrOh58Jux4UaJoUT4Pf6C0Tgi1JfIYdMl6DAO47zPnaolgr/s320/Pantallazo-HelloPhpProject+-+NetBeans+IDE+6.0-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiAPQ0uYIhS8kUjgXGh5i3VKeN3Sb0Yap_RZltOri9-po_tmQMzLjlrAmbLfm1i5ZHjUEzyphvdmnyeZnZUklkELXVwCrkrkZrOh58Jux4UaJoUT4Pf6C0Tgi1JfIYdMl6DAO47zPnaolgr/s1600-h/Pantallazo-HelloPhpProject+-+NetBeans+IDE+6.0-1.png)Tratemos de escribir el siguiente código y veremos como se va autoescribiendo el código necesario.

```java
<code><?php session_start();?><br /><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><br /><html><br /><head><br />    <title></title><br /></head><br /><body><br />    <form action="index.php" method="post"><br />        Nombre: <input type="text" name="nombre" /><br/><br />        <input type="submit" /><br />    </form><br />    <?php<br />    $lista=$_SESSION["lista"];<br /><br />    if ($nombre=$_POST["nombre"]){<br />        $lista[]=$nombre;<br />    }<br />    if ($lista){<br />        echo "<ul>";<br />        foreach ($lista as $elem) {<br />                echo "<li>$elem</li>";<br />            }<br />        echo "</ul>";<br />    }<br />    $_SESSION["lista"]=$lista;<br />    ?><br /></body><br /></html><br /><br /></code>
```

## Ejecutando el programa

Como todo proyecto en NetBeans, bastará con presionar la tecla F6. Se ejecutará nuestro navegador, y veremos ejecutar el proyecto tal cual lo hemos programado.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgTb95qSe9aLFkkuEOYxw-f603xA6FQOlF4OMdK90mJq8L021ZfYXYWMKy3do85eJiumn8ja-yGoidORGRGGjO1Yc85-7yBO4ZazGhgErO0JmAU6kegvvqxLjaKPJoFSK6-YSgOSry3Q60f/s320/Pantallazo-Mozilla+Firefox-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgTb95qSe9aLFkkuEOYxw-f603xA6FQOlF4OMdK90mJq8L021ZfYXYWMKy3do85eJiumn8ja-yGoidORGRGGjO1Yc85-7yBO4ZazGhgErO0JmAU6kegvvqxLjaKPJoFSK6-YSgOSry3Q60f/s1600-h/Pantallazo-Mozilla+Firefox-1.png)

## Para terminar...

Físicamente, los archivos están dentro del directorio del proyecto que se definió al momento de crearse. Al momento de ejecutar el proyecto, lo que hace NetBeans es copiar la carpeta del proyecto con todos sus archivos y los coloca en el directorio del Apache Server. Si volvemos a ejecutar el proyecto, volverá a copiar los archivos. Así que si editamos el archivo y lo guardamos, no podremos verlo en el navegador hasta que presionemos la tecla F6, o ejecutemos el proyecto.
