---
layout: post
title: "Biblioteca compartida en plugins de Liferay"
date: 2014-01-09T16:31:00.001Z
last_modified_at: 2014-01-09T16:31:22.970Z
author: "Diego Silva Límaco"
permalink: /2014/01/biblioteca-compartida-en-plugins-de.html
canonical_url: https://www.apuntesdejava.com/2014/01/biblioteca-compartida-en-plugins-de.html
tags:
  - "portlets"
  - "liferay"
  - "tips"
  - "plugins"
---

[![](/assets/blogger/heading.png)](/assets/blogger/heading.png)

Volviendo un rato con [+Liferay](https://plus.google.com/110984633913716210797) (y como son apuntes principalmente para que yo no me olvide), voy a compartir un truco (¿?) que no lo vi en algún tutorial, pero que lo usan mucho en el desarrollo de plugins para este CMS.

Cuando se desarrollan más de un proyecto plugin para Liferay, llega un momento en que se necesitan compartir alguna biblioteca desarrollada por nosotros, por ejemplo, alguna conexión a una base de datos especial que lo queremos usar en un proyecto Hook y en varios proyectos Portlet.

Lo más "normal" sería hacer una biblioteca en java, compilarlo y empaquetarlo como .jar y copiarlo en cada biblioteca de los proyectos. Pero, si hacemos un cambio en la biblioteca, deberíamos copiarla en todos los proyectos que la necesitan para que estén actualizados. ¿No sería mejor que en el momento que se compila el plugin, también compile empaquete y copie la biblioteca de manera automática?

Pues bien, aquí está la solución. Primero, revisemos a la carpeta del SDK, y veremos que existe una subcarpeta llamada "shared". Allí crearemos nuestra biblioteca.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Aqlnfn8damRM5PsHoiEZ_uV2d6erTF9RHl3R8osEmRltkezDrY0AcmHxMfwqNn_eVMiJj3Qj5PH__uZsby701ZzKrCl0Y10BP3Y0kZ-ZVIxXXIq93O6LlhnKyB-Img4OHQplKB3Us2g/s1600/09-01-2014+11-07-55+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Aqlnfn8damRM5PsHoiEZ_uV2d6erTF9RHl3R8osEmRltkezDrY0AcmHxMfwqNn_eVMiJj3Qj5PH__uZsby701ZzKrCl0Y10BP3Y0kZ-ZVIxXXIq93O6LlhnKyB-Img4OHQplKB3Us2g/s1600/09-01-2014+11-07-55+a.m..png)

Dentro de esa carpeta habrán dos archivos "build.xml" y "build-common-shared.xml"

Allí crearemos nuestra biblioteca de la siguiente manera:

- Crearemos una carpeta con subfijo "shared". Por ejemplo: "conexiones-shared"

- Dentro de la carpeta creada, crearemos el archivo "build.xml" con el siguiente contenido.

```java
<?xml version="1.0"?>
<!DOCTYPE project>

<project name="conexiones-shared" basedir="." default="deploy"  >
  <property name="plugin.version" value="1" />
  <import file="../build-common-shared.xml" />
</project>
```

- Crearemos la carpeta "src" donde colocaremos nuestro código fuente organizado en paquetes.

En este punto, sugiero utilizar NetBeans, ya que nos ayudará a organizar las carpetas y a compilar.

Ahora, ya que tenemos nuestra biblioteca lista para compartirla, veamos cómo la incluirla en los proyectos plugins.

Simplemente, en los archivos `build.xml` de cada proyecto plugin, debemos agregar la propiedad `import.shared`. Por ejemplo, si estamos desarrollando un proyecto portlet llamado `importante-portlet`, así que modificamos su archivo `build.xml` con lo siguiente

```java
<?xml version="1.0"?>
<!DOCTYPE project>

<project name="importante-portlet" basedir="." default="deploy">
 <import file="../build-common-portlet.xml" />
 <property name="import.shared" value="conexiones-shared" />
</project>
```

Y listo, cuando compilemos el proyecto con `ant compile` este compilará la biblioteca compartida y la incluirá en el proyecto.

Nota: Si hay una clase creada en un proyecto plugin y deseamos usarla en otro proyecto, es mejor extraer esta clase a una biblioteca "shared" y hacer lo que se acaba de mencionar. Pero si tenemos un proyecto que necesariamente utiliza una funcionalidad completa de otro plugin, es mejor editar el archivo `liferay-plugin-package.properties` y agregar la propiedad `required-deployment-contexts` y se indicará el nombre del proyecto plugin que se va a necesitar

Espero que les sea de utilidad.
