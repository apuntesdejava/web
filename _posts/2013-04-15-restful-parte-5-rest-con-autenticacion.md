---
layout: post
title: "RESTful parte 5: REST con autenticación"
date: 2013-04-15T18:50:00.002Z
last_modified_at: 2013-04-16T18:03:07.852Z
author: "Diego Silva Límaco"
permalink: /2013/04/restful-parte-5-rest-con-autenticacion.html
canonical_url: https://www.apuntesdejava.com/2013/04/restful-parte-5-rest-con-autenticacion.html
tags:
  - "glassfish"
  - "glassfish v3"
  - "restful"
  - "netbeans 7.3"
  - "java ee"
  - "tutorial"
  - "netbeans"
  - "java ee 6"
---

[![](/assets/blogger/rest-ful-webservice-baner.png)](/assets/blogger/rest-ful-webservice-baner.png)

Hasta el momento hemos visto un CRUD usando RESTful, con un objeto y varios objetos.

Ahora, quiero mostrar el manejo de la seguridad en RESTful usando los estándares de Java EE6.

Para nuestro tutorial utilizaremos:

- GlassFish 3.1.2.2

- NetBeans 7.3

- JQuery, que lo obtendremos de la red directamente

- Chrome o Firefox + Firebug (aunque la última versión de Firefox ya viene con un depurador propio)

Para poder implementarlo necesitamos configurar en GlassFish los usuarios y los grupos. Luego, estos serán mapeados en nuestra aplicación. Para más información sobre Usuarios, Grupos y Roles, leer (en inglés)   "[Working with Realms, Users, Groups and Roles](http://docs.oracle.com/javaee/6/tutorial/doc/bnbxj.html) de "[The Java EE 6 Tutorial](http://docs.oracle.com/javaee/6/tutorial/doc/index.html)"

### Configurando Realm del GlassFish (con usuarios y grupos)

Iniciamos el GlassFish, ya sea desde la línea de comandos (ejecutando $GLASSFISH_HOME\bin\asadmin start-domain) o desde el NetBeans en el panel "Services" (Ctrl+5) Nodo "Servers > GlassFish Server" clic derecho y seleccionando "Start"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifwS2oSANhzxTwez6MeHXrw_e112pJSZcUt53Hj7_7uzbEEbVurTVE4NJbStCe28fnY_xdG1QTsj5Z-XiTTfaq2kehJw_Vgijo37YisL4t1D7Z5ZvI7YWdJj-lyePz6LCEy84mr__JUe8/s320/15-04-2013+09-39-45+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifwS2oSANhzxTwez6MeHXrw_e112pJSZcUt53Hj7_7uzbEEbVurTVE4NJbStCe28fnY_xdG1QTsj5Z-XiTTfaq2kehJw_Vgijo37YisL4t1D7Z5ZvI7YWdJj-lyePz6LCEy84mr__JUe8/s1600/15-04-2013+09-39-45+a.m..png)

Ahora, entramos a la consola web de GlassFish ([http://localhos:4848](http://localhos:4848/)) y seleccionamos "Configurations > server-config > Security > Realms > file" (File, porque usaremos - pare este ejemplo -una autenticación basada en archivo plano. Para producción podremos usar otro tipo de autenticación)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEharg6X_1EymGPtrVQ5CRv1q8MKY5w5oLIMbuvtcaLqW9DyALu_rz6eb6J_QbJsuiwMCe_tGUHRcw3uMyZvBxDmwIi4BQqNDKVkFip0oG9m85QNjjRyhzjZ-x8LrjLbk0pzNKHl6QLzVBM/s320/15-04-2013+09-49-51+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEharg6X_1EymGPtrVQ5CRv1q8MKY5w5oLIMbuvtcaLqW9DyALu_rz6eb6J_QbJsuiwMCe_tGUHRcw3uMyZvBxDmwIi4BQqNDKVkFip0oG9m85QNjjRyhzjZ-x8LrjLbk0pzNKHl6QLzVBM/s1600/15-04-2013+09-49-51+a.m..png)

Hacemos clic en el botón superior  "Manage Users" y comenzaremos a crear usuarios:

- Clic en "New..."

- Escribimos los siguientes campo:

- User ID: **usuario1**

- Group List: **usuario**

- New password: **usuario1 **(la misma contraseña para no olvidarnos)

- Confirm New password: **usuario1**

- Clic en "Ok"

- Crearemos dos usuarios más (usuario2, usuario3) con el  mismo rol y dos usuarios (admin1, admin2) con el rol "admin".

En este caso, los grupos se crearán cada vez que es mencionado en los usuarios. Otros tipos de *Realm* - como el de base de datos - debe existir otra tabla con los grupos a considerar.

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody>
<tr><td style="text-align: center;"><a href="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg8DFMgzEfV-bxVRcbwjzwSzyPB770y40GDmQA1yYfwKx1m4glI4fHlbglTNsSdt2MTEDnkCZadDJ-5ulMBdQ2_phZ6zw0FTrhN8GHYSzJw-7Ytqfa9Omgr6IYxKf-ktIyl9QLTOz7Ch6g/s1600/15-04-2013+09-58-23+a.m..png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="208" src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg8DFMgzEfV-bxVRcbwjzwSzyPB770y40GDmQA1yYfwKx1m4glI4fHlbglTNsSdt2MTEDnkCZadDJ-5ulMBdQ2_phZ6zw0FTrhN8GHYSzJw-7Ytqfa9Omgr6IYxKf-ktIyl9QLTOz7Ch6g/s320/15-04-2013+09-58-23+a.m..png" width="320" /></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Usuarios creados en el realm "File" de GlassFish</td></tr>
</tbody></table>

Si crea otro Realm de tipo file, asegurarse de que el JAAS Context sea **fileRealm**.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjegkO4lNEZ_bR7we38IYSND10szg-O7490Oq4bjJhp4SQTBWbeFeSYv-q256BVWz8sGxxL4mKthAnx5smOile28VrbfoEe5_3Bmc71gu4FW7OaiIH9E1Wi_jBatl0oLWfHIa707ucW1Is/s400/15-04-2013+10-54-18+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjegkO4lNEZ_bR7we38IYSND10szg-O7490Oq4bjJhp4SQTBWbeFeSYv-q256BVWz8sGxxL4mKthAnx5smOile28VrbfoEe5_3Bmc71gu4FW7OaiIH9E1Wi_jBatl0oLWfHIa707ucW1Is/s1600/15-04-2013+10-54-18+a.m..png)

Además, notar que este realm se llama "file". Este nombre lo usaremos cuando configuremos nuestra aplicación web.

### Definiendo seguridad en una aplicación Web.

Ahora, crearemos una aplicación llamada "CalculadoraSeguraRestWeb" el cuál tendrá la clase `CalculadoraService`.

<script src="http://pastebin.com/embed_js.php?i=XrXNAcsh"></script>

Lo nuevo en este código (en comparación del publicado en la [Parte 1](/2010/11/restful-la-forma-mas-ligera-de-hacer.html)) es que se están declarando dos nuevas anotaciones.

- [@DeclareRoles](http://docs.oracle.com/javaee/6/api/javax/annotation/security/DeclareRoles.html), que - como su nombre lo dice - declara los roles para una aplicación. Esta anotación se define en una clase.

- [@RolesAllowed](http://docs.oracle.com/javaee/6/api/javax/annotation/security/RolesAllowed.html), que indica que roles son permitidos para acceder al método.

Ahora bien, vemos que aquí se definen **roles** (user,admin) pero en  GlassFish hemos definido **grupos** (usuario,admin)

Lo que necesitamos es mapearlo: tales roles de la Aplicación corresponde a tales usuarios del GF, o, tales roles de la aplicación corresponde a tales grupos de GF. ¿Cuál es la diferencia entre Roles y Grupos? Veámoslo así:

- Los grupos son agrupaciones de usuarios, por ejemplo, agrupados por área de una empresa: Contabilidad, Finanzas, Sistemas, etc. Su alcance es solo organizacional.

- El rol es lo que toma un usuario cuando ingresa a la aplicación. Tenemos, por ejemplo: gerentes, usuarios, usuarios para imprimir, usuarios nocturnos, etc. Su alcance es solo en la aplicación.

Para nuestro caso, vamos a mapear el rol "USER" con el grupo "usuario", y "ADMIN" con el grupo "admin".

### Mapeando Grupos como Roles en una aplicación Web.

Entramos al archivo web.xml, y si no existe tal archivo, lo creamos con File > New (Ctrl+N), Categoría: Web, Tipo archivo: Standard Deployment Descriptor (web.xml)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgS7C44io9vLocehJ0lqemsMj47jEJyXxjw6YdQ4Pf-2eKRLghVR9TNvOue-Dh2cdUJ2LDsOhSl3myErqxptE5e2LU-TU50KCjvLN1D6UJzMlyDO6NM36LBI4JSqWB_dJAw6wD5H7-XQzc/s320/15-04-2013+11-04-26+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgS7C44io9vLocehJ0lqemsMj47jEJyXxjw6YdQ4Pf-2eKRLghVR9TNvOue-Dh2cdUJ2LDsOhSl3myErqxptE5e2LU-TU50KCjvLN1D6UJzMlyDO6NM36LBI4JSqWB_dJAw6wD5H7-XQzc/s1600/15-04-2013+11-04-26+a.m..png)

Seleccionamos la pestaña "Security" y en la sección "Login Configuration" seleccionamos "Basic" (esta es una autenticación muy genérica que le indica al navegador web abrir un formulario estándard)

Luego, en la entrada de texto "Realm Name" escribimos el nombre del realm que vamos a usar. Para este ejemplo colocaremos el nombre "file".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhNIimg8CGon0Lh0CDTqU7r4BMIaDAqOCT8j4f96f0vYIHgvGSPRv-574_mpJ0I_V_uQNABQQuEbZeAngooNBcc74tCba1qmCdV_if319KWYfe478F9ITvZqK086zdyWnzgOibnxOvLoVk/s320/16-04-2013+12-54-13+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhNIimg8CGon0Lh0CDTqU7r4BMIaDAqOCT8j4f96f0vYIHgvGSPRv-574_mpJ0I_V_uQNABQQuEbZeAngooNBcc74tCba1qmCdV_if319KWYfe478F9ITvZqK086zdyWnzgOibnxOvLoVk/s1600/16-04-2013+12-54-13+p.m..png)

Luego, en la misma pestaña pero en la sección "Security Roles", agregar dos roles "USER" y "ADMIN".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjaq_wKos5QNtb-n0V9BEn5vCslm4oFXMe1scy7NwYBjq_cNZ3zJNukENI2RExYkLMT_FYihLxFeBUcs5hWtRlFVuDCSEaakfsvD3oxsKWO6n5rLvHyCtWOi4en8roUCQ8ov-gseZbtiA/s320/15-04-2013+11-09-52+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjaq_wKos5QNtb-n0V9BEn5vCslm4oFXMe1scy7NwYBjq_cNZ3zJNukENI2RExYkLMT_FYihLxFeBUcs5hWtRlFVuDCSEaakfsvD3oxsKWO6n5rLvHyCtWOi4en8roUCQ8ov-gseZbtiA/s1600/15-04-2013+11-09-52+a.m..png)

Y para terminar con este archivo, en la sección "Security Contrstraints" hacemos clic en "Add Security Constraint", indicando el campo "Display Name" el valor "CalculadoraConstraint". Con esto estamos creando un conjunto de reglas de seguridad donde asignaremos un grupo de **rutas de acceso** con un **roles que podrán accederlos**.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEikEvkWJUaZw4Zioje4Lfe4c86uxRzgUNiW4LA-hocg5Crdn5cjdBJ_deufXv2iCkVBVgFhEFzi-ZTV8CgmKTj4xnvBaITQSbDu3rj9cG9SoFCUu-yZC-RTeUGtbdvvCU0UuCk0XCroh5U/s320/15-04-2013+11-14-54+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEikEvkWJUaZw4Zioje4Lfe4c86uxRzgUNiW4LA-hocg5Crdn5cjdBJ_deufXv2iCkVBVgFhEFzi-ZTV8CgmKTj4xnvBaITQSbDu3rj9cG9SoFCUu-yZC-RTeUGtbdvvCU0UuCk0XCroh5U/s1600/15-04-2013+11-14-54+a.m..png)

En la subsección "Web Resource Collection" indicamos qué rutas son parte de este conjunto. Hacemos clic en "Add" y escribimos

- Resource Name: CalculadoraResource

- URL Pattern(s): /webresources/calculadora/*  (Es el URL asociado al servicio que estamos protegiendo)

- HTTP Method(s). All (Se puede especificar cualquier tipo dependiendo de nuestro criterio. Para este caso usaremos All)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiAL3a1tHxxQtkdiQmZEtlah482WRY0FeJwA8eFqLS4b-2oxmnICgAYUxIaP_TcxWzGq6q9zJ2h44yUrdpHqYFDhudrwlKq3uQIQDTdU8Mo0Z64Bu3j00LqQ492NbHaxQp5BPSd3wrqD9s/s320/15-04-2013+11-17-28+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiAL3a1tHxxQtkdiQmZEtlah482WRY0FeJwA8eFqLS4b-2oxmnICgAYUxIaP_TcxWzGq6q9zJ2h44yUrdpHqYFDhudrwlKq3uQIQDTdU8Mo0Z64Bu3j00LqQ492NbHaxQp5BPSd3wrqD9s/s1600/15-04-2013+11-17-28+a.m..png)

Y activamos la opción "Enable Authenticacion Constraint" donde le indicaremos qué roles son permitidos para acceder al URL descrito arriba.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh9uxplJv_TVX0wDOtMEz31wBouIijYsCe-bq9obH6XXsFcCyVQ7Zu_xisZlkT956P8RfTP6_8IBs3EaGYaHuxF64llTXFfGQ53xodWnntG0f8iu3HPBdouqbwbGpe-eesiUEqGVt_TAR4/s320/15-04-2013+11-19-41+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh9uxplJv_TVX0wDOtMEz31wBouIijYsCe-bq9obH6XXsFcCyVQ7Zu_xisZlkT956P8RfTP6_8IBs3EaGYaHuxF64llTXFfGQ53xodWnntG0f8iu3HPBdouqbwbGpe-eesiUEqGVt_TAR4/s1600/15-04-2013+11-19-41+a.m..png)

Esto es todo en el archivo web.xml Si revisamos el código fuente, debe quedar algo así.

<script src="http://pastebin.com/embed_js.php?i=h5hMSQAG"></script>

Se pudo haber hecho directamente en el código fuente, pero con el IDE se hace más rápido y así hemos podido ver de qué trataba cada sección.

Ahora, abrimos el archivo de despliegue glassfish-web.xml Si no existe, lo creamos desde File> New (Ctrl+N) Categoria: GlassFish, Tipo de archivo: GlassFish Descriptor.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhz49OxB6wOikv4TVYQYjCNZ9wWVDOvZTYbE2Wydsae74HWMqbZNpxD-kdkdh7G6IgnIW9q0o8sL-ounuL2PkDrZE6flNLd63RRftqhWtcp71_WnY9fr6zaYv-am7PYaxfkVikvDn4opPc/s320/15-04-2013+11-35-17+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhz49OxB6wOikv4TVYQYjCNZ9wWVDOvZTYbE2Wydsae74HWMqbZNpxD-kdkdh7G6IgnIW9q0o8sL-ounuL2PkDrZE6flNLd63RRftqhWtcp71_WnY9fr6zaYv-am7PYaxfkVikvDn4opPc/s1600/15-04-2013+11-35-17+a.m..png)

Y en la pestaña "Security" veremos que están declarados los roles "ADMIN" y "USER" pero con un signo de interrogación. Esto es porque ha detectado que se han declarado en el web.xml pero no están declarados en este archivo de contexto. Aquí es donde debemos mapear los Roles de la aplicación con los grupos que definimos en el Realm.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyAXy2otdc7J0f_vMPj6Dq2WmBBiQAPljIl5fDNL2jVW41ZUdi1mgz2fcG-UK0PC6fv8eM7_E9xLecqz2dTCzLe05KzgffHl9a49gR3F9PHL1ZwrCFgqj2ignaK3_1B2xusClvAzIXzpk/s320/15-04-2013+11-39-05+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyAXy2otdc7J0f_vMPj6Dq2WmBBiQAPljIl5fDNL2jVW41ZUdi1mgz2fcG-UK0PC6fv8eM7_E9xLecqz2dTCzLe05KzgffHl9a49gR3F9PHL1ZwrCFgqj2ignaK3_1B2xusClvAzIXzpk/s1600/15-04-2013+11-39-05+a.m..png)

Abrimos el nodo"ADMIN" y hacemos clic en "Add Group". Escribiremos "admin" que es el grupo que definimos en el Realm.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmUfGivP4YemF64l5WOKKATQUahA79E8Mo0SJv4W4DAbtR_gzkSBDpfSStji6bKSrbJm5XzMo37poOj8P1Bm-sdNL3Gz4k-bi4U0CyAuWzO770HTS13PtErwZPydRMddTdw1WV7x9JniE/s320/15-04-2013+11-40-50+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmUfGivP4YemF64l5WOKKATQUahA79E8Mo0SJv4W4DAbtR_gzkSBDpfSStji6bKSrbJm5XzMo37poOj8P1Bm-sdNL3Gz4k-bi4U0CyAuWzO770HTS13PtErwZPydRMddTdw1WV7x9JniE/s1600/15-04-2013+11-40-50+a.m..png)

Clic en OK y veremos que ya se ha asignado el grupo "admin" al rol "ADMIN". Veremos que el signo de interrogación del Rol ha desaparecido.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZk-jyf2A2TC-l3mCLBkNzwUQNQ459E4bBgXyooaFXGusr1zOuI1A9i6HhhYdoIKTQl8uwsv-ubpF5tDzNGUvOsSAIzVtia0D6BC_j7GZVSfcmCh36q4SWG6jYZnbN2g-7imdjqB0vSS8/s320/15-04-2013+11-41-31+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZk-jyf2A2TC-l3mCLBkNzwUQNQ459E4bBgXyooaFXGusr1zOuI1A9i6HhhYdoIKTQl8uwsv-ubpF5tDzNGUvOsSAIzVtia0D6BC_j7GZVSfcmCh36q4SWG6jYZnbN2g-7imdjqB0vSS8/s1600/15-04-2013+11-41-31+a.m..png)

Ahora, haremos lo mismo para el rol "USER" pero le asignaremos el grupo "usuario".

Al final, esta pestaña debe lucir algo así

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi1yMt3b8Psi1wpu6k2yau36fGdCztRiVnkBRVdBREBxZxryDusTS-Eo-UJRFEGrADCIDYWNnvKRj4_UcycHOI0rqpEJt_8UBIMpxHpRCjL2f2aF1BF1HdaL6pT4HkvYoLoF1u_eGXid8A/s320/15-04-2013+11-44-05+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi1yMt3b8Psi1wpu6k2yau36fGdCztRiVnkBRVdBREBxZxryDusTS-Eo-UJRFEGrADCIDYWNnvKRj4_UcycHOI0rqpEJt_8UBIMpxHpRCjL2f2aF1BF1HdaL6pT4HkvYoLoF1u_eGXid8A/s1600/15-04-2013+11-44-05+a.m..png)

El archivo `glassfish-web.xml` luciría algo así

<script src="http://pastebin.com/embed_js.php?i=k3bB7YtE"></script>

### Definiendo el cliente

Para finalizar, haremos el cliente en el index.jsp de este proyecto. Lo haremos casi como el que se vió en la Parte 1 de este conjunto de tutoriales: usando jQuery. Pero, en lugar de usar el método [jQuery.get()](http://api.jquery.com/jQuery.get/) usaremos [jQuery.ajax()](http://api.jquery.com/jQuery.ajax/).

<script src="http://pastebin.com/embed_js.php?i=WsPN0k9K"></script>

Ahora,  ejecutemos la aplicación, y tratemos de darle un valor y calcular su factorial haciendo clic en el botón

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjzGbMD33VIdjrgnx9ONI_OymHZ6MhzJMtRtlORJpPcQ6ly_DDEBQ8AvUOQAVa0z8dSI-G7nZfRL86k-VNZIcj7_I01EhuMo2WS4MDg8SkGS_hr1eABP3exXKcE7zVRqHk8etZqEugXlYY/s320/15-04-2013+11-59-52+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjzGbMD33VIdjrgnx9ONI_OymHZ6MhzJMtRtlORJpPcQ6ly_DDEBQ8AvUOQAVa0z8dSI-G7nZfRL86k-VNZIcj7_I01EhuMo2WS4MDg8SkGS_hr1eABP3exXKcE7zVRqHk8etZqEugXlYY/s1600/15-04-2013+11-59-52+a.m..png)

Nos mostrará la autenticación del navegador para la aplicación. Este es el tipo "basic" que definimos en el web.xml, y es lo que queremos.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2kGYUs16EpwlBtDVgSoUxSRafcxvNtmDV_UJF-_uz1fnD1DZ4ZtSjW-vpbZNifNMqY8P-0pW8PMAa5xPMkvXTmqEUjQIl9fCoN0emIDDhMDGiljPnkWD-8NWej4F-vwYb-uxvVY2qL0U/s320/15-04-2013+12-00-23+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2kGYUs16EpwlBtDVgSoUxSRafcxvNtmDV_UJF-_uz1fnD1DZ4ZtSjW-vpbZNifNMqY8P-0pW8PMAa5xPMkvXTmqEUjQIl9fCoN0emIDDhMDGiljPnkWD-8NWej4F-vwYb-uxvVY2qL0U/s1600/15-04-2013+12-00-23+p.m..png)

Le ponemos las credenciales que pedimos en el Realm: usuario: **usuario1**, contraseña: **usuario1** Y si las credenciales son válidas, nos mostrará el resultado calculado.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiBNhq4gLo37NoNX1qQMsdm-aPV2aGwBblAIbQigAiX-VkdT9sH_vZFUHMeRTJJbQvbdscElIAqejMBMf3JmRxLnjUOTxXCxjInrNXVsXx3lImgjfRnrVyVD5EzLW7Ye3OPgkYjnDQjtvc/s320/15-04-2013+12-00-41+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiBNhq4gLo37NoNX1qQMsdm-aPV2aGwBblAIbQigAiX-VkdT9sH_vZFUHMeRTJJbQvbdscElIAqejMBMf3JmRxLnjUOTxXCxjInrNXVsXx3lImgjfRnrVyVD5EzLW7Ye3OPgkYjnDQjtvc/s1600/15-04-2013+12-00-41+p.m..png)

Ahora bien, necesitamos que la autenticación sea transparente ¿cómo lo hacemos? Le pasamos el usuario y contraseña a la petición del jQuery.

### Agregando autenticación el jQuery

He visto que la autenticación en la petición ajax de toolkit tipo jQuery Dojo es que permite pasar el usuario y contraseña en la misma petición, y así pasa la autenticación Basic.

Agregaremos un formulario de autenticación en el mismo .jsp.

<script src="http://pastebin.com/embed_js.php?i=rtVmKf8d"></script>

Y modificaremos el script que llama al REST para obtener las credenciales y enviárselas al REST.

<script src="http://pastebin.com/embed_js.php?i=Af99uHaS"></script>

El completo, sería así

<script src="http://pastebin.com/embed_js.php?i=Gfvr3XVm"></script>

Y cuando lo ejecutemos, bastará con que coloquemos el usuario y contraseña en el formulario respectivo, y listo... ya estamos usando la autenticación de REST con nuestro formulario.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGg2MKKry74c0IyMCdw38EFfaOz6fJUqClI5h3zCHcZhDA3gr0EjD809M28sMBtT7rwdg0ATRsRdXZSxcGhJz6Q8h-HULMTyX08UiLntcETJVNpBSdsrWPoGl26r_UHud_bJQKr2wcfRQ/s320/15-04-2013+12-12-06+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGg2MKKry74c0IyMCdw38EFfaOz6fJUqClI5h3zCHcZhDA3gr0EjD809M28sMBtT7rwdg0ATRsRdXZSxcGhJz6Q8h-HULMTyX08UiLntcETJVNpBSdsrWPoGl26r_UHud_bJQKr2wcfRQ/s1600/15-04-2013+12-12-06+p.m..png)

### Código fuente

Y a este post no le iba a faltar su código fuente.

Puedes descargar el proyecto desde aquí:

[http://java.net/projects/apuntes/downloads/download/restful/CalculadoraSeguraRestWeb.tar.gz](http://java.net/projects/apuntes/downloads/download/restful/CalculadoraSeguraRestWeb.tar.gz)

... y desde Mercurial, aquí:

[http://java.net/projects/apuntes/sources/hg/show/CalculadoraSeguraRestWeb](http://java.net/projects/apuntes/sources/hg/show/CalculadoraSeguraRestWeb)
