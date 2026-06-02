---
layout: post
title: "Configurando NetBeans con contenedores web / javaee"
date: 2013-09-18T15:53:00.004Z
last_modified_at: 2013-09-18T15:53:25.531Z
author: "Diego Silva Límaco"
permalink: /2013/09/configurando-netbeans-con-contenedores.html
canonical_url: https://www.apuntesdejava.com/2013/09/configurando-netbeans-con-contenedores.html
tags:
  - "glassfish"
  - "java"
  - "tomcat"
  - "java ee"
  - "netbeans"
  - "tips"
---

[![](/assets/blogger/nb-servers.png)](/assets/blogger/nb-servers.png)

Por la mala experiencia que tengo con los instaladores en Windows, prefiero que los aplicativos sean unos archivos que se puedan descomprimir. Si no hay más remedio que instalarlos, pues lo hago.

NetBeans tiene una *versión* "portable" siendo el instalador un archivo .zip con todo el IDE dentro. Lo bueno de esto es que el mismo .zip puede ser ejecutado en cualquier plataforma que tenga instalado el JDK. (Ese es el gran motivo por lo que uso poco el Eclipse).

[![](/assets/blogger/nb.png)](/assets/blogger/nb.png)

Lo malo de esto es que no incluye los servidores Java EE.

[![](/assets/blogger/nb1.png)](/assets/blogger/nb1.png)

Es algo obvio el motivo, ya que el instalador nativo genera todos los archivos y configuraciones necesarias para que el IDE funcione.... en cambio un .zip solo contiene el contenido.

Pero no hay de qué preocuparse, porque podemos configurar el NB con un Tomcat, GlassFish y demás servidores, sean nuevos, o existentes. Aquí hablaremos un poco de esto.

GlassFish y Tomcat también tienen su versión "instalador" y ".zip" Personalmente prefiero los .zip, ya que solo los descomprimo y listo, a funcionar.

### GlassFish

Para descargar GlassFish, lo podemos hacer desde aquí.

[https://glassfish.java.net/download.html](https://glassfish.java.net/download.html)

[![](/assets/blogger/nb2.png)](/assets/blogger/nb2.png)

Allí indica y sugiere como primera instancia que se utilice la versión .zip. La instalación lo dice claro: descomprimir el .zip. Y listo!

### Tomcat

Al inicio, Tomcat era un simple .zip o .tar.gz Ahora lo distribuyen como instalador para Windows, sea 64bits o 32 bits. La diferencia de los tipos de instaladores son las siguientes:

- **.zip** y **.tar.gz** son archivos comprimidos, para Windows y Linux. Ambos tienen los archivos `startup.bat` / `startup.sh` y `shutdown.bat` / `shutdown.sh`

- **32-bits Windows .zip** y **64-bit Windows zip** son para Windows, pero tienen el archivo tomcatw.exe que está preparado para ejecutarse en Windows 32 o 64 respectivamente, y puede ser configurado como servicio de Windows. Además cuentan con los scripts de inicio `startup.*` y `shutdown.*`

- **64-bits Itanium Windos zip**  es lo mismo que el anterior, pero paraWindows Itanium.

- **32-bit/64-bit Windows Service Installer** configura el Tomcat como servicio de Windows. No cuenta con los scripts de inicio `startup.*` ni `shutdown.*`.

Si me preguntan cuál yo usuaria, pues si es para Linux, uso el .tar.gz y si es para Windows uso el segundo, ya que puedo configurarlo a mi gusto para usarlo.

Puedes descargar NetBeans desde aquí, la página oficial: [http://tomcat.apache.org/download-70.cgi](http://tomcat.apache.org/download-70.cgi) No vale cualquier otra fuente tales como softonic ni otro. Usen el oficial, no el "cocinado".

### Configurando con NetBeans

Bien, asumiendo que tengamos el Tomcat y el Glassfish ya sea instalado o descomprimido, o que ya haya uno existente, y queremos conectarnos desde NetBeans, aquí los pasos:

#### Tomcat

[](/assets/blogger/nb5.png)

- Entrar al panel de Services, o presionar Ctrl+5.

[![](/assets/blogger/nb3.png)](/assets/blogger/nb3.png)

Como verán, puede ser que no haya ningún servidor en el nodo de Servidores. Y allí es donde hacemos clic derecho en el nodo "servers" y seleccionamos "Add Server..."

- Seleccionamos "Apache Tomcat" y abajo le ponemos el nombre. Recomiendo que el nombre sea algo referente a lo que vamos  a usar, por ejemplo "Tomcat Test", o "Tomcat Desarrollo", o "Tomcat 7.0.35", etc.
[![](/assets/blogger/nb4.png)](/assets/blogger/nb4.png)
Clic en "Next"

- Especificamos la ruta donde se encuentra el Tomcat, y donde estará la ruta de la configuración de Tomcat que se usará en NetBeans.

[![](/assets/blogger/nb5.png)](/assets/blogger/nb5.png)

Recomiendo mucho que se use esta opción, ya que el Tomcat quedará limpio de configuraciones e instalaciones. Si existe un problema en la configuración de nuestra aplicación, borramos esta carpeta y volvemos a configurar el Tomcat. Si la configuración estaría dentro de NetBeans, tendríamos que borrar todo el Tomcat para volverlo a configurar.
Además, debemos poner un usuario y contraseña que es el que administrará el Tomcat desde NetBeans, esto es quien podrá desplegar y replegar las aplicaciones a ejecutarse en Tomcat desde NetBeans.

Clic en Finish, y listo.. ya tenemos el NetBeans con Tomcat

### GlassFish

Con GlassFish es la misma historia.

- "Add Server...", seleccionamos GlassFish y escribimos el nombre de nuestro servidor para NetBeans
[![](/assets/blogger/nb6.png)](/assets/blogger/nb6.png)
Clic en "Next"

- Seleccionamos la ruta donde tenemos instalado el GlassFish. Notar que se debe indicar la carpeta raiz del GlassFish, no la ruta del dominio.

[![](/assets/blogger/nb7.png)](/assets/blogger/nb7.png)

Clic en "Next"

- Seleccionamos el dominio del GlassFish que usaremos para esta configuración de NetBeans con GlassFish. Por omisión crea el dominio **domain1** para comenzar.

[![](/assets/blogger/nb8.png)](/assets/blogger/nb8.png)

También podríamos configurar un servidor remoto, para ello debemos especificar en qué IP o nombre de computador se encuentra.
Además, si el GlassFish que vamos a conectar necesita autenticación, le colocamos el usuario y contraseña.
Clic en "Finish".

Y listo! en tres pasos ya tenemos nuestro servidor java ee configurado para NetBeans.

Espero que les sea de utilidad, y.. esta vez no hay código fuente porque no hay proyecto `:)`

Si tienen alguna sugerencia, tema de qué tratar, no duden en escribir en los comentarios de aquí abajo, en el Google+ o Facebook.

¡Hasta el siguiente tutorial!.
