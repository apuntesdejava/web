---
layout: post
title: "Aprendiendo sobre Alcances de variables de Sesión en JSF"
date: 2009-02-13T15:36:00.001Z
last_modified_at: 2009-06-15T20:55:36.323Z
author: "Diego Silva"
permalink: /2009/02/aprendiendo-sobre-alcances-de-variables.html
canonical_url: https://www.apuntesdejava.com/2009/02/aprendiendo-sobre-alcances-de-variables.html
tags:
  - "java"
  - "web"
  - "netbeans 6.5"
  - "java ee"
  - "ICEfaces"
  - "netbeans"
  - "tutorial"
  - "jsf"
---

(Versión Wiki: [http://wiki.netbeans.org/AprendiendoSobreAlcancesJSF](http://wiki.netbeans.org/AprendiendoSobreAlcancesJSF))

### Introducción

Sabemos que es un dolor de cabeza usar las variables de sesión a través de los objetos HttpSession y HttpRequest. No sabemos si una variable está en nivel de sesión o en nivel de request, simplemente lo ponemos y lo usamos, aunque después nos pueden dar problemas a lo largo de la aplicación Pero al usar JSF esto se hará mucho más sencillo. JSF nos permite utilizar tres tipos de alcances:

-  Aplicación: Una variable guardada en este alcance es visible durante toda la aplicación, hasta que se repliegue la aplicación o hasta que se detenga el servidor.
-  Sesión: Una variable guardada a nivel de sesión, puede ser visible durante el tiempo de vida del usuario en la aplicación, hasta que se invalide la sesión.
-  *Request*: Una variable en nivel *request* dura solo hasta la siguiente página, Una página 1, guarda la variable en nivel *request* y redirecciona la petición a la página 2. La página 2 la utiliza, y el objeto desaparece.
Por tanto, haremos una aplicación que permita hacer votos y mostrar el resultado. Las alternativas y cuenta de votos se guardarán a nivel de la aplicación; el usuario que haya hecho el voto no podrá volver a votar, por tanto la aplicación sabrá que se trata del mismo usuario porque mantiene la sesión; y cuando el usuario quiera ver los resultados, estos se mostrarán en de acuerdo al requerimiento.

### Software necesario:

-  Java 6
-  Glassfish V2
-  NetBeans 6.5 con el componente Visual ICE Faces que se puede descargar desde el Centro de Actualización (Herramientas > Complementos)

### Creando una aplicación JSF con Visual ICEFaces

#### Diseñando la aplicación visual

-  Crearemos una aplicación Web al que llamaremos Scopes <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes01.jpg" width="500" /></td></tr></tbody></table>
-  En la Paso "4. Frameworks" activamos el framework **Visual Web ICEfaces** <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes02.jpg" width="500" /></td></tr></tbody></table>
-  Al terminar de crear el proyecto, se mostrará un texto de advertencia. Lo borramos ya que advierte que en este proyecto no funcionarán las paletas *Woodstock*
-  Ahora, desde el panel *ICEfaces* arrastramos y colocamos los siguientes componentes al diseño de Page1.jsp

-  OutputText: Y en el atributo value escribimos '¿Cuál es tu lenguaje de programación favorito?'
-  SelectOneRadio: cuyo atributo id será opcionesRadio
-  Y dos CommandButton: uno con id=votarButton, value='Votar' y el otro id=resultadosButton, value='Ver resultados', action='ver_resultados' <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes03.jpg" /></td></tr></tbody></table>En general, podemos escribir el código y por cada declaración de clase que vayamos usar, escribimos unos cuantos caracteres del nombre y presionamos Ctrl+Espacio para que el IDE nos sugiera las clase, y al seleccionarla nos hará el import de esas clases de manera automática. O al finalizar de escribir todo el código, presionamos Mayus+Ctrl+I para importar las clases necesarias y borrar las innecesarias.

-  En el explorador del proyecto, abrimos el nodo de fuentes de clase y abrimos la clase ApplicationBean1.java. Esta clase contendrá todas las variables que se usarán en toda la aplicación. Para nuestro caso, aquí colocaremos las opciones de la encuesta, y el contador por cada opción marcada. Así que, después de la declaración de la clase, justamente después de  {  escribimos
private com.sun.webui.jsf.model.Option[] opciones;
private java.util.HashMap votos;  Además, crearemos sus métodos set y get. Podemos hacer esto desde la opción *Reestructurar > Encapsular campos...*
-  También necesitamos hacer una pequeña lógica de negocio para incrementar los votos a alguna opción seleccionada. Así que crearemos el siguiente método:

```java
<code><br />public void votoPara(String votoHecho) {<br />  Integer cuenta = votos.get(votoHecho);<br />  if (cuenta == null) {<br />     cuenta = 0;<br />  }<br />  cuenta++;<br />  votos.put(votoHecho, cuenta);<br />}<br /></code>
```

-  Ahora, vamos al método init() de la misma clase, y en la última línea del cuerpo del método escribiremos la inicialización de los valores de las propiedades que acabamos de crear:

```java
<code><br />opciones = new Option[]{<br />new Option("java", "Java Programming Language"),<br />new Option("cpp", "C++"),<br />new Option("fortran", "Fortran")};<br />votos = new HashMap<string, integer="">();<br />for (Option o : opciones) {<br />    votos.put(o.getValue().toString(), 0);<br />}<br /></code>
```

-  Ya tenemos las variables que son visibles desde toda la aplicación. Ahora haremos la variable que durará la sesión del usuario. Así que abrimos la clase SessionBean1.java y agregamos la propiedad boolean haVotado con sus respectivos set/get

```java
<code><br />private boolean haVotado;<br /><br />public boolean isHaVotado() {<br />   return haVotado;<br />}<br /><br />public void setHaVotado(boolean haVotado) {<br />   this.haVotado = haVotado;<br />}<br /></code>
```

-  Y la última variable de nivel de requerimiento (request) será la hora en que se accede al resultado de los votos. Así que abriremos la clase RequestBean1.java y agregamos la propiedad java.util.Date hora con su respecto set/get

```java
<code><br />private java.util.Date hora;<br /><br />public Date getHora() {<br />    return hora;<br />}<br /><br />public void setHora(Date hora) {<br />    this.hora = hora;<br />}<br /></code>
```

#### Manejando los valores de los controles

-  Necesitamos colocar los valores de nuestro arreglo de la clase ApplicationBean1 en el formulario. Vayamos al modo diseño visual de Page1.jsp, hagamos clic derecho sobre el objeto opcionesRadio y seleccionamos *Bind to data...*
-  Seleccionamos el objeto opciones que se encuentra bajo el objeto ApplicationBean1 <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes04.jpg" /></td></tr></tbody></table>Clic en *Aceptar*
-  Al hacer esto, el objeto del diseño se habrá 'desaparecido*. No sucede tal cosa, sino que se adecuo al contenido. Como las opciones solo se verán en tiempo de ejecución, no se pueden visualizar en el modo de edición. *
-  Ahora, debemos establecer que cuando el usuari haya hecho clic en el botón "Votar", ya no puede volver a votar. Para ello necesitamos desactivar el botón. Así que el estado de este control depende del valor de la propiedad *haVotado* que está en la clase SessionBean1. Haremos clic derecho sobre el botón, y seleccionamos *Properties binding...* y seleccionamos en el panel izquierdo la propiedad disabled y en el panel derecho seleccionamos de *SessionBean1.haVotado* <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes05.jpg" /></td></tr></tbody></table>Clic en *Close*.
-  Hacemos clic en el botón superior *Java* para ver el código de la clase Page1.java, y agregamos los siguientes métodos. Estos nos permitirán acceder a los objetos ApplicationBean1, SessionBean1 y RequestBean1

```java
<code><br />protected ApplicationBean1 getApplicationBean1() {<br />   return (ApplicationBean1) getBean("ApplicationBean1");<br />}<br /><br />protected RequestBean1 getRequestBean1() {<br />   return (RequestBean1) getBean("RequestBean1");<br />}<br /><br />protected SessionBean1 getSessionBean1() {<br />   return (SessionBean1) getBean("SessionBean1");<br />}<br /></code>
```

-  Hacemos clic en el botón superior *Design* para ver el modo diseño de Page1.jsp y hacemos doble-clic sobre el botón *Votar*. Esto creará el método votarButton_action() en la clase Page1.java. Aquí obtendremos el valor seleccionado y lo incrementaremos en el contador de votos:

```java
<code><br />public String votarButton_action() {<br />   if (selectOneRadio1Bean.getSelectedObject() != null) {<br />      String votoHecho = (String) selectOneRadio1Bean.getSelectedObject();<br />      getApplicationBean1().votoPara(votoHecho);<br />      getSessionBean1().setHaVotado(true);<br />      Date hora = new Date();<br />      getRequestBean1().setHora(hora);<br />   }<br />   return null;<br />}<br /></code>
```

-  Regresamos al modo diseño de Page1.jsp y hacemos doble clic en el botón resultadosButton y hacemos que devuelva la cadena "mostrar_resultados"

```java
<code><br /><br />public String resultadosButton_action() {       <br />    return "mostrar_resultados";<br />}<br /></code>
```

#### Página de respuesta

-  Creamos una nueva página de la categoría *JavaServer Faces* y el tipo *ICEfaces Visual Web JSF Page* <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes06.jpg" /></td></tr></tbody></table>al cual lo llamaremos Page2.jsp
-  Agregaremos los siguientes controles:

-  Un outputText con value="Resultados de los votos"
-  Un commandButton con value="Inicio" y id="inicioButton"
-  Otro commandButton con value="Recargar" y id="cargarButton"
-  Un outputText con id="resultadoText", **escape=(desmarcado)** y value=""
-  Otro outputText con id="fechaText" y value=""  <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes07.jpg" width="align" /></td></tr></tbody></table>

-  Tanto para resultadoText como para fechaText hacemos clic derecho sobre el control y seleccionamos "Add Binding Attribute"
-  Hagamos doble en el botón "Inicio".  Se abrirá el editor del código de Page2.java, y se creará el método inicioButton_action(), modificamos el código para que tenga el siguiente contenido:

```java
<code><br />public String inicioButton_action() {       <br />   return "inicio";<br />}<br /></code>
```

 Posteriormente programaremos la navegación de las páginas.
-  Estando en el archivo Page2.java, buscamos el método prederender() y lo editamos con el siguiente código

```java
<code>    public void prerender() {<br />        //Mostrar los últimos propositos<br />        ApplicationBean1 appBean = getApplicationBean1();//El Bean de toda la aplicacion<br />        Option[] opciones = appBean.getOpciones();//las opciones de la aplicacion<br />        Map<String, Integer> cuentasVotos = appBean.getVotos(); //y obtenemos las cuentas de los votos hechos<br />        StringBuilder sb = new StringBuilder(); //para contatenar las cadenas que vamos a crear.<br />        sb.append("<table border='0' cellpadding='5'>");//vamos a crear un table para resultados<br />        for (Option opcion : opciones) { //recorremos todas las opciones de la encuesta<br />            String idVoto = (String) opcion.getValue(); //obtenemos el id de la opción<br />            String etiqueta = opcion.getLabel();//obtenemos el valor que se muestra como opciones<br />            int cuenta = cuentasVotos.get(idVoto); //obtenemos cuantos votos se hizo para la opción actual<br />            sb.append("<tr>"); //nueva fila en el table<br />            sb.append("<td>" + etiqueta + "</td>"); //agregamos la etiqueta de la opcion de voto<br />            sb.append("<td>" + cuenta + "</td>");//agregamos los votos hechos a la opcion de voto actual<br />            sb.append("</tr>"); //fin de la fila en el table<br />        }<br />        sb.append("</table>"); //fin del table<br />        resultadoText.setValue(sb); //mostramos el resultado. Se mostrará como String<br /><br />        //Ahora, obtendremos la hora y fecha en que se hizo el voto<br />        RequestBean1 reqBean=getRequestBean1(); //obtenemos el bean del requerimiento<br />        Date hora=reqBean.getHora();<br />        if (hora!=null){<br />            fechaText.setValue("Su voto fue realizado el "<br />                    +(String)DateFormat.getTimeInstance(DateFormat.FULL).format(hora)); //imprimos la fecha en un formato completo<br />        }<br />    }<br /><br /></code>
```

#### Navegación entre las páginas

-  Abrimos el archivo faces-config.xml. La manera más rápida de ubicar el archivo es presionando Mayus+Alt+O y escribimos el nombre del archivo.
-  Hacemos clic en el botón superior que dice "PageFlow" para entrar al modo visual de la navegación de las páginas de JSF. Más o menos se visualizará así: <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes09.jpg" /></td></tr></tbody></table>Vemos que en cada ícono de página hay un cuadrado de color celeste en la parte derecha. Así que hacemos clic en ese cuadrado del ícono del archivo Page1.jsp, lo arrastramos y lo soltamos en Page2.jsp. <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes10.jpg" /></td></tr></tbody></table>
-  Al soltar la flecha, se habrá creado un vértice dirigido con el nombre "case1" Hacemos doble clic sobre este texto y lo cambiamos con el nombre "mostrar_resultados" <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes11.jpg" /></td></tr></tbody></table>
-  Haremos otro enlace desde la Page2.jsp a Page1.jsp  y se llamará "inicio"  <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes12.jpg" /></td></tr></tbody></table>
Estos textos son los que escribimos como return en los métodos resultadosButton_action()  de Page1.jsp y inicioButton_action() de Page2.jsp respectivamente. Hagamos clic en el botón superior "XML" de faces-config.xml. Cuando arrastramos los flechas, el código que generó fue el siguiente:

```java
<code>    <navigation-rule><br />        <from-view-id>/Page1.jsp</from-view-id><br />        <navigation-case><br />            <from-outcome>mostrar_resultados</from-outcome><br />            <to-view-id>/Page2.jsp</to-view-id><br />        </navigation-case><br />    </navigation-rule><br />    <navigation-rule><br />        <from-view-id>/Page2.jsp</from-view-id><br />        <navigation-case><br />            <from-outcome>inicio</from-outcome><br />            <to-view-id>/Page1.jsp</to-view-id><br />        </navigation-case><br />    </navigation-rule></code><br />
```

#### Ejecutando la aplicación

Ejecutamos el proyecto con la tecla F6.  <table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes13.jpg" /></td></tr></tbody></table>Hagamos nuestro primer voto: Seleccionamos nuestro voto y hacemos clic en el botón "Votar". Notemos que en ese mismo momento el botón quedó desactivado.
<table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes14.jpg" /></td></tr></tbody></table>Este botón quedará desactivado mientras duré la sesión o hasta que cerremos nuestro navegador. Hagamos clic en el botón "Ver resultados".
<table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes15.jpg" /></td></tr></tbody></table>Podemos regresar al inicio haciendo clic en el boton "Inicio" y aún así no se podrá volver a votar. Recordemos que ese botón lo asociamos al objeto "haVotado" que se encuentra en el SessionBean
Ahora probemos entrando desde **otro navegador**. Entremos nuevamente a la misma dirección [http://localhost:8080/Scopes/Page1.iface](http://localhost:8080/Scopes/Page1.iface)
<table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes16.jpg" /></td></tr></tbody></table>Sin hacer ningún voto, hagamos clic en "Ver resultados"
<table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes17.jpg" /></td></tr></tbody></table>Vemos que se ve el voto que hicimos desde el otro navegador. Pero no se visualiza cuando fue. Claro, eso se calculó al momento del voto desde el otro navegador. En este nuevo navegador hagamos clic en "inicio" y realicemos nuestro voto.
<table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes18.jpg" /></td></tr></tbody></table>Regresemos a nuestro primer navegador, y hagamos clic en el botón "Recargar"
<table class="imageplugin" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/AprendiendoSobreAlcancesJSF/scopes19.jpg" /></td></tr></tbody></table>

### Conclusiones

Hemos podido ver cómo funcionan los diferentes alcances (scope) en una aplicación JSF. No fue necesario de algún request.setAttribute() o session.setAttribute Solo basta con colocar propiedades en los Bean de acuerdo a nuestro requerimiento. Si queremos que una variable dure en toda la aplicación para todos los usuarios, usamos ApplicationBean1; si queremos que una variable dure durante la sesión del usuario, usamos SessionBean1, y si solo queremos que dure solo en una página, usamos RequestBean1.

### Recursos

El proyecto utilizado en este tutorial se puede descargar desde aquí [http://diesil-java.googlecode.com/files/scopes.tar.gz](http://diesil-java.googlecode.com/files/scopes.tar.gz)
