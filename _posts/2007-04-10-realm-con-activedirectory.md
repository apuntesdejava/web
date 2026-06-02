---
layout: post
title: "Realm con ActiveDirectory"
date: 2007-04-10T19:22:00Z
last_modified_at: 2009-04-25T21:55:03.833Z
author: "Diego Silva"
permalink: /2007/04/realm-con-activedirectory.html
canonical_url: https://www.apuntesdejava.com/2007/04/realm-con-activedirectory.html
tags:
  - "seguridad"
  - "tomcat"
  - "web"
---

Después de revisar varios ejemplos, probar y probar, logré encontrar una configuración para usar Realm con el ActiveDirectory de Windows. Esta es la configuración que usé:

```java
<Context path="/ldap" ><br />      <Realm className="org.apache.catalina.realm.JNDIRealm" <br />             connectionURL="ldap://med_spdom01" debug="99"<br />             userPattern="{0}@meduca.gob.pe"<br />             roleBase="OU=Politicas,DC=meduca,DC=gob,DC=pe"<br />             roleName="cn"/><br /></Context>
```

Como se ve en userPattern, le estoy poniendo el dominio del usuario.
Primero había probado logearme con ese formato en la ventana de inicio de sesión del windows.  Al momento de escribir el árroba (@) en el nombre de usuario, la lista de dominios se me desactiva. Ya no hacía falta especificar el dominio. Con esa premisa fue que intenté utilizar el mismo formato para el Realm en el Tomcat
