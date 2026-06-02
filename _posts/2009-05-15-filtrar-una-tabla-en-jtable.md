---
layout: post
title: "Filtrar una tabla en JTable"
date: 2009-05-15T18:02:00.002Z
last_modified_at: 2009-06-15T20:20:57.295Z
author: "Diego Silva"
permalink: /2009/05/filtrar-una-tabla-en-jtable.html
canonical_url: https://www.apuntesdejava.com/2009/05/filtrar-una-tabla-en-jtable.html
tags:
  - "swing"
  - "desktop"
  - "java"
  - "jdbc"
  - "netbeans"
  - "tips"
  - "sql"
  - "trucos"
---

Un alumno me pregunta cómo filtrar los datos de un JTable, siendo estos datos obtenidos de un query.

La mejor manera no es manipular el JTable a través de su cantidad de columnas, agregando filas, borrando algunas de ellas, modificando las celdas, etc. Eso es realmente un dolor de cabeza.

Recordemos que estamos trabajando en Java que es Orientado  a Objetos.. no en VisualBasic.

Así que, si queremos manipular los datos de un JTable, debemos usar una clase que se encargue de manipular los datos, y que el jtable use esa clase.

La interfaz `TableModel` es la indicada. Pero tiene demasiados métodos a implementar. Así que usaremos algo ya casi hecho. Se llama la clase abstracta `AbstractTableModel`.

Simplemente, debemos heredarla:

```java
<code>public class PersonasTableModel extends AbstractTableModel {....</code>
```

Y con eso debemos implementar tres métodos: `getRowCount()`, `getColumnCount()` y `getValueAt(int rowIndex, int columnIndex)`.

La clase que estamos creando debe tener un arreglo interno. Este arreglo es el resultado del query en la base de datos.

```java
<code>//...    private List<person> personas = new ArrayList<person>();//...</person></person></code>
```

¿Por qué? Pues, los métodos que estamos implementado deben manipular ese arreglo. No la base de datos, ya que ese arreglo - como dije - es el resultado de un query en la base de datos.

Si se hace una búsqueda (filtrar por nombres por ejemplo), se debe hacer el query en la base de datos, y rehacer la lista. De tal manera que el jtable siempre tomara el valor del mismo modelo y este tiene la nueva lista.

Aquí dejo un ejemplo en NetBeans usando la base de datos TRAVEL. Se debe iniciar el java db del netbeans para que funcione.

El código fuente se encuentra aquí: [http://diesil-java.googlecode.com/files/FiltroJTable.tar.gz](http://diesil-java.googlecode.com/files/FiltroJTable.tar.gz)
