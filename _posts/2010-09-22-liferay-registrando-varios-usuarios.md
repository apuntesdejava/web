---
layout: post
title: "Liferay: Registrando varios usuarios (usando complemento Hook)"
date: 2010-09-22T06:51:00.001Z
last_modified_at: 2010-11-04T18:10:43.763Z
author: "Diego Silva"
permalink: /2010/09/liferay-registrando-varios-usuarios.html
canonical_url: https://www.apuntesdejava.com/2010/09/liferay-registrando-varios-usuarios.html
tags:
  - "netbeans 6.9"
  - "liferay"
  - "portalpack"
  - "tutorial"
  - "netbeans"
  - "trucos"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgtW0KC2fxfz8nJE3tZBsnsUvVL2MdeqtTJE-0cIwSRRwWVYHSfyaJDbyhLC0IxYv41Bsobl2lZ3UFwa0ge-RLa-cE2lbrrrt7uei-saBoZsLF-Zl7RThiXqcCd33n4MkKqXeHrIL-D-FVN/s1600/liferay-logo.png)

He estado buscando alguna opción de Liferay que me permita crear varios usuarios a la vez... pero no tuve éxito. Pensé (y hasta pregunté en el foro de liferay.com) si se podía modificar directamente la base de datos. Pero como es un sistema complejo, hacer esto podría malograr el sistema.

Entonces pensé que debería haber otra solución utilizando el API de Liferay. Al final de todo, es una plataforma, y debería existir un API completo para ello.

Bien, el API existe, pero la documentación es bastante pobre (solo echarle un vistazo al javadoc [http://docs.liferay.com/portal/6.0/javadocs/](http://docs.liferay.com/portal/6.0/javadocs/) no tiene ni una descripción de alguna clase.. al menos sirve para saber qué clases tiene el API)

Encontré en el wiki de Liferay sobre el desarrollo de extensiones para el Portal, y este me pareció interesante: [http://www.liferay.com/community/wiki/-/wiki/Main/Portal+Hook+Plugins](http://www.liferay.com/community/wiki/-/wiki/Main/Portal+Hook+Plugins). Habla de manera general para qué sirven los Hooks dentro de Liferay y muestran algunos ejemplos.

En líneas generales, los hooks son complementos que modifican el comportamiento del liferay. Hay de tres tipos:

- Los que se ejecutan al inicio del portal

- Los eventos de inicio de sesión, y

- Los eventos de servicios.

Como mi caso es crear usuarios masivamente, me corresponde crear un Hook cuando se ejecute el liferay. Otros ejemplos de Hook (como el de inicio de sesión) se puede encontrar en Adictosaltrabajo.com: [http://www.adictosaltrabajo.com/tutoriales/tutoriales.php?pagina=LiferayHookPlugin](http://www.adictosaltrabajo.com/tutoriales/tutoriales.php?pagina=LiferayHookPlugin)

En varios tutoriales explican que debería bajarse el Kit de desarrollo (SDK) de Complementos de Liferay. Pero no se preocupen, NetBeans con el PortalPack ya nos ahorra bastante este trabajo. Así que manos a la obra.

### Requisitos

Para este tutorial utilicé lo siguiente:

- NetBeans 6.9.1 con JDK 6.0u21

- PortalPack 3.0.4 (Descargable desde aquí: [http://contrib.netbeans.org/portalpack/pp30/download304.html](http://contrib.netbeans.org/portalpack/pp30/download304.html))

- Liferay 6.0.5 en Tomcat 6.0 (Descargable desde aquí: [http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.0.5/liferay-portal-tomcat-6.0.5.zip/download](http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.0.5/liferay-portal-tomcat-6.0.5.zip/download))

Si quieres saber cómo configurar el Liferay con el NetBeans, te recomiendo mi anterior post: [Nuestro primer portlet en Liferay](/2010/07/nuestro-primer-portlet-en-liferay.html). Aunque se explica utilizando el Liferay + GlassFish, el agregar el servidor Liferay al NetBeans es el mismo procedimiento.

### Creando el proyecto Hook

La creación de un proyecto hook en NetBeans es bien simple: consiste en crear un proyecto web común y corriente. A este le llamaremos "CrearUsuarios-hook"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjevxz7OLt4JKbwa580ZBI4L-8mwkP88nd3S9n0RnhrEcFkRbgp9Uwziixj6QTdKXakXkvO1G4WER4yxwm_bz306K70nDs28iWQ6CcgpClUdnDOEO_LQ2kuJsQScFuxvoHpRdlgQ8FhMKT8/s640/hook01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjevxz7OLt4JKbwa580ZBI4L-8mwkP88nd3S9n0RnhrEcFkRbgp9Uwziixj6QTdKXakXkvO1G4WER4yxwm_bz306K70nDs28iWQ6CcgpClUdnDOEO_LQ2kuJsQScFuxvoHpRdlgQ8FhMKT8/s1600/hook01.jpg)

Luego, escogemos el tipo de servidor que queremos utilizar. Naturalmente debemos escoger el Liferay, ya que con esto el NetBeans nos agregará las bibliotecas necesarias para nuestro proyecto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhNs5HXTiLSeLmyJgiuvAlqeYqEA-cBTAih2p5lQBjxNJVO3Vw-n1sukpt39EwZA8PaW_l0AmXkAwjm_3meeNjlbmHMpv_ksOqShxEBCMio1ezlTBFLkatVBvQBgbJ7qFabsVfFwJ1uMPR8/s640/hook02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhNs5HXTiLSeLmyJgiuvAlqeYqEA-cBTAih2p5lQBjxNJVO3Vw-n1sukpt39EwZA8PaW_l0AmXkAwjm_3meeNjlbmHMpv_ksOqShxEBCMio1ezlTBFLkatVBvQBgbJ7qFabsVfFwJ1uMPR8/s1600/hook02.jpg)

Y en este paso, hacer clic en "Finish" sin crear ningún portlet.. porque lo que vamos a hacer es un Complemento Hook, no un Portlet.

### Creando el complemento Hook

Bien, hasta ahora solo hemos creado el espacio de trabajo. Ahora crearemos el Hook como si fuera un archivo más. Entramos a File > New File y seleccionamos en la categoría "WebSpace/Liferay Plugins" el tipo de archivo "Hook Plugin"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgn-AAFDDS-53SEPYChYk_VOvM3M1Lq-DmgSDnpJbb60cw4x4LYHLcXZdg9JoU_GoZYVUK42jRwHr9R6sI0LzYTgdLc06zykTMM8jF3wHQAiPhadcHZdtJI43GULmpGdwXftu0OvnBc4Wyz/s640/hook03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgn-AAFDDS-53SEPYChYk_VOvM3M1Lq-DmgSDnpJbb60cw4x4LYHLcXZdg9JoU_GoZYVUK42jRwHr9R6sI0LzYTgdLc06zykTMM8jF3wHQAiPhadcHZdtJI43GULmpGdwXftu0OvnBc4Wyz/s1600/hook03.jpg)

Después de hacer clic en "Next", especificamos qué tipo de Hook es el que vamos a crear. Como queremos que se ejecute al inicio del Portal, seleccionamos en "Event Type" el valor "application.startup.events". El nombre de la clase será `CrearUsuariosHookAction` en el paquete `hook`.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgv7BjNeZ09M48ojqRn9Ahq3rd1BRHrqRz_8FVJmGdqahQBKDqfbbLBYjnbdyPRQfKlzS7OHZ-_Cf3mIrv38JjVlNyURInmnicuuks1Fxhs7C6fcH6-dgXKSqSi8QIa9ngIgQ_y_enaJF-g/s640/hook04.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgv7BjNeZ09M48ojqRn9Ahq3rd1BRHrqRz_8FVJmGdqahQBKDqfbbLBYjnbdyPRQfKlzS7OHZ-_Cf3mIrv38JjVlNyURInmnicuuks1Fxhs7C6fcH6-dgXKSqSi8QIa9ngIgQ_y_enaJF-g/s1600/hook04.jpg)

Clic en Finish y listo.. ya tenemos nuestra clase en blanco listo para llenar.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhsa0m44WwOTVdolDu_3DJt-A48hKyBxVDLXoSjvSjfkNPgqxJYj5RUWkTzed_7WcJuHplB_Cga8oE_h9AlshFQWwTP4732DKjK_-OlzkNwHYx6695fT-jYmlaRKwtAToq6Ty7nu_xsJqJ7/s640/hook05.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhsa0m44WwOTVdolDu_3DJt-A48hKyBxVDLXoSjvSjfkNPgqxJYj5RUWkTzed_7WcJuHplB_Cga8oE_h9AlshFQWwTP4732DKjK_-OlzkNwHYx6695fT-jYmlaRKwtAToq6Ty7nu_xsJqJ7/s1600/hook05.jpg)

### Registrando los usuarios

Como les comenté al inicio, la documentación es bastante pobre. Creo que es por la cantidad de clases que contiene. Pero no hay problema. Ya existe un ejemplo (también, sin documentación) de cómo utilizar el API de Liferay. Su nombre es `sevencogs-hook` y está disponible en la página del proyecto Liferay en sourceforge.net. Aquí están los archivos:

- Ejemplo para Liferay 5.2.x: [http://sourceforge.net/projects/lportal/files/Liferay%20Plugins/5.2.2/sevencogs-hook-5.2.2.1.war/download](http://sourceforge.net/projects/lportal/files/Liferay%20Plugins/5.2.2/sevencogs-hook-5.2.2.1.war/download)

- Ejemplo para Liferay 6.0.x:  [http://sourceforge.net/projects/lportal/files/Liferay%20Plugins/6.0.5/sevencogs-hook-6.0.5.1.war/download](http://sourceforge.net/projects/lportal/files/Liferay%20Plugins/6.0.5/sevencogs-hook-6.0.5.1.war/download)

Mi opinión es que el ejemplo de Liferay 5.2 es el más claro.

Por si causa confusión donde encontrar el ejemplo exacto, el código fuente del Hook son los siguientes:

- Versión 5.2:  [http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252FStartupAction.java](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252FStartupAction.java)

- Versión 6.0: [http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252FUpgradeCompany.java](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252FUpgradeCompany.java)

El código es bastante entendible. Basta entender las variables utilizadas. Aquí muestro mi código que es compatible con Liferay 6

```java
<code>
    private void doRun(long companyId) {

        try {
            String firstName = "Diego";
            String lastName = "Silva";
            boolean male = true;
            String jobTitle = "Consultor Java";
            String screenName = "diego.silva";
            long creatorUserId = 0;
            long facebookId = 0;
            boolean autoPassword = false;
            String password1 = screenName;
            String password2 = password1;
            boolean autoScreenName = false;
            String emailAddress = screenName + "@apuntesdejava.com";
            String openId = StringPool.BLANK;
            Locale locale = new Locale("ES", "PE");
            String middleName = StringPool.BLANK;
            int prefixId = 0;
            int suffixId = 0;
            int birthdayMonth = Calendar.MARCH;
            int birthdayDay = 27;
            int birthdayYear = 1976;
            Country country = CountryServiceUtil.getCountryByA2("PE");
            long countryId = country.getCountryId();
            long regionId = 0;
            Group guestGroup = GroupLocalServiceUtil.getGroup(companyId, GroupConstants.GUEST);
            long[] groupIds = new long[]{guestGroup.getGroupId()};
            long[] userGroupIds = null;
            boolean sendEmail = false;
            Role adminRole = RoleLocalServiceUtil.getRole(
                    companyId, RoleConstants.ADMINISTRATOR);

            Role powerUserRole = RoleLocalServiceUtil.getRole(
                    companyId, RoleConstants.POWER_USER);
            long[] roleIds = new long[]{
                adminRole.getRoleId(), powerUserRole.getRoleId()
            };
            int statusId = GetterUtil.getInteger(PropsUtil.get("sql.data.com.liferay.portal.model.ListType.organization.status"));
            String comments = null;
            ServiceContext serviceContext = null;
            System.out.print("Creando organización...");
            //creando la organización
            long userId=UserLocalServiceUtil.getDefaultUserId(companyId);
            long parentOrganizationId =
   OrganizationConstants.DEFAULT_PARENT_ORGANIZATION_ID;
            boolean recursable = true;
            Organization apuntesOrganization = OrganizationLocalServiceUtil.addOrganization(userId, parentOrganizationId, "Apuntes de Java",
                    OrganizationConstants.TYPE_REGULAR_ORGANIZATION,
                    recursable, regionId, countryId, statusId,
                    comments, serviceContext);
            long[] organizationIds = new long[]{apuntesOrganization.getOrganizationId()};
            System.out.println("... registrado con ID:"+apuntesOrganization.getOrganizationId());
            //registrando el usuario
            System.out.print("Creando usuario...");
            User user = UserLocalServiceUtil.addUser(creatorUserId, companyId,
                    autoPassword, password1, password2,
                    autoScreenName, screenName, emailAddress, facebookId,
                    openId, locale,
                    firstName, middleName, lastName,
                    prefixId, suffixId, male, birthdayMonth,
                    birthdayDay, birthdayYear,
                    jobTitle, groupIds, organizationIds,
                    roleIds, userGroupIds, sendEmail, serviceContext);
            System.out.println("... creado con ID:"+user.getUserId());
        } catch (PortalException ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        } catch (SystemException ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        }
    }
</code>
```

Aquí se ve que se ha creado una organización nueva llamada "Apuntes de Java" y el usuario que es perteneciente a ella.

La diferencia con Liferay 5, es que en el 6 hay un nuevo parámetro llamado facebookId. Todos los demás campos son iguales. Así que considere esta característica cuando hagas un Hook de crear usuarios en Liferay 5 o 6.

### Ejecutando el proyecto

Desde nuestro IDE bastará con ejecutar el proyecto y esperar que se despliegue en el servidor local.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnw5Y_wSGW5t50GvZnvXql-fBkieRfJcPYYzqhaIXpfR7o4bJBmZZ2nB0rt18F2cX0ur9Tf3SvpLt6W7QxWf0t8Xz1wnRl_7HXDMBUJFUpggG7jOIJuH_MZgWLzuK_moAr-ES0Dca_eVKX/s320/hook06.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnw5Y_wSGW5t50GvZnvXql-fBkieRfJcPYYzqhaIXpfR7o4bJBmZZ2nB0rt18F2cX0ur9Tf3SvpLt6W7QxWf0t8Xz1wnRl_7HXDMBUJFUpggG7jOIJuH_MZgWLzuK_moAr-ES0Dca_eVKX/s1600/hook06.jpg)

Y aquí vemos la organización creada...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8caPE7a09F6guOxRbOOraNwHlIzyUw9qF7WLA0hTljASS0LkQLPwFGv5KIRTyZqYHgLbHO4BKSLRREVPOeyNxBjrzN9Vrx7nFaZqwxqE3bqs5mVRQpMlzm-9abYoDMjEMyS1VMhyy_63g/s640/hook07.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8caPE7a09F6guOxRbOOraNwHlIzyUw9qF7WLA0hTljASS0LkQLPwFGv5KIRTyZqYHgLbHO4BKSLRREVPOeyNxBjrzN9Vrx7nFaZqwxqE3bqs5mVRQpMlzm-9abYoDMjEMyS1VMhyy_63g/s1600/hook07.jpg)

Y el usuario creado...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmOP8mYqpExUiV9CzMQJVus2S-66rjzH2oLyxyPKdtVrGp3Shdk8i_n9UL-n79QcnOhfw1gPTcV75M6Cti9P_F2efO_ORPVkc46ESqB8eunhUxfNvETDbeyJqYTxsNMgnwNFnEFRa5iwoV/s640/hook08.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmOP8mYqpExUiV9CzMQJVus2S-66rjzH2oLyxyPKdtVrGp3Shdk8i_n9UL-n79QcnOhfw1gPTcV75M6Cti9P_F2efO_ORPVkc46ESqB8eunhUxfNvETDbeyJqYTxsNMgnwNFnEFRa5iwoV/s1600/hook08.jpg)

Para crear varios usuarios, bastará con repetir la misma operación con cada uno de ellos. O si se desea importar de una tabla preexistente, consideren hacer una conexión por JDBC a la base de datos donde se tienen los usuarios a cargar, y dentro de un `while (rs.next())` llamar al método `UserLocalServiceUtil.addUser()`

### Desplegando en servidor de producción

Para ponerlo en producción, primero debemos construir el .war. Esto es simple, basta con darle clic derecho al ícono del proyecto y seleccionar `build`. Con esto nos generará el archivo .war listo para desplegarlo en el servidor.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpc88o_8G7Ogcv3W-3DxW6CpTvxGAUh4O9UYeqvTKl8uNoZER0Bqa4XXlc16IYa6OqK9VLsbenriNWgdYEVGqYAI3VtpohkdJumtPZQKI8e7ps7M2lp-X1nDzAA7HOzWQ9RJmqeL-jeWr8/s320/hook09.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpc88o_8G7Ogcv3W-3DxW6CpTvxGAUh4O9UYeqvTKl8uNoZER0Bqa4XXlc16IYa6OqK9VLsbenriNWgdYEVGqYAI3VtpohkdJumtPZQKI8e7ps7M2lp-X1nDzAA7HOzWQ9RJmqeL-jeWr8/s1600/hook09.jpg)

Hay dos maneras para desplegarlo en un servidor en producción. Una es utilizando el ControlPanel de Liferay y utilizar la opción "Instalar complemento", seleccionamos el archivo .war e instalarlo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhlhGNxJEkgPfjvtmo6_cWKrwlXMvio_kSzeg4cg6CPCw7HpUxnSrsLoxj59EFyWrT61DTfQkMQOg6YY7HxDV9QFFzKX7pSxumXJzuOYJc-UGWsskhQRnFhLWXt2MNQqnUk-tVtUTrCCu-l/s320/hook10.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhlhGNxJEkgPfjvtmo6_cWKrwlXMvio_kSzeg4cg6CPCw7HpUxnSrsLoxj59EFyWrT61DTfQkMQOg6YY7HxDV9QFFzKX7pSxumXJzuOYJc-UGWsskhQRnFhLWXt2MNQqnUk-tVtUTrCCu-l/s1600/hook10.jpg)

La otra es copiar el archivo .war en el directorio `deploy` que se encuenrta dentro del directorio instalado de Liferay.

### Código fuente

Y no podía faltar el código fuente del proyecto utilizado para este tutorial:

[http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252FCrearUsuarios-hook.tar.gz](http://kenai.com/projects/apuntes/downloads/download/ejemplos%252Fliferay%252FCrearUsuarios-hook.tar.gz)

¡Que les sea de utilidad!
