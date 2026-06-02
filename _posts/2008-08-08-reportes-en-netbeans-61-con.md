---
layout: post
title: "Reportes en NetBeans 6.1 con iReport/JasperReports y Visual Web JavaServer Faces"
date: 2008-08-08T18:22:00.006Z
last_modified_at: 2011-02-07T15:23:20.914Z
author: "Diego Silva"
permalink: /2008/08/reportes-en-netbeans-61-con.html
canonical_url: https://www.apuntesdejava.com/2008/08/reportes-en-netbeans-61-con.html
tags:
  - "glassfish"
  - "java"
  - "web"
  - "ireport"
  - "reportes"
  - "netbeans 6.1"
  - "tutorial"
  - "netbeans"
  - "jasperreports"
  - "jsf"
---

[Este tutorial también se encuentra en los [tutoriales en Español de NetBeans.](http://wiki.netbeans.org/Avbravo_TutorialesEspanol) Ya que es un Wiki, se puede tener el tutorial actualizado]

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Introducción

*Microsoft* tiene su *Visual Studio*, *Java* tiene a *NetBeans*.

*Microsoft* tiene su *Crystal Reports*, *Java* tiene *JasperReports*.

Java no tiene nada qué envidiar a Visual Studio. Ni menos en los reportes.

JasperReports es un framework bastante completo para desarrollar reportes tanto web como desktop en Java.

Aunque el formato fuente de un reporte en JasperReports es un archivo XML, existe una herramienta que permite crear un reporte de manera visual. Su nombre: iReport.

Pero como estamos usando como IDE a NetBeans, podemos elaborar nuestro reporte sin salir del IDE. Para ello, existe un plugin (archivo .nbm) para NetBeans que muestra el iReport dentro del mismo IDE.

[http://downloads.sourceforge.net/ireport/iReport-nb-0.9.2.nbm](http://downloads.sourceforge.net/ireport/iReport-nb-0.9.2.nbm)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Instalando el plugin

Después de descargar el archivo .nbm, abrimos el IDE NetBeans. Entramos al menú Tools > Plugins, y en la ficha *Downloaded*, hacemos clic en el botón *Add plugins...*

Seleccionamos el archivo .nbm que previamente hemos descargado. Después de esto se mostrará la ventana lista para instalarse el plugin:

[![Image:Pantallazo-Plugins_ReportesEnNetBeansConIReport.png](http://wiki.netbeans.org/wiki/images/a/aa/Pantallazo-Plugins_ReportesEnNetBeansConIReport.png)](http://draft.blogger.com/File:Pantallazo-Plugins_ReportesEnNetBeansConIReport.png)

Y hacemos clic en el botón *Install*. Se nos mostrará la siguiente ventana:

[File:Pantallazo-NetBeans IDE Installer.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-NetBeans_IDE_Installer.png)

Clic en *Next*. Aceptamos los términos de la licencia, y hacemos clic en *Install*. Nos mostrará la ventana de advertencia ya que el plugin es posible que no sea confiable:

[File:Pantallazo-Verify Certificate.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-Verify_Certificate.png)

Pero como sabemos de dónde lo hemos descargado, hacemos clic en *Continue*.

Al finalizar la instalación del plugin, veremos que hay una opción nueva en la barra de herramientas,

[![Image:ireportnb1_ReportesEnNetBeansConIReport.jpg](http://wiki.netbeans.org/wiki/images/e/e9/Ireportnb1_ReportesEnNetBeansConIReport.jpg)](http://draft.blogger.com/File:Ireportnb1_ReportesEnNetBeansConIReport.jpg)

y se muestra un panel nuevo de salida llamado "iReport output"

[![Image:ireportnb2_ReportesEnNetBeansConIReport.jpg](http://wiki.netbeans.org/wiki/images/1/1c/Ireportnb2_ReportesEnNetBeansConIReport.jpg)](http://draft.blogger.com/File:Ireportnb2_ReportesEnNetBeansConIReport.jpg)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

#### Verificando la biblioteca instalada.

Entremos a *Tools > Libraries* y seleccionemos la biblioteca *JasperReports 2.0.5-snapshot*. Revisemos el panel del classpath y veremos que hay una referencia marcada de rojo.

[![](http://wiki.netbeans.org/wiki/images/5/51/Pantallazo-Library_Manager.png)](http://wiki.netbeans.org/wiki/images/5/51/Pantallazo-Library_Manager.png)

Pues bien, significa que según la ubicación donde se instaló el módulo no encuentra la ubicación del .jar que necesitamos para nuestra aplicación. Por tanto, lo configuraremos manualmente.

Hacemos clic en el botón *Add Jar/Folder..* y buscamos la carpeta donde está instalada el NetBeans. Veremos que dentro hay una carpeta llamada *ireport*

[![](http://wiki.netbeans.org/wiki/images/7/75/Pantallazo-Browse_JAR-Folder.png)](http://wiki.netbeans.org/wiki/images/7/75/Pantallazo-Browse_JAR-Folder.png)

Entramos a esa carpeta, luego a *modules > ext*.

Buscamos el archivo *jasperreports-3.0.1.jar*,lo seleccionamos

[![](http://wiki.netbeans.org/wiki/images/2/2d/Pantallazo-Browse_JAR-Folder-1.png)](http://wiki.netbeans.org/wiki/images/2/2d/Pantallazo-Browse_JAR-Folder-1.png)

```java
y hacemos clic en <i>Add JAR/Folder</i>.
```

Como podemos deducir, el problema que no encontraba el archivo *jasperreports-2.0.5.jar* era porque no existía.

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Creando un proyecto

Lo que haremos en esta aplicación es mostrar en una lista todas las personas registradas en la base de datos *TRAVEL*. El usuario seleccionará uno de ellos, y hará clic en  un botón llamado *Mostrar Viajes* para mostrar en un reporte todos los viajes relacionados a esta persona. Además, habrá un botón de opción (Radio Button) que permitirá escoger el formato del reporte: en PDF o en HTML.

Crearemos un proyecto web llamado **TravelReport** el cual utilizará el framework *Visual Web JavaServer Faces*.

Además, agregamos la biblioteca 'JasperReports 2.0.5-snapshot'

[File:Pantallazo-Project Properties - TravelReport.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-Project_Properties_-_TravelReport.png)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### La página con la lista de personas

De la paleta de componentes seleccionamos un *Label* y lo soltamos en el *Page1.jsp*. El texto que tendrá el componente *label* será "Seleccione una persona:".

Además, de la paleta de componentes arrastramos un *Listbox* y lo soltamos debajo  del *label* que acabamos de pegar. En el panel de propiedades escribimos como *id* de este componente el valor *personasLB*.

También pegaremos un *Radio button group* al costado de la lista. Pondremos *formatoCG* como valor de la propiedad *id*.

Luego le damos clic derecho sobre el *Radio button group* que acabamos de pegar y seleccionamos la opción *Configure Default Options...* Editamos las opciones para que tengan como en la siguiente imagen:

[File:Pantallazo-Options Customizer - formatoCG.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-Options_Customizer_-_formatoCG.png)

Le damos nuevamente clic derecho y seleccionamos *Add Binding attribute*. Hacemos lo mismo con el componente *personasLB*.

Para finalizar con el diseño de esta página,  pegaremos un componente *button* y tendrá como texto "Mostrar Reporte".

El diseño de la página debe quedar así:

[File:Pantallazo-TravelReport - Page1.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-TravelReport_-_Page1.png)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Accediendo a la base de datos

Entramos al panel de *Services* del panel izquierdo, o presionando Ctrl+5. Abrimos el nodo *Databases*, hacemos clic derecho sobre la conexión a la base de datos *travel* y seleccionamos *Connect...*

Seleccionamos el nodo *Tables >> PERSON*, lo arrastramos y lo soltamos sobre el componente *personasLB*. Sabremos que se realizó ya que las opciones que se mostrarán en el diseño serán "abc" tres veces.

Hacemos clic derecho sobre *personasLB* y seleccionamos *Bind to data..*. Debe lucir así:

[File:Pantallazo-Bind to Data - personasLB.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-Bind_to_Data_-_personasLB.png)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Diseñando el reporte

Lo que necesitamos antes de programar cómo debe mostrarse el reporte, es, justamente, diseñar el reporte.

Presionamos Ctrl+N para mostrar el asistente para crear un nuevo archivo. Seleccionamos la categoría *Report* y el tipo de archivo *Report*.

[File:Pantallazo-New File.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-New_File.png)

Clic en el botón *Next*.

Escribimos *viajes.jrxml* como nombre del archivo, y en el campo *Folder* seleccionamos a través del botón *Browse* la carpeta *src/java/travelreport*

[File:Pantallazo-New Report.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-New_Report.png)

Clic en el botón *Next*.

En la ventana donde se selecciona el Datasource, hacemos clic en el botón *New..*, y en la ventana de diálogo que se muestra, seleccionamos *NetBeans Database JDBC Connection*

[![Image:Pantallazo-nbjdbconn_ReportesEnNetBeansConIReport.png](http://wiki.netbeans.org/wiki/images/f/fb/Pantallazo-nbjdbconn_ReportesEnNetBeansConIReport.png)](http://draft.blogger.com/File:Pantallazo-nbjdbconn_ReportesEnNetBeansConIReport.png)

Clic en el botón *Next*.

Escribimos '*travelDB* como nombre, y de la lista desplegable seleccionamos la conexión para la base de datos *travel*.

[![Image:Pantallazo-nbjdbconn1_ReportesEnNetBeansConIReport.png](http://wiki.netbeans.org/wiki/images/8/80/Pantallazo-nbjdbconn1_ReportesEnNetBeansConIReport.png)](http://draft.blogger.com/File:Pantallazo-nbjdbconn1_ReportesEnNetBeansConIReport.png)

Podemos hacer clic en el botón *Test* para comprobar que esté correcta la conexión.

Clic en el botón *Save*.

Clic en el  botón *Design query* para diseñar la consulta del reporte.

En este diseñador de consultas, desplegamos la lista que se encuentra en la parte media izquierda y seleccionamos la base de datos *TRAVEL*. Con esto se mostrarán las tablas de la base de datos.

[File:Pantallazo- query1.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-_query1.png)

Hacemos doble clic en la tabla *TRIP*. Un ícono que representa a la tabla *TRIP* se mostrará en el panel derecho de la ventana.  Hacemos doble clic también en la tabla *TRIPTYPE*. Veremos que se mostró la asociación existente entre ambas tablas.

Activamos las casillas de verificación de los campos *DEPDATE*, *DEPCITY* y *DESTCITY* de la *TRIP*, y *DESCRIPTION* de la tabla *TRIPTYPE*.

Clic en el botón *Ok*

El diseño de la consulta va a quedar así:

[File:Pantallazo- query3.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-_query3.png)

Clic en el botón *Ok*

Ahora vemos el comando SQL generada por el diseñador.

[File:Pantallazo-New File-2.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-New_File-2.png)

Clic en el botón *Next*.

En la selección de campos, hacemos clic en el botón ">>" para agregar todos los campos en el reporte.

[File:Pantallazo-New File-3.png](http://wiki.netbeans.org/wiki/index.hp?title=Special:Upload&wpDestFile=Pantallazo-New_File-3.png)

Clic en el botón *Next*.

En la selección de grupos, hacemos clic en el botón *Next*, ya que no haremos alguna agrupación en el reporte.

En la selección de diseño ("Layout") del reporte, seleccionamos *Tabular Layout*.

[File:Pantallazo-New File-4.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-New_File-4.png)

Clic en el botón *Next*. Finalmente, clic en el botón *Finish*.

El IDE nos mostrará el diseño del reporte que acabamos de crear utilizando el asistente. Podemos editarlo para que luzca como en la siguiente imagen:

[File:Pantallazo-NetBeans IDE 6.1-reporte1.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-NetBeans_IDE_6.1-reporte1.png)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Modificando el reporte para que permita parámetros.

Entramos a la opción *Window > Navigating > Report Inspector*. Se abrirá un panel llamado *Report Inspector* en la parte lateral izquierda inferior.

Hacemos clic derecho sobre el nodo *Parameters* y *Add parameter*. Con esto se agregará un nuevo nodo llamado *parameter1*.

Lo seleccionamos y modificamos las propiedades colocando lo siguiente:

-  **name**: personId

-  **Default value expresion**: "1"

-  **use as a prompt**: (sin seleccionar)

[File:Pantallazo-NetBeans IDE 6.1-parameterPersonId.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-NetBeans_IDE_6.1-parameterPersonId.png)

Hacemos clic derecho en una zona en blanco del diseñador de reportes, y seleccionamos *Edit query*. Se nos presentará el diseñador de consultas para el reporte actual.

[File:Pantallazo-Report query.png](http://wiki.netbeans.org/wiki/index.php?title=Special:Upload&wpDestFile=Pantallazo-Report_query.png)

Tenemos dos caminos para agregar el parámetro *personId* en la consulta

-  Agregando el valor **WHERE TRIP.PERSONID = $P{personId}** desde la misma ventana de edición del comando SQL.

-  Utilizando el diseñador de reporte, haciendo clic en el botón *Query designer*. Para ello, desde el diseñador de consulta, damos clic derecho sobre el nodo *WHERE* y seleccionamos *add condition*

[![Image:Pantallazo-condition_ReportesEnNetBeansConIReport.edit-1.png](http://wiki.netbeans.org/wiki/images/4/4c/Pantallazo-condition_ReportesEnNetBeansConIReport.edit-1.png)](http://draft.blogger.com/File:Pantallazo-condition_ReportesEnNetBeansConIReport.edit-1.png)

De cualquier manera, el query debe ser similar a este:

```java
SELECT
     TRIP."DEPDATE" AS TRIP_DEPDATE,
     TRIP."DEPCITY" AS TRIP_DEPCITY,
     TRIP."DESTCITY" AS TRIP_DESTCITY,
     TRIPTYPE."DESCRIPTION" AS TRIPTYPE_DESCRIPTION
FROM
     "TRAVEL"."TRIPTYPE" TRIPTYPE INNER JOIN "TRAVEL"."TRIP" TRIP ON TRIPTYPE."TRIPTYPEID" = TRIP."TRIPTYPEID"

WHERE
     TRIP.PERSONID = $P{personId}
```

Hacemos clic en el botón *Ok* para cerrar la ventana *Report query*

Podemos hacer clic en el botón *Preview* de la barra de herramientas del diseño del reporte para ver una muestra de cómo se visualizaría el reporte.

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Adicionando ImageServlet a la aplicación

Los reportes HTML de JasperReports utilizan algunos recursos propios como ciertas imágenes que ayudan a mostrarse un reporte correctamente. Para ello, debemos agregar un Servlet de JasperReports para que interprete las peticiones de imágenes usando sus propios recursos.

Abrimos el archivo *web.xml*, seleccionamos la sección *Servlets*, y hacemos clic en el botón *Add Servlet Element* que se encuentra en la parte superior derecha. En la ventana de diálogo que se muestra, escribimos los siguientes valores:

[![Image:AddImageServlet_ReportesEnNetBeansConIReport.jpg](http://wiki.netbeans.org/wiki/images/f/f2/AddImageServlet_ReportesEnNetBeansConIReport.jpg)](http://draft.blogger.com/File:AddImageServlet_ReportesEnNetBeansConIReport.jpg)

Clic en el botón *OK*

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Programando el lanzamiento del reporte.

Hasta ahora hemos hecho todo el diseño visual. Ahora haremos la parte de la programación del botón *Mostrar reporte*.

Regresamos a la ventana *Page1.jsp* y estando en el modo "Design" vamos a la ventana *Navigator*. Examinamos los nodos y le damos doble clic en el nodo *ApplicationBean1*. El código fuente de *ApplicationBean1.java* se abrirá en el editor.

**sugerencia:** podemos escribir las siguientes líneas de código presionando Ctrl+Espacio cuando se desea escribir una clase o un método de tal manera que el IDE nos pueda sugerir cuáles son las clases que se utilizará y agregará los *imports* necesarios.  También se puede copiar estas líneas de código y pegarlas en el editor del IDE, y luego presionar Ctrl+Mayúscula+I para importar las clases que se utilizan en la clase

.

Agregemos el siguiente método:

```java
public void jasperReport(String tipo, String dataSourceName, Map<String, String> params) throws ClassNotFoundException {
        ExternalContext econtext = getExternalContext();
        InputStream inputStream = ApplicationBean1.class.getResourceAsStream("/travelreport/viajes.jasper");
        if (inputStream == null) {
            throw new ClassNotFoundException("Archivo viajes.jasper no se encontró");
        }
        FacesContext fcontext = FacesContext.getCurrentInstance();
        try {
            JRExporter exporter = null;
            Context  ctx=new InitialContext();
            DataSource ds=(DataSource) ctx.lookup(dataSourceName);
            Connection conn=ds.getConnection();

            JasperPrint jasperPrint = JasperFillManager.fillReport(inputStream, params, conn);
            HttpServletResponse response = (HttpServletResponse) econtext.getResponse();

            HttpServletRequest request = (HttpServletRequest) econtext.getRequest();

            response.setContentType(tipo);
            if ("application/pdf".equals(tipo)) {
                exporter = new JRPdfExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
                exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
            } else if ("text/html".equals(tipo)) {
                exporter = new JRHtmlExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
                exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
                exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, request.getContextPath() + "/image?image=");
            }
            if (exporter != null) {
                exporter.exportReport();
            }
        } catch (Exception ex) {
            Logger.getLogger(ApplicationBean1.class.getName()).log(Level.SEVERE, null, ex);
            throw new FacesException(ex);
        }
        fcontext.responseComplete();

    }
```

Ahora, desde la ventana *Page1.jsp* hacemos doble clic en el botón *Mostrar reporte*. Con esto se mostrará el método *button1_action()*. Editemos el método para que luzca así:

```java
public String button1_action() {
        try {
            Map<String, String> params = new HashMap<String, String>();
            params.put("personId", getPersonasLB().getSelected().toString());
            String dataSourceName = getSessionBean1().getPersonRowSet().getDataSourceName();

            String tipo = (String) formatoCG.getSelected();
            getApplicationBean1().jasperReport(tipo, dataSourceName, params);

        } catch (Exception ex) {
            Logger.getLogger(Page1.class.getName()).log(Level.SEVERE, null, ex);
            error(ex.toString());
        }
        return null;
    }
```

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Ejecutando la aplicación

Ejecutamos el proyecto con la tecla F6.

[![Image:Pantallazo-ProjectRunning_ReportesEnNetBeansConIReport.png](http://wiki.netbeans.org/wiki/images/a/aa/Pantallazo-ProjectRunning_ReportesEnNetBeansConIReport.png)](http://draft.blogger.com/File:Pantallazo-ProjectRunning_ReportesEnNetBeansConIReport.png)

Seleccionemos una persona de la lista, seleccionamos una opción del tipo de reporte (html o pdf) y hacemos clic en el botón "Mostrar reporte".

Reporte en HTML:

[![Image:reporte-html1_ReportesEnNetBeansConIReport.jpg](http://wiki.netbeans.org/wiki/images/2/25/Reporte-html1_ReportesEnNetBeansConIReport.jpg)](http://draft.blogger.com/File:Reporte-html1_ReportesEnNetBeansConIReport.jpg)

Reporte en PDF:

[![Image:reporte-pdf1_ReportesEnNetBeansConIReport.jpg](http://wiki.netbeans.org/wiki/images/8/81/Reporte-pdf1_ReportesEnNetBeansConIReport.jpg)](http://draft.blogger.com/File:Reporte-pdf1_ReportesEnNetBeansConIReport.jpg)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Recursos

El código fuente del proyecto utilizado en este tutorial se encuentra aquí [http://diesil-java.googlecode.com/files/TravelReport.tar.gz](http://diesil-java.googlecode.com/files/TravelReport.tar.gz)

[](http://draft.blogger.com/post-edit.g?blogID=8553642737291298841&postID=1851829313234652604)

### Ver también

-  [Generating Reports and PDFs From a Web Application](http://testwww.netbeans.org/kb/55/vwp-reports.html)

-  [Using Databound Components to Access a Database](http://www.netbeans.org/kb/60/web/databoundcomponents.html)
