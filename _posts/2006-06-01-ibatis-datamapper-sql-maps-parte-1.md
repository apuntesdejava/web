---
layout: post
title: "iBatis Datamapper (sql maps) parte 1"
date: 2006-06-01T07:00:00Z
last_modified_at: 2009-04-25T21:55:03.676Z
author: "Diego Silva"
permalink: /2006/06/ibatis-datamapper-sql-maps-parte-1.html
canonical_url: https://www.apuntesdejava.com/2006/06/ibatis-datamapper-sql-maps-parte-1.html
tags:
  - "ibatis"
  - "apache"
  - "java"
  - "tutorial"
  - "sql"
---

El framework iBatis DataMapper (también conocido como SQL
Maps) permite reducir significativamente la codificación en
java para una aplicación que maneja base de datos relacional.
Quizás la primera impresión que uno tenga es que sea
igual a Hibernate (que es un mapeador de objetos con tablas
relacionales – ORM). Ibatis es diferente. Como veremos en este
tutor, iBatis mapea las consultas SQL y permite interactuarlas con
JavaBeans tanto como parámetros de entrada y como salidas.

## Manos a la obra

Para comenzar, obtendremos el framework de la página de
ASF: [http://ibatis.apache.org/](http://ibatis.apache.org/)
El archivo que habremos bajado (iBATIS_DBL-2.1.7.XX.zip) contendrá
tres archivos .jar. En este tutor solo usaremos ibatis-common-2.jar y
ibatis-sqlmap-2.jar. No necesita de algún otro .jar, al menos
para este capítulo.

### Definiendo la estructura de los datos

Crearemos nuestro JavaBean ***Categoria*** con la
siguiente estructura.

```java
package com.jugperu.tutores.ibatis.beans;<br /><br />public class Categoria {<br />    private int id; // podemos utilizar tipos de datos nativos<br />    private String nombre;<br />/*... poner sus respectivos métodos<br />setXX() y getXX() para que tenga el<br />patrón JavaBean (value object)*/<br />}
```

También necesitamos crear nuestra base de datos. Podemos usar
cualquier motor; naturalmente necesitaremos su respectivo *driver*.

Crearemos nuestra tabla CATEGORIA, la cual tendrá la
siguiente estructura:

<table border="1"><br /><thead><br /><tr><br /><th><br /><p>Nombre</p><br /></th><br /><th><br /><p>Tipo</p><br /></th><br /></tr><br /></thead><br /><tbody><br /><tr><br /><td><br /><p>CAT_ID</p><br /></td><br /><td><br /><p>Autonumérico (clave principal)</p><br /></td><br /></tr><br /><tr><br /><td><br /><p>CAT_NOMBRE</p><br /></td><br /><td><br /><p>Varchar(30)</p><br /></td><br /></tr><br /></tbody><br /></table>

Como se puede ver, hemos puesto nombres de campos distintos a las
propiedades de nuestro JavaBean. Veremos como en iBatis podremos
asociar cada columna con su respectiva propiedad en los objetos.

### Configuración de la conexión a la base de datos desde nuestra aplicación

Crearemos el archivo database.properties dentro del paquete
*com.jugperu.tutores.ibatis.resources* el cual tendrá los
siguientes valores:

```java
#el driver de nuestra base de datos<br />jdbc.driver=org.hsqldb.jdbcDriver<br />#el url para nuestra conexion.<br />jdbc.url=jdbc:hsqldb:file:data/productos.hsqldb<br />#el usuario<br />jdbc.username=sa<br />#y la contraseña<br />jdbc.password=
```

Crearemos el archivo *SqlMapConfig.xml *que tendrá el
siguiente contenido:

```java
<?xml version="1.0" encoding="UTF-8" ?><br /><!DOCTYPE sqlMapConfig<br />PUBLIC "-//iBATIS.com//DTD SQL Map Config 2.0//EN"<br />"http://www.ibatis.com/dtd/sql-map-config-2.dtd"><br /><sqlMapConfig><br />  <properties resource="com/jugperu/tutores/ibatis/resources/database.properties"/><br />  <transactionManager type="JDBC"><br />    <dataSource type="SIMPLE"><br />      <property name="JDBC.Driver" value="${jdbc.driver}"/><br />      <property name="JDBC.ConnectionURL" value="${jdbc.url}"/><br />      <property name="JDBC.Username" value="${jdbc.username}"/><br />      <property name="JDBC.Password" value="${jdbc.password}"/><br />    </dataSource><br />  </transactionManager><br />  <sqlMap resource="com/jugperu/tutores/ibatis/resources/Almacen.xml"/><br /></sqlMapConfig>
```

El atributo “resource” del elemento “properties”
debe apuntar a la ubicación del archivo .properties que
acabamos de crear. Debe estar en posición relativa a nuestras
clases. Si deseamos utilizar una ubicación que esté
fuera del alcance de la aplicación, utilizaremos el atributo
“url”.

```java
<properties url="file://c:/proyecto/database.properties"/>
```

Vemos que las propiedades de las conexión (elementos <property
/>) utiliza variables como *${jdbc.driver}*. Esto es porque
está utilizando los valores nuestro archivo
*database.properties*. El archivo *SqlMapConfig.xml* solo
puede utilizar un archivo *.properties* para estos casos.

El elemento *<sqlMap/>* apunta a un archivo
*Almacen.xml*. Este archivo lo describiremos a continuación.
Al igual que el elemento *<properties />* se puede
especificar un url para apuntar a un recurso que se encuentre fuera
del alcance de la aplicación.

Los demás elementos de este .xml lo detallaremos en el
siguiente capítulo.

### Definiendo el mapa de consultas.

Crearemos el archivo *Almacen.xml* dentro del paquete
*com.jugperu.tutores.ibatis.resources* el cual tendrá el
siguiente contenido

```java
<?xml version="1.0" encoding="UTF-8" ?><br /><!DOCTYPE sqlMap<br />PUBLIC "-//iBATIS.com//DTD SQL Map 2.0//EN"<br />"http://www.ibatis.com/dtd/sql-map-2.dtd"><br /><sqlMap namespace="almacen"><br />  <typeAlias type="com.jugperu.tutores.ibatis.beans.Categoria" alias="categoria"/><br />  <insert id="insertCategoria" parameterClass="categoria"><br />    insert into CATEGORIA<br />    (cat_nombre)<br />    values (#nombre#)<br />  </insert><br />  <select id="getCategoriaPorId" resultClass="categoria" parameterClass="int"><br />    select cat_id as id, cat_nombre as nombre<br />    from categoria<br />    where cat_id=#value#<br />  </select><br /></sqlMap>
```

Detallaremos el contenido de este .xml:

El elemento *<typeAlias />* nos permitirá
describir un alias para evitar escribir un nombre clase largo. En
este caso, en vez de escribir
*"com.jugperu.tutores.ibatis.beans.Categoria"*
usaremos “*categoria”*

Vemos que tiene elementos que se pueden asociar rápidamente
a las sentencias SQL. Todos estos elementos tienen el atributo “id”.
Este nos permitirá identificar a cada uno de ellos.
Detallaremos la estructura de cada uno:

```java
<insert id="insertCategoria" parameterClass="categoria"><br />    insert into CATEGORIA<br />    (cat_nombre)<br />    values (#nombre#)<br />  </insert>
```

Este elemento recibe como parámetro un objeto cuyo tipo está
definido en el atributo “resultClass”. Como el nombre
completo de nuestra clase es bien largo, hemos definido un alias con
el elemento *<typeAlias />*. Por tanto, el tipo del
parámetro es *com.jugperu.tutores.ibatis.beans.Categoria*.

El comando INSERT debe guardar relación con la sintaxis del
motor que estamos usando. Los valores encerrados en signos numerales
(#) hacen referencia a las propiedades del objeto recibido como
parámetro.

El elemento *<select>* recibe como parámetro un
valor numérico “int” y devuelve devuelve un objeto
de tipo “categoria”. El parámetro “int”
es un alias predefinido de la clase *java.lang.Integer*. Por
tanto, al invocar a esta sentencia SQL pasaremos como parámetro
un objeto Integer.

```java
<select id="getCategoriaPorId" resultClass="categoria" parameterClass="int"><br />    select cat_id as id, cat_nombre as nombre<br />    from categoria<br />    where cat_id=#value#<br />  </select>
```

En este elemento tiene una sentencia SQL donde los campos que son
seleccionados tienen un alias. Es decir, el campo CAT_ID tiene como
alias “id”, y CAT_NOMBRE tiene como alias “nombre”.
De esta manera iBatis colocará cada campo de la tabla
resultante y los colocará en sus respectivas propiedades del
objeto a devolver.

### Programa de prueba

La mejor manera de hacer un programa de prueba es utilizando un
*TestCase* en *JUnit*. Crearemos nuestro TestCase
llamándolo IbatisMapsTestCase y tendrá el siguiente
método setUp().

```java
Reader reader = Resources.getResourceAsReader("SqlMapConfig.xml");<br />// el .xml para la conexión<br />        sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);<br />//construye el manejador de llamadas al iBatis
```

Crearemos nuestro test para registrar objetos *Categorias*.

```java
public void testInsertarCategorias() throws SQLException {<br />        try {<br />            sqlMap.startTransaction();<br />            Categoria c1 = new Categoria();<br />            Categoria c2 = new Categoria();<br />            Categoria c3 = new Categoria();<br />            c1.setNombre("memorias");<br />            c2.setNombre("placas");<br />            c3.setNombre("procesadores");<br /><br />            sqlMap.insert("insertCategoria", c1);<br />            sqlMap.insert("insertCategoria", c2);<br />            sqlMap.insert("insertCategoria", c3);<br /><br />            sqlMap.commitTransaction();<br />        } catch (SQLException ex) {<br />            ex.printStackTrace();<br />            assertTrue(false);<br />        } finally {<br />            sqlMap.endTransaction();<br /><br />        }<br />    }
```

También haremos un test para obtener un objeto.

```java
public void testGetCategoriaPorId() throws SQLException {<br />        try {<br />            sqlMap.startTransaction();<br /><br />            Categoria c1 = (Categoria) sqlMap.queryForObject(<br />                    "getCategoriaPorId", Integer.valueOf(2));<br />            assertNotNull(c1);<br />            mostrar(c1);<br /><br />        } catch (SQLException ex) {<br />            ex.printStackTrace();<br />            assertTrue(false);<br />        } finally {<br />            sqlMap.endTransaction();<br />        }<br />    }<br /><br />    private static void mostrar(Categoria cat) {<br />        System.out.println(cat.getId() + "\t" + cat.getNombre());<br />    }
```

### Claves autogeneradas

El método “insert” de sqlMap devuelve un objeto
que contiene el valor de la nueva clave generada (si aplica). Pero en
nuestro ejemplo el valor que devuelve es *null,* a pesar que
hemos declarado que la clave primaria es autonumérica . iBatis
nunca sabrá cual es el valor a menos que pongamos en la
sentencia sql qué valor tiene que devolver.

Editemos *Almacen.xml* en el
elemento <insert > de tal manera que luzca de la siguiente
manera.

```java
...<br />  <insert id="insertCategoria" parameterClass="categoria"><br />    insert into CATEGORIA<br />    (cat_nombre)<br />    values (#nombre#)<br />    <b><selectKey resultClass="int"></b><br />    <b>select distinct  identity() as id </b><br />    <b>from categoria </b><br />    <b></selectKey></b><br />  </insert><br />...
```

Esta es la sentencia para HSQLDB, que es el motor usado en este
ejemplo. Para MySQL el comando SQL que está dentro de
<selectKey> debería ser:

```java
...<br />    <selectKey resultClass="int"><br />    <b>select last_insert_id() as id</b><br />    </selectKey><br />...
```

y para SQL Server:

```java
...<br />    <selectKey resultClass="int"><br />    <b>select @@IDENTITY as ID</b><br />    </selectKey><br />...
```

### Manejando resultados

#### Definiendo mapa de resultados

Hemos visto que para asociar todos los campos de una consulta a
las propiedades del JavaBean, cada uno de estos debe tener un alías.
Lo cual nos puede ser un gran problema, ya que si se tratase de
varios campos, tendríamos que poner varios “as”
por cada uno. Y si fueran varias sentencias SQL, también nos
puede resulta problemático hacer una modificación.

iBatis nos permite crear un mapa de resultado. Allí
podremos definir la asociación que utilizaremos entre
propiedades del objeto y campos de la consulta.

Para ello agregaremos el siguiente elemento en *Almacen.xml*

```java
<resultMap id="res-categoria" class="categoria"><br />    <result property="id" column="cat_id"/><br />    <result property="nombre" column="cat_nombre"/><br />  </resultMap>
```

Cada vez que utilicemos como respuesta “res-categoria”,
iBatis se encargará de crear una instancia de “categoria”
y colocará en cada propiedad los valores de cada columna que
se utilice.

Agregaremos una consulta nueva:

```java
<select id="getAllCategoria" <b>resultMap="res-categoria"</b>><br />    select *<br />    from categoria<br />  </select>
```

Como se puede ver, ya no es necesario colocar un alias por cada
campo.

Y crearemos un nuevo test para probarlo:

```java
List lista = sqlMap.queryForList("getAllCategoria", null);<br />            for (Iterator iter = lista.iterator(); iter.hasNext(); ) {<br />                Categoria cat = (Categoria) iter.next();<br />                mostrar(cat);<br />            }
```

#### Resultados sin JavaBeans

No necesariamente utilizaremos un JavaBean para obtener un
resultado. Podemos utilizar un *java.util.HashMap* para obtener
todos los campos de una consulta. Cada *key* será el
nombre del campo, y su respectivo *value* será el valor
asociado.

```java
<resultMap id="res-map-categoria" class="java.util.HashMap"><br />    <result property="id" column="cat_id"/><br />    <result property="nombre" column="cat_nombre"/><br />  </resultMap><br />...<br />  <select id="getMapCategoriaPorId" resultMap="res-map-categoria"><br />    select *<br />    from categoria<br />    where cat_id=#value#<br />  </select>
```

El objeto devuelto por *queryForObject()* será de clase
*java.util.HashMap*.

```java
HashMap map = (HashMap) sqlMap.queryForObject(<br />                    "getMapCategoriaPorId", Integer.valueOf(1));
```

Por tanto, podríamos construir una consulta con diversos
campos sin preocuparnos por la estructura que va a devolver.

También podemos obtener solo un campo en una lista.

```java
<resultMap id="res-categoria-nombre" class="java.lang.String"><br />    <result property="nombre" column="cat_nombre"/><br />  </resultMap><br />...<br />  <select id="getNombresCategoria" resultMap="res-categoria-nombre"><br />    select *<br />    from categoria<br />  </select>
```

Y cada objeto de la lista obtenida de *queryForList()* será
un *java.lang.String*.

```java
List lista = sqlMap.queryForList("getNombresCategoria", null);
```

Naturalmente, podríamos crear una consulta que tenga como
*resultMap* un objeto *HashMap *e invocarlo con
*queryForList()* . El resultado será una lista donde cada
elemento será un *hashmap*.

### Manejando parámetros

iBatis también permite definir los parámetros que
van a recibir las consultas. Su estructura es muy similar a los
*resultMaps*.

```java
<parameterMap id="par-categoria" class="categoria"><br />    <parameter property="id"/><br />    <parameter property="nombre"/><br />  </parameterMap><br />//......<br />  <update id="updateCategoria" parameterMap="par-categoria"><br />    update categoria<br />    set cat_nombre=#nombre#<br />    where cat_id=#id#<br />  </update>
```

También podemos prescindir de un JavaBean para enviar
parámetros. Para ello utilizaremos un *java.util.Map*.
Cada *key* se accederá como si fuera una propiedad de un
JavaBean.

```java
<update id="updateMapCategoria" parameterClass="java.util.Map"><br />    update categoria<br />    set cat_nombre=#nombre#<br />    where cat_id=#id# <br />  </update>
```

### Asociaciones

Uno de los principales problemas del manejo de base de datos
relacionales utilizando objetos es la asociación entre tablas.

Crearemos una tabla PRODUCTO con la siguiente estructura:

<table border="1"><br /><tbody><tr><br /><th><br /><p>Campo</p><br /></th><br /><th><br /><p>Tipo</p><br /></th><br /></tr><br /><tr><br /><td><br /><p>PR_ID</p><br /></td><br /><td><br /><p>Autonumérico (clave principal)</p><br /></td><br /></tr><br /><tr><br /><td><br /><p>PR_NOMBRE</p><br /></td><br /><td><br /><p>Varchar(30)</p><br /></td><br /></tr><br /><tr><br /><td><br /><p>PR_PRECIO</p><br /></td><br /><td><br /><p>Decimal</p><br /></td><br /></tr><br /><tr><br /><td><br /><p>PR_STOCK</p><br /></td><br /><td><br /><p>Numérico entero</p><br /></td><br /></tr><br /><tr><br /><td><br /><p>PR_CATEGORIA</p><br /></td><br /><td><br /><p>Numérico no nulo (clave foránea de CATEGORIA)</p><br /></td><br /></tr><br /></tbody></table>

Crearemos el JavaBean con sus respectivas propiedades:

```java
package com.jugperu.tutores.ibatis.beans;<br /><br />public class Producto {<br />    private int id;<br />    private String nombre;<br />    private int stock;<br />    private double precio;<br />    private Categoria categoria;<br />//.....<br />}
```

#### Agregando un registro

Crearemos un *<insert >* para manejar la inserción
de objetos a la tabla.

```java
<typeAlias type="com.jugperu.tutores.ibatis.beans.Producto" alias="producto"/><br />//...<br />  <insert id="insertProducto" parameterClass="producto"><br />    insert into producto<br />    (pr_nombre,pr_stock,pr_precio,pr_categoria)<br />    values (#nombre#,#stock#,#precio#,<b>#categoria.id#</b>)<br />  </insert>
```

Note cómo se accede a una propiedad de *Producto*
que es de clase *Categoria*. En caso que la propiedad
**categoria** fuera nulo, iBatis toma toda la expresión
(categoria.id) como nulo.

Probamos insertar un objeto *Producto*:

```java
Categoria cat = (Categoria) sqlMap.queryForObject(<br />                    "getCategoriaPorId", Integer.valueOf(1));<br />            Producto p1 = new Producto();<br />            p1.setNombre("Kingston");<br />            p1.setPrecio(300.50);<br />            p1.setStock(5);<br />            p1.setCategoria(cat);<br /><br />            sqlMap.insert("insertProducto", p1);
```

Es necesario recalcar que iBatis no agrega automáticamente los
objetos asociados que no existan en la base de datos. Es decir, si se
crea un objeto *Categoria* y se asocia a un nuevo objeto de
*Producto*, al hacer el *insert()* solo se guardarán
los valores del objeto *Producto* y no los del objeto *Categoria*.

#### Obteniendo un registro

Para obtener un registro mapeado en
objeto, al <*resultMap>* se agregará un atributo
más:

```java
<resultMap id="res-producto" class="producto"><br />    <result property="id" column="pr_id"/><br />    <result property="nombre" column="pr_nombre"/><br />    <result property="stock" column="pr_stock"/><br />    <result property="precio" column="pr_precio"/><br />    <result property="categoria" column="pr_categoria" select="getCategoriaPorId"/><br />  </resultMap>
```

Como se ve, para la propiedad *categoria* se tomará el
campo *pr_categoria* y se buscará su valor del select
*getCategoriaPorId*. Al hacer esto, se invocará a dicho
*select* y se le pasará como parámetro el valor de
*pr_categoria* obteniendo el objeto correspondiente.

El select para obtener objetos de
*Producto* será muy simple:

```java
<select id="getProductoPorId" resultMap="res-producto"><br />    select *<br />    from producto<br />    where pr_id=#value#<br />  </select>
```

Y la llamada desde java será la misma que se ha estado
manejando:

```java
Producto p = (Producto) sqlMap.queryForObject("getProductoPorId",<br />                    Integer.valueOf(1));<br />            mostrar(p); //muestra cada campo del objeto “p”<br />//.....<br /><br />    private static void mostrar(Producto p) {<br />        System.out.println(p.getId() + "\t" + p.getNombre() + "\t" +<br />                           p.getPrecio() + "\t" + p.getStock() + "(" +<br />                           p.getCategoria().getNombre() + ")");<br />    }
```

Pero esta solución tiene una deficiencia: para obtener un
producto, iBatis hará dos consultas: uno para el producto y
otro para la categoría. Si fueran varios productos, hará
una consulta por los productos y N consultas por cada producto para
obtener su categoria.

Esto se puede solucionar haciendo un *join* modificando el
*<resultMap >*.

```java
<resultMap id="res-producto-opt" class="producto"><br />    <result property="id" column="pr_id"/><br />    <result property="nombre" column="pr_nombre"/><br />    <result property="stock" column="pr_stock"/><br />    <result property="precio" column="pr_precio"/><br />    <result property="categoria.id" column="pr_categoria"/><br />    <result property="categoria.nombre" column="cat_nombre"/><br />  </resultMap><br />....<br />  <select id="getAllProductoOpt" resultMap="res-producto-opt"><br />    select *<br />    from producto p, categoria c<br />    where p.pr_categoria=c.cat_id<br />  </select>
```

## Conclusiones

Con iBatis se puede mapear las consultas que necesitamos para
nuestro proyecto. La sintaxis que se utilice para manejar los
registros de la base de datos está fuertemente aislada en la
lógica de negocio. Esto nos permite tener un código
limpio de sentencias SQL. Si es necesario hacer alguna modificación
en SQL, bastará con editar el XML y no una clase en java
evitando la compilación de esta.
