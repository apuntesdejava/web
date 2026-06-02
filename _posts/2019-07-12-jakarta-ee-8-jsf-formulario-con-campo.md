---
layout: post
title: "Jakarta EE 8 | JSF: Formulario con campo enum y LocalDate"
date: 2019-07-12T16:56:00.001Z
last_modified_at: 2019-07-15T05:00:29.709Z
author: "Diego Silva Límaco"
permalink: /2019/07/jakarta-ee-8-jsf-formulario-con-campo.html
canonical_url: https://www.apuntesdejava.com/2019/07/jakarta-ee-8-jsf-formulario-con-campo.html
description: "Siguiendo con nuestra serie de JSF (en Jakarta EE 8) hoy veremos cómo manejar campos de tipo enum y LocalDate."
tags:
  - "jakarta ee"
  - "payara"
  - "jsf"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSEi2suLpvoTabxy6FaK_5Q5qrVtmmAoTjfK6LhimnPIPoWiqgR8_4LVlOffAFLXV_8u3mYDQpTWtPE/pub?w=1440&h=900)](https://docs.google.com/drawings/d/e/2PACX-1vSEi2suLpvoTabxy6FaK_5Q5qrVtmmAoTjfK6LhimnPIPoWiqgR8_4LVlOffAFLXV_8u3mYDQpTWtPE/pub?w=1440&h=900)

Siguiendo con nuestra serie de JSF (en Jakarta EE 8) hoy veremos cómo manejar campos de tipo `enum` y `LocalDate`.

Estos campos no son comunes para manejar en un formulario web, donde generalmente se maneja en campos de tipo `String`.

Veremos que Jakarta EE 8 manipula los de tipo `enum` de una manera transparente, mientras que los `LocalDate` necesita de una pequeña ayuda usando un `javax.faces.convert.Converter`.

## Uso de tipo enum

Para nuestro ejemplo, crearemos un tipo `enum` al que llamaremos `Gender` y este tendrá solo dos valores: `MALE` y `FEMALE`.

Además, para fines prácticos en la presentación de cada valor en el formulario, le agregaremos una etiqueta (`label`) que es la que se mostrará en el formulario HTML. El código sería así:

```java
package com.apuntesdejava.jsf.bean.type;

public enum Gender {
    MALE("Hombre"), FEMALE("Mujer");
    private final String label;

    private Gender(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

}
```

Nuestra clase POJO `Person` ahora tendrá ese campo:

```java
//...
    private Gender gender;
//...
    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }
//...
```

Además, para poder mostrar todos los valores de ese `enum` en la página JSF, necesitamos crear un método en la clase `PersonView` de la siguiente manera:

```java
//...
    public Gender[] getGenderOptions() {
        return Gender.values();
    }
//...
```

El JSF, finalmente, tendrá la siguiente etiqueta: permitirá guardar el valor del formulario y mostrará las opciones disponibles:

```java
<h:outputLabel for="gender" value="Sexo" />
<h:selectOneRadio id='gender' value="#{personView.form.gender}">
 <f:selectItems value="#{personView.genderOptions}" var="s" itemLabel="#{s.label}" itemValue="#{s}" />
</h:selectOneRadio>
```

## Tipo java.time.LocalDate

Este tipo necesita una ayuda. Podemos declarar el campo llamado `birthday` de tipo `java.time.LocalDate`. Pero para que sea manipulable desde JSF necesitamos un convertidor. Esta clase debe implementar a la interfaz `javax.faces.convert.Converter`, y debe tener una anotación para identificar este convertidor. Esta anotación es `javax.faces.convert.FacesConverter`. Veámoslo en el código:

```java
package com.apuntesdejava.jsf.bean.converter;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

@FacesConverter("com.apuntesdejava.jsf.LocalDateConverter") // importante esta declaración para identificarlo en la página JSF
public class LocalDateConverter implements Converter<LocalDate> {

    @Override
    public LocalDate getAsObject(FacesContext context, UIComponent component, String value) {
        if (value == null) {
            return null;
        }
        return LocalDate.parse(value, DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    @Override
    public String getAsString(FacesContext context, UIComponent component, LocalDate value) {
        if (value == null) {
            return null;
        }
        return value.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

}
```

Finalmente, nuestra página JSF deberá tener estas etiquetas.

```java
<h:outputLabel for="birthday" value="Nacimiento"/>
<h:inputText  id="birthday" value="#{personView.form.birthday}">
 <f:converter converterId="com.apuntesdejava.jsf.LocalDateConverter" />
</h:inputText>
```

Si no me creen, mira este vídeo 😀. Aquí está lo mismo y explicado en tiempo real.

<iframe allowfullscreen="" frameborder="0" height="270" src="https://www.youtube.com/embed/7n6bNnBkvw8" width="480"></iframe>

[Suscríbete a mi canal](https://www.youtube.com/apuntesdejava) para ver más vídeos así, y sígueme en twitter [@apuntesdejava](https://twitter.com/apuntesdejava/) para que estés enterado de las novedades que estaré compartiendo.

# ACTUALIZACIÓN

Gracias al usuario Sk8! quien comentó al final de este post, menciona que hay una manera más fácil de usar `LocalDate` desde JSF sin necesidad de crear un converter.

Aquí adjunto un vídeo aplicando su recomendación.

<iframe allowfullscreen="" frameborder="0" height="270" src="https://www.youtube.com/embed/rmy-lZTS8Xo" width="480"></iframe>

Gracias SK8!

Aquí no pretendo ser dueño de la verdad, y estoy abierto a recibir cualquier comentario para mejorar los aportes de Java. La idea principal es que todos podamos compartir y mejorar el uso de Java en español.

```java
<h:outputLabel for="birthday" value="Nacimiento"/>
<h:inputText  id="birthday" value="#{personView.form.birthday}">
 <f:convertDateTime type="localDate" pattern="dd/MM/yyyy" />
</h:inputText>
```

Gracias, nuevamente S8k!
