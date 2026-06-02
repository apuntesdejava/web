---
layout: post
title: "Configurar NetBeans con WebLogic"
date: 2009-01-13T23:05:00Z
last_modified_at: 2009-04-25T21:55:03.169Z
author: "Diego Silva"
permalink: /2009/01/configurar-netbeans-con-weblogic.html
canonical_url: https://www.apuntesdejava.com/2009/01/configurar-netbeans-con-weblogic.html
tags:
  - "oracle"
  - "web"
  - "netbeans 6.5"
  - "weblogic"
  - "netbeans"
  - "tips"
---

(Tomado de [http://www.nabble.com/Netbeans-6.5-can't-add-Weblogic-10.3-server-td20002675.html](http://www.nabble.com/Netbeans-6.5-can't-add-Weblogic-10.3-server-td20002675.html))
Considerando que se tiene instalado WebLogic 10.3 en c:\oracle\Middleware\wlserver_10.3, el usuario es weblogic y su contraseña weblogic:
1. Abrir el archivo %HOME_PATH%\.netbeans\6.5\config\J2EE\InstalledServers\.nbattrs Es un archivo en formato xml
2. Agregar la siguiente etiqueta:

```java
<code><fileobject name="__instance_4__"><br /> <attr name="debuggerPort" stringvalue="8787"/><br /> <attr name="displayName" stringvalue="BEA WebLogic Server"/><br /> <attr name="domainRoot" stringvalue="C:/oracle/Middleware/wlserver_10.3/samples/domains/wl_server"/><br /> <attr name="isLocal" stringvalue="true"/><br /> <attr name="password" stringvalue="weblogic"/><br /> <attr name="registeredWithoutUI" stringvalue="false"/><br /> <attr name="serverRoot" stringvalue="C:/oracle/Middleware/wlserver_10.3"/><br /> <attr name="url" stringvalue="deployer:WebLogic:http://localhost:7001:C:/oracle/Middleware/wlserver_10.3:C:/oracle/Middleware/wlserver_10.3/samples/domains/wl_server"/><br /> <attr name="username" stringvalue="weblogic"/><br /></fileobject> <br /></code>
```

Notar el nombre del objeto creado:instance_4, debe ser un nombre único.
3. En la misma carpeta crear un archivo sin contenido cuyo nombre es el mismo que se ha declarado en el paso anterior.
4. Guardar y abrir el NetBeans. Podemos ver en el panel de Prestaciones el nuevo servidor.

![nb-wl.jpg](http://wiki.netbeans.org/attach/TaT_NetBeansWebLogic/nb-wl.jpg)
