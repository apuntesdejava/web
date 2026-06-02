---
layout: post
title: "Liferay 7.2. Service Layer - Creando entidades y servicios"
date: 2019-08-09T20:07:00Z
last_modified_at: 2019-08-09T20:07:12.104Z
author: "Diego Silva Límaco"
permalink: /2019/08/liferay-72-service-layer-creando.html
canonical_url: https://www.apuntesdejava.com/2019/08/liferay-72-service-layer-creando.html
description: "Sigamos con Liferay, ahora con el tema Service Layer."
tags:
  - "servicios"
  - "liferay"
  - "entidades"
  - "tutorial"
  - "base de datos"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vRWYwNzDfiluKRc-ql4aK9ewfCLX3o_HnWJCSHl_WMxezA8-BE6s17bLi7kFeLdhnYC1_uMWeaAcQ2b/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vRWYwNzDfiluKRc-ql4aK9ewfCLX3o_HnWJCSHl_WMxezA8-BE6s17bLi7kFeLdhnYC1_uMWeaAcQ2b/pub?w=1440&h=810)

Sigamos con Liferay, ahora con el tema Service Layer.

Liferay Service Builder es una herramienta de generación de código que permite, usando un archivo xml, generar una capa completa de servicios. La generación de código incluye definciones de base de datos, código para caché y persistencia, clases de servicios con métodos CURD y la capa de servicios remotos con compatibilidad con JSON y SOAP Web Services.

¡Y todo esto con un solo archivo `service.xml` !

En el archivo service.xml podemos definir lo siguiente:

- Información global para los servicios (namespace de la base de datos, paquete de las clases)

- Entidades y atributos (columnas)

- Orden por omisión de la recuperación de los datos

- Métodos de búsqueda de entidades

- Variantes de servicios generados (local y remoto)

- Datasource (interno o externo)

- Excepciones de servicios

- Referencias de servicios disponibles en la generación de clases de servicio.

- Caché a utilizar.

Un ejemplo de qué es lo que tiene el `service.xml` lo podemos ver para la entidade Blogs de Liferay. Aquí podemos encontrar un ejemplo: [https://github.com/liferay/liferay-portal/blob/7.1.x/modules/apps/blogs/blogs-service/service.xml](https://github.com/liferay/liferay-portal/blob/7.1.x/modules/apps/blogs/blogs-service/service.xml)

Para continuar con este tutorial, crearemos tres entidades (en el vídeo se muestran dos, y son las que trataremos aquí)

- Course

- SessionCourse

- Homework.

## Creando el módulo

Para comenzar, necesitamos crear un módulo con la plantilla "service-builder".

[![]({{ '/assets/blogger/create.png' | relative_url }})]({{ '/assets/blogger/create.png' | relative_url }})

Clic Next. Establecemos el paquete donde se elojarán las clases a crear. Colocamos `com.apuntesdejava.virtualclassroom`

[![]({{ '/assets/blogger/2019-08-09_11-40-56.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_11-40-56.png' | relative_url }})

Clic en Finish.

Esto nos creará dos submódulos con el mismo nombre, pero con los subfijos "-api" y "-service".

[![]({{ '/assets/blogger/2019-08-09_11-42-17.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_11-42-17.png' | relative_url }})

El módulo classroom-api tendrá solo los API para acceder a los servicios. Hay interfaces, nada de implementación. Es la parte que los demás módulos podrán acceder.

El módulo classroom-service tendrá la implementación en sí. Allí colocaremos la lógica de los CRUD, búsquedas y demás métodos que quisiéramos crear.

## Configurando los módulos

A continuación, necesitamos declarar unas dependencias a cada módulo en sus archivos build.gradle de la siguiente manera.

Para el archivo build.gradle de classroom-api agregar estas dependencias.

```java
compileOnly group: "com.liferay", name: "com.liferay.osgi.util", version: "3.0.0"
```

Finalmente, quedaría así: <script src="https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/e2a44ee55a89289b0ebadeee2f1c9fa105273e24/modules/classroom/classroom-api/build.gradle?embed=t"></script>

Para el archivo build.gradle de classroom-service agregar estas dependencias.

```java
compileOnly group: "javax.portlet", name: "portlet-api", version: "3.0.0"
compileOnly group: "javax.servlet", name: "servlet-api", version: "2.5"
```

y quedaría finalmente así: <script src="https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/e2a44ee55a89289b0ebadeee2f1c9fa105273e24/modules/classroom/classroom-service/build.gradle?embed=t"></script>

## Declarando las entidades

Las entidades se definen en el archivo `service.xml` que se encuentra dentro del módulo classroom-service. Viene con un ejemplo de Entidad, pero podemos eliminarlo y configurar los nuestros.

Para comenzar, debemos personalizar el namespace, estando en la vista de Overview, seleccionamos el nodo "Service Builder". En el campo "Namespace" colocamos el que deseemos.

[![]({{ '/assets/blogger/2019-08-09_13-36-10.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_13-36-10.png' | relative_url }})

Este nombres nos permitirá identificar a estos servicios, además será tomado como un prefijo de las tablas que se crearán en la base de datos.

Luego, en el nodo "Entities" hacemos clic en el botón "Add Entity" y procedemos a crear las entidades.

[![]({{ '/assets/blogger/2019-08-09_13-39-14.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_13-39-14.png' | relative_url }})

Y crearemos nuestra primera entidad: Course. Además, aseguremos en activar los checks "Local Service" y "Remote Service"

[![]({{ '/assets/blogger/2019-08-09_13-40-50.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_13-40-50.png' | relative_url }})

No tendrá ninguna columna. Vamos a decirle al Service Builder que cree los campos predeterminados para esta entidad, haciendo clic en "Add Default Columns"

[![]({{ '/assets/blogger/2019-08-09_13-42-47.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_13-42-47.png' | relative_url }})

Esto nos creará los siguientes campos:

[![]({{ '/assets/blogger/2019-08-09_13-44-23.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_13-44-23.png' | relative_url }})

- `courseId`: Es la clave primaria. Está basado en el nombre de la entidad, seguido de id.

- `groupId`: Es el identificador del site de donde se registrarán los cursos.

- `companyId`: Es el identificador de la instancia del portal.

- `userId`: Es el id del usuario que está registrando el curso.

- `userName`: Es el nombre del usuario

- `createDate`: Guarda la fecha de creación del curso

- `modifiedDate`: Guarda la fecha de la última modificación del curso.

Además de estos campos, le agregaremos dos más:

- `name` Tipo String

- `description` Tipo String

Solo que name permitirá tener localization. Para ello, después de crearlo, activamos el check Localized en el editor.

[![]({{ '/assets/blogger/2019-08-09_13-54-55.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_13-54-55.png' | relative_url }})

También crearemos la entidad CourseSession y tendrá los siguientes campos:

- courseSessionId (long)

- groupId (long)

- companyId (long)

- userId (long)

- userName (String)

- createDate (Date)

- modifiedDate (Date)

- title (String) (Este no tendrá localización)

- description (String)

- dueDate (Date)

- courseId (long).

### Finders

Los Finders son métodos de consulta a la base de datos, el cual definimos en la configuración de `service.xml`. Estos hacen caché automáticamente y pueden ser personalizados en cada clase. Para nuestro caso crearemos los siguientes finders por cada entidad:

<table>
<thead>
<tr><th>Entidad</th><th>Finder</th><th>Columnas</th></tr>
</thead>
<tbody>
<tr><td rowspan="4">Course</td>
<td>UserId</td>
<td>userId</td>
</tr>
<tr>
<td>GroupId</td><td>groupId</td>

</tr>
<tr>
<td rowspan="2">U_G
</td><td>userId</td>
</tr>
<tr><td>groupId</td>
</tr>
<tr>
<td>SessionCourse
</td><td>CourseId</td><td>courseId</td>
</tr>
</tbody>
</table>

Finalmente, el service.xml debería lucir algo así:

<script src="https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/e2a44ee55a89289b0ebadeee2f1c9fa105273e24/modules/classroom/classroom-service/service.xml?embed=t"></script>

## Construyendo las clases

Una vez que tenemos las entidades declaradas, debemos construir las clases. Para ello usaremos las tareas de gradle, y seleccionamos el siguiente:

virtual-classroom > modules > classroom > classrom-service > build > buildService

[![]({{ '/assets/blogger/2019-08-09_14-02-00.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-02-00.png' | relative_url }})

Doble clic, y esperemos a que termine de construir.

Al terminar, presionamos Ctrl+F5 en el árbol del proyecto, y veremos que se crearon clases.

[![]({{ '/assets/blogger/2019-08-09_14-04-28.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-04-28.png' | relative_url }})

En clases que nos vamos a ocupar son las que están dentro del paquete `com.apuntesdejava.virtualclassroom.service.impl`, porque allí son las implementaciones de los CRUD.

## Creando los métodos CRUD

Ahora, haremos los métodos para el CRUD de la entidad Course. Todo esto se hace en `CourseLocalServiceImpl`. Todos los -LocalServiceImpl debería tener la implementación directa de la persistencia. Las clases con subfijo -ServiceImpl (que refiere a los servicios remotos) deben acceder a los métodos de los -LocalServiceImple, y no manejar directamente a la persistencia. Además, en estas clases remotas deberían estar el manejo de los permisos.

Entonces, crearemos el primero método de la clase `CourseLocalServiceImpl`

```java
public Course addCourse(long groupId, Map<Locale, String> name, String description, ServiceContext serviceContext)
   throws PortalException {
  long courseId = counterLocalService.increment(Course.class.getName()); //obtiene un nuevo ID proporcionado por la plataforma
  Course course = super.createCourse(courseId); //instancia un curso, usando el ID creado arriba
  course.setGroupId(groupId); //colocamos valores de los parámetros
  course.setNameMap(name); //el mapa permite guardar por idioma
  course.setCompanyId(serviceContext.getCompanyId()); //la instancia del portal está en el contexto
  course.setDescription(description);
  course.setUserId(serviceContext.getUserId());
  User user = userLocalService.getUser(serviceContext.getUserId()); //para obtener...
  course.setUserName(user.getScreenName()); //... el nombre del usuario
  course.setCreateDate(serviceContext.getCreateDate(new Date())); //fecha de creacion
  return super.addCourse(course); //lo guarda en la base de datos y lo devuelve a quien invocó el servicio

 }
```

De la misma manera para la actualización:

```java
public Course updateCourse(long courseId, Map<Locale, String> name, String description,
   ServiceContext serviceContext) throws PortalException {
  Course course = getCourse(courseId); //obtiene el curso para actualizar
  course.setNameMap(name); //se coloca los nuevos valores
  course.setDescription(description);
  course.setModifiedDate(serviceContext.getModifiedDate(new Date())); //se registra la fecha de actualizacion
  return updateCourse(course); // se invoca a la actualizacion y se devuelve a quién lo invocó.
 }
```

Para los listados, los finders en sí, deberían existir mínimo 3 métodos por cada finder: findBy..(parametros), findBy..(paramétros,start,end), y countBy..(parámetros). Aquí está un ejemplo para el finder `UserId`.

```java
public List<Course> findByUserId(long userId) {
  return coursePersistence.findByUserId(userId);
 }

 public List<Course> findByUserId(long userId, int start, int end) {
  return coursePersistence.findByUserId(userId, start, end);
 }

 public int countByUserId(long userId) {
  return coursePersistence.countByUserId(userId);
 }
```

Para lo mismo serán para los demás finders.

La clase completa se podrá ver aquí:

[https://github.com/apuntesdejava/liferay-virtual-classroom/blob/master/modules/classroom/classroom-service/src/main/java/com/apuntesdejava/virtualclassroom/service/impl/CourseLocalServiceImpl.java](https://github.com/apuntesdejava/liferay-virtual-classroom/blob/master/modules/classroom/classroom-service/src/main/java/com/apuntesdejava/virtualclassroom/service/impl/CourseLocalServiceImpl.java)

El servicio remoto, en la clase `CourseServiceImpl`, debería tener los mismos métodos, pero invocará a los métodos que están en el servicio local, de la siguiente manera

```java
public Course addCourse(long groupId, Map<Locale, String> name, String description, ServiceContext serviceContext)
   throws PortalException {
  return courseLocalService.addCourse(groupId, name, description, serviceContext);
 }

 public Course updateCourse(long courseId, Map<Locale, String> name, String description,
   ServiceContext serviceContext) throws PortalException {
  return courseLocalService.updateCourse(courseId, name, description, serviceContext);
 }

 public List<Course> findByGroupId(long groupId) {
  return courseLocalService.findByGroupId(groupId);
 }

 public List<Course> findByUserId(long userId) {
  return courseLocalService.findByUserId(userId);
 }

 public List<Course> findByUserId(long userId, int start, int end) {
  return courseLocalService.findByUserId(userId, start, end);
 }
```

Las clases completas se encuentran aquí:

[https://github.com/apuntesdejava/liferay-virtual-classroom/tree/master/modules/classroom/classroom-service/src/main/java/com/apuntesdejava/virtualclassroom/service/impl](https://github.com/apuntesdejava/liferay-virtual-classroom/tree/master/modules/classroom/classroom-service/src/main/java/com/apuntesdejava/virtualclassroom/service/impl)

## Desplegando los servicios

Con el liferay en ejecución desde el IDE, arrastremos los dos módulos al servidor de Liferay.

[![]({{ '/assets/blogger/2019-08-09_14-36-30.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-36-30.png' | relative_url }})

Y listo. En ese mismo momento se crearán las tablas según se han configurado. Para ello podemos revisar la base de datos.

[![]({{ '/assets/blogger/2019-08-09_14-39-24.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-39-24.png' | relative_url }})

[![]({{ '/assets/blogger/2019-08-09_14-40-10.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-40-10.png' | relative_url }})

## Probando los servicios

Para poder invocar a nuestro servicio necesitamos el valor del groupId, el del site principal. Así que entraremos al panel de control, y en la sección "Settings" del Site por omisión "Liferay" obtenemos el valor. Para mi caso es 20123.

[![]({{ '/assets/blogger/2019-08-09_14-49-07.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-49-07.png' | relative_url }})

Ahora sí, entremos a la siguiente url: http://localhost:8080/api/jsonws Ahí se muestran todas los servicios remotos publicados.

Seleccionamos el context name con nombre vc que es el namespace que hemos definido al inicio.

[![]({{ '/assets/blogger/2019-08-09_14-51-32.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-51-32.png' | relative_url }})

En la caja de búsqueda escribimos "add" para buscar el método "add-course":

[![]({{ '/assets/blogger/2019-08-09_14-53-58.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-53-58.png' | relative_url }})

Y ahí nos mostrarán los parámetros para invocación. Pero en nuestro caso no usaremos esta pantalla de prueba, sino lo haremos desde la consola de javascript que está en Liferay. Así que iremos al inicio del portal http://localhost:8080 y abrimos la consola de javascript de nuestro navegador. Allí escribiremos lo siguiente:

```java
Liferay.Service(
  '/vc.course/add-course',
  {
    groupId: 20123, //nuestro groupId
    name: {"es_ES":"Nuestro primer curso de Liferay"} , //en formato JSON
    description: 'Aqui haremos un portlet' //un texto cualquiera
  },
  function(obj) {
    console.log(obj); //callback para imprimir el resultado
  }
);
```

Este sería el resultado.

[![]({{ '/assets/blogger/2019-08-09_14-58-37.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_14-58-37.png' | relative_url }})

Podemos ver la respuesta obtenida, el valor del companyId, los valores para createDate y userId con userName, el campo "name" con el XML de la localización, etc.

Ahora, también podemos invocar a los otros métodos creados, por ejemplo, podemos consultar el método `find-by-group-id`. Su invocación sería así:

```java
Liferay.Service(
  '/vc.course/find-by-group-id',
  {
    groupId: 20123
  },
  function(obj) {
    console.log(obj);
  }
);
```

Tendríamos el siguiente resultado:

[![]({{ '/assets/blogger/2019-08-09_15-05-26.png' | relative_url }})]({{ '/assets/blogger/2019-08-09_15-05-26.png' | relative_url }})

Y listo, tenemos nuestros servicios creados y que podemos consumir desde cualquier portlet de Liferay a manera de AJAX. Eso lo veremos en los siguientes posts.

## Vídeo

Y, por si estaba complicado y queremos verlo en la vida real, aquí el vídeo explicado. Tanto el vídeo como este post se complementan.

<iframe allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/HQ7_e613eBA" width="560"></iframe>

# Código fuente

Y no podía faltar, el código fuente de este proyecto:

- Bitbucket: [https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/service-builder/](https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/src/service-builder/)

- Github: [https://github.com/apuntesdejava/liferay-virtual-classroom/tree/service-builder](https://github.com/apuntesdejava/liferay-virtual-classroom/tree/service-builder)
