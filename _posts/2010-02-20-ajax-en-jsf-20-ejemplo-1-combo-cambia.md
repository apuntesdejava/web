---
layout: post
title: "Ajax en JSF 2.0 - Ejemplo 1: Combo cambia texto"
date: 2010-02-20T17:05:00.008Z
last_modified_at: 2014-06-24T16:49:04.277Z
author: "Diego Silva"
permalink: /2010/02/ajax-en-jsf-20-ejemplo-1-combo-cambia.html
canonical_url: https://www.apuntesdejava.com/2010/02/ajax-en-jsf-20-ejemplo-1-combo-cambia.html
tags:
  - "youtube"
  - "netbeans 6.8"
  - "tutorial"
  - "netbeans"
  - "video"
  - "jsf"
  - "ajax"
  - "jsf 2.0"
---

La técnica Ajax es muy útil para hacer aplicaciones donde solo se actualiza una parte de la página y no toda.

Cuando salió JSF no tenía esta característica, pero otros frameworks (como ICEfaces) proporcionaban el Ajax como manera natural. También se podía utilizar otros complementos al JSF para que pueda funcionar.. pero ya no era el JSF natural.

Con JSF 2.0, el Ajax ya es natural. Mostraremos un conjunto de ejemplos de Ajax con JSf 2.0.

En este post haremos un ejemplo de cómo un combo puede cambiar el valor de un texto. Primero lo haremos sin Ajax, y luego con Ajax.

#### El ManagedBean

Primero haremos un ManagedBean llamado FormBean. Tendrá una propiedad que contiene las opciones del combo, y luego un atributo donde tendrá el valor seleccionado del combo.

```java
package jsf;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.model.SelectItem;
@ManagedBean(name = "FormBean")
@RequestScoped
public class FormBean {

    private SelectItem[] opciones = new SelectItem[]{new SelectItem("01", "Opción 1"),
        new SelectItem("02", "Opción 2"),
        new SelectItem("03", "Opción 3")};

    private String opcionActual;

    public FormBean() {
    }

    public SelectItem[] getOpciones() {
        return opciones;
    }

    public String getOpcionActual() {
        return opcionActual;
    }

    public void setOpcionActual(String opcionActual) {
        this.opcionActual = opcionActual;
    }

}
```

#### El archivo .xhtml

Ahora, en nuestro .xhtml mostraremos el combo, ponemos un botón para ejecute el formulario y un `outputText` para que se muestre el valor seleccionado:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html"
      xmlns:f="http://java.sun.com/jsf/core">
    <h:head>
        <title>Ejemplo Combo Cambia Texto</title>
    </h:head>
    <h:body>
        <h:form>
            Opciones: <h:selectOneMenu value="#{FormBean.opcionActual}">
                <f:selectItems value="#{FormBean.opciones}" />
            </h:selectOneMenu><br/>
            <h:commandButton value="Mostrar" />
            <br/>
            Opción seleccionada: <h:outputText id="opcionActual" value="#{FormBean.opcionActual}" />
        </h:form>
    </h:body>
</html>
```

Al ejecutarlo, veremos que se muestra el combo, cambiamos el valor de este, hacemos clic en el botón y se actualiza el valor de abajo. Muy simple `:)`. Pero el problema es que tenemos que hacer clic en el botón para actualizar el texto inferior. Lo ideal es que se actualiza solo cuando se haga el cambio en el combo, si necesidad de hacer submit. Ahí es donde entra Ajax.

#### Implementado Ajax en JSF 2.0

En JSF 2.0 es tan fácil implementar Ajax como escribir un tag.

Pongamos el tag `<f:ajax  />` dentro del combo a mostrar. Pero como queremos que cambie solo el valor del `outputText`, le indicamos el id del tag en el atributo `render`. Así quedaría el .xhtml final.

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html"
      xmlns:f="http://java.sun.com/jsf/core">
    <h:head>
        <title>Ejemplo Combo Cambia Texto</title>
    </h:head>
    <h:body>
        <h:form>
            Opciones: <h:selectOneMenu value="#{FormBean.opcionActual}">
                <f:selectItems value="#{FormBean.opciones}" />
                <f:ajax render="opcionActual" />
            </h:selectOneMenu><br/>
            <h:commandButton value="Mostrar" />
            <br/>
            Opción seleccionada: <h:outputText id="opcionActual" value="#{FormBean.opcionActual}" />
        </h:form>
    </h:body>
</html>
```

Ahora, ejecutamos el proyecto y veremos qué pasa cuando cambiamos el combo.

El código fuente de este proyecto, está disponible aquí:

[http://diesil-java.googlecode.com/files/JSF20AjaxComboCambiatexto.tar.gz](http://diesil-java.googlecode.com/files/JSF20AjaxComboCambiatexto.tar.gz)

Y aquí un vídeo para que vean que no estoy mintiendo `:P`

<object height="505" width="640"><param name="movie" value="http://www.youtube.com/v/wCKAtVoo6Cs&hl=es_ES&fs=1&color1=0x234900&color2=0x4e9e00"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/wCKAtVoo6Cs&hl=es_ES&fs=1&color1=0x234900&color2=0x4e9e00" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="505"></embed></object>
