---
layout: post
title: "CRUD con JSF usando ICE Faces"
date: 2009-01-28T16:46:00.001Z
last_modified_at: 2009-06-15T20:56:52.545Z
author: "Diego Silva"
permalink: /2009/01/crud-con-jsf-usando-ice-faces.html
canonical_url: https://www.apuntesdejava.com/2009/01/crud-con-jsf-usando-ice-faces.html
tags:
  - "web"
  - "netbeans 6.5"
  - "ICEfaces"
  - "netbeans"
  - "tutorial"
  - "jsf"
---

(Versión wiki: [http://wiki.netbeans.org/CRUDconVisualiceFaces](http://wiki.netbeans.org/CRUDconVisualiceFaces))

Este tutorial permite guiar los pasos para realizar una simple aplicación que mantiene una tabla de una base de datos. Permite realizar Insert, Update y Delete (CRUD= Create / Read / Update / Delete)
Además se considerará la funcionalidad importante de ICE faces, que es el uso de Ajax.
Para ello lo realizaremos con lo siguiente:

-  Java Development Kit 5 ó 6
-  NetBeans 6.5 con el Plugin VisualJSF, *ICEFaces Design-Time and Run-Time Libraries*, y *ICEfaces Project Integration*
-  Glassfish V2
-  La base de datos ejemplo TRAVEL de JavaDB

### Creando la aplicación

#### Diseñando la aplicación

-  Creamos un proyecto web presionando Mayúscula+Ctrl+N. Será una aplicación web que tendrá por nombre **InsertUpdateDelete**, utilizará Glassfish y activamos la opción que necesitamos usar el *Visual Web ICEfaces*
-  El editor habrá abierto el archivo *Page1.jsp* en modo diseño. Como una advertencia aparece un texto indicando que no se las paletas de Visual JavaServer Faces (los componentes de Woodstock) no son permitidos en proyectos con ICEfaces.<table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud00.jpg" /></td></tr></tbody></table>Así que lo tendremos muy en cuenta y no usaremos nada de esas paletas. Borramos ese mensaje de advertencia, seleccionándolo y presionando la tecla "Supr" (Delete)
-  En esta ventana pegaremos de la paleta *ICEfaces* (Mayúscula+Ctrl+8) el componente **DataTable**, y le pondremos "tablaPersonas" como valor de la propiedad *id*
-  Del panel de *Prestaciones* (Ctrl+5), abrimos la base de datos "travel", seleccionamos la tabla *PERSON*... <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud01.jpg" /></td></tr></tbody></table>... lo arrastramos y lo soltamos sobre el DataTable que acabamos de pegar
-  Si se presenta una ventana de diálogo donde se pregunta sobre qué objeto se pondrá los valores de la tabla... <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud02.jpg" /></td></tr></tbody></table>... seleccionamos *tablaPersonas*. Con esto, la tabla se actualizará con un contenido parecido a esto.  <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud03.jpg" /></td></tr></tbody></table>. Debemos notar que los campos mostrados son los mismos que se muestran en la tabla.
-  Ejecutamos la aplicación, y veremos que en pocos clics tenemos una aplicación simple que muestra el contenido de la tabla PERSONS. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud04.jpg" width="520" /></td></tr></tbody></table>Adicionalmente se puede agregar una opción para que se pueda ordenar por los campos. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud05.jpg" width="520" /></td></tr></tbody></table>En ejecución:  <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud06.jpg" width="520" /></td></tr></tbody></table>Además, podemos hacer un selector por filas, para ello en el modo de diseño hacemos clic derecho sobre la tabla y seleccionamos *Add RowSelector..."  <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud07.jpg" width="520" /></td></tr></tbody></table>*
-  Nos mostrará una ventana de diálogo donde nos pide a qué asociar el selector de filas  <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/crud07a.jpg" /></td></tr></tbody></table>Sin modificar nada, hacemos clic en *Close*

### Preparando para el modelo de datos para actualizar los datos

-  Ahora, crearemos una clase que tendrá el siguiente código:
package insertupdatedelete.beans;

import java.sql.Timestamp;
import java.util.TreeMap;

public class Person {

private int personId;
private String name;
private String jobTitle;
private int frequentFlyer;
private Timestamp lastDateUpdated;

public Person(TreeMap data) {
personId = (Integer) data.get("PERSON.PERSONID");
name = (String) data.get("PERSON.NAME");
jobTitle = (String) data.get("PERSON.JOBTITLE");
frequentFlyer = (Integer) data.get("PERSON.FREQUENTFLYER");
lastDateUpdated = (Timestamp) data.get("PERSON.LASTUPDATED");
}
}

-  Al final de la clase, antes de la última llave que cierra la clase, presionamos las teclas Alt+Insertar para insertar código. Se nos presentará un menú emergente, y seleccionamos la opción "Getter y Setter..." Esto nos permitirá crear los métodos sets y gets para todas las propiedades. Por ello, seleccionamos todas las propiedades, o marcamos la clase. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud08.jpg" /></td></tr></tbody></table>... y hacemos clic en "Generar"
-  Ahora, nos ubicamos nuevamente al final de la clase, antes de la última llave, presionamos Alt+Insertar y seleccionamos *Constructor*. No seleccionamos ningún campo. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud09.jpg" /></td></tr></tbody></table>Esto nos creará un constructor sin parámetros.
-  Crearemos otro constructor repitiendo el paso anterior, pero esta vez seleccionaremos todos los campos. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud10.jpg" /></td></tr></tbody></table>
-  Agregue las siguientes propiedades a la clase Page1.java      private Person blankPerson = new Person();
private Person selectedPerson = blankPerson;
private boolean editDisabled = true;
 Luego genere los setter y getters de las propiedades *selectedPerson* y *editDisabled*. Con esto lucirá la clase así:  <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud11.jpg" /></td></tr></tbody></table>
-  Ahora, necesitamos programar la lógica de negocio cuando se haga clic en alguna de las filas de la tabla. Cuando se hace clic en alguna de las filas de la tabla durante la ejecución de la aplicación, se ejecutará el método **rowSelector1_processAction()** de la clase Page1.java. Debemos editar este método con el siguiente código:    public void rowSelector1_processAction(RowSelectorEvent rse) {
int selectedRowIndex = rse.getRow();
editDisabled=false;
dataTable1Model.setRowIndex(selectedRowIndex);
selectedPerson=new Person((TreeMap)dataTable1SortableDataModel.getRowData());
}

### El formulario de edición

Ahora, agregaremos un formulario de edición, de tal manera que cada vez que hagamos clic en una de las filas de la tabla, se muestre los campos de ese registro en ese formulario. Para ello haremos lo siguiente:

-  De la paleta ICEFaces, seleccionar *Form* y soltarlo en la parte inferior de la tabla. Asegurémonos que no está dentro del otro formulario.<table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud12.jpg" /></td></tr></tbody></table>
-  Agregar los campos que querramos editar, por ejemplo, el nombre y el cargo. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud14.jpg" width="520" /></td></tr></tbody></table>
-  Por cada campo agregado, hacemos clic derecho y seleccionamos *Bind to data...* para seleccionar de donde se obtendrá los datos para el formulario.  <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud13.jpg" width="500" /></td></tr></tbody></table>Notar que se está asociando al objeto   selectedPerson
-  Ahora, por cada campo, hacemos clic derecho nuevamente y seleccionamos *Property binding...* y hacemos que la propiedad disabled esté asociada a la propiedad editDisabled <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud15.jpg" width="520" /></td></tr></tbody></table>
-  Agregamos un CommandButton en el form2, y también asociamos la propiedad disabled con el objeto editDisabled
¿Por qué hay que asociar el disabled con el objeto editDisabled ? Recordemos que cuando se selecciona una fila, el valor de editDisabled se vuelve a false (comenzaba con el valor true). Esto quiere decir, que los input-text y el button se mostrarán como desactivados hasta que cuando alguien le hace clic en una fila. Si sucede esto, los input-text y el button se volverán editables (disabled=false)

### Agregando lógica de edición

-  Hagamos clic derecho sobre el botón, y seleccionamos *Edit event handler > Process Action*. <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud16.jpg" /></td></tr></tbody></table>Eso nos creará el método processAction(). Editaremos el contenido de ese método con lo siguiente:      public void button1_processAction(ActionEvent ae) {
personDataProvider.setCachedRowSet((javax.sql.rowset.CachedRowSet) getValue("#{SessionBean1.personRowSet}"));
persistPerson(selectedPerson);
selectedPerson=blankPerson;
editDisabled=true;
}

-  El método persistPerson() no existe, y el NetBeans nos mostrará un foquito en el margen izquierdo sugeriéndonos que debemos crear un método. Podemos hacerle clic sobre ese foco para que nos cree el método sugerido, o presionamos Alt+Enter. Editamos el contenido de este método con lo siguiente:      private void persistPerson(Person selectedPerson) {
if (personDataProvider != null) {
java.util.Date d = new Date();
Timestamp t = new Timestamp(d.getTime());
if (personDataProvider.getRowCount() > 0) {
personDataProvider.cursorFirst();
do {
if (personDataProvider.getValue("PERSON.PERSONID").equals(selectedPerson.getPersonId())) {
personDataProvider.setValue("PERSON.NAME", selectedPerson.getName());
personDataProvider.setValue("PERSON.JOBTITLE", selectedPerson.getJobTitle());
personDataProvider.setValue("PERSON.FREQUENTFLYER", selectedPerson.getFrequentFlyer());
personDataProvider.setValue("PERSON.LASTUPDATED", t);
break;
}
} while (personDataProvider.cursorNext());
personDataProvider.commitChanges();
}
}
}
-  Para terminar, debemos asegurarnos de que al cargarse la página por primera vez, debe mostrarse los datos actualizados. Debemos editar el método prerender() de Page1.java      @Override
public void prerender() {
try {
CachedRowSet cachedRowSet = (CachedRowSet) getValue("#{SessionBean1.personRowSet}");
cachedRowSet.execute();
personDataProvider.refresh();
dataTable1SortableDataModel.setWrappedData(getValue("#{SessionBean1.personRowSet}"));
} catch (SQLException ex) {
log(ex.getMessage(), ex);

}

}

-  Ejecutamos la aplicación, y veremos cómo se comporta <table class="imageplugin" style="margin-left: auto; margin-right: auto;" border="0"><tbody><tr><td><img src="http://wiki.netbeans.org/attach/CRUDconVisualiceFaces/crud17.jpg" width="520" /></td></tr></tbody></table>

### Recursos

El código fuente que utilicé para este proyecto se puede descargar desde aquí [http://diesil-java.googlecode.com/files/CRUDicefaces.tar.gz](http://diesil-java.googlecode.com/files/CRUDicefaces.tar.gz)
