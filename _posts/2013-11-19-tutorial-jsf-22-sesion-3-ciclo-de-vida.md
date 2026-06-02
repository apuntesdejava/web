---
layout: post
title: "Tutorial JSF 2.2 - Sesión 3: Ciclo de vida de una aplicación"
date: 2013-11-19T05:24:00.003Z
last_modified_at: 2013-11-19T05:29:41.986Z
author: "Diego Silva Límaco"
permalink: /2013/11/tutorial-jsf-22-sesion-3-ciclo-de-vida.html
canonical_url: https://www.apuntesdejava.com/2013/11/tutorial-jsf-22-sesion-3-ciclo-de-vida.html
tags:
  - "glassfish v4"
  - "glassfish"
  - "javaee7"
  - "web"
  - "java ee"
  - "tutorial"
  - "jsf"
  - "jsf 2.2"
---

[![Tutorial JSF 2.2 - Sesión 3: Ciclo de vida de una aplicación]({{ '/assets/blogger/jsf-logo.png' | relative_url }})]({{ '/assets/blogger/jsf-logo.png' | relative_url }})

Siguiendo con el tutorial de JSF 2.2, esta vez veremos el ciclo de vida de una aplicación. Es importante conocer esto, ya que podremos saber cómo viaja una petición desde el cliente web, es procesado por el servidor, y cómo devuelve el resultado.

En la página [7.6 The Lifecycle of a JavaServer Faces Application](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-intro006.htm) se puede ver el siguiente gráfico que representa el ciclo de vida de una aplicación:

[![]({{ '/assets/blogger/jsfintro-lifecycle.gif' | relative_url }})]({{ '/assets/blogger/jsfintro-lifecycle.gif' | relative_url }})

... pero como no quiero dar una simple traducción de otra web, lo que haremos es ver cada fase del ciclo de vida en una aplicación.

Fijémonos en los recuadros azules, son seis. Estos son los pasos que se ejecuta en el lado del servidor. Los recuadros blancos son como los "estímulos" para que la aplicación haga algo. Como podemos ver en el flujo, puede pasar desde los primeros recuadros "Restore View" y "Apply Request" hasta "Process Validations" si es que se aplica una validación, o puede ir directo a la última fase "Render Response" si es que no tiene nada que hacer. Esto último sucede cuando se llama a una página por primera vez y no se procesa nada, mas que mostrar el contenido de la página.

Para probar eso, vamos a crear una aplicación (que yo la llamé jsf-03-lifecycle) y tiene los siguientes `.xhtml`

**`index.xhtml`**

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head >
        <title>Facelet Title</title>
    </h:head>
    <h:body  >
        <h1>Formulario de prueba</h1>
        <h:form>
            <h:panelGrid columns="2">
                <h:outputLabel value="Nombre" for="nombre"/>
                <h:inputText  id="nombre" value="#{lifecycleBean.personaForm.nombre}" />

                <h:outputLabel value="Sexo" />
                <h:panelGroup layout="block">
                    <h:selectOneRadio value="#{lifecycleBean.personaForm.sexo}">
                        <f:selectItem itemLabel="Hombre" itemValue="H" />
                        <f:selectItem itemLabel="Mujer" itemValue="M" />
                    </h:selectOneRadio>
                </h:panelGroup>

            </h:panelGrid>
            <h:commandButton action="result" value="Enviar" />
        </h:form>
    </h:body>
</html>
```

**`result.xhtml`**

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h2>Result</h2>
        <h:form>
            <h:panelGrid columns="2">
                <h:outputText value="Nombre"/>
                <h:outputText value="#{lifecycleBean.personaForm.nombre}" />

                <h:outputText value="Sexo"/>
                <h:outputText value="#{lifecycleBean.personaForm.sexo}" />

            </h:panelGrid>
            <h:commandLink value="Regresar" action="index"/>
        </h:form>
    </h:body>
</html>
```

Nuestro *ManagedBean* tendrá el siguiente código:

```java
//Archivo LifecycleManagedBean.java

package com.apuntesdejava.jsf.controladores;

import com.apuntesdejava.jsf.bean.PersonaForm;
import javax.enterprise.context.RequestScoped;
import javax.inject.Named;

@Named("lifecycleBean")
@RequestScoped

public class LifecycleManagedBean {

    private PersonaForm personaForm = new PersonaForm();

    public LifecycleManagedBean() {

    }

    public PersonaForm getPersonaForm() {
        return personaForm;
    }

    public void setPersonaForm(PersonaForm personaForm) {
        this.personaForm = personaForm;
    }

}
```

El bean que nos servirá de bean tiene el siguiente código:

```java
//Archivo PersonaForm.java
package com.apuntesdejava.jsf.bean;

import java.util.Date;

public class PersonaForm {

    private String nombre;
    private char sexo;
    private Date fechaRegistro;
    private String correoElectronico;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public char getSexo() {
        return sexo;
    }

    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

}
```

Hasta aquí no hay nada extraordinario. Ahora debemos agregar un "oidor" que lo engancharemos al ciclo de vida para ver los efectos que sucede cuando ejecutamos la aplicación.

```java
//Archivo MiPhaseListener.java
package com.apuntesdejava.jsf.controladores;

import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.context.FacesContext;
import javax.faces.event.PhaseEvent;
import javax.faces.event.PhaseId;
import javax.faces.event.PhaseListener;
import javax.servlet.http.HttpServletRequest;

public class MiPhaseListener implements PhaseListener {

    static final Logger LOGGER = Logger.getLogger(MiPhaseListener.class.getName());

    @Override
    public void afterPhase(PhaseEvent event) {
        LOGGER.log(Level.INFO, "Después:{0}", event.getPhaseId());
    }

    @Override
    public void beforePhase(PhaseEvent event) {
        LOGGER.log(Level.INFO, "Antes:{0}", event.getPhaseId());
    }

    @Override
    public PhaseId getPhaseId() {
        return PhaseId.ANY_PHASE;
    }
}
```

Y para engancharlo al ciclo de vida de la aplicación, debemos crear el archivo `faces-config.xml` en `WEB-INF`. Si no existe el archivo, lo creamos desde la opción New File > JavaServer Faces > JSF Faces Configuration:

[![]({{ '/assets/blogger/lifecycle-01.png' | relative_url }})]({{ '/assets/blogger/lifecycle-01.png' | relative_url }})

Una vez creado, registramos el listener en el .xml que acabamos de crear usando el siguiente código:

```java
<?xml version='1.0' encoding='UTF-8'?>
<faces-config version="2.2"
    xmlns="http://xmlns.jcp.org/xml/ns/javaee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-facesconfig_2_2.xsd">
    <lifecycle>
        <phase-listener> com.apuntesdejava.jsf.controladores.MiPhaseListener</phase-listener>
    </lifecycle>
</faces-config>
```

Ahora, ejecutaremos la aplicación, y veamos el log de cada petición que hagamos.

Veamos: La primera vez que ejecutamos:

[![]({{ '/assets/blogger/lifecycle-02.png' | relative_url }})]({{ '/assets/blogger/lifecycle-02.png' | relative_url }})

Solo se presentan dos fases: RESTORE_VIEW y RENDER_RESPONSE. Es decir, la primera y la última fase.

Veamos qué pasa cuando colocamos valores y le damos clic en "Enviar":

[![]({{ '/assets/blogger/lifecycle-03.png' | relative_url }})]({{ '/assets/blogger/lifecycle-03.png' | relative_url }})

Al parecer ya pasa por todas las fases del ciclo de vida. Veamos si ponemos una validación. Para ello agregamos las líneas resaltadas en el `index.html` como sigue:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <h:head >
        <title>Facelet Title</title>
    </h:head>
    <h:body  >
        <h1>Formulario de prueba</h1>
        <h:form>
            <h:panelGrid columns="2">
                <h:outputLabel value="Nombre" for="nombre"/>
                <h:inputText  id="nombre" value="#{lifecycleBean.personaForm.nombre}" />

                <h:outputLabel value="Correo electrónico" for="email"/>
                <h:inputText  id="email" value="#{lifecycleBean.personaForm.correoElectronico}" >
                    <f:validator validatorId="emailValidator"/>
                </h:inputText>

                <h:outputLabel value="Sexo" />
                <h:panelGroup layout="block">
                    <h:selectOneRadio value="#{lifecycleBean.personaForm.sexo}">
                        <f:selectItem itemLabel="Hombre" itemValue="H" />
                        <f:selectItem itemLabel="Mujer" itemValue="M" />
                    </h:selectOneRadio>
                </h:panelGroup>

            </h:panelGrid>
            <h:commandButton action="result" value="Enviar" />
        </h:form>
    </h:body>
</html>
```

Y creamos la siguiente clase:

```java
//EmailValidator.java
package com.apuntesdejava.jsf.validation;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.FacesValidator;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;

@FacesValidator("emailValidator")
public class EmailValidator implements Validator {

    private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\." + "[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*" + "(\\.[A-Za-z]{2,})$";
    private final Pattern pattern;
    private Matcher matcher;

    public EmailValidator() {
        pattern = Pattern.compile(EMAIL_PATTERN);
    }

    @Override
    public void validate(FacesContext context, UIComponent component, Object value) throws ValidatorException {
        matcher = pattern.matcher(value.toString());
        if (!matcher.matches()) {
            FacesMessage msg = new FacesMessage("Falló la validación del correo electrónico.", "El formato de correo electrónico no es válido");
            msg.setSeverity(FacesMessage.SEVERITY_ERROR);
            throw new ValidatorException(msg);
        }

    }

}
```

Y al ejecutar el proyecto, ingresemos un valor no válido para el correo electrónico. Esto es lo que nos mostrará en el log del servidor:

[![]({{ '/assets/blogger/lifecycle-04.png' | relative_url }})]({{ '/assets/blogger/lifecycle-04.png' | relative_url }})

(He limpiado el log antes de ejecutar el error. Esto es para poder más claramente el log que responde)

Como podemos ver, no muestra el paso 4 ni el paso 5. Es decir, no está actualizando el modelo, ni está dando la ejecución a la aplicación, ya que la validación no lo dejó.

De esta manera, nos podemos asegurar que cada fase se ejecuta de manera independiente, y no afecta con la lógica de nuestra aplicación. Si queremos validar una entrada de un campo, debemos asegurarnos que se haga en su capa respectiva (usando los validadores) y no cuando haya guardado los valores en el modelo, ya que sería más difícil el manejo de mensajes de error al usuario. Con esto en mente, veremos poco a poco como este ciclo de vida nos ayudará en las siguientes aplicaciones.

Esto es todo por ahora.

El código fuente lo pueden descargar desde aquí: [https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-03-lifecycle.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-03-lifecycle.tar.gz)

### Bibliografía

El modelo del ciclo de vida lo tomé de: [Java EE 7 Tutorial - 7.6 The Lifecycle of a JavaServer Faces Application](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-intro006.htm)

El ejemplo de validador de correo electrónico, lo tomé de aquí: [Custom Email Validator in JSF](http://noorulhudawebsite.weebly.com/2/post/2012/02/custom-email-validator-in-jsf.html).

**Nos vemos en un siguiente post**

**
**
**Bendiciones para todos!**
