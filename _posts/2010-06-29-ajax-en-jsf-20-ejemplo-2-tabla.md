---
layout: post
title: "Ajax en JSF 2.0 - Ejemplo 2: Tabla actualizada según se escriba"
date: 2010-06-29T16:11:00.057Z
last_modified_at: 2013-01-25T23:37:49.023Z
author: "Diego Silva"
permalink: /2010/06/ajax-en-jsf-20-ejemplo-2-tabla.html
canonical_url: https://www.apuntesdejava.com/2010/06/ajax-en-jsf-20-ejemplo-2-tabla.html
tags:
  - "netbeans 6.9"
  - "tutorial"
  - "netbeans"
  - "jsf"
  - "ajax"
  - "jsf 2.0"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijRSM3NV221WTDsWNa_e83ABdLNtTRo5IsSL9b3jpVNg7U7X6L0pJ96kFGwq2O98J8kg7kwZlCUkSFmgpFZHB4Xm4Zse60PGw1HuI2jTbFYLFcjWeuAde_fvuxrWDZM5_yjmGq_5brdGEO/s1600/jsf20-con-ajax.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijRSM3NV221WTDsWNa_e83ABdLNtTRo5IsSL9b3jpVNg7U7X6L0pJ96kFGwq2O98J8kg7kwZlCUkSFmgpFZHB4Xm4Zse60PGw1HuI2jTbFYLFcjWeuAde_fvuxrWDZM5_yjmGq_5brdGEO/s1600/jsf20-con-ajax.png)

Siguiendo con los ejemplos después de mucho tiempo, ahora mostraré cómo actualizar una lista dependiendo del texto que se escribe en un input-text, pero usando Ajax. Es decir, a medida que se escribe, se actualizará el contenido del texto. Todo esto usando JSF 2.0 con su tag `<ajax />`

### El EJB

Para comenzar, debemos tener un lista de elementos que se actualizarán de acuerdo a un parámetro. Yo tengo un EJB que hace una consulta por JPA-API a mi base de datos "samples" (Esta base de datos viene como parte de las bases de datos de ejemplo de Java DB / Apache Derby y que son accesibles desde NetBeans). La entidad que estoy manejando es el `Manufacturer`.

```java
public List<Manufacturer> findByName(String name) {
  String $name = "%" + name.replaceAll(" ", "%") + "%";
  CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
  CriteriaQuery<Manufacturer> criteriaQuery = criteriaBuilder.createQuery(Manufacturer.class);
  Root<Manufacturer> manufacturer = criteriaQuery.from(Manufacturer.class);
  criteriaQuery.select(manufacturer);
  criteriaQuery.where(criteriaBuilder.like(manufacturer.get("name").as(String.class), $name));
  List<Manufacturer> list = em.createQuery(criteriaQuery).getResultList();        return list;
}
```

### El ManagedBean

Ahora, el ManagedBean que se comunicará con la interfaz de usuario y le dirá qué mostrar. Este tiene un atributo llamado `"nombre"` que estará asociado al input-text del formulario que el usuario verá. Lo que escriba se guardará ahí, y será tomado para la búsqueda en la base de datos.

```java
@ManagedBean(name = "formBean")
@SessionScopedpublic class ManufacturerManagedBean {
    static final Logger LOGGER = Logger.getLogger(ManufacturerManagedBean.class.getName());
    @EJB
    private ManufacturerFacade manufacturerFacade; //el EJB
    private String nombre = ""; //el atributo que estará asociado al input-text
    private List<Manufacturer> manufacturerList; //la lista a mostrar
    /** Creates a new instance of ManufacturerManagedBean */
    public ManufacturerManagedBean() {
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public List<Manufacturer> getListByName() {
        if (manufacturerList == null) { //si es la primera vez que se accederá a la lista...
            manufacturerList = manufacturerFacade.findByName(nombre); //... actualizar el contenido
        }
        return manufacturerList; //devuelve la lista con los elementos encontrados
    }
    public void nombreChangeListener(AjaxBehaviorEvent  event) {
        //cada vez que haya un cambio en el texto, vuelve a generar la lista
        manufacturerList = manufacturerFacade.findByName(nombre);
    }
}
```

### El .xhtml

Y, en la tercera capa, vemos el .xhtml que mostrará el contenido actualizado y el formulario.

El contenido será mostrado en un `<h:dataTable /> ` como cualquier resultado. Tendrá como ID=`manufacturerTable`. Este ID es importante porque es por donde el Ajax le dirá qué elemento de la página debe actualizar.

```java
<h:dataTable value="#{formBean.listByName}" border="1" var="item" id="manufacturerTable">
                <h:column>
                    <f:facet name="header">
                        ID
                    </f:facet>
                    <h:outputText value="#{item.manufacturerId}" />
                </h:column>
                <h:column>
                    <f:facet name="header">
                        Nombre
                    </f:facet>
                    <h:outputText value="#{item.name}" />
                </h:column>
                <h:column>
                    <f:facet name="header">
                        e-mail
                    </f:facet>
                    <h:outputText value="#{item.email}" />
                </h:column>
            </h:dataTable>
```

Ahora, la parte más esperada: el input-text con el Ajax.

Realmente consiste en un tag h:inputText que tiene dentro un tag f:ajax. El que hace realmente el trabajo es este último tag.

```java
<h:inputText id="nombreFiltro" autocomplete="off" value="#{formBean.nombre}"  >
                <f:ajax render="manufacturerTable" event="keyup" listener="#{formBean.nombreChangeListener}"/>
            </h:inputText>
```

- El atributo `render` dice qué IDs del HTML se van a actualizar. Aquí dice que es el ID del dataTable.
- El atributo `event` dice qué evento del tag inputText (porque está manejando los eventos del tag que lo envuelve) va ejecutar el ajax. En este caso será el evento keyup del input-text.
- El atributo `listener` indica cuál es el método que se ejecutará cuando suceda el evento. En este caso es el método `nombreChangeListener` del ManagedBean que hemos creado hace un momento.

Y listo, lo ejecutamos y ya.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiYnIJabz742hUrxHAI3LnaLx5VBNipj4t7A1KLEbuOZ1XSIsiaQcd0S-HJSovKZ4YDtGFRVigkwAMIkaC-ON8Hppl6j2l0ARiT_6pfq5vWAfBUdVna82wfOm3IemVEENmPSYD5MKJer-28/s640/jsf-ajax-tabla-texto.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiYnIJabz742hUrxHAI3LnaLx5VBNipj4t7A1KLEbuOZ1XSIsiaQcd0S-HJSovKZ4YDtGFRVigkwAMIkaC-ON8Hppl6j2l0ARiT_6pfq5vWAfBUdVna82wfOm3IemVEENmPSYD5MKJer-28/s1600/jsf-ajax-tabla-texto.jpg)

### El proyecto

Este proyecto, como todos los demás, debería ejecutarse si problemas en un NetBeans IDE 6.8/6.9, usando GlassFish v3. Aquí está para descargarlo.

- [https://java.net/downloads/apuntes/samples/web/JSF20AjaxTextoCambiaTabla.tar.gz](https://java.net/downloads/apuntes/samples/web/JSF20AjaxTextoCambiaTabla.tar.gz)
