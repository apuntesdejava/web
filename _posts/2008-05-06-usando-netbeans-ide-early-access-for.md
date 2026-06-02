---
layout: post
title: "Usando NetBeans IDE Early Access for PHP"
date: 2008-05-07T02:42:00Z
last_modified_at: 2009-04-25T21:55:03.342Z
author: "Diego Silva"
permalink: /2008/05/usando-netbeans-ide-early-access-for.html
canonical_url: https://www.apuntesdejava.com/2008/05/usando-netbeans-ide-early-access-for.html
tags:
  - "php"
  - "netbeans"
---

Acabo de bajar el [NetBeans IDE Early Access for PHP](http://download.netbeans.org/netbeans/6.1/final/) para ver que tal es, y a medida que voy investigando, estaré redactando este post.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhfsXnYQgwuF9mMAoMFU_Q4fNZG8c6Gf8Ll2zkBxEiVYwbuMAuE9zkFeY1C8cevKRHZIycdoS0ommetBa8VCqfDp4E0lxN5LSGPGSznW548PL9Fr-7aqjDXIvzunZiu1CxXgBLHYxuVijin/s320/nb6-php5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhfsXnYQgwuF9mMAoMFU_Q4fNZG8c6Gf8Ll2zkBxEiVYwbuMAuE9zkFeY1C8cevKRHZIycdoS0ommetBa8VCqfDp4E0lxN5LSGPGSznW548PL9Fr-7aqjDXIvzunZiu1CxXgBLHYxuVijin/s1600-h/nb6-php5.jpg)
Previamente ya tengo instalado un sistema WAMP (Windows + Apache + MySQL + PHP) Mencioné algo de cómo se instala en el anterior post [PHP en NetBeans 6.0]({{ '/2007/12/php-en-netbeans-60.html' | relative_url }})

La instalación es sencilla, solo pide la ubicación del Java y donde se debe instalar el IDE. Lo demás solo son mensajes de confirmación

## Creando un proyecto

 Entramos al menú File > New Project  ( o presionamos Shift + Ctrl + N)
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEipZVqwP0ZX08jlc_sjaM4v5E0fxLgG9tSXqq1bnHCGha31_6rnm58uz_eIGKQeJDPdlyunIRkXswdgxhUKkEh-UuHrx4Kfim67J-kEUCbg6uyMtzR9dZcr_2WEDntW63IjVSjQpbfauZZc/s320/nb6-php5-01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEipZVqwP0ZX08jlc_sjaM4v5E0fxLgG9tSXqq1bnHCGha31_6rnm58uz_eIGKQeJDPdlyunIRkXswdgxhUKkEh-UuHrx4Kfim67J-kEUCbg6uyMtzR9dZcr_2WEDntW63IjVSjQpbfauZZc/s1600-h/nb6-php5-01.jpg)
Clic en Next.  Luego nos preguntará el nombre del proyecto, donde se guardará, y cómo se publicará.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh7NSb1SSWgi37-vyqfdNfFsD0mndBK_OJSIm1uNyhbm6gWhjLcdonKAnp5oXeWLvbRFnzBZMBUqxA_IegdGhkWEtFZCh2OcYIBlmRQn1fcFQqKyglKDsT1yKGF3_u6hk4W0NoX6sZ6mrxy/s320/nb6-php5-02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh7NSb1SSWgi37-vyqfdNfFsD0mndBK_OJSIm1uNyhbm6gWhjLcdonKAnp5oXeWLvbRFnzBZMBUqxA_IegdGhkWEtFZCh2OcYIBlmRQn1fcFQqKyglKDsT1yKGF3_u6hk4W0NoX6sZ6mrxy/s1600-h/nb6-php5-02.jpg)
Esta versión tiene una variante con la versión Plugin del NetBeans 6.0. Antes, todo se trabajaba en una sola carpeta (como en los proyectos java EE) y cuando se ejecutaba, todos los archivos que estaban dentro del proyecto (imágenes, paginas, y todo archivo) se copiaba a la carpeta del servidor. Si el proyecto contenía varios archivos, los copiaba todos, así el cambio solo se ha hecho en uno de ellos.

En este Early Access, podemos definir donde se ubicarán los archivos fuentes del proyecto. Podemos crear una carpeta que tendrá acceso del apache utilizando un Alias, podemos usar la misma carpeta que nos proporciona NB y dejamos que los copie al directorio htdocs del Apache cuando se ejecute, o lo ponemos directamente en la carpeta htdocs. Haremos esta última opción.

Para ello modificamos el valor del campo "Project sources"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiI0KsnvyFyQTZg8lm0eM3D8F56t95rfwjeydEfp6VFMZvrtkdg6TE0HMMLseBqzAFAQbvU1paO6HSJLx2Pike3UHmZIBqz8UZmbLmyLHlySCP0SvPssUXWXA9Ceyw2NOgVSwqZIQow5ARJ/s320/nb6-php5-02a.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiI0KsnvyFyQTZg8lm0eM3D8F56t95rfwjeydEfp6VFMZvrtkdg6TE0HMMLseBqzAFAQbvU1paO6HSJLx2Pike3UHmZIBqz8UZmbLmyLHlySCP0SvPssUXWXA9Ceyw2NOgVSwqZIQow5ARJ/s1600-h/nb6-php5-02a.jpg)Asegurémonos que la carpeta sea la misma que se utilizará para publicar:

- Project Source: C:\Archivos de programa\Apache Group\Apache2\htdocs\PhpProject1
- Project URL: http://localhost/PhpProject1/
Esto es porque si se crea una carpeta dentro de htdocs, tomará el mismo nombre para publicarse en la web.

Clic en Finish.

Si quiere utilizar una carpeta para desarrollar y otra para publicar, entre a las propiedades del proyecto y haga esto

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgkQic7JuYOq5lDyOnLBimJZ5y8PpVnEZ6SpJwQ3m3ml9lxEFGQVY9xvAiMgTk8GEpEjmKJ0dZ6SBHWjHITSR97EXBo9nZt_YnqXfa6APnZ5nXunG8jF8lm43DyFripwviP1OanstfjwGUV/s320/php.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgkQic7JuYOq5lDyOnLBimJZ5y8PpVnEZ6SpJwQ3m3ml9lxEFGQVY9xvAiMgTk8GEpEjmKJ0dZ6SBHWjHITSR97EXBo9nZt_YnqXfa6APnZ5nXunG8jF8lm43DyFripwviP1OanstfjwGUV/s1600-h/php.png)Note que está la carpeta "Source Folder" donde estarán los archivos .php y todo lo necesario para su web. Esto es lo que editarás con el IDE. Y existe la carpeta indicada en "Copy to folder" que es donde se copiará cuando ejecute el proyecto.

## Configurando la base de datos

 Algo realmente bueno en la versión 6.1 de NetBeans es que viene configurado nativamente para conectarse al servidor MySQL.

Presionamos Ctrl+5 para visualizar el panel de Servicios. Vemos que solo tiene un nodo llamado "Databases". Desplegamos ese nodo y veremos la opción para conectarse a MySQL. Podemos ver las propiedades de este nodo para establecer la conexión al servidor MySQL, es decir, el usuario y la contraseña:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjF_3aA59Tza1KFtPOvvCeXek2nVIfysaLzxA5qJajQoOBbjt658xHt6aNxLijh7n8k2gB0XJs1FWweMAvOh0cIHOyrDS3d9YzuoH_cWDqebB59S0UjSb3cTt3klMto4HFPkm8y2Dn2vFVr/s320/nb6-php5-03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjF_3aA59Tza1KFtPOvvCeXek2nVIfysaLzxA5qJajQoOBbjt658xHt6aNxLijh7n8k2gB0XJs1FWweMAvOh0cIHOyrDS3d9YzuoH_cWDqebB59S0UjSb3cTt3klMto4HFPkm8y2Dn2vFVr/s1600-h/nb6-php5-03.jpg)
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjcwsrA6L-CSYDBYREfuf97J_WE7krdFDVx8_-IIA-8Aul_LmjAqnPL7q4A8T7lgn2aKVTJXeLwJlZ6SRt15yKJySB5JudfVgG3Jb8QjA_fEHUazvPMYeAO_kOJkm4BW-ifoxfaaTtl47u/s320/nb6-php5-03a.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjcwsrA6L-CSYDBYREfuf97J_WE7krdFDVx8_-IIA-8Aul_LmjAqnPL7q4A8T7lgn2aKVTJXeLwJlZ6SRt15yKJySB5JudfVgG3Jb8QjA_fEHUazvPMYeAO_kOJkm4BW-ifoxfaaTtl47u/s1600-h/nb6-php5-03a.jpg)
Podemos crear una base de datos desde esa opción. Por ejemplo, creemos la base de datos "sistema". Ni bien se crea, nos pedirá crear una nueva conexión a esta base de datos (usuario, y contraseña). Al finalizar, podemos ver que se creó una nueva conexión en el árbol de "databases".
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhvjTzAeRCzfIt2hnZQg1EGVY9cyHDU94s1B5Jr9dBNILBTJtoikUPTE_x4duWTgJI03lleHJCkK3NGS9WlZlgsbabdJq29ppW5oyFTS-rtJF9NjnQokiIOf6af16XJ9iMi_tn1Mmdod79u/s320/nb6-php5-04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhvjTzAeRCzfIt2hnZQg1EGVY9cyHDU94s1B5Jr9dBNILBTJtoikUPTE_x4duWTgJI03lleHJCkK3NGS9WlZlgsbabdJq29ppW5oyFTS-rtJF9NjnQokiIOf6af16XJ9iMi_tn1Mmdod79u/s1600-h/nb6-php5-04.jpg)

Creemos una tabla llamada "usuarios" y que tenga los campos:

- id_usuario
- contrasenia
- nombre
Podemos hacerlo desde la opción de NetBeans "create table" y ejecutando un comando SQL:

```java
<code>create table usuarios(<br />id_usuario varchar(20) not null primary key,<br />contrasenia varchar(100),<br />nombre varchar(100))<br /></code>
```

Refrescamos el árbol, y veremos la tabla recién creada:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4V2aVSWgkd-m09v3N_6ZHUXYn5Z5z-M3A92ohpR7OkZgK6swd9iwqv7SYp5QL-8yPpdyqpO19udiAfCWTNLaQc8yja0YK37gdYuqXkLCqpvzCVpsfAFz-NpYKQMemWty3oDwNzzgk_nRV/s320/nb6-php5-05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4V2aVSWgkd-m09v3N_6ZHUXYn5Z5z-M3A92ohpR7OkZgK6swd9iwqv7SYp5QL-8yPpdyqpO19udiAfCWTNLaQc8yja0YK37gdYuqXkLCqpvzCVpsfAFz-NpYKQMemWty3oDwNzzgk_nRV/s1600-h/nb6-php5-05.jpg)Insertemos unos cuantos valores a nuestra tabla

```java
<code>insert into usuarios values ('diego','diesil','Diego Silva'), ('juanpe','perez','Juan Perez')<br /></code>
```

 y pasemos a la siguiente fase.

## Creando una página de inicio de sesión

 Presionamos Ctrl + 1 para visualizar el proyecto. Ya existe un archivo index.php. Lo que crearemos será una página PHP, para ello hacemos clic derecho sobre el ícono "source files" y seleccionamos New > PHP Web Page.

¿Qué diferencia hay entre PHP Web Pages y PHP File? PHP no solo se ejecuta en web, también en consola como si fuera un script .bat o de shell de Linux. En ambos casos se tratan de archivos de textos con extensión .php. Pero NetBeans nos va ahorrar el trabajo de escribir los tags necesarios para una web. Así que si creamos un PHP Web Page, NetBeans nos creará un archivo .php con las etiquetas básicas de un HTML, además del scriptlet para PHP.

Crearemos nuestro PHP Web Page con el nombre "login_form". Este .php debe cumplir dos funciones:

- Mostrar el formulario de inicio de sesión
- Validar los datos ingresados en el formulario.
Esto no es una clase de PHP, así que de una vez mostraré el código de login_form.php

Recomiendo escribir el código, no copiar y pegar. Al escribir el código veremos como NetBeans nos ayuda en la escritura de la sintaxis, variables, y funciones del PHP.

```java
<code><?php<br />$op=$_POST["op"]; //obtenemos el valor de la accion que se esta haciendo<br />if (isset($op) && $op=="login") //si tiene valor y es 'login'...<br />$ok=validar_ingreso(); //.. validamos el ingreso<br />//sino.. mostrar el formulario<br />//$ok tendra TRUE si se logeo correctamente<br />?><br /><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><br /><html><br /><head><br /><title></title><br /></head><br /><body><br /><h1>Inicio de sesion</h1><br /><?php if($op && !$ok){ //si no se logeo correctamente, mostrar un mensaje de error<br /> print("Usuario o contraseña errónea");<br />} ?><br /><form method="post" action="<?php print($_SERVER["PHP_SELF"]);?>"><br /><input type="hidden" name="op" value="login"/><br />usuario:<input type="text" name="usuario"/><br/><br />contrase&ntilde;a: <input type="password" name="contrasenia"/><br/><br /><input type="submit" value="Entrar"/><br /></form><br /></body><br /></html><br /><?php //se pueden poner scriplets en cualqueir parte del php<br />function validar_ingreso(){<br />$usuario=$_POST["usuario"]; //obtengo el parametro usuario del formulario...<br />$contrasenia=$_POST["contrasenia"]; //... y la contrasenia<br />$conn=mysql_connect("localhost", "root", "adminadmin") or die (mysql_error($conn)); //nos conectamos a la base de atos<br />mysql_select_db("sistema", $conn) or die (mysql_error($conn)); //cambiamos de base de datos<br />//creamos un comando SQL, notar que si pongo comillas dobles, el valor de las variables<br />//   son interpretadas como parte de la cadena<br />$query="SELECT * FROM usuarios WHERE id_usuario='$usuario' AND contrasenia='$contrasenia'";<br />$res=mysql_query($query, $conn) or die (mysql_error($conn)); //ejecuto el comando<br /><br />if ($res ){ //.. si se ejecuto correctamente, el valor de $res no es falso<br /><br /> if ($reg=mysql_fetch_object($res)){ //obtengo todo el registro como un objeto<br />     session_start(); //inicio las variables de sesion...<br />     $_SESSION["usuario"]=$reg; //..  y almaceno el valor del objeto en la sesion<br />     header("Location: index.php"); //y redirecciono al index de la aplicacion<br />     mysql_close($conn);// cierro la conexion a la base de datos<br />     return true; //termino todo correctamente<br /> }<br />}<br />mysql_close($conn);// cierro la conexion a la base de datos<br />//si no devuelvo nada, la funcion retornara false.<br />}<br />?><br /><br /></code>
```

Bueno, esto hace el logeo, ahora la parte más interesante debería ser la página index.php
Si no se ha iniciado sesión, deberá reenviar al formulario de inicio de sesión, y si ya inicio sesión, debería mostrar el nombre.

Hemos visto que en login_form.php, después de validar el usuario se guarda un objeto en una variable de sesión llamada "usuario". Pues bien, lo que haremos será verificar si existe esa variable de sesión de tal manera obtener el objeto que guardamos y mostrar el nombre del usuario que acaba de iniciar sesión.

Este es el contenido del index.php

```java
<code><?php session_start();<br />$reg=$_SESSION["usuario"];<br />if (!isset($reg))<br />header("Location: login_form.php");<br />?><br /><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><br /><html><br /><head><br /><title></title><br /></head><br /><body><br /><?php<br /><br />print("Hola ".$reg->nombre);<br />?><br /></body><br /></html><br /><br /></code>
```

## Ejecutando el proyecto

 Ejecutemos el proyecto y tratemos de ingresar a [http://localhost/PhpProject1/](http://localhost/PhpProject1/). Automáticamente nos reenviará al formulario de inicio de sesión

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizy7-Q9dCkgk79skWU1xetzLgdNvk-FF67TAWVtZg5Th3fdqYx_trzeS9oxBjurA-Qy7_0hpymuRnKHok3lAfRkoxifHFL6FKlcLd_uhpiOuZriFjk9_Ci8_VM7bGkCShNde7cZ6MBro23/s320/nb6-php-run1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizy7-Q9dCkgk79skWU1xetzLgdNvk-FF67TAWVtZg5Th3fdqYx_trzeS9oxBjurA-Qy7_0hpymuRnKHok3lAfRkoxifHFL6FKlcLd_uhpiOuZriFjk9_Ci8_VM7bGkCShNde7cZ6MBro23/s1600-h/nb6-php-run1.jpg)
Ingresamos los valores correctos para iniciar una sesión de usuario según nuestra tabla usuarios, y veremos que nos redirecciona al index.php y nos muestra el nombre del usuario.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjD6fvvORC_nVxdm4mqaQ2mcUGLAUORPp-_KrlOdjDHVfDDreaS6GmfVh_YYCBl3WFtjeg3sIwaXygpmKbJNxfmqBZ8MzbqycKm8i7cIEkzrQafXWKb42RM1mrGiz80-ILAu2iGwy3RlR_E/s320/nb6-php-run2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjD6fvvORC_nVxdm4mqaQ2mcUGLAUORPp-_KrlOdjDHVfDDreaS6GmfVh_YYCBl3WFtjeg3sIwaXygpmKbJNxfmqBZ8MzbqycKm8i7cIEkzrQafXWKb42RM1mrGiz80-ILAu2iGwy3RlR_E/s1600-h/nb6-php-run2.jpg)Y si tratamos de abrir una nueva ventana (del mismo navegador) e ingresamos a la misma dirección web, ya no nos mostrará el formulario de inicio de sesión...
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiE-bR2XGoRiXQl-uOCgFtdM9xOjNWU2LdfjBd702LtVrIHgL6wwlYhToJn31jQkF-cU_Bl0Eeim-oQ3r26w69aJZIqWSiQOvJq0OTaekARBCQoyFm-fQRrkET3j0vWA5aQsQid_TuWFjxs/s320/nb6-php-run3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiE-bR2XGoRiXQl-uOCgFtdM9xOjNWU2LdfjBd702LtVrIHgL6wwlYhToJn31jQkF-cU_Bl0Eeim-oQ3r26w69aJZIqWSiQOvJq0OTaekARBCQoyFm-fQRrkET3j0vWA5aQsQid_TuWFjxs/s1600-h/nb6-php-run3.jpg)
... porque ya iniciamos la sesión en la otra ventana del mismo navegador

## Finalmente

 A mi parecer, esta versión mejorada del IDE para PHP ayuda notablemente en la edición de proyectos PHP, los autocomplete de código son mucho más rápidos que la versión para NetBeans 6.0 y la documentación está más completa. Esperemos que pronto lo tengan disponible para NetBeans 6.1

Luego haré un post sobre cómo depurar la ejecución del PHP desde NetBeans.
