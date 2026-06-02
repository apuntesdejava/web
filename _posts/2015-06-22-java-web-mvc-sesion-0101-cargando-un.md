---
layout: post
title: "Java Web MVC - Sesión 01.01: Cargando un archivo"
date: 2015-06-22T17:54:00.001Z
last_modified_at: 2018-01-10T23:42:59.572Z
author: "Diego Silva Límaco"
permalink: /2015/06/java-web-mvc-sesion-0101-cargando-un.html
canonical_url: https://www.apuntesdejava.com/2015/06/java-web-mvc-sesion-0101-cargando-un.html
tags:
  - "glassfish"
  - "java"
  - "netbeans 8"
  - "upload"
  - "jsp"
  - "servlets"
  - "java ee"
  - "java ee 7"
  - "netbeans"
---

[![]({{ '/assets/blogger/javaee1_large.png' | relative_url }})]({{ '/assets/blogger/javaee1_large.png' | relative_url }})

Si vieron el [vídeo](https://youtu.be/9JwXoL0FSBs) y [post](http://goo.gl/fb/jpwwKE) anterior, habrán visto que propongo cargar la foto del usuario que se está registrando.. pero no aparece en el tutorial. Y si no lo han visto, ahora ya lo saben.

Pues bien, este post es un anexo a la sesión anterior sobre Java Web MVC.

### El campo en la entidad

Para comenzar, debemos agregar el campo `byte[] foto` en la entidad, de tal manera que pueda permitir los bytes de la foto. Pero como se va a guardar en la tabla, le indicamos la anotación `[@javax.persistence.Lob](http://docs.oracle.com/javaee/7/api/javax/persistence/Lob.html)` para que el JPA haga lo suyo convirtiéndolo como bloque en la tabla.

```java
@Lob
    private byte[] foto;

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }
```

Código fuente completo: [Alumno.java](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/ff5b044e3d5c/src/main/java/com/apuntesdejava/aulavirtual/entities/Alumno.java?at=upload-servlet#cl-35)

### El servlet que lo cargará

Ahora, cuando recibamos el archivo cargado, necesitamos preparar el Servlet que recibe los datos de tal manera que permita carga de archivos. Para ello debemos, primero, agregar la notación [@javax.servlet.annotation.MultipartConfig](http://docs.oracle.com/javaee/7/api/javax/servlet/annotation/MultipartConfig.html) antes de la declaración del servlet.

 Luego, debemos leer el parámetro del formulario y guardarlo como arreglo de bytes:

```java
Part fotoPart = request.getPart("foto");
            int fotoSize=(int)fotoPart.getSize(); //si no tiene tamaño, no hay foto

            byte[] foto=null; //el buffer
            if(fotoSize>0){
                foto=new byte[fotoSize];
                try(DataInputStream dis=new DataInputStream(fotoPart.getInputStream())){
                    dis.readFully(foto);

                }
            }
```

Y, solo si tiene dato, lo guardamos en la entidad.

```java
if (fotoSize>0)
                alumno.setFoto(foto);
```

El archivo completo: [RegistroAlumnoServlet.java](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/ff5b044e3d5c4117837800f0a52f67a8f396b139/src/main/java/com/apuntesdejava/aulavirtual/servlet/RegistroAlumnoServlet.java?at=upload-servlet)

### El servlet que lo mostrará

Una imagen, a diferencia de un dato de tipo String o Date, no puede ser mostrada en un JSP como un simple "print". Una imagen, en Web, es un recurso más como un HTML o CSS, por ello, debemos crear el recurso que lo mostrará. Así que, haremos un servlet que cuando se le indique el ID del registro que debería tener la foto, busque en la base de datos el ID, tome el arreglo de bytes que representa a la foto, y le decimos al servlet que lo imprima tal cual.

<script src="https://bitbucket.org/apuntesdejava/aulavirtual-web/src/ff5b044e3d5c4117837800f0a52f67a8f396b139/src/main/java/com/apuntesdejava/aulavirtual/servlet/MostrarFotoServlet.java?embed=t"></script>

Es un simple vaciado de bytes al response, que es el encargado de mostrar los resultados en http.

### El JSP que lo muestra

Como estamos usando el mismo formulario para ingresar los datos y mostrar los datos registrados, haremos lo mismo para ingresar la foto usando el `<input type="file" />` y un poco más abajo para mostrar el contenido de la imagen:

```java
<div class="form-group">
  <label for="foto">Foto</label>
  <input type="file" name="foto" id="foto"/><br/>
  <c:if test="${alumno.foto ne null}">
      <img src="<%=request.getContextPath()%>/MostrarFotoServlet?id=${alumno.id}" style="width: 100px;"/>
  </c:if>
</div>
```

El archivo completo: [alumno_form.jsp](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/ff5b044e3d5c4117837800f0a52f67a8f396b139/src/main/webapp/alumno_form.jsp?at=upload-servlet)

### El vídeo

Si no te gusta leer, aquí tienes el vídeo donde se muestra cómo cargar la imagen.

<iframe allowfullscreen="" frameborder="0" height="410" src="https://www.youtube.com/embed/sbNynV3OOJI" width="730"></iframe>

### El código fuente

El código fuente del proyecto completo incluyendo la carga del archivo, la puedes descargar desde aquí

- [https://bitbucket.org/apuntesdejava/aulavirtual-web/src/ff5b044e3d5c?at=upload-servlet](https://bitbucket.org/apuntesdejava/aulavirtual-web/src/ff5b044e3d5c?at=upload-servlet)

- [https://github.com/apuntesdejava/aulavirtual-web/tree/upload-servlet](https://github.com/apuntesdejava/aulavirtual-web/tree/upload-servlet)
