---
layout: post
title: "Implementando Contextos Java e Inyección de Dependencia (CDI)"
date: 2012-12-13T03:12:00Z
last_modified_at: 2012-12-13T03:12:08.485Z
author: "Diego Silva Límaco"
permalink: /2012/12/implementando-contextos-java-e.html
canonical_url: https://www.apuntesdejava.com/2012/12/implementando-contextos-java-e.html
tags:
  - "java ee"
  - "cdi"
  - "tutorial"
  - "java"
  - "java ee 6"
---

[![]({{ '/assets/blogger/3075injection.jpg' | relative_url }})]({{ '/assets/blogger/3075injection.jpg' | relative_url }})

La inyección de dependencia es una técnica popular en el desarrollo de aplicaciones empresariales java. En una inyección de dependencia, también llamada **Inversión de Control (Inversion of Control - IoC)**, un componente especifica los recursos de los que depende.

Un inyector, típicamente un contenedor, proporciona los recursos al componente. Aunque la inyección de dependencia puede ser implementado de varias maneras, muchos desarrolladores lo implementan con anotaciones.

*Nota: Traducción al español no autorizada del libro [Java EE 6 Cookbook for Security, Tuning, and Extending Enterprise Applications](http://www.packtpub.com/java-ee6-securing-tuning-extending-enterprise-applications-cookbook/book) - Capítulo "Implementing Java Contexts and Dependency Injection (CDI)"*

El concepto de CDI tiene su origen el año 2002 con [Rod Johnson](http://en.wikipedia.org/wiki/Rod_Johnson_%28programmer%29) ([@springrod](https://twitter.com/springrod)), quien lanzó el *framework* con la publicación de su libro *[Expert One-on-One J2EE and Development](http://www.wrox.com/WileyCDA/WroxTitle/productCd-0764543857.html).* Desde entonces, **SpringFramework** ha sido el framework más usado ampliamente en el mundo Java. La Inyección de Dependencia es usado en gran medida en *frameworks* de desarrollo Java tales como Spring  y Guice. Desafortunadamente,  no existe un enfoque estándar para la inyección de dependencia basada en anotaciones. En particular, un *framework* tal como Spring adopta un enfoque diferente para inyección de dependencia basada en anotaciones, que la de Guice.

Estos servicios hacen que los componentes Java EE, incluyendo *EJB Session Beans* y ***JavaServer Faces (JSF)** managed beans*, estén sujetos a contextos de ciclos de vida, para ser inyectados y para interactuar en una manera imprecisa para enlazarse a eventos. CDI unifica y simplifica los modelos de programación EJB y JSF y proporciona beans empresariales (enteprise beans) para reemplazar los beans  manejados (managed beans) en una aplicación JSF.

JSR 299 puede ser dividido en estos principales paquetes:

- Alcances y contextos (Scopes and contexts) `javax.context`

- Servicios de inyección de dependencias: `javax.inject`

- Framework de integración SPI: `javax.inject.manager`

- Servicio de notificación de eventos: `javax.event`

JSR 299 se basa fuertemente en anotaciones Java para las especificacón Context and Dependency Injection, JSR 330. JSR 330 contiene un conjunto de anotaciones para usarse en clases inyectables. Las anotaciones son las siguientes:

- `@Qualifier`: Identifica anotaciones de cualificador. Los cualificadores son claves basados en tipos que ayudan a distinguir diferentes usos de objetos del mismo tipo.

- `@Inject`: Identifica constructores, métodos y campos inyectables.

- `@Named`: Es un calificador basado en cadena (String)

- `@Scope`: Identifica anotaciones de alcance

- `@Singleton`: Identifica un tipo que el inyector instancia solo una vez.

### @Qualifier

La anotación `@Qualifier` del JSR 330 identifica y especifica la implementación de una clase Java o una interfaz a ser inyectada.

```java
@Target({ TYPE, METHOD, PARAMETER, FIELD })
@Retention(RUNTIME)
@Documented
@Qualifier
public @interface InjectableType {...}
```

### @Inject

La anotación `@Inject` identifica un punto el cual una dependencia en una clase o interfaz Java puede ser inyectada en una clase destino. Esta inyección no solo crea una instancia, o prototipa un objeto por omisión, también puede inyectar un objeto *singleton* como tal:

```java
@Stateful
@SessionScoped
@Model
public class ServiceWithInjectedType {
@Inject InjectableType injectable;
...
```

El contenedor buscará el tipo inyectable especificado por `@Qualifier` y automáticamente inyectará la referencia.

### @Named

La anotación `@Named` proporciona los calificadores basados en cadenas en lugar de los basados en tipo. Un ejemplo de esto es:

[http://download.oracle.com/javaee/6/api/javax/inject/Named.html](http://download.oracle.com/javaee/6/api/javax/inject/Named.html)

```java
@Named
public class NamedBusinessType
implements InjectableType {...}
```

### @Scope

Dentro de una aplicación web, un *bean*  tiene que ser capaz de mantener el estado de la duración de la interacción del cliente con la aplicación. La siguiente tabla detalla los alcances de los beans.
<table>
<thead><tr><th>Alcance</th><th>Anotación</th><th>Duración</th></tr></thead>
<tbody>
<tr><td>Requerimiento</td><td><code>@RequestScoped</code></td><td>La interacción del cliente por un simple requerimiento HTTP</td>
</tr>
<tr><td>Sesión</td><td><code>@SessionScoped</code></td><td>La interacción del cliente a través de varios  requerimientos HTTP</td>
</tr>
<tr><td>Aplicación</td><td><code>@ApplicationScoped</code></td><td>Comparte el estado a través de todas las interacciones de los clientes</td>
</tr>
<tr><td>Dependiente</td><td><code>@Dependent</code></td><td>Alcance por omisión. Significa un objeto existe para servir exactamente a un cliente (bean), y tiene el mismo ciclo de vida del cliente (bean)</td>
</tr>
<tr><td>Conversación</td><td><code>@ConversationScoped</code></td><td>La interacción del cliente con la aplicación JSF dentro de los dominios del controlador que se extiende a través de múltiples invocaciones del ciclo de vida del JSF</td>
</tr>
</tbody>
</table>

Las anotaciones de alcance basadas en clase se verían así:

```java
@Stateful
@SessionScoped
@Model
public class ServiceWithInjectedType {
@Inject InjectableType injectableType;
```

Podemos también ,crear nuestros propios manejadores de alcance usando la anotación `@Scope`

```java
@java.lang.annotation.Documented
@java.lang.annotation.Retention(RUNTIME)
@javax.inject.Scope
public @interface CustomScoped {}
```
