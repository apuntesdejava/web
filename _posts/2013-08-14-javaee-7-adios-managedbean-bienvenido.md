---
layout: post
title: "JavaEE 7: Adios ManagedBean, Bienvenido CDI"
date: 2013-08-14T05:15:00.002Z
last_modified_at: 2013-08-14T05:15:43.376Z
author: "Diego Silva Límaco"
permalink: /2013/08/javaee-7-adios-managedbean-bienvenido.html
canonical_url: https://www.apuntesdejava.com/2013/08/javaee-7-adios-managedbean-bienvenido.html
tags:
  - "javaee7"
  - "netbeans 7.3"
  - "java ee"
  - "netbeans"
  - "jsf"
  - "jsf 2.2"
---

En la reciente versión de Java EE7, los ManagedBean ( o también llamados Bean Administrados) ya no se usarán. Estos beans se usaban como Backend de las páginas JSF. En su lugar, se usarán inyección de dependencias, ya que se instanciarán de la misma manera como lo hacía los ManagedBean.

Un cambio adicional en JavaEE7, es que ya no se va a necesitar del archivo beans.xml cuando se quiera usar CDI.

Probemos con el clásico "Hola mundo", para ver cómo funciona.

Tenemos una clase llamada Saludo.java, que contiene el siguiente código:

```java
package com.apuntesdejava.cdi;

import javax.enterprise.context.RequestScoped;
import javax.inject.Named;

@Named
@RequestScoped
public class Saludo {

    private String nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSaludo() {
        if (nombre != null && !nombre.isEmpty()) {
            return "Hola " + nombre;
        }
        return null;
    }
}
```

Notemos que la notación `@RequestScope` es del paquete, y no de faces.

Al usar @ManagedBean hacíamos que la clase solo sea usado para JSF. Por otro lado, al usarlo como CDI, la instanciación de la clase puede ser utilizada en cualquier parte sin necesidad que sea un JSF.

Ahora, veamos como será nuestro JSF.

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h:form>
            <h2>CDI en JSF</h2>
            Escriba su nombre:<h:inputText value="#{saludo.nombre}" />
            <br/>
            <h:commandButton value="Saludar!" />
            <p>
                <h:outputText value="#{saludo.saludo}" />
            </p>
        </h:form>
    </h:body>
</html>
```

Luego veremos más ejemplos de CDI con JSF 2.2
