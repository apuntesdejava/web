---
layout: post
title: "Enmulando EJB en Web usando Spring"
date: 2010-09-14T15:33:00.003Z
last_modified_at: 2011-03-07T15:17:53.814Z
author: "Diego Silva"
permalink: /2010/09/enmulando-ejb-en-web-usando-spring.html
canonical_url: https://www.apuntesdejava.com/2010/09/enmulando-ejb-en-web-usando-spring.html
tags:
  - "spring"
  - "java"
  - "web"
  - "ejb 3.1"
  - "tutorial"
  - "ejb"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiHsFiWEV2WoZsM-nvPig9TaaN1SJkf8ksjR7krJzBfEuMOVNVhAZVrtCcJ4OVjojaxNJNbHWlASdX2Us7oZARTsWZVQBgcGTB6Zd71xqJWYJE_3rkUlp_N_BrFvYYR4OXSMx2lGcgOUwZF/s1600/spring.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiHsFiWEV2WoZsM-nvPig9TaaN1SJkf8ksjR7krJzBfEuMOVNVhAZVrtCcJ4OVjojaxNJNbHWlASdX2Us7oZARTsWZVQBgcGTB6Zd71xqJWYJE_3rkUlp_N_BrFvYYR4OXSMx2lGcgOUwZF/s1600/spring.png)

Cuando salió el EJB 3.1 con la capacidad de poderse ejecutar en un módulo web, comencé a usarlo sin parar. Con los EJB me hace más fácil conectarme a la base de datosusando JPA porque simplemente debería usar ` ``@PersistenceContext` respectivamente.

Pero no todos los servidores  donde uno va a desplegar aplicaciones son Java EE6, así que las facilidades del EJB 3.1 serían truncadas.

Afortunadamente existe Spring para ayudarnos a instanciar clases como si fueran EJB, y más aún, nos permite usar JPA y mantener las notaciones ``  `@PersistenceContext`.

Veamos cómo se hace esto.

Para comenzar, debemos considerar que existe nuestro archivo `persistence.xml` con la conexión a la base de datos. Para este ejemplo estoy usan la base de datos `sample` que viene en el JavaDB.

```java
<code>
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="1.0"
   xmlns="http://java.sun.com/xml/ns/persistence"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://java.sun.com/xml/ns/persistence
                       http://java.sun.com/xml/ns/persistence/persistence_1_0.xsd">
  <persistence-unit name="EjbSpringWebPU" transaction-type="JTA">
    <jta-data-source>jdbc/sample</jta-data-source>
    <exclude-unlisted-classes>false</exclude-unlisted-classes>
    <properties/>
  </persistence-unit>
</persistence>
</code>
```

Nuestros "Facade" que funcionarán como los EJB, será casi como un EJB, con todo la notación de persistencia:

```java
<code>
public class DiscountCodeFacade {

    @PersistenceContext(unitName = "EjbSpringWebPU")
    private EntityManager em;

    public List<DiscountCode> getDiscountCodes() {
        Query query = em.createQuery("select o from DiscountCode o");
        return query.getResultList();
    }
}</code>
```

Hasta aquí, todo normal. Ahora, necesitamos instanciar este facade y que ya tenga la conexión a la persistencia. Bueno, en Spring se tiene que hacer esto:

Instanciar la persistencia:

```java
<code>
    <bean id="EjbSpringWebPU" class="org.springframework.orm.jpa.LocalEntityManagerFactoryBean">
        <property name="persistenceUnitName" value="EjbSpringWebPU"/>
    </bean>
</code>
```

Luego, decirle que ejecute todas las notaciones que se solicitarán en las siguientes clases:

```java
<code>
    <bean class="org.springframework.orm.jpa.support.PersistenceAnnotationBeanPostProcessor"/>
</code>
```

Para terminar, instanciar el Facade:

```java
<code>
    <bean id="DiscountCodeFacade" class="service.DiscountCodeFacade" />
</code>
```

Y listo, ya se puede utilizar casi como un EJB:

```java
<code>
DiscountCodeFacade facade=ServiceFactory.getInstance().getDiscountCodeFacade();
List<DiscountCode> discountCodes = facade.getDiscountCodes();
</code>
```

El proyecto utilizado para este post se encuentra aquí:

[https://java.net/downloads/apuntes/samples/web/EjbSpringWeb.tar.gz](https://java.net/downloads/apuntes/samples/web/EjbSpringWeb.tar.gz)
