---
layout: post
title: "Desplegando un .war en tomcat5.5 sobre ubuntu"
date: 2007-06-30T06:32:00Z
last_modified_at: 2009-04-25T21:55:03.760Z
author: "Diego Silva"
permalink: /2007/06/desplegando-un-war-en-tomcat55-sobre.html
canonical_url: https://www.apuntesdejava.com/2007/06/desplegando-un-war-en-tomcat55-sobre.html
tags:
  - "error"
  - "seguridad"
  - "tomcat"
  - "ubuntu"
---

Cuando ejecutaba el tomcat 5.5 sobre Ubuntu, de manera local (desde el usuario) las aplicaciones se ejecutaban correctamente. Pero cuando quería correrlo desde un demonio como parte del sistema, siempre mandaba un error de seguridad.

Después de revisar por ahí, encontré que el ubuntu pone algunas seguridades sobre las acciones desde el tomcat.

Edité este archivo

```java
/etc/tomcat5.5/policy.d/50user.policy
```

y agregué lo siguiente:

```java
<code>grant codeBase "file:/var/lib/tomcat5.5/webapps/<span style="font-weight: bold;">mi-aplicacion-web</span>/-" {<br />     permission java.security.AllPermission;<br />     permission java.net.SocketPermission "127.0.0.1:3306", "connect,resolve";<br />     permission java.net.SocketPermission "*.noaa.gov:80", "connect";<br />     permission java.io.FilePermission "/var/lib/tomcat5.5/webapps/<span style="font-weight: bold;">mi-aplicacion-web</span>/WEB-INF/logs-", "read,write,delete";<br />};<br /><br /></code>
```

... y vaya que resultó
