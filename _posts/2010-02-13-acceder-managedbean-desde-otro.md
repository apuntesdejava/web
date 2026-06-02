---
layout: post
title: "Acceder a ManagedBean desde otro ManagedBean en JSF 2.0"
date: 2010-02-13T23:11:00.001Z
last_modified_at: 2011-09-19T18:36:19.352Z
author: "Diego Silva"
permalink: /2010/02/acceder-managedbean-desde-otro.html
canonical_url: https://www.apuntesdejava.com/2010/02/acceder-managedbean-desde-otro.html
tags:
  - "java ee"
  - "java ee 6"
  - "jsf"
  - "web"
  - "jsf 2.0"
---

Cuando se trabaja con variables sesión en JSP/Servlets es fácil guardar estas variables y también accederlas... bueno, al menos para quien ha trabajado bastante con este tipo de variables de sesión: Desde un servlet se debería escribir

```java
request.setAttribute("obj1",obj1);
```

... cuando se desea guardar una variable de sesión de alcance "request".Para uno de alcance "sesión" es una historia similar.

Y desde un JSP para acceder a esta variable de sesión, usando EL, deberíamos usar algo como esto:

```java
<code> Mostrando objeto: ${ob1}</code>
```

Pero en JSF (en especial la versión 2.0), ya no se debería utilizar variables de sesión ya que JSF propone ManagedBeans que tengan alcance Scope, Request, Application, Custom y none. Pues bien, esto funcionaría así.

Un ManagedBean:

```java
@ManagedBean(name="bean1")
@SessionScoped
public class Bean1 {

    public Bean1() {
    }
    private String nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

}
```

Y para accederlo desde una página JSF, debería ser así:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h:form>
            Nombre:<h:inputText value="#{bean1.nombre}" />
            <br/><h:commandButton value="Guardar" />
        </h:form>
    </h:body>
</html>
```

Todo normal.. y si accedemos desde otra página, bastaría con escribir `#{bean1.nombre}`

Hasta ahí todo normal y muy bien.. pero que pasaría si tenemos otro managedBean y queremos acceder al primer managedBean?

Pues bien, se debería declarar una propiedad (con set/get) del tipo del primer ManagedBean, y agregarle la anotación `@ManagedProperty("#{bean1}")` (Donde bean1 es el nombre del otro managedbean. Y listo!! solo usar.

```java
@ManagedBean(name = "bean2")
@RequestScoped
public class Bean2 {

    @ManagedProperty("#{bean1}")
    private Bean1 bean1;

    /** Creates a new instance of Bean2 */
    public Bean2() {
    }

    public String getSaludo() {
        return "Hola " + bean1.getNombre();
    }

    public Bean1 getBean1() {
        return bean1;
    }

    public void setBean1(Bean1 bean1) {
        this.bean1 = bean1;
    }

}
```

El código fuente de este ejemplo se encuentra aquí: [http://diesil-java.googlecode.com/files/ScopesJSF20.tar.gz](http://diesil-java.googlecode.com/files/ScopesJSF20.tar.gz)
