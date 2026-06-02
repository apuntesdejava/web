---
layout: post
title: "Groovy: Un lenguaje dinámico y ágil para la Plataforma Java"
date: 2010-01-04T23:13:00Z
last_modified_at: 2010-01-04T23:13:44.101Z
author: "Diego Silva"
permalink: /2010/01/groovy-un-lenguaje-dinamico-y-agil-para.html
canonical_url: https://www.apuntesdejava.com/2010/01/groovy-un-lenguaje-dinamico-y-agil-para.html
tags:
  - "netbeans 6.8"
  - "groovy"
  - "tutorial"
  - "netbeans"
---

El primer post de este año quisiera dedicarlo a un lenguaje interesante. Este es Groovy: Un lenguaje dinámico como JavaScript, pero no es interpretado; tiene acceso a todo el API de Java, se ejecuta sobre el JVM, y por tanto puede interactuar con nuestras aplicaciones Java. Podemos tener algunas clases en Groovy y otras en Java. Más información lo puedes encontrar en [Wikipedia](http://es.wikipedia.org/wiki/Groovy_%28Lenguaje_de_Programaci%C3%B3n%29).

Lo bueno de este lenguaje es que - a gran diferencia de Java - no necesita de una clase "Main" para ejecutar la aplicación. Es como JavaFX, PHP, o como JavaScript, que ejecuta las instrucciones de arriba a medida que se van declarando. Por tanto, un "HolaTodos" puede ser así

```java
<code>
package demogroovy

public class Prueba{
    public static void main(String[] a){
        System.out.println("Hola a todos");
    }
}
</code>
```

o así:

```java
<code>
package demogroovy
println("Hola a todos")
</code>
```

Ambos son válidos en Groovy. Notar que los punto-y-coma (;) son opcionales.

NetBeans nos permite crear clases Groovy en cualquier proyecto Java. Por tanto, necesitamos crear un proyecto Java cualquiera (web o desktop) y luego crear las clases Groovy.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8HA0psWIN_Ywwna8QLdCthNe66H9f3fCVHxIu5PeDy4T6VRmkz0jUbGfwlXria1OxEziRn_CexlQm5uHbsmGgf043m3r3Wqx_tsFHD9tfbBL9ckrFQ0Rkf2v55AHUpYYKy6ApS586DN26/s400/groovy01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8HA0psWIN_Ywwna8QLdCthNe66H9f3fCVHxIu5PeDy4T6VRmkz0jUbGfwlXria1OxEziRn_CexlQm5uHbsmGgf043m3r3Wqx_tsFHD9tfbBL9ckrFQ0Rkf2v55AHUpYYKy6ApS586DN26/s1600-h/groovy01.jpg)

 No voy hacer un tutorial de Groovy ya que hay uno bueno aquí: [http://groovy.org.es/](http://groovy.org.es/) en español, o si deseas la fuente en inglés, aquí está la web oficial: [http://groovy.codehaus.org/](http://groovy.codehaus.org/). Solo voy a resaltar cosas muy interesantes de este lenguaje. Por ejemplo, el acceso a base de datos:

Como está hecho en Java, entonces debe utilizar las bibliotecas de java. Si deseo acceder a la base de datos Apache Derby, debo utilizar sus drivers; si uso MySQL, debo usar su respectivo driver, y así.

Un ejemplo que adapto de ["Tutorial 6 - Groovy SQL"](http://groovy.codehaus.org/Tutorial+6+-+Groovy+SQL) es este:

```java
<code>
package demogroovy

import groovy.sql.Sql;

sql=Sql.newInstance("jdbc:derby://localhost:1527/sample",
        "app","app",
        "org.apache.derby.jdbc.ClientDriver")
println "ID Prod.\tDescripción"
sql.eachRow("select * from product",
    {println "${it.product_id}\t${it.description} "})

fila=sql.firstRow("select customer_id,name,email from customer")
println "Cliente ${fila.customer_id}:${fila.name} -> ${fila.email}"
</code>
```

Aquí estoy usando la base de datos "sample" que viene como ejemplo en NetBeans.

La simpleza del lenguaje permite ahorrar tiempo en programación. Por ejemplo, podemos tener un JavaBean en Java:

```java
<code>
package demogroovy.beans;

public class Cliente {

    private int id;
    private String nombre;
    private String correo;

    public Cliente() {
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
</code>
```

Luego, podemos tener un DAO hecho en Groovy:

```java
<code>
package demogroovy.dao
import groovy.sql.Sql;
import demogroovy.beans.Cliente

class ClientesDao {
    private def sql;
    ClientesDao(){
        sql=Sql.newInstance("jdbc:derby://localhost:1527/sample", //URL del JDBC
        "app","app", //usuario y contraseña
        "org.apache.derby.jdbc.ClientDriver") //driver del JDBC
    }

    def getClientes(){
        def lista=[];
/*notar las comillas de los alias de cada campo. Esto nos asegura que cada campo
será asociado a cada propiedad del bean Cliente.
*/
        sql.eachRow("SELECT customer_id as \"id\",name as \"nombre\",email as \"correo\" FROM customer"){
             Cliente c=new Cliente(it.toRowResult()) //se instancia y pone las propiedades segun corresponda de acuerdo al metodo toRowResult()
            lista << c //agrega a la lista
        }
        return lista;
    }

    def updateCliente(Cliente c){
        sql.executeUpdate("UPDATE customer SET name=?, email=? WHERE customer_id=?",[c.nombre,c.correo,c.id])
    }

}
</code>
```

Notemos que para acceder a las propiedades del bean no necesitamos usar los métodos set/get.. solo accedemos a la propiedad misma.

Y para acceder al dao, lo hacemos como si fuera un objeto java:

```java
<code>
List<Cliente> clientes= (List) dao.getClientes();
</code>
```

Es un ahorro de código, de esfuerzo y de tinta si se desea imprimir los códigos fuentes (¿aún se hace eso? Por el bien de la naturaleza espero que ya no).

Aquí he colgado un proyecto de cómo usar un JFrame + JTable para acceder a una base de datos, usando una clase Groovy para el DAO.

[http://diesil-java.googlecode.com/files/DemoGroovy.tar.gz](http://diesil-java.googlecode.com/files/DemoGroovy.tar.gz)

Utiliza el Apache Derby, por lo que primero debemos iniciar el servidor. En su defecto, se puede utilizar otra base de datos, y hacer los cambios respectivos.
