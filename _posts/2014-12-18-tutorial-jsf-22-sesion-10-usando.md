---
layout: post
title: "Tutorial JSF 2.2 - Sesión 10: Usando Converters, Listeners, y Validators"
date: 2014-12-19T01:52:00.001Z
last_modified_at: 2018-01-10T23:43:28.647Z
author: "Diego Silva Límaco"
permalink: /2014/12/tutorial-jsf-22-sesion-10-usando.html
canonical_url: https://www.apuntesdejava.com/2014/12/tutorial-jsf-22-sesion-10-usando.html
tags:
  - "glassfish"
  - "java ee"
  - "java ee 7"
  - "netbeans"
  - "jsf"
  - "jsf 2.2"
---

[![Tutorial JSF 2.2 - Sesión 10: Usando Converters, Listeners, y Validators](/assets/blogger/lossless-page1-320px-20110510-jsf-logo.tiff.png)](/assets/blogger/lossless-page1-320px-20110510-jsf-logo.tiff.png)

Siguiendo por nuestro viaje por el mundo del JSF (y ya estando cerca al fin), aprenderemos a usar los Converters, Listeners y Validators.

Recordemos que:

- Los converters son usados para convertir que es recibida desde un componente de entrada (como el inputText).

- Los Listeners son usados para que escuchen los eventos que sucedan en una página para realizar acciones definidas.

- Los validators son usados para validar que el dato que es recibido por un componente de entrada cumpla con los requisitos necesarios antes de que sea procesado en la aplicación.

Con esta pequeña introducción, comenzaremos...

### Usando Converters estándar

La impelementación de JSF proporciona un conjunto de implementaciones de Converters que podemos usar para convertir datos. Su función principal es tomar una cadena que viene desde el API del Servlet y convertirlo a objetos Java para nuestra aplicación.

Las clases de los converters están en el paquete javax.faces.convert. Cada converter está asociado a un mensaje de error, por si falla la conversión. Si se le pide que convierta una cadena en un número, el JSF ya tiene preparado el mensaje de error a mostrar.

Si quieren ver cuáles son los mensajes de errores predeterminados de GlassFish, pueden revisar el archivo `$GLASSFISH_HOME/modules/javax.faces.jar`

Aquí una pequeña muestra del contenido del archivo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUsY8T_VQ9Ykbi_Z-IQ0VkGEQ_pW2tTvofSULa-sAnR0RuCNBwatGnqGnJs0uU6im37kIKl7h-jyDyTp5i5hSu_bjgkL_pcu5RtAqw76ek7GdQEe5OiNJiz9iyKXl-JtiNyGNab3Mp9fw/s1600/15-12-2014+12-12-38+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUsY8T_VQ9Ykbi_Z-IQ0VkGEQ_pW2tTvofSULa-sAnR0RuCNBwatGnqGnJs0uU6im37kIKl7h-jyDyTp5i5hSu_bjgkL_pcu5RtAqw76ek7GdQEe5OiNJiz9iyKXl-JtiNyGNab3Mp9fw/s1600/15-12-2014+12-12-38+p.m..png)

Vamos a probar el uso de un converter estándar.

Recordemos algo: todas las entradas desde un input son siempre texto (String), por tanto, nuestro converter debe tener la capacidad de convertirlo a número antes que llegue al ManagedBean.

En nuestro proyecto de ejemplo, haremos que guarde un campo de tipo numérico llamado "edad".

```java
package com.apuntesdejava.jsf.converters;

import java.io.Serializable;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

/**
 *
 * @author dsilva
 */
@Named
@SessionScoped
public class FormBean implements Serializable{

    private Integer edad;

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

}
```

Ahora, pondremos nuestro `inputText` que guarde ese valor, pero con el converter (que está resaltado en el siguiente código)

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h1>Probando converters</h1>
        <h:form>
            <h:outputLabel value="Escribir la edad:"/>
            <h:inputText value="#{formBean.edad}">
                <f:converter converterId="javax.faces.Integer" />
            </h:inputText>
        </h:form>
    </h:body>
</html>
```

Al ejecutarlo, y escribir un texto (y presionar Enter) el formulario tratará de evaluarlo antes de guardarlo, y si no es un número, lanzará el mensaje de error:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdfL0sF3wj96QQKF5fA63gE2NXMvmWgUbAdAnaYRuIzglDuTXRQPf04l78m9RZyrMG1fV_zuyxelTVan3Ji5d7HTIXZRdBrzwHloJAntIxMUiR7RfX7vTHcSMrMZm64BRwhlA6xzTk3HU/s1600/15-12-2014+12-30-35+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdfL0sF3wj96QQKF5fA63gE2NXMvmWgUbAdAnaYRuIzglDuTXRQPf04l78m9RZyrMG1fV_zuyxelTVan3Ji5d7HTIXZRdBrzwHloJAntIxMUiR7RfX7vTHcSMrMZm64BRwhlA6xzTk3HU/s1600/15-12-2014+12-30-35+p.m..png)

Así se ingrese un número decimal, mostrará el mismo mensaje de error, porque el valor no es un número entero. En cambio, si escribimos un número entero, y presionamos Enter, entonces no mostrará ningún mensaje de error (y no va a mostrar nada, porque no le hemos puesto nada de mensajes)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgl2-Q70Ck971cF-BgAcvgmMbVmsV_IYNJh0D_aYXFe7yB8M3cZ8P3LZIo5m_oC0OEzoOPS5GMNc-QXgAvzyU7co2WhuBNHzPWf9DU5iZVeiT2PSDvd6ix0Qr_nDaD32E_p_TR4VrliHpE/s1600/15-12-2014+12-32-36+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgl2-Q70Ck971cF-BgAcvgmMbVmsV_IYNJh0D_aYXFe7yB8M3cZ8P3LZIo5m_oC0OEzoOPS5GMNc-QXgAvzyU7co2WhuBNHzPWf9DU5iZVeiT2PSDvd6ix0Qr_nDaD32E_p_TR4VrliHpE/s1600/15-12-2014+12-32-36+p.m..png)

Notemos que el tag tiene el atributo converterId con un ID. Para ver la lista de todos los ID de converter que corresponde a cada clase converter, lo podemos encontrar aquí: [Table 11-1 Converter Classes and Converter IDs](https://docs.oracle.com/javaee/7/tutorial/jsf-page-core001.htm#CHDIHIIC)

Ahora hagámoslo más interesante (y es para resolver una pregunta repetitiva que me han hecho): Cómo convertir un inputText en una fecha (java.util.Date). Pues, casi lo mismo. Solo que en este caso, usaremos el tag `<f:converterDateTime />`

Primero, agregaremos a nuestro ManagedBean el atributo de tipo `java.util.Date` (ojo, es fecha, no String):

```java
package com.apuntesdejava.jsf.converters;

import java.io.Serializable;
import java.util.Date;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

/**
 *
 * @author dsilva
 */
@Named
@SessionScoped
public class FormBean implements Serializable{

    private Integer edad;
    private Date fechaRegistro;

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

}
```

Ahora, hagamos el `inputText`, pero para que no vean que hago trampa, haremos que el mismo valor que se ingrese, se vuelva a imprimir pero con otro formato... total, si es tipo `java.util.Date` puede moldearse a cualquier formato:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h1>Probando converters</h1>
        <h:form>
            <h:panelGrid columns="2">
                <h:outputLabel value="Escribir la edad:"/>
                <h:inputText value="#{formBean.edad}">
                    <f:converter converterId="javax.faces.Integer" />
                </h:inputText>

                <h:outputLabel value="Fecha registro:"/>
                <h:inputText value="#{formBean.fechaRegistro}">
                    <f:convertDateTime pattern="dd/MM/yyyy" />
                </h:inputText>

                <h:outputText value="#{formBean.fechaRegistro}">
                    <f:convertDateTime dateStyle="full" locale="es"/>
                </h:outputText>
            </h:panelGrid>
            <h:commandButton value="Entrar"/>
        </h:form>
    </h:body>
</html>
```

Para el `inputText` notemos que el converter tiene de formato `dd/MM/yyyy`. Lo que significa que se solo va convertir en formato fecha si es que tiene ese patrón: día (dos dígitos), mes (dos dígitos), año (cuatro dígitos) separados por el signo de la barra inclinada ("/"). Una vez convertido, cuando se recargue la página, se mostrará con el formato indicado en la línea 24: fecha completa en idioma español.

Este sería el resultado, si ingreso una fecha válida:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3x6OM2sXc-WiaZ6gwuyqDhR8BHEh6GTYg81K0VsxzY5maB-xORpHXmCfERrp7UA0nHl0kNVqlhZqINi6Rc9Ne2P1Kem9i7gTzIHxAXUxJu9xhSn61oEwjrq4mrihUn7s4-jyNs9X4Mko/s1600/15-12-2014+03-09-42+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg3x6OM2sXc-WiaZ6gwuyqDhR8BHEh6GTYg81K0VsxzY5maB-xORpHXmCfERrp7UA0nHl0kNVqlhZqINi6Rc9Ne2P1Kem9i7gTzIHxAXUxJu9xhSn61oEwjrq4mrihUn7s4-jyNs9X4Mko/s1600/15-12-2014+03-09-42+p.m..png)

Para conocer más sobre el formato de fechas, podemos revisar la lección del Tutorial Java: [Customizing Formats](http://docs.oracle.com/javase/tutorial/i18n/format/simpleDateFormat.html).

Y para el tratamiento de monedas, podemos usar el tag `convertNumber` y podemos indicar el tipo de moneda a usar, y la plataforma se encargará de convertirlo.

```java
<h:outputLabel value="Precio total"/>
                <h:outputText value="#{formBean.precioTotal}">
                    <f:convertNumber currencyCode="USD"  type="currency"/>
                </h:outputText>
```

Por ejemplo, si la propiedad `precioTotal` fuera un Double con el valor `123.456`, este sería el resultado:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhUrhFcfkLHgcqsH3LKdK6bfghnNfrTk4AmG_gvwwScUB7tP27cgkjM0Yb9dcw0-DodgqYsbXfo7-ytJz66q1Sp7nc58Xe8rxKLDzSM-_UF5Gs9u6eXSbgi5Sys5nWllaACL7_24eMLXQg/s1600/15-12-2014+03-20-28+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhUrhFcfkLHgcqsH3LKdK6bfghnNfrTk4AmG_gvwwScUB7tP27cgkjM0Yb9dcw0-DodgqYsbXfo7-ytJz66q1Sp7nc58Xe8rxKLDzSM-_UF5Gs9u6eXSbgi5Sys5nWllaACL7_24eMLXQg/s1600/15-12-2014+03-20-28+p.m..png)

Más sobre el formato de números, podemos revisar la lección del Tutorial Java: "[Customizing Formats](http://docs.oracle.com/javase/tutorial/i18n/format/decimalFormat.html)".

### Registrando Listeners en Componentes

Los Listeners son métodos de ManagedBean o clases (que implementa a `javax.faces.event.ValueChangeListener`) que nos permite interceptar ciertos eventos antes de que llegue el requerimiento al ManagedBean. Por ejemplo, podemos interceptar cada vez que hay un cambio en el valor del componente

Veamos esta clase:

```java
package com.apuntesdejava.jsf.listeners;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.ValueChangeEvent;
import javax.faces.event.ValueChangeListener;

/**
 *
 * @author dsilva
 */
public class CambiaNombreChangeListener implements ValueChangeListener {

    private static final Logger LOG = Logger.getLogger(CambiaNombreChangeListener.class.getName());

    @Override
    public void processValueChange(ValueChangeEvent event) throws AbortProcessingException {
        LOG.log(Level.INFO, "Entrando al Listener de {0}", getClass().getName());
        if (event.getNewValue() != null) {
            LOG.log(Level.INFO, "\tNuevo valor:{0}", event.getNewValue());
        }
    }

}
```

Además, agreguemos la propiedad `nombre` al ManagedBean

```java
public class FormBean implements Serializable{
    private static final Logger LOG = Logger.getLogger(FormBean.class.getName());

    private Integer edad;
    private Date fechaRegistro;
    private Double precioTotal=123.456;

    private String nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        LOG.log(Level.INFO, "Nuevo valor para la propiedad Nombre:{0}", nombre);
        this.nombre = nombre;
    }
```

Ahora bien, este será nuestra página modificada:

```java
<h:outputLabel value="Escribe tu nombre:"/>
                <h:inputText value="#{formBean.nombre}" required="true">
                    <f:valueChangeListener type="com.apuntesdejava.jsf.listeners.CambiaNombreChangeListener" />
                </h:inputText>
            </h:panelGrid>
```

Cuando escribamos un valor en el campo "nombre" y hagamos clic en "Entrar", el resultado en el log será el siguiente:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQd98-Pwi7SQYFeIKracSkECmDoJo9l98pyvrPZqNcRwdImrPNuELorR47WVlz-B4e264h8OoZDOyclp4XaJY29xpp_g4RyF-MIKBfZhZVkbJJOB-kw2a2OUg3o5B5n88HHBG-9nIfitM/s1600/15-12-2014+04-56-05+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQd98-Pwi7SQYFeIKracSkECmDoJo9l98pyvrPZqNcRwdImrPNuELorR47WVlz-B4e264h8OoZDOyclp4XaJY29xpp_g4RyF-MIKBfZhZVkbJJOB-kw2a2OUg3o5B5n88HHBG-9nIfitM/s1600/15-12-2014+04-56-05+p.m..png)

### Usando Validators estándard

Los validadores son componentes que permiten validar una entrada de texto que tenga cierta estructura. Existen cinco predefinidos, y estos son las clases y tags que se utilizan para usar correctamente un validador:

<table>
<thead>
<tr><th>Clase</th><th>Tag</th><th>Función</th>
</tr>
</thead>
<tbody>
<tr><td><code>BeanValidator</code></td><td><code>validateBean</code></td><td>Registra un validador para el componente</td></tr>
<tr><td><code>DoubleRangeValidator</code></td><td><code>validateDoubleRange</code></td><td>Verifica que el valor a ingresar esté dentro de un rango determinado. El valor debe ser un punto flotante o convertible a punto flotante.</td></tr>
<tr><td><code>LengthValidator</code></td><td><code>validateLength</code></td><td>Verifica que la longitud del valor ingresado en el componente tenga máximo un determinado valor. El valor a ingresar en el componente debe ser una cadena java.lang.String</td></tr>
<tr><td><code>LongRangeValidator</code></td><td><code>validateLongRange</code></td><td>Verifica que el valor que se ingresa en el componente deba estar dentro de un rango determinado. El valor puede ser de tipo numérico o una cadena que pueda ser convertido a long.</td></tr>
<tr><td><code>RegexValidator</code></td><td><code>validateRegex</code></td><td>Verifica que el valor ingresado en el componente coincida con una expresión regular (regex)</td></tr>
<tr><td><code>RequiredValidator</code></td><td><code>validateRequired</code></td><td>Se asegura que se haya ingresado un valor en el componente, no permite valores vacíos.</td></tr>
</tbody>
</table>

Todas las clases implementan la interfaz `Validator`. Es decir, también podemos crear nuestros propios validadores si implementamos dicha interfaz.

Si queremos validar que el valor ingresado debe tener un valor entre 1 y 10:

```java
<h:outputLabel value="Cantidad" for="cantidad"/>
                <h:inputText id="cantidad" size="4" value="#{formBean.cantidad}">
                    <f:validateLongRange minimum="1" maximum="10"/>
                </h:inputText>
                <h:message for="cantidad"/>
```

Si ingresamos un valor fuera del rango, nos aparece un mensaje de error:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEisZ_DRVyaocCQ2ngF8CmGWeElXGwXnUm-UPe7bSwyeN9p4LvbatAteBcmnihBz3MBOwqByE4tcmaFItgnAx-PcmLgqBnZiUqMXAFk7tlU290Z5gOrmRjqeZ5sp9T1ZKL6Y4J9gjIvkRVU/s1600/18-12-2014+08-33-02+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEisZ_DRVyaocCQ2ngF8CmGWeElXGwXnUm-UPe7bSwyeN9p4LvbatAteBcmnihBz3MBOwqByE4tcmaFItgnAx-PcmLgqBnZiUqMXAFk7tlU290Z5gOrmRjqeZ5sp9T1ZKL6Y4J9gjIvkRVU/s1600/18-12-2014+08-33-02+p.m..png)

Y si queremos, también podemos validar - usando regexp - que la cadena ingresada sea un correo electrónico:

```java
<h:outputLabel value="Correo electrónico" for="email"/>
                <h:panelGroup>
                    <h:inputText id="email" value="#{formBean.email}">
                        <f:validateRegex  pattern="[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}"/>
                    </h:inputText>
                    <h:message for="email" errorStyle="color:red"  />
                </h:panelGroup>
```

Regex tomado de: [http://www.regular-expressions.info/email.html](http://www.regular-expressions.info/email.html)

### Código fuente

Si quieren explorar el código fuente del proyecto aquí expuesto, lo pueden hacer entrando a [https://bitbucket.org/apuntesdejava/blog/src/tip/jsf-10-converters-listeners-validators/](https://bitbucket.org/apuntesdejava/blog/src/tip/jsf-10-converters-listeners-validators/)

Y también pueden bajar el código fuente en

[https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-10-converters-listeners-validators.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-10-converters-listeners-validators.tar.gz)

### Bibliografía

Este post me basé en esta página [Using Converters, Listeners, and Validators](https://docs.oracle.com/javaee/7/tutorial/jsf-page-core.htm)  ([https://docs.oracle.com/javaee/7/tutorial/jsf-page-core.htm](https://docs.oracle.com/javaee/7/tutorial/jsf-page-core.htm))
