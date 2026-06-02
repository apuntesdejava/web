---
layout: post
title: "Definición de DataSource en JavaEE6"
date: 2010-05-18T15:00:00.045Z
last_modified_at: 2010-05-18T15:00:04.214Z
author: "Diego Silva"
permalink: /2010/05/definicion-de-datasource-en-javaee6.html
canonical_url: https://www.apuntesdejava.com/2010/05/definicion-de-datasource-en-javaee6.html
tags:
  - "datasource"
  - "java ee"
  - "tutorial"
  - "java ee 6"
  - "tips"
  - "trucos"
---

Las aplicaciones Java EE que se han mostrado en este blog son más orientados para desplegarlos en GlassFish. Esto conlleva a que cada los DataSource sean de acuerdo para proveedor de cada Java EE. Así, mis ejemplos para GlassFish no funcionarían para JBoss, Geronimo, WebLogic, etc. Aún así, cuando se desarrolla la aplicación desde NetBeans, y cuando se genera el .war, este no asegura que en ese archivo no exista la configuración de DataSource para la aplicación para usar. Por ejemplo, para GlassFish desde NetBeans se crea el archivo `sun-resources.xml`, pero este archivo no existe dentro del .war. Por tanto, antes de desplegar el .war en el GlassFish, se necesita crear manualmente el Pool de Conexiones y el Recurso JDBC. Como siempre he dicho a los que he dictado el curso Java EE: el archivo `sun-resources.xml` es el archivo de recursos para el modo de desarrollo. Solo es usado desde NetBeans.

Ahora bien ¿no debería haber un archivo único? Vamos: el JPA funciona para todos los motores de base de datos, el JNDI de EJB 3.1 (ahora) ya es compatible con todos los proveedores de JavaEE ¿el DataSource no merece tener el mismo *respeto*? Pues aquí la solución.

Ahora, para crear un DataSource para cualquier componente de JavaEE es más fácil, gracias a las especificaciones de Java EE6. Esto se logra usando la anotación [@DataSourceDefinition](http://java.sun.com/javaee/6/docs/api/javax/annotation/sql/DataSourceDefinition.html). Aquí un ejemplo para usar la base de datos `sample` de Apache Derby.

```java
<code>@DataSourceDefinition(name = "java:comp/env/SampleDataSource",
className = "org.apache.derby.jdbc.ClientDataSource",
user = "app",
password = "APP",
databaseName = "sample",
serverName = "localhost")
@Stateless
public class CustomerSessionBean implements CustomerSessionBeanRemote {

    @Resource(lookup = "java:comp/env/SampleDataSource")
    private DataSource source;...</code>
```

Y desde ahora, cada vez que se accede a la base de datos se hará a través del DataSource.

**¿java:comp?**

Hay cuatro niveles de ámbito que pueden tener los DataSource. Dependiendo del prefijo en el nombre del DataSource, estos son:

- `java:comp`: Solo es visible por el componente donde se ha declarado. Por ejemplo, si se declara en un Servlet, solo será visible por el servlet y no por otro aún estando en la misma aplicación.

- `java:module`: Solo es visible por el módulo. Un módulo puede ser un módulo EJB, o un módulo Web (un .war). Todos los componentes del módulo (servlets, ejb, etc) pueden ver el recurso, pero no otro módulo aún si están dentro de una aplicación (.ear)

- `java:app`: Solo es visible para todos los componentes de los módulos de una aplicación (.ear). No puede ser visible por otra aplicación aún si están dentro del mismo servidor Java EE 6.

- `java:global`: Solo es visible para todos las aplicaciones, módulos y componentes de todas las mismas aplicaciones que están dentro del mismo servidor Java EE 6. No puede ser visible por otro servidor aún si están dentro del mismo computador.`:)`. Creo que está claro `:P`
