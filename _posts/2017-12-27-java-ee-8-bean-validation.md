---
layout: post
title: "Java EE 8: Bean Validation"
date: 2017-12-27T23:36:00Z
last_modified_at: 2017-12-27T23:37:59.597Z
author: "Diego Silva Límaco"
permalink: /2017/12/java-ee-8-bean-validation.html
canonical_url: https://www.apuntesdejava.com/2017/12/java-ee-8-bean-validation.html
description: "Veamos otra característica de Java EE 8: El Bean Validation 2.0"
tags:
  - "java ee"
  - "java ee 8"
---

[![]({{ '/assets/blogger/duke-conformance.jpeg' | relative_url }})]({{ '/assets/blogger/duke-conformance.jpeg' | relative_url }})

En Java EE 8, el api Bean Validation ha venido con mejoras.

Por ejemplo, ahora podemos validar un campo de tipo `java.time.LocalDate`

```java
@Past
    private LocalDate fechaIngreso;
```

También, determinar los límites de una lista:

```java
@NotEmpty
    private List<@Size(min = 1, max = 15) String> proyectos;
```

Al igual que un nuevo tipo de validación (y así evitar log RegEx)

```java
@Email
    private String email;
```

Podemos evaluar los campos validados desde el mismo Java (aquí un ejemplo desde una prueba unitaria):

```java
@Test
    public void testMemberWithNoValues() {
        Empleado e = new Empleado();
        e.setEmail("abc@");
        e.setDni("12345678");
        e.setProyectos(Arrays.asList("Proyecto 1", "Proy2", "Proy3"));

        // validate the input
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<Empleado>> vs = validator.validate(e);
        vs.forEach((v) -> {
            System.out.println("--->" + v.getPropertyPath() + ":" + v.getMessage());
        });
    }
```

Ahora bien, este mismo Bean con validación puede ser usado dentro de un JSF:

```java
<h:body>
        <h:form>
            <h:outputLabel for="nombre" value="Nombre"/>
            <h:inputText id="nombre" value="#{formBean.empleado.nombre}" /><br/>
            <h:outputLabel for="email" value="Email"/>
            <h:inputText id="email" value="#{formBean.empleado.email}" /><br/>
            <h:outputLabel for="dni" value="DNI"/>
            <h:inputText id="dni" value="#{formBean.empleado.dni}" /><br/>

            <br/>
            <h:commandButton value="Enviar" />
        </h:form>
    </h:body>
```

## Código fuente

Puedes ver este ejemplo en acción con este código fuente completo:

[https://bitbucket.org/apuntesdejava/novedades-javaee-8/src/master/bean-validation/?at=master](https://bitbucket.org/apuntesdejava/novedades-javaee-8/src/master/bean-validation/?at=master)
