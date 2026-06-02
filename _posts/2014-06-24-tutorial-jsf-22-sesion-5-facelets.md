---
layout: post
title: "Tutorial JSF 2.2 - Sesión 5: Facelets - Componentes compuestos (Parte II)"
date: 2014-06-24T17:19:00.001Z
last_modified_at: 2014-06-24T17:26:20.963Z
author: "Diego Silva Límaco"
permalink: /2014/06/tutorial-jsf-22-sesion-5-facelets.html
canonical_url: https://www.apuntesdejava.com/2014/06/tutorial-jsf-22-sesion-5-facelets.html
tags:
  - "javaee7"
  - "facelets"
  - "web"
  - "netbeans 7.4"
  - "java ee"
  - "tutorial"
  - "netbeans"
  - "jsf 2.2"
---

[![JSF Componentes compuestos]({{ '/assets/blogger/puzzle-3d.jpg' | relative_url }})]({{ '/assets/blogger/puzzle-3d.jpg' | relative_url }})

"Componentes compuestos", raro nombre, no? Es que no encontré otra traducción para "[Composite Components](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-facelets005.htm#GIQZR)"

Esta característica de JSF permite hacer lo siguiente: darnos la facilidad de crear nuestro propio componente utilizando otros componentes. Por ejemplo, si siempre vamos a seleccionar un producto dependiendo de una selección del tipo de producto, pues sería conveniente tener un componente que permita al usuario seleccionar los dos datos, y no nosotros tener que repetir la misma lógica de selección de objetos.

Comenzaremos por crear nuestro componente desde el NetBeans. Después de haber creado nuestro proyecto web JSF, creamos un archivo y dentro de la categoría "JavaServer Faces" seleccionamos "JSF Composite Component"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnVyzOKVKTR3NSiENLVCTnkzg8M7qsY1RoC6WLtGMibpuaszpXJiBR2we5v6FLkZgzKp7X075JDFD8laRp9rDldWE4sEyQn5UJvZaQIR1vluTCPgtrLvbPZnSL7pEpfsBnIatKfSWC4I4/s1600/17-12-2013+10-56-49+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnVyzOKVKTR3NSiENLVCTnkzg8M7qsY1RoC6WLtGMibpuaszpXJiBR2we5v6FLkZgzKp7X075JDFD8laRp9rDldWE4sEyQn5UJvZaQIR1vluTCPgtrLvbPZnSL7pEpfsBnIatKfSWC4I4/s1600/17-12-2013+10-56-49+a.m..png)

Clic en "Next". El IDE nos va a proponer el nombre (out) y la ubicación. Solo cambiemos el nombre de nuestro componente. Lo llamaremos "SelectProd"

[![]({{ '/assets/blogger/02-name_cc.png' | relative_url }})]({{ '/assets/blogger/02-name_cc.png' | relative_url }})

Clic en "Finish".

Y listo, nos mostrará una plantilla del componente. Tiene dos secciones: la interfaz, y la implementación.

[![]({{ '/assets/blogger/03-code_generated.png' | relative_url }})]({{ '/assets/blogger/03-code_generated.png' | relative_url }})

En la interfaz se describen cuáles son las propiedades que serán de interfaz entre el formulario y nuestro componente. Como necesitamos dos propiedades para nuestro selector, lo declaramos allí:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:cc="http://xmlns.jcp.org/jsf/composite"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">

  <!-- INTERFACE -->
  <cc:interface>
    <cc:attribute name="productCode" required="true" />
    <cc:attribute name="product" required="true" />

  </cc:interface>

  <!-- IMPLEMENTATION -->
  <cc:implementation>
  </cc:implementation>
</html>
```

Y en la implementación es donde realmente se crea la parte visual de nuestro componente.

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:cc="http://xmlns.jcp.org/jsf/composite"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">

    <!-- INTERFACE -->
    <cc:interface >
        <cc:attribute  name="productCode" required="true"  />
        <cc:attribute  name="product" required="true"/>
    </cc:interface>

    <!-- IMPLEMENTATION -->
    <cc:implementation>
        <h:panelGrid columns="2" captionClass="alignRight,alignLeft">
            <h:outputLabel value="Product code" for="productCode" />
            <h:selectOneMenu value="#{cc.attrs.productCode}" id="productCode">
                <f:selectItems value="#{cc.allProductCodes }"
                               var="prodCod"
                               itemLabel="#{prodCod.description}"
                               itemValue="#{prodCod.prodCode}"/>
                <f:ajax render="product" />
            </h:selectOneMenu>

            <h:outputLabel value="Product" for="product" />
            <h:selectOneMenu  id="product" value="#{cc.attrs.product}" >
                <f:selectItems value="#{cc.products}"
                               var="prod"
                               itemLabel="#{prod.description}"
                               itemValue="#{prod.productId}"/>
            </h:selectOneMenu>

        </h:panelGrid>
    </cc:implementation>
</html>
```

**Analicemos**:

El `<h:panelGrid>` es fácil de comprender qué es. También el `<h:outputLabel/>`.

También podemos ver el `<h:selectOneMenu/>` que permite mostrar una lista de elementos como el tag `<select>` de html. *SOLO QUE* el atributo "value" está apuntando a un atributo del componente:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUb6k7K6oPqNIkZQBJoK5ThnrfcJmvyeAh6wqh5f7nLddiu07xxAQ8iIQoAon5kF8DXrw-jFiAE8IO_1NiatuMnq1odT7PMuGvk4Uk6U8ej-4LKTaBsYz3RoLg_5NEL-818nOrt72EPAg/s1600/23-06-2014+06-03-17+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjUb6k7K6oPqNIkZQBJoK5ThnrfcJmvyeAh6wqh5f7nLddiu07xxAQ8iIQoAon5kF8DXrw-jFiAE8IO_1NiatuMnq1odT7PMuGvk4Uk6U8ej-4LKTaBsYz3RoLg_5NEL-818nOrt72EPAg/s1600/23-06-2014+06-03-17+p.m..png)

Esto nos permitirá grabarlo en un atributo del componente y manipularlo para lo que queramos.

## La clase del componente

Si lo ejecutamos tal cual, nos mostrará algo bonito y que puede ser enlazado al *ManagedBean *que queramos. Pero lo que queremos es mostrar dos combos, y que el segundo dependa del primero. Por tanto, necesitamos jalar los datos de una tabla para mostrar los datos en el primer combo, luego cuando se cambie el valor del primer combo, usando ajax, recarguemos el segundo combo.

Para enviar los datos del primer combo, lo que debemos hacer es usar el atributo `valueChangeListener` del tag `[h:selectOneMenu](http://docs.oracle.com/javaee/7/javaserverfaces/2.2/vdldocs/jsp/h/selectOneMenu.html).`Normalmente usamos un ManagedBean para colocar nuestros métodos listener, y para guardar los valores del formulario. Recordemos que estamos creando un componente, por tanto, no debemos guardarlo en el ManagedBean ¿cómo lo haremos? Crearemos la clase del componte.

Crearemos la clase llamada SelectProduct con la anotación `@FacesComponent` y que extienda a `javax.faces.component.UINamingContainer`

```java
package com.apuntesdejava.javaee7.jsf.cc.component;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.component.FacesComponent;
import javax.faces.component.UINamingContainer;

@FacesComponent("SelectProduct")
public class SelectProductComponent extends UINamingContainer {

    private static final Logger LOG = Logger.getLogger(SelectProductComponent.class.getName());

}
```

El nombre colocado en la anotación es la que debemos establecerlo en la declaración del componente en el .xhtml

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGplfOW3TrvsWYgakPWdRqmv7st1zZpBt7i-gRG8HpYthGLXIARsHPH6jWTAeoVf43pAeTuMxd1syG73AC7mj-lVi5fjMqNnjDnb-tJlxbtDZ8PzJ_Kh3PBC4lW1gUKoPDm8OFtdEpSMo/s1600/24-06-2014+11-23-27+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgGplfOW3TrvsWYgakPWdRqmv7st1zZpBt7i-gRG8HpYthGLXIARsHPH6jWTAeoVf43pAeTuMxd1syG73AC7mj-lVi5fjMqNnjDnb-tJlxbtDZ8PzJ_Kh3PBC4lW1gUKoPDm8OFtdEpSMo/s1600/24-06-2014+11-23-27+a.m..png)

Además, debemos crear los métodos necesarios para:

- Obtener todos los registros de la tabla PRODUCT_CODE de la base de datos

- Interceptar el cambio de valor del combo productCode

- Obtener todos los registros de la tabla PRODUCT dependiendo del valor seleccionado en el combo productCode

Aquí muestro la clase completa (y documentada, claro)

```java
package com.apuntesdejava.javaee7.jsf.cc.component;

import com.apuntesdejava.javaee7.jsf.cc.bean.Product;
import com.apuntesdejava.javaee7.jsf.cc.bean.ProductCode;
import com.apuntesdejava.javaee7.jsf.cc.dao.ProductCodeDao;
import com.apuntesdejava.javaee7.jsf.cc.dao.ProductDao;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.component.FacesComponent;
import javax.faces.component.UINamingContainer;
import javax.faces.event.ValueChangeEvent;
import javax.inject.Inject;

/**
 *
 * @author dsilva
 */
@FacesComponent("SelectProduct")
public class SelectProductComponent extends UINamingContainer {

    private static final Logger LOG = Logger.getLogger(SelectProductComponent.class.getName());

    @Inject
    private ProductCodeDao productCodeDao; //manejamos todos los productCode de la base de datos
    @Inject
    private ProductDao productDao; //manejamos todos los product de la base de datos

    /**
     * Obtiene todos los productCode de la base de datos
     *
     * @return
     */
    public List<ProductCode> getAllProductCodes() {
        return productCodeDao.getAllProductCodes();
    }

    /**
     * Obtiene todos los productos de un productCode seleccionado previamente
     *
     * @return
     */
    public List<Product> getProducts() {
        //así obtenemos el atributo guardado en el atributo del componente
        String productCode = (String) getAttributes().get("productCode");

        LOG.log(Level.INFO, "ProductCode seleccionado:{0}", productCode);
        return productDao.getProductsByProductCode(productCode); //obtiene todos los productos segun el productCode selecionado
    }

    /**
     * Interpreta el cambio del valor del combo ProductCode
     *
     * @param event
     */
    public void doProductCodeChange(ValueChangeEvent event) {
        String productCode = (String) event.getNewValue(); //obtenemos el valor...
        getAttributes().put("productCode", productCode); //... y lo guardamos en los atributos
    }

}
```

**Nota**: Aquí estoy usando algo de CDI, para poder instanciar los DAO. Es solo usado para este ejemplo, no es obligatorio usarlo en los proyectos con componentes compuestos. Se pueden utilizar EJB, JPA o cualquier fuente de datos. Yo lo usé así por la simpleza aplicada a este proyecto. En otro post me gustaría hablar más del CDI, y de JPA. Los códigos para los DAO lo pueden ver en la descarga del proyecto, o aquí mismo: [https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-05-cc/src/main/java/com/apuntesdejava/javaee7/jsf/cc/dao/jdbc/](https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-05-cc/src/main/java/com/apuntesdejava/javaee7/jsf/cc/dao/jdbc/)

Ahora, necesitamos implementarlo en nuestro .xhtml

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:cc="http://xmlns.jcp.org/jsf/composite"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">

    <!-- INTERFACE -->
    <cc:interface componentType="SelectProduct">
        <cc:attribute  name="productCode" required="true"  />
        <cc:attribute  name="product" required="true"/>
    </cc:interface>

    <!-- IMPLEMENTATION -->
    <cc:implementation>
        <h:panelGrid columns="2" captionClass="alignRight,alignLeft">
            <h:outputLabel value="Product code" for="productCode" />
            <h:selectOneMenu value="#{cc.attrs.productCode}"
                             id="productCode"
                             valueChangeListener="#{cc.doProductCodeChange}">
                <f:selectItems value="#{cc.allProductCodes }"
                               var="prodCod"
                               itemLabel="#{prodCod.description}"
                               itemValue="#{prodCod.prodCode}"/>
                <f:ajax render="product" />
            </h:selectOneMenu>

            <h:outputLabel value="Product" for="product" />
            <h:selectOneMenu  id="product"
                              value="#{cc.attrs.product}" >
                <f:selectItems value="#{cc.products}"
                               var="prod"
                               itemLabel="#{prod.description}"
                               itemValue="#{prod.productId}"/>
            </h:selectOneMenu>

        </h:panelGrid>
    </cc:implementation>
</html>
```

En las líneas 20,21 y 31 se están usando los métodos creados en nuestra clase componente. Notemos que siempre se antepone el código `cc`

La línea 25 muestra el ajax que hace recargar el contenido del segundo combo. Para más ejemplos de AJAX con JSF, pueden revisar estos posts:

- [Ajax en JSF 2.0 - Ejemplo 1: Combo cambia texto]({{ '/2010/02/ajax-en-jsf-20-ejemplo-1-combo-cambia.html' | relative_url }})

- [Ajax en JSF 2.0 - Ejemplo 2: Tabla actualizada según se escriba]({{ '/2010/06/ajax-en-jsf-20-ejemplo-2-tabla.html' | relative_url }})

#### ... y un botón al componente

Además podemos agregar un botón a nuestro diseño, y hacerlo de tal manera que cuando se reutilice el componente, le demos la posibilidad al desarrollador que pueda hacer algo después con los valores. Para nuestro ejemplo colocaremos un botón y que la etiqueta del botón sea configurable en la reutilización.

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:cc="http://xmlns.jcp.org/jsf/composite"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">

    <!-- INTERFACE -->
    <cc:interface componentType="SelectProduct">
        <cc:attribute  name="productCode" required="true"  />
        <cc:attribute  name="product" required="true"/>
        <cc:attribute  name="buttonText" required="true"/>
        <cc:attribute name="buttonAction" method-signature="java.lang.String action()" />
    </cc:interface>

    <!-- IMPLEMENTATION -->
    <cc:implementation>
        <h:panelGrid columns="2" captionClass="alignRight,alignLeft">
            <h:outputLabel value="Product code" for="productCode" />
            <h:selectOneMenu value="#{cc.attrs.productCode}"
                             id="productCode"
                             valueChangeListener="#{cc.doProductCodeChange}">
                <f:selectItems value="#{cc.allProductCodes }"
                               var="prodCod"
                               itemLabel="#{prodCod.description}"
                               itemValue="#{prodCod.prodCode}"/>
                <f:ajax render="product" />
            </h:selectOneMenu>

            <h:outputLabel value="Product" for="product" />
            <h:selectOneMenu  id="product"
                              value="#{cc.attrs.product}" >
                <f:selectItems value="#{cc.products}"
                               var="prod"
                               itemLabel="#{prod.description}"
                               itemValue="#{prod.productId}"/>
            </h:selectOneMenu>

            <h:commandButton action="#{cc.attrs.buttonAction}"
                             value="#{cc.attrs.buttonText}"
  />
        </h:panelGrid>
    </cc:implementation>
</html>
```

No hay implementaciones, solo son las declaraciones de lo que tendrá y se mostrará en el componente.

### Usando el componente

Aquí viene lo divertido: utilizar el componente. Para ello, crearemos un ManagedBean al que llamaremos `FormBean` y tendrá el siguiente contenido:

```java
package com.apuntesdejava.javaee7.jsf.cc.managedbean;

import com.apuntesdejava.javaee7.jsf.cc.bean.Product;
import com.apuntesdejava.javaee7.jsf.cc.dao.ProductDao;
import java.io.Serializable;
import java.util.logging.Logger;
import javax.enterprise.context.SessionScoped;
import javax.inject.Inject;
import javax.inject.Named;

/**
 *
 * @author dsilva
 */
@Named(value = "formBean")
@SessionScoped
public class FormBean implements Serializable {

    private static final Logger LOG = Logger.getLogger(FormBean.class.getName());

    private String productCode;
    private String product;
    @Inject
    ProductDao productDao;

    /**
     * Creates a new instance of FormBean
     */
    public FormBean() {
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    /**
     * Obtiene el objeto del producto seleccionado
     *
     * @return El Objeto {@link com.apuntesdejava.javaee7.jsf.cc.bean.Product}
     * seleccionado
     */
    public Product getProductSelected() {
        if (product == null) {
            return null;
        }
        return productDao.findByProductId(product);
    }

    /**
     * Ejecuta una acción. En este caso solo va a devolver null para retornar a
     * la misma página
     *
     * @return El nombre de la página a mostrar después de ejecutar la acción
     */
    public String showProductSelected() {
        return null;//que devuelve nada, o sea, se queda en la misma pagina
    }
}
```

Y crearemos nuestro `index.xhtml` de la siguiente manera:

```java
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:ezcomp="http://xmlns.jcp.org/jsf/composite/ezcomp">
    <h:head>
        <title>Facelet Title</title>
    </h:head>
    <h:body>
        <h:messages/>
        <h:form>
            <ezcomp:SelectProd productCode="#{formBean.productCode}"
                               product="#{formBean.product}"
                               buttonAction="#{formBean.showProductSelected}"
                               buttonText="Mostrar producto seleccionado"
                               />
            <h:outputText rendered="#{formBean.productSelected ne null}"
                          value="El producto seleccionado es: #{formBean.productSelected}"/>
        </h:form>
    </h:body>
</html>
```

La línea 5 se autoescribe en el IDE cuando se comienza a escribir el tag `<ezcomp...` y presionando las teclas Ctrl+Espacio.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgI0Hz6Q-RvjBG1tGXogvCL_c7Tsr62dFEm9Dqam8qYCOw7WARQgTamkGYC6PrYRlY8NWtHX5E1QHKdX0HjUZHrUS-sGO-CP76NXPKZOhMxIEKDJJJzS5yOL1g2PfoCgGsq-8W-pFD7RdQ/s1600/24-06-2014+12-10-40+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgI0Hz6Q-RvjBG1tGXogvCL_c7Tsr62dFEm9Dqam8qYCOw7WARQgTamkGYC6PrYRlY8NWtHX5E1QHKdX0HjUZHrUS-sGO-CP76NXPKZOhMxIEKDJJJzS5yOL1g2PfoCgGsq-8W-pFD7RdQ/s1600/24-06-2014+12-10-40+p.m..png)

Las líneas 12 al 16 son la declaración del uso del componente. Como se puede ver, es total transparente. No necesitamos saber nada de los combos, ni cómo accede a la base de datos. Asumimos que está bien, y lo podremos reutilizar en cualquier formulario que necesitemos.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhTjOk9kFyhmWkfc1SCSsv4gJBo3D3VFYCTXjGHIMMebrkoS6DDX_OImHmujJlZ2YilXdp_ECWfj07PAQww549-F3PcXIMlTiNEAvEVSgw9xAs_wz_jxgV8djMVHnR-TnZlBKYOQ2Athqs/s1600/24-06-2014+12-18-52+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhTjOk9kFyhmWkfc1SCSsv4gJBo3D3VFYCTXjGHIMMebrkoS6DDX_OImHmujJlZ2YilXdp_ECWfj07PAQww549-F3PcXIMlTiNEAvEVSgw9xAs_wz_jxgV8djMVHnR-TnZlBKYOQ2Athqs/s1600/24-06-2014+12-18-52+p.m..png)

### Bibliografía

Para este ejemplo me basé de la documentación provista por Oracle:

- [8.5 Composite Components](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-facelets005.htm)

- [14 Composite Components: Advanced Topics and an Example](http://docs.oracle.com/javaee/7/tutorial/doc/jsf-advanced-cc.htm)

### Código fuente

El código fuente para explorar lo pueden encontrar aquí:

[https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-05-cc/](https://bitbucket.org/apuntesdejava/tutorial-jsf/src/tip/jsf-05-cc/)

y el proyecto para descargar se encuentra aquí:

[https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-05-cc.tar.gz](https://java.net/projects/apuntes/downloads/download/web/Tutorial%20JSF%202.2/jsf-05-cc.tar.gz)
