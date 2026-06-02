---
layout: post
title: "Upload en JSF 2.0"
date: 2011-03-08T23:26:00Z
last_modified_at: 2011-03-08T23:26:24.387Z
author: "Diego Silva Límaco"
permalink: /2011/03/upload-en-jsf-20.html
canonical_url: https://www.apuntesdejava.com/2011/03/upload-en-jsf-20.html
tags:
  - "web"
  - "servlets"
  - "java ee"
  - "java ee 6"
  - "jsf"
  - "jsf 2.0"
---

![]({{ '/assets/blogger/upload.png' | relative_url }})

Después de varias semanas desconectado por motivo de trabajo (parece que ahora sí trabajo más que antes) retomo (y espero que sea más seguido) los artículos de este blog que, según veo las estadísticas, a varios desarrolladores ayudan.

Y bueno, estuve haciendo una aplicación con JSF 2.0, y una de las característica que debería tener es que  permita anexar archivos. Los Servlet 3.0 - que son parte de Java EE 6 - permiten cargar archivos de manera nativa. Lo que mostraré en este post es justamente cómo utilizar el Upload de Servlet 3.0 desde una aplicación web con JSF 2.0. No usaré extensiones de JSF como el ICEFaces o el MyFaces, porque quiero hacerlo de la manera más genérica posible, de tal manera que no afecte a la implementación de JSF que estén usando.

Supongamos que nuestra aplicación debe  registrar  una bitácora de trabajo, y en cada registro permita anexar archivos, para que después se pueda descargar.

Nuestra aplicación web...

[![]({{ '/assets/blogger/upload-001.jpg' | relative_url }})]({{ '/assets/blogger/upload-001.jpg' | relative_url }})

... se llamará "BitacoraWeb"...

[![]({{ '/assets/blogger/upload-002.jpg' | relative_url }})]({{ '/assets/blogger/upload-002.jpg' | relative_url }})

... y se ejecutará en GlassFish V3...

[![]({{ '/assets/blogger/upload-003.jpg' | relative_url }})]({{ '/assets/blogger/upload-003.jpg' | relative_url }})

... con soporte para JSF 2.0

[![]({{ '/assets/blogger/upload-004.jpg' | relative_url }})]({{ '/assets/blogger/upload-004.jpg' | relative_url }})

Y listo...

[![]({{ '/assets/blogger/upload-005.jpg' | relative_url }})]({{ '/assets/blogger/upload-005.jpg' | relative_url }})

Comencemos ahora sí. (Para la siguiente haré un post bien explicado sobre cómo crear aplicaciones web en NetBeans para ahorrarme estos pasos)

Para registrar la bitácora necesitamos de una base de datos. Lo mostraré aquí con MySQL, pero - naturalmente - ustedes pueden utilizar la que más se acomode.

Asumiré - para este post - que existe la base de datos "bitacora" asignado al usuario "bitacora" con contraseña "bitacora"

Ahora, necesitamos una entidad llamada "Entrada" que tendrá las siguientes propiedades:

```java
<code>@Entity
public class Entrada implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column
    private String descripcion;
    @ElementCollection
    private List<Adjunto> adjuntos;

    public void addAdjunto(Adjunto adjunto) {
        getAdjuntos().add(adjunto);
    }

    public List<Adjunto> getAdjuntos() {
        if (adjuntos == null) {
            adjuntos = new ArrayList<Adjunto>();
        }
        return adjuntos;
    }
//... métodos get y set por cada propiedad
</code>
```

Y la Clase `Adjunto` tendrá la siguiente estructura:

```java
<code>
@Embeddable
public class Adjunto implements Serializable {

    @Lob
    private byte[] contenido;
    @Column
    private String tipoContenido;
    @Column
    private String nombreArchivo;

    public Adjunto() {
    }

    public Adjunto(byte[] contenido, String tipoContenido, String nombreArchivo) {
        this.contenido = contenido;
        this.tipoContenido = tipoContenido;
        this.nombreArchivo = nombreArchivo;
    }
//.. métodos set y get de las propiedades.
</code>
```

Ahora, necesitamos el manejador de la entidad `Entrada`. Con el NetBeans, esto se nos será muy fácil: basta con seleccionar desde la opción "File > New" la opción "Persistence > Session Beans For Entity Classes"

[![]({{ '/assets/blogger/upload-006.jpg' | relative_url }})]({{ '/assets/blogger/upload-006.jpg' | relative_url }})

Seleccionamos las Entidades que queremos administrar...

[![]({{ '/assets/blogger/upload-007.jpg' | relative_url }})]({{ '/assets/blogger/upload-007.jpg' | relative_url }})

... seleccionamos donde queremos que se creen...

[![]({{ '/assets/blogger/upload-008.jpg' | relative_url }})]({{ '/assets/blogger/upload-008.jpg' | relative_url }})

... y listo.

Ahora, crearemos un ManagedBean de alcance "Session" llamado BitacoraBean. Este es el que mostrará los datos en el formulario.

[![]({{ '/assets/blogger/upload-009.jpg' | relative_url }})]({{ '/assets/blogger/upload-009.jpg' | relative_url }})

No voy a detallar cada parte del código, porque es algo complejo. Además, el código colgado ya tiene sus propios comentarios. Pero sí voy a explicar partes principales de las clases principales.

En la parte inferior del JSF hay un formulario que es donde se registrará la bitácora. Pero también hay una parte para agregar los archivos. Para esto utilicé otra página para cargar los adjuntos.

```java
<code>//...
        <h:form id="form">
            <h:panelGrid columns="2">
                <h:outputLabel value="Descripción" for="descripcion" />
                <h:inputTextarea id="descripcion" value="#{bitacoraBean.entradaActual.descripcion}" />

                <h:outputText value="Adjuntos"/>

                <h:panelGroup>
                    <h:commandButton value="Recargar..." id="recargar">
                        <f:ajax render="adjuntos" />
                    </h:commandButton>
                    <h:button value="Agregar" onclick="return abrirAdjuntos()"/>

<!-- aqui va el codigo donde se muestra los adjuntos -->
                </h:panelGroup>
            </h:panelGrid>
            <h:commandButton action="#{bitacoraBean.guardarEntrada}" value="Guardar"/>
        </h:form>
//...
</code>
```

Por ello existe el botón "Cargar archivo". Lo que hace este botón es abrir un JSP que tiene un formulario para cargar cualquier archivo.

El boton "recargar" no hace nada. Solo que cuando se llama, se recarga la página, y por tanto, muestra los contenidos de la tabla de adjuntos. (Por ahora lo oculté, porque sino se confundiría con lo que quiero explicar)

El formulario de carga es bastante simple: (archivo form.jsp)

```java
<code>//...
        <h1>Cargar archivo</h1>
        <form action="<c:url value='/servlet/upload'  />" method="POST" enctype="multipart/form-data">
            Archivo:
            <input type="file" name="archivo" value="" />
            <button type="submit">Cargar</button>
        </form>
//...</code>
```

El servlet que es apuntado por este formulario es lo principal. Veamos por qué:

```java
<code>
@WebServlet(name = "UploadServlet", urlPatterns = {"/servlet/upload"})
public class UploadServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("archivo"); //obtengo el archivo adjunto
        String nombreArchivo = extraerNombre(filePart.getHeader("content-disposition")); //extraigo el nombre

        InputStream is = filePart.getInputStream(); //obtengo el Stream
        long size = filePart.getSize(); //... el tamaño
        byte[] buffer = new byte[(int) size]; //.. creo el buffer
        is.read(buffer); //.. leo el buffer en un solo bloque
        is.close(); //... cierro el buffer
        String mimeType = filePart.getContentType(); //... obtengo el tipo de archivo
        Adjunto adjunto = new Adjunto(buffer, mimeType, nombreArchivo); //... creo el objeto ajdjunto
        BitacoraBean bitacoraBean = (BitacoraBean) request.getSession().getAttribute("bitacoraBean"); //obtengo el bean
        Entrada entradaActual = bitacoraBean.getEntradaActual(); //.. obtengo la entrada actual que está con el formulario
        entradaActual.addAdjunto(adjunto); //... adjunto el objeto del archivo
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println("<html><head>"); //imprimo en el HTML para ejecutar un javascript
            out.println("<script type=\"text/javascript\">");
            out.println("window.opener.document.getElementById(\"form:recargar\").click()"); //busco el boton para recargar
            out.println("window.close()"); //cierro ventana
            out.println("</script>");
            out.println("</head></html>");
        } finally {
            out.close();
        }
    }

    /**
     * Método para extrar el nombre físico del archivo
     * @param header Parametro del nombre, con toda la ruta completa en el cliente
     * @return Devuelve solo el nombre del archivo
     */
    static private String extraerNombre(String header) {
        String[] parts = header.split(";");
        for (String part : parts) {
            if (part.trim().startsWith("filename=")) { //busco todos los que comienzan con filename
                String[] $parts = part.split("="); //separo el nombre
                StringBuilder $sb = new StringBuilder($parts[1]);
                String fn = $sb.substring(1, $sb.length() - 1); //el segundo es el nombre
                File f = new File(fn); //creo una entrada de archivo
                return f.getName(); //devuelvo el nombre del archivo
            }
        }
        return "";
    }

</code>
```

Ahora bien, el boton "Recargar" es utilizado justo por el JavaScript que devuelve el Servlet. La parte que contiene para mostrar los adjuntos (o sea, lo que oculté hace un rato) es como sigue:

```java
<code>
 <h:dataTable id="adjuntos" value="#{bitacoraBean.entradaActual.adjuntos}"  var="adjunto" binding="#{bitacoraBean.adjuntosDataTable}">
   <h:column>
     <h:outputText value="#{adjunto.nombreArchivo}" />
   </h:column>
   <h:column>
     <h:commandButton value="X" action="#{bitacoraBean.quitarAdjunto}" />
   </h:column>
 </h:dataTable>

</code>
```

Como se ve, aquí se muestra los adjuntos tienen  tener un botón (con una "X") para quitarlo de la bitácora que se va a registrar. Este botón llama al método `quitarAdjunto`. Pero para que funcione, se ha creado un binding llamado `adjuntosDataTable`. El método de quitarAdjunto es como sigue:

```java
<code>
//...
    public HtmlDataTable getAdjuntosDataTable() {
        return adjuntosDataTable;
    }

    public void setAdjuntosDataTable(HtmlDataTable adjuntosDataTable) {
        this.adjuntosDataTable = adjuntosDataTable;
    }

    public String quitarAdjunto(){
        Adjunto adjunto = (Adjunto) adjuntosDataTable.getRowData();
        entradaActual.quitarAdjunto(adjunto);
        return null;
    }

//...

</code>
```

Por ello, cuando se hace clic en el botón "X", busca el objeto asociado (getRowData()), lo quita de los adjuntos de la entrada, y devuelve null para que recargue la página.

Listo....!!

Ah, falta mostrar los registros de la bitácora, y que muestre los archivos. Aquí el código:

```java
<code>
        <h2>Entradas de Bitácora</h2>
        <h:dataTable border="1" value="#{bitacoraBean.entradas}" var="entrada">
            <h:column>
                <f:facet name="header">ID</f:facet>
                #{entrada.id}
            </h:column>
            <h:column>
                <f:facet name="header">Descripción</f:facet>
                #{entrada.descripcion}
            </h:column>
            <h:column>
                <f:facet name="header">Adjuntos</f:facet>
                <h:dataTable value="#{entrada.adjuntos}" var="adjunto">
                    <h:column>
                        <h:outputLink value="#{facesContext.externalContext.requestContextPath}/servlet/upload/abrir"  >
                            <h:outputText value="#{adjunto.nombreArchivo}" />
                            <f:param name="id" value="#{entrada.id}" />
                            <f:param name="archivo" value="#{adjunto.nombreArchivo}" />
                        </h:outputLink>
                    </h:column>
                </h:dataTable>

            </h:column>
        </h:dataTable>

</code>
```

Cada archivo adjunto que se está mostrando está apuntado por un enlace, que es un servlet. Y este servlet es el siguiente:

```java
<code>
//...
@WebServlet(name = "MostrarArchivoServlet", urlPatterns = {"/servlet/upload/abrir"})
public class MostrarArchivoServlet extends HttpServlet {

    @EJB
    private EntradaFacade entradaFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String $idEntrada = request.getParameter("id"); //obtengo el ID del parametro
        String archivo = request.getParameter("archivo"); //obtengo el nombre del archivo del parametro
        Long idEntrada = Long.parseLong($idEntrada); //convierto el ID a Long...
        Entrada entrada = entradaFacade.find(idEntrada);//.. para buscarlo en la base de datos
        if (entrada == null) { //si no existe...
            response.setStatus(HttpServletResponse.SC_NOT_FOUND); //... devuelvo un mensaje de q no existe
            return; //... y termina
        }
        List<Adjunto> adjuntos = entrada.getAdjuntos(); //ahora, obtenemos todos los adjuntos de la entrada
        Adjunto adjuntoMostrar = null; //el adjunto actual
        for (Adjunto $adjunto : adjuntos) { //recorro todos los adjuntos
            if ($adjunto.getNombreArchivo().equals(archivo)); //comparamos el nombre, y si existe...
               adjuntoMostrar = $adjunto; //.. lo capturamos
        }
        if (adjuntoMostrar == null) { //si recorrio toda la lista y no encontro nada...
            response.setStatus(HttpServletResponse.SC_NOT_FOUND); //... devolvemos un mensaje que q no existe
            return; //.. y termina
        }

        OutputStream out = response.getOutputStream();
        try {
            response.setContentType("application/octet-stream"); //...preparamos el tipo para q se descargue la adjunto
            response.setHeader("Content-Disposition", "attachment;filename=" + adjuntoMostrar.getNombreArchivo().replaceAll(" ", "_")); //preparando el 'download' al navegador

            response.setContentLength(adjuntoMostrar.getContenido().length); //ponemos el tamaño...
            out.write(adjuntoMostrar.getContenido()); //... y vaciamos el contenido

        } finally {
            out.close(); //y cerramos el flujo
        }
    }

//...

</code>
```

### Código fuente

El código fuente de proyecto se puede descargar desde aquí:

[http://java.net/projects/apuntes/downloads/download/web/BitacoraWeb.tar.gz](http://java.net/projects/apuntes/downloads/download/web/BitacoraWeb.tar.gz)
