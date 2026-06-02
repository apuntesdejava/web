---
layout: post
title: "Usando el API de persistencia en aplicaciones de escritorio (Introducción)"
date: 2007-06-11T20:10:00Z
last_modified_at: 2009-04-25T21:55:03.257Z
author: "Diego Silva"
permalink: /2007/06/usando-el-api-de-persistencia-en.html
canonical_url: https://www.apuntesdejava.com/2007/06/usando-el-api-de-persistencia-en.html
tags:
  - "jpa"
  - "desktop"
  - "java"
---

(Traducción no oficial de [Using the Persistence API in Desktop Applications](http://java.sun.com/developer/technicalArticles/J2SE/Desktop/persistenceapi/?feed=JSC))

La especificación JSR220 define los EJB 3.0. Uno de los primeros objetivos es la simplicidad en la creación, manejo y almacenamiento de beans de entidad. Trabajando hacia la meta, Sun Microsystems y la colaboración de la comunidad de desarrolladores crearon un nuevo API que te permite usar los antiguos objetos de java (o POJOs) como entidades persistentes. El API de persistencia Java te facilita en el uso de POJOs como beans de entidad y reduce significativamente la necesidad de descriptores de despliegues complciados y beans ayudatnes extras. Adicionalmente, puedes usar siempre el API en aplicaciones de escritorio.

Puedes describir muchas razones por la que deberías usar el nuevo API de persistencia, pero aquí hay algunas:

- No tienes que crear complejos objetos de accesos a datos (DAO).
- El API te ayuda manejar las transacciones.
- Escribes código basado en estándares que interactuan con la base de datos relacional, independientemente del código específico del proveedor.
- Puedes evitar SQL para usar las propiedades y nombres de las clases.
- Puedes usar y manejar POJOs.
- Puedes también usar el API de persistencia para persistencia de aplicaciones de escritorio.
Este artículo describe el API de persistencia de Java y como usarlo en aplicaciones desktop con Java SE que requieren persistencia de objetos. Aprenderás lo siguiente:

- Cómo definir entidades de persistencia en tu aplicación.
- Importar paquetes y clases del API.
- Cómo usar el API en una aplicación de ejemplo.
- Cómo usar el lenguaje de consulta de persistencia de java.
- Cómo obtener una implementación de referencia y documentación.
- Cómo configurar el netBeans para usar el API.

### Entidades y sus relaciones

Si tus aplicaciones están en un escritorio o en un servidor de aplicaciones como GlassFish, el API de persistencia de Java requiere que definas las clases que serán almacenadas en una base de datos. El API usa el término entidad  para definir clases que serán mapeadas a la base de datos relacional. Debes identificar las entidades persistentes y definir sus relaciones usando anotaciones. El compilador de Java reconocerá y usará las anotaciones para ahorrarte el trabajo. Usando anotaciones, el compilador generará clases adicionales para ti y realizar la comprobación de errores en tiempo de compilación.

#### Declarando Entidades

Quizás la más importante anotación es javax.persistence.Entity. Esta anotación identifica clases persistentes y es requerida para todas las definiciones de clases que intentes usar con el API de persistencia. Las clases entidad serán tablas en una base de datos relacional. Las instancias de entidad mapeadas serán filas en una o más tablas.
El siguiente código de ejemplo comienza con la definición de una clase Player que será un jugador de baseball. Las anotaciones en tu código comenzar con el símbolo @.

```java
<code>@Entity<br />public class Player {<br />...<br /><br /></code>
```

Nota que la anotación Entity está justo antes de la definición de la clase. La implementación del Api de Persistencia de Java creará una tabla para la entidad Player en tu base de datos relacional. Por omisión, el nombre de la tabla corresponde con el nombre de la clase. En este caso, una tabla PLAYER representará las entidades Player.
Las restricciones en entidades son algunas pero importantes. Primero, las entidades deben ser de clases de alto nivel. No puedes crear entidades desde enumeraciones o interfaces. Además, tu clase no ser ser final, sin métodos  finales o variables de instancias de persistencia final.

A parte de estas limitaciones, las entidades pueden ser cualquier otra clase java. Por ejemplo, las entidades pueden ser clases abstractas o concretas. Sin embargo, las entidades abstractas deberían tener subclases de otra clase entidad para poder ser almacenadas en la base de datos. Las clases pueden extender o ser extendidas de otras entidades o de clases que no sean entidades.

#### Campos y propiedades

Un estado de entidad está definido por un valor de sus campos o propiedades. Debes decidir si el API de persistencia usa tus campos variables o tus propiedades get/set cuando recuperes o almacenes las entidades. Si anotas las variables de instancia así mismos, la persistencia dada será directamente accedida las variables de instancia. Si anotas que con el estilo de un JavaBean usando los métodos get & set, la persistencia dada será usar sus accesores para cargar y almacenar el estado persistente. Deberías elegir uno estilo u otro, utilizar los dos métodos es ilegal en una especificación de concurrencia. La especificación de  persistencia actual muestra ejemplo que tienen anotadas accesores de propiedades, así que este artículo seguirá esa convención.

Puedes usar la mayoría de tipos para persistencia de campos, incluyendo tipos primitivos, envoltorios (wrappers) para tipos primitivos (como Integer, Character. etc), String y muchos más. Consulta la especificación del API para detalles de los tipos de campos permitidos.

Todas las entidades deberían tener una clave primaria. Las claves pueden ser un campo único o una combinación de campos. Este artículo usa claves de campo simple, pero podrías crear claves con múltiples campos si es necesario. Identifica una clave de campo simple con la anotación Id.

Los campos clave deben ser uno de los siguientes tipos:

- Tipos primitivos (como int, long, etc).
- Envoltorios para tipos primitivos (Integer, Long, etc)
- java.lang.String
- java.util.Date
- java.sql.Date
El siguiente código de ejemplo define una clase Player. Este ejemplo muestra como podrías usar cuatro anotaciones diferentes: Entity, Id, GeneratedValue y Transient.

```java
<code>@Entity<br />public class Player implements Serializable {<br /><br />private Long    id;<br />private String  lastName;<br />private String  firstName;<br />private int     jerseyNumber;<br />private String  lastSpokenWords;<br /><br />/** Creates a new instance of Player */<br />public Player() {<br />}<br /><br />/**<br />* Gets the id of this Player. The persistence provider should<br />* autogenerate a unique id for new player objects.<br />* @return the id<br />*/<br />@Id<br />@GeneratedValue<br />public Long getId() {<br />return this.id;<br />}<br /><br />/**<br />* Sets the id of this Player to the specified value.<br />* @param id the new id<br />*/<br />public void setId(Long id) {<br />this.id = id;<br />}<br /><br />public String getLastName() {<br />return lastName;<br />}<br />public void setLastName(String name) {<br />lastName = name;<br />}<br /><br />// ...<br />// some code excluded for brevity<br />// ...<br /><br />/**<br />* Returns the last words spoken by this player.<br />* We don't want to persist that!<br />*/<br />@Transient<br />public String getLastSpokenWords() {<br />return lastSpokenWords;<br />}<br /><br />public void setLastSpokenWords(String lastWords) {<br />lastSpokenWords = lastWords;<br />}<br /><br />// ...<br />// some code excluded for brevity<br />// ...<br />}<br /><br /></code>
```

La clave primaria de la entidad es la propiedad id y está correctamente marcada con la anotación Id. Las claves primarias pueden ser valores autogenerados. El comportamiento para las claves autogeneradas no está completamente especificada, pero la implementación de la referencia generará automáticamente un valor si agregas la anotación GeneratedValue a la clave primaria.

```java
<code>@Id<br />@GeneratedValue<br />public Long getId() {<br />...<br /><br /></code>
```

Siempre marca explicítamente las propiedades o campos que no deberían ser persistentes. Usa la anotación Transient para marcar propiedades transeúntes. Puedes también usar la palabra reservada transient para los campos. Las propiedades y campos marcadas por la anotación Transient no serán almacenados permanentemente en tu base de datos. En el anterior código de ejemplo, nota que la propiedad `lastSpokenWords usa la notación Transient. Los campos marcados con la palabra clave transient no serán persistentes en la base de datos.`

#### Relación entre entidades

Como en el mundo real de entidades, tus objetos persistentes usualmente no trabajan solos. las clases de entidad típicamente interactúan  con otras clases, usando o dando servicios. Las clases pueden tener relaciones uno-a-uno, uno-a-varios, varios-a-uno, y muchos-a-muchos. Puedes buscar cada una de estas relaciones en un jugador de baseball y un equipo como se muestra en este artículo.

Por ejemplo, un jugador tiene un promedio de bateo. El promedio de bateo y el jugador tienen una relación uno-a-uno. Un jugador tiene un promedio. Una instancia de un promedio sólo será de un solo jugador.

Los equipos tienen jugadores. Aunque hay jugadores que están solo en un equipo, un equipo consiste de muchos jugadores. La relación entre las clases Equipo y Jugador es uno-a-muchos. Un equipo tiene muchos jugadores. Un tipo similar de relación es muchos-a-uno. La relación muchos-a-uno es a menudo una perspectiva inversa de una relación uno-a-muchos. Podrías, por ejemplo, apenas como dices fácilmente que las clases del jugador y del equipo tienen muchos a una relación si consideras la relación de la perspectiva de un jugador.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhE8CDBxEwhZO12tin3fXM4CTQ7SvWmfXc3DXa04v_fSQau7RzMWueLF9um75Ocz7KATIufkkOc0_Ln2eHkAZoxgYlPLGXtSWlv2MmEl8WVFz2Jy4prwZFOMk7MtrBfjwZbp-5ynFEWeI_c/s320/cardinality.gif)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhE8CDBxEwhZO12tin3fXM4CTQ7SvWmfXc3DXa04v_fSQau7RzMWueLF9um75Ocz7KATIufkkOc0_Ln2eHkAZoxgYlPLGXtSWlv2MmEl8WVFz2Jy4prwZFOMk7MtrBfjwZbp-5ynFEWeI_c/s1600-h/cardinality.gif)
Un equipo jugará en muchos juegos cada temporada, y cada juego tiene muchos - tan sólo dos actualmente - equipos participando. Para propósitos de la base de datos relacional, el equipo a jugar es una relación muchos-a-muchos.

Puedes modelar estas relaciones de entidades en el API de persistencia. En cualquier caso que tus objetos entidad tengas estas relaciones, podrías aplicar una de estas anotaciones para relacionar una propiedad de entidad.

- OneToOne

- OneToMany

- ManyToOne

- ManyToMany

Las relaciones de las base de datos pueden ser de uno-solo-sentido, esto significa que solo una de las entidades conoce quién es la otra entidad o entidades de la relación. La relación unidireccional tiene un lado propio, el lado que mantiene la relación en la base de datos.

Las relaciones bidireccionales tienen los lados propio e inverso. El lado propio determina cómo y cuando los cambios afectan a la relación. También, el lado propio usualmente contiene la clave foránea a la otra entidad.

Regresando al ejemplo del baseball, los objetos Player tienen relaciones ManyToOne con un objeto Team. Aunque si bien esto no podrá ser literalmente verdad en el mundo real, en una base de datos, un Player tiene una relación propia. Declarar esta relación muchos-a-uno entre las entidades Player y Team agregando la anotación ManyToOne a la propiedad team de la clase Player:

```java
<code>@Entity<br />public class Player implements Serializable {<br />...<br />private Team team;<br /><br />@ManyToOne<br />public Team getTeam() {<br />return team;<br />}<br />...<br />}<br /><br /></code>
```

Ya que las clases Team y Player tienen una relación bidireccional, ahora deberías definir el lado inverso de la relación y relacionarlos. Desde la perspectiva de la clase Team, la relación es uno-a-muchos. Adicionalmente, una instancia de Player referirá a una instancia de Team a través de su variable team. Usar el atributo mappedBy con la anotación OneToMany tal que el motor de persistencia conoce cómo coincidir los equipos y los jugadores. El atributo mappedBy existe en el lado inverso de una relación bidireccional, como lo es la clase Team. En este ejemplo, el atributo mappedBy muestra que la propiedad team de una instancia Player mapea a una instancia Team. Siendo mapeado por una propiedad team de un objeto Player significa que un identificador de un objeto Team existirá como una clave foránea en una columna de la tabla PLAYER. El lado propio de Player de una relación es responsable para almacenar una clave foránea.

La clase Team es como sigue. Note el método getPlayers, el cuál tiene la anotación inversa OneToMany con el atributo mappedBy.

```java
<code>@Entity<br />public class Team implements Serializable {<br /><br />private Long id;<br />private String teamName;<br />private String division;<br />private Collection<Player> players;<br /><br />/** Creates a new instance of Team */<br />public Team() {<br />players = new HashSet();<br />}<br /><br />/**<br />* Gets the id of this Team.<br />* @return the id<br />*/<br />@Id<br />@GeneratedValue<br />public Long getId() {<br />return this.id;<br />}<br /><br />/**<br />* Sets the id of this Team to the specified value.<br />* @param id the new id<br />*/<br />public void setId(Long id) {<br />this.id = id;<br />}<br /><br />@OneToMany(mappedBy = "team")<br />public Collection<Player> getPlayers() {<br />return players;<br />}<br /><br />public void setPlayers(Collection<Player> players) {<br />this.players = players;<br />}<br />...<br />}<br /><br /></code>
```

#### Nombres de columnas y tablas por omisión

La especificación del API de persistencia proporciona valores por omisión útiles para las anotaciones de atributo. Deberías leer los detalles de la especificación, pero muchos ejemplos están aquí.

Cada entidad tiene un nombre. Por omisión, el nombre de la entidad es el nombre de la clase. La anotación Entity tiene un atributo nombre que te permite especificar explícitamente el nombre. Puedes usar el nombre de la entidad en consultas. En el ejemplo Player, usarás el nombre Player en tus consultas. Si deseas usar el nombre BaseballPlayer como nombre de entidad, usa el atributo nombre como se especifica a continuación.

```java
<code>@Entity (name="BaseballPlayer")<br />public class Player {<br />...<br /></code>
```

BASEBALLPLAYER es ahora también el nombre de la tabla para esta entidad, pero puedes cambiarlo con la anotación Table. Table tiene tres elementos opcionales, y uno determina el nombre de la tabla entidad. Cambie el nombre de la tabla a BASEBALL_PLAYER con el atributo nombre de la anotación Table como sigue:

```java
<code>@Entity<br />@Table(name="BASEBALL_PLAYER")<br />public class Player {<br />...<br /><br /></code>
```

Por omisión, las implementaciones de persistencia usan un campo de entidad o nombres de campo como lso nombres de las columnsa en una tabla entidad. Por ejemplo, ya que el nombre de la clase tiene una propiedad lastName, la columna correspondiente es LASTNAME. Las omisiones no son nada sorprendentes ya que son practicamente identicos a los nombres que usas en el código de tu aplicación. Puedes, sin embargo, sobreescribir el valor por defecto usando la anotacion Column y su elemento name. Si prefieres usar SURNAME en lugar de LASTNAME, puedes anotar la propiedad lastName así:

```java
<code>@Column(name="SURNAME")<br />public String getLastName() {<br />...<br /><br /></code>
```

Existen muchas más anotaciones y elementos opcionales. Estos te ayudarán a controlar la longitud o tamaño, campos obligatorios, operaciones de cascada, y otras opciones estándar asociadas a las bases de datos de relacionales. Este artículo muestra información y ejemplos para algunas de las más comunes combinaciones que te ayudarán a iniciar en el uso de este API.

#### Unidades de persistencia

La agrupación de entidades en tu aplicación se llama unidad de persistencia. Debes definir una unidad de persistencia de aplicación en un archivo llamado persistence.xml. Este archivo debería existir dentro del directorio META-INF de tu aplicación. Puedes poner el subdirectorio META-INF junto con el directorio del código fuente del proyecto.

El archivo persistence.xml tiene muchas funciones, pero la más importante tarea en un entorno de escritorio es la de listar todas las entidades en tu aplicación y nombrar la unidad de persistencia. Listar las clases entidad es necesario para la portabilidad en entornos Java SE. El archivo persistence.xml para las entidades de este artículo luce así:

```java
<code><?xml version="1.0" encoding="UTF-8"?><br /><persistence version="1.0" xmlns="http://java.sun.com/xml/ns/persistence"<br /> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<br /> xsi:schemaLocation="http://java.sun.com/xml/ns/persistence<br /> http://java.sun.com/xml/ns/persistence/persistence_1_0.xsd"><br /><persistence-unit name="league" transaction-type="RESOURCE_LOCAL"><br /><br /> <provider>oracle.toplink.essentials.ejb.cmp3.EntityManagerFactoryProvider</provider><br /> <class>com.sun.demo.jpa.Player</class><br /> <class>com.sun.demo.jpa.Team</class><br /> <properties><br /><br />   <property name="toplink.jdbc.user" value="league"/><br />   <property name="toplink.jdbc.password" value="league"/><br />   <property name="toplink.jdbc.url" value="jdbc:derby://localhost:1527/league"/><br /><br />   <property name="toplink.jdbc.driver" value="org.apache.derby.jdbc.ClientDriver"/><br />   <property name="toplink.ddl-generation" value="create-tables"/><br /> </properties><br /><br /></persistence-unit><br /></persistence><br /><br /></code>
```

La mayor parte de este archivo es una plantilla, y herramientas como NetBeans 5.5 pueden crearlo correctamente para ti. Los elementos más importantes para este artículo son los siguientes:

- persistence-unit
- provider
- class
- property
El atributo nombre de la unidad de persistencia pueden ser cualquier que desees.  Este nombre no es necesariamente el nombre de tu base de datos o de tu esquema, pero para mantener la consistencia puede sernos útil que sea así. En este ejemplo, la unidad de persistencia (PU) es league. Cuando se usa el API desde aplicaciones Java SE, el tipo transacción por omisión es RESOURCE-LOCAL. En entorno Java EE, puede también ver transacciones tipo JTA, el cuál significa que el administrador de entidades participa en la transacción. Si no especificas el tipo, por omisión se establece, el cuál hace que sea mucho más fácil mover tu aplicación desde un entorno a otro.

El elemento provider declara el archivo de la clase que provee el factory inicial para crear una instancia EntityManager. Tu implementador del API de persistencia podría dar más detalles acerca de los valores correctos para este elemento. El ejemplo de persistence.xml muestra un nombre de clase provider usada en la implementación de GlassFish.

Usar el elemento class para listar los nombres de clases entidades en tu aplicación. En este código ejemplo del artículo, solo dos entidades son necesarias: Player y Team. El nombre completo de la clase con el paquete son necesarios. El proveedor de persistencia sabrá que clases de la aplicación serán mapeadas a la base de datos relacional para leer los nombres de entidad desde el archivo persistence.xml.

Finalmente, en entornos Java SE de escritorio puedes poner propiedades de conexión a la base de datos en el archivo persistence.xml si no es posible usar JNDI. Las propiedades de la conexión a la base de datos incluyen el nombre de usuario y contraseña para la conexión, la cadena de la conexión (URL) y el nombre de la clase del driver. Adicionalmente, puedes incluir propiedades de persistencia del proveedor como opciones para crear o borrar-crear nuevas tablas. La propiedad namespace javax.persistence está reservada para propiedades definidas por la especificación. Las opciones de las especificaciones y propiedades del  proveedor deben ser usadas para evitar conflictos con la especificación.  El archivo persistence.xml mostrado usa la implementación GlassFish. Sus propiedades de la especificación del proveedor son el namespace toplink y no son parte de su propia especificación. Los proveedores de persistencia ignorarán cualquier otra propiedad que no estén en sus especificaciones o que no sean parte de su propiedades de las especificaciones del proveedor.
