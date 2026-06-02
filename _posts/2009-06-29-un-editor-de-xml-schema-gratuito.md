---
layout: post
title: "Un editor de XML Schema gratuito... NetBeans"
date: 2009-06-29T05:28:00.002Z
last_modified_at: 2009-06-29T05:32:08.508Z
author: "Diego Silva"
permalink: /2009/06/un-editor-de-xml-schema-gratuito.html
canonical_url: https://www.apuntesdejava.com/2009/06/un-editor-de-xml-schema-gratuito.html
tags:
  - "tutorial"
  - "netbeans"
  - "xml"
---

Cuando queremos editar un archivo XML podemos usar un editor de texto plano (aunque llega a ser confuso cuando crece mucho).

Sabemos que los XML permite cualquier estructura de datos, pero tampoco hay que abusar de ello. Es necesario que tenga un orden: cuales son los tags, cuantos, cuales y en qué orden se establecen los valores, qué atributos debe tener, etc.

Para ello se puede usar [DTD](http://es.wikipedia.org/wiki/DTD), o un , [XML Schema](http://en.wikipedia.org/wiki/XML_Schema).

Usar un XML Schema tiene la gran ventaja es que es otro XML más, y que tiene más manera de restringir un XML que usando un DTD.

Para hacer un XML Schema se debería de usar un super editor de XML. El más conocido es el XML Spy. Lo he usado bastante, hasta cuando me decía que debería pagar por la versión.... además no corría en Linux.

Jugando por ahí con NetBeans encontré que también tiene su propio editor de Schemas. Y de eso lo trataré en este post.

**Paso 0: Instalación del editor de XML Schemas.**
Para comenzar, debemos instalar el componente, si es que no hemos instalado la opción de SOA.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2wd_OtjbxkgE0I_YLTXGuaD3BgCdiQx9OfydESLNgmzBJCrOHywg7XEyyPtVnvMWkoxTavbBc2pyf5PkeqciK-QstbK49kK_YctD0Ku-v2lDtfmr3x5UBDOe47OAv42Rt86_V8-8KaVwf/s400/Pantallazo-Plugins.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2wd_OtjbxkgE0I_YLTXGuaD3BgCdiQx9OfydESLNgmzBJCrOHywg7XEyyPtVnvMWkoxTavbBc2pyf5PkeqciK-QstbK49kK_YctD0Ku-v2lDtfmr3x5UBDOe47OAv42Rt86_V8-8KaVwf/s1600-h/Pantallazo-Plugins.png)

**Paso 1: Creando un .XSD**
Nuestro .xsd resultante será el que se menciona en [W3 Schools.org](http://www.w3schools.com/): [XML Schema Example](http://www.w3schools.com/schema/schema_example.asp). Veremos que es muy sencillo.

Como nuestro NetBeans no trabaja si no es con un proyecto, crearemos uno en blanco de cualquier tipo: Desktop Application o Web Application.

Luego, crearemos un nuevo archivo (Ctrl+N), y seleccionamos de la categoría XML, el tipo de archivo "XML Schema"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCOm4Y0j2keFqM6n2J0qoiy-M9Vr5S_T5mD1ely2zexcXOhzfG9aFcwWlUpqf3xlVBImDNCR2Efkx3sgLid95WucBh4QH5OUYEvwt00zPlVoLAIHcAC2fWPqBL5mjPo3RWjwNY8CgCCPY0/s400/Pantallazo-New+File.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCOm4Y0j2keFqM6n2J0qoiy-M9Vr5S_T5mD1ely2zexcXOhzfG9aFcwWlUpqf3xlVBImDNCR2Efkx3sgLid95WucBh4QH5OUYEvwt00zPlVoLAIHcAC2fWPqBL5mjPo3RWjwNY8CgCCPY0/s1600-h/Pantallazo-New+File.png)

.. y llamaremos a nuestro archivo "shiporder":

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbnMR0MYpmRBU2E9oKk6NFitBoTp01L7lzHl2-Kn5aS74sTfLGXkl-A5xkidOqqnhRJ8IJL_dynYiuBjKOD6QC9V9vs9m7gvlQzBW-kbzUSFFxiraVdCOoDA7BhsCoEfvEU3d3gWpveaMz/s400/Pantallazo-New+XML+Schema.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbnMR0MYpmRBU2E9oKk6NFitBoTp01L7lzHl2-Kn5aS74sTfLGXkl-A5xkidOqqnhRJ8IJL_dynYiuBjKOD6QC9V9vs9m7gvlQzBW-kbzUSFFxiraVdCOoDA7BhsCoEfvEU3d3gWpveaMz/s1600-h/Pantallazo-New+XML+Schema.png)

Al terminar, veremos que nos aparece un editor visual de XML.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQpfCOCc3FoB6uB94t0Ed_S2hMYcR7LuX3IV6ZpCU3lDtM7NOpzoU-oQXVHqpaeQcL-LigRvD4oOlqU-CD27w3BeDZOIdzUZF_WzhMqYoMu9xZRaaRMxSV-LjKoseU-pEtwdeIgWKKxB0U/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQpfCOCc3FoB6uB94t0Ed_S2hMYcR7LuX3IV6ZpCU3lDtM7NOpzoU-oQXVHqpaeQcL-LigRvD4oOlqU-CD27w3BeDZOIdzUZF_WzhMqYoMu9xZRaaRMxSV-LjKoseU-pEtwdeIgWKKxB0U/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401.png)

En los botones superiores, podemos alternar de la vista de Esquema a Diseño (Design)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuBeE12ZPAwgFJNrwidxTYvAIUIvGOn79fdRgALr3HPrWF8EkMS45Up-BPw5JUsASVYmnuyOoPH3lqq8h7B5aa21sNwgyeEeZCOrOWz9phs4CoSADndZUpIGyWxJ4Cn6Kf_DSld0hPF2lR/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuBeE12ZPAwgFJNrwidxTYvAIUIvGOn79fdRgALr3HPrWF8EkMS45Up-BPw5JUsASVYmnuyOoPH3lqq8h7B5aa21sNwgyeEeZCOrOWz9phs4CoSADndZUpIGyWxJ4Cn6Kf_DSld0hPF2lR/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-1.png)

.. o a la misma fuente XML.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFCqwU23YWSrr8zsG8ExQBuTJsLXIwSjkzEA1LS4qx5C4qXS2U80YA3drigiBcZVKy8EKGTNAqjUnUJFR67ZXOuyYX-ZI_oHqNrkLZiYMzdxwjJQGjXbH6f4N81zBPyQGOMMkZaCc9TlrK/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFCqwU23YWSrr8zsG8ExQBuTJsLXIwSjkzEA1LS4qx5C4qXS2U80YA3drigiBcZVKy8EKGTNAqjUnUJFR67ZXOuyYX-ZI_oHqNrkLZiYMzdxwjJQGjXbH6f4N81zBPyQGOMMkZaCc9TlrK/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-2.png)

Regresamos al modo "Schema".

**Paso 2: Definiendo los tipos simples que deberá tener el XML**

Ahora, según el ejemplo descrito en el W3 Schools, el XML debe ser así:

```java
<code><?xml version="1.0" encoding="ISO-8859-1"?><br /><br /><shiporder orderid="889923"<br />xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<br />xsi:noNamespaceSchemaLocation="shiporder.xsd"><br />  <orderperson>John Smith</orderperson><br />  <shipto><br />    <name>Ola Nordmann</name><br />    <address>Langgt 23</address><br />    <city>4000 Stavanger</city><br />    <country>Norway</country><br />  </shipto><br />  <item><br />    <title>Empire Burlesque</title><br />    <note>Special Edition</note><br />    <quantity>1</quantity><br />    <price>10.90</price><br />  </item><br />  <item><br />    <title>Hide your heart</title><br />    <quantity>1</quantity><br />    <price>9.90</price><br />  </item><br /></shiporder></code>
```

Se puede ver a simple vista que se utilizan tres tipos de elementos simples:

- cadena
-  entero positivo
- decimal
Y que el ID de la orden, es una cadena que solo debe permitir 6 digitos.

Pues bien, ahora definiremos cuatro tipos de datos para nuestro esquema. Hacemos clic derecho sobre la categoría "Simple types" y seleccionamos "Add simple type..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgi-7Q-QKG-f_-XjTejxwIEIh5kAmRKHH4qhvZXkXSwDFXiLHaspLnFWfgBPRfSTU8IVw7GAQLSfrshA_5yMIEhUuuMDSbKxKMTfdjZrFSsDcLhcXLthmnqukOhW-y5pk-8m7dmDBvGfNi5/s320/add-simple-type.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgi-7Q-QKG-f_-XjTejxwIEIh5kAmRKHH4qhvZXkXSwDFXiLHaspLnFWfgBPRfSTU8IVw7GAQLSfrshA_5yMIEhUuuMDSbKxKMTfdjZrFSsDcLhcXLthmnqukOhW-y5pk-8m7dmDBvGfNi5/s1600-h/add-simple-type.png)

.. escribiremos el nombre "stringType" que será basado en el tipo "string".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhUEH-TfcnuPTgYR0bWpy7y5MFF1ljqBAsPzmaGdnWEqQEgZdKHHcORIWfAe7W5NqUaJ1xXC4yWi6uqhyphenhyphen3z0iUf2zl3zgPh5xDDeGMIHcDeDYy_EoJwSjk3lIZcX_MC9hJUmYazbMisNRdM/s400/Pantallazo-Add+Simple+Type.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhUEH-TfcnuPTgYR0bWpy7y5MFF1ljqBAsPzmaGdnWEqQEgZdKHHcORIWfAe7W5NqUaJ1xXC4yWi6uqhyphenhyphen3z0iUf2zl3zgPh5xDDeGMIHcDeDYy_EoJwSjk3lIZcX_MC9hJUmYazbMisNRdM/s1600-h/Pantallazo-Add+Simple+Type.png)

... clic en OK. Repetiremos lo mismo para los siguientes tipos:

- intType (positiveInteger)
- decType (decimal)
- orderIdType (string)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKexBmL2F3W1pNJ8f8RcbAQZOgF3VchkDTWm_hUV19TBJOPYK_s_xLz3XqseQWLqPHRfMj46jfVjR_DLk-jecBK4CX7LmbhKg1XCzHGP5EmdnpYmknAe5mE3DEaF3Tk5Gi5M4VCy9L03d3/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKexBmL2F3W1pNJ8f8RcbAQZOgF3VchkDTWm_hUV19TBJOPYK_s_xLz3XqseQWLqPHRfMj46jfVjR_DLk-jecBK4CX7LmbhKg1XCzHGP5EmdnpYmknAe5mE3DEaF3Tk5Gi5M4VCy9L03d3/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-3.png)

**Paso 3: Definiendo los tipos complejos.**
Los tipos complejos para el XML son para los siguientes elementos (tags):

- shipto (name, address, city, country)

- item (title, note, quality, price)

- shiporder (orderperson, shipto, item)

Así que comenzaremos a crear el primer tipo complejo: shiptoType.

Clic derecho sobre "Complex types" y seleccionamos "Add Complex type..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDQ59KXCNPxKmXY7VqZVwD6vr8197AnC1NcFaFQsGmbojeoEnZL9vzqYYwNY81FDxBCIVkOYDOkyzH_6XL2Qny9JNCyS8mUNDTUA_BCZHlC8S4HNNfqgysynDHiFw3cOW_cY02mUzbC2h1/s320/add-complex-type.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDQ59KXCNPxKmXY7VqZVwD6vr8197AnC1NcFaFQsGmbojeoEnZL9vzqYYwNY81FDxBCIVkOYDOkyzH_6XL2Qny9JNCyS8mUNDTUA_BCZHlC8S4HNNfqgysynDHiFw3cOW_cY02mUzbC2h1/s1600-h/add-complex-type.png)

El nombre del tipo complejo será shiptoType, y contendrá una secuencia.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZS02qnskocJtc0F70y5jsddItNPX0Wo9unEopyKe21qDxTl0EfcKdKChVqGiLJTtFQXrajCr4aEtbqkQh5qm4p6hEuhneQzSTWYEYm21cz4QA6F-XDhhue0BmaDEv3nZ2i1Hx5ZAAnwDI/s320/Pantallazo-Add+Complex+Type.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZS02qnskocJtc0F70y5jsddItNPX0Wo9unEopyKe21qDxTl0EfcKdKChVqGiLJTtFQXrajCr4aEtbqkQh5qm4p6hEuhneQzSTWYEYm21cz4QA6F-XDhhue0BmaDEv3nZ2i1Hx5ZAAnwDI/s1600-h/Pantallazo-Add+Complex+Type.png)

... clic en OK.

Ahora, debemos agregar la secuencia que compone ese tipo complejo. El primer subelemento es "name" de tipo "stringType". Para ello, debemos seleccionar el elemento "sequence" de "shiptoType", hacemos clic derecho, y seleccionamos "Add > Element..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdbdzWlLBRM395Ly_D44XOUoAsRdnWeHEaHJImoHqG5Xn7mw4kz2Qthc-qKMZxLalaDoIKL7JhiOlv6A4dhvKi5gP-LVA6wjTk-_Oljztrbwi_ZvdHEyMidbRqfBWUFcB0g7B3pKxMiFcS/s400/add-element.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdbdzWlLBRM395Ly_D44XOUoAsRdnWeHEaHJImoHqG5Xn7mw4kz2Qthc-qKMZxLalaDoIKL7JhiOlv6A4dhvKi5gP-LVA6wjTk-_Oljztrbwi_ZvdHEyMidbRqfBWUFcB0g7B3pKxMiFcS/s1600-h/add-element.png)

el nombre es "name" y usamos un tipo existente (el que acabamos de crear): Use existing type >Simple types > stringType

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEii85zABeNuTUtUoP4Wx0mrivKUV5lBur6a3xO_DEguisO2uxdSPmq3V0qY9WfNFR4SqpHCQc_70X3l8EYn_vl7ltVflG_ieTJv8cnzQtyq9I3wOQOoxfNCsRAxsWOSPgdcIG6BHQTfykfO/s320/Pantallazo-Add+Element-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEii85zABeNuTUtUoP4Wx0mrivKUV5lBur6a3xO_DEguisO2uxdSPmq3V0qY9WfNFR4SqpHCQc_70X3l8EYn_vl7ltVflG_ieTJv8cnzQtyq9I3wOQOoxfNCsRAxsWOSPgdcIG6BHQTfykfO/s1600-h/Pantallazo-Add+Element-1.png)

Repetiremos la acción por los otros tres subelementos más:

- address (stringType)
- city (stringType)
- country (stringType)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJcWWmLl4IPQ8VtFkrDRWJqROBIU1i7ID5AB-ndWOWVT2LmzOeS8db3mq-2aJgjmdZyrC3wOsdbr_9zUHAvLJZvmhkN3BzTUwFtJviPE6ITQztQ_LSH2nVMAKFo5HcDVEGEo4S0vLMUnkq/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-4.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJcWWmLl4IPQ8VtFkrDRWJqROBIU1i7ID5AB-ndWOWVT2LmzOeS8db3mq-2aJgjmdZyrC3wOsdbr_9zUHAvLJZvmhkN3BzTUwFtJviPE6ITQztQ_LSH2nVMAKFo5HcDVEGEo4S0vLMUnkq/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-4.png)

Ahora, crearemos un nuevo tipo complejo, llamado itemType, y tendrá los siguientes subelementos:

- title (stringType)
- note (stringType)
- quantity (intType)
- price (decType)
Pero el elemento "note"  es opcional. Para ello, seleccionamos clic derecho sobre ese elemento y seleccionamos "properties", y en el atributo "Min occurrs" escribimos "0"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLam7UC0n92eNpYGYUppGLd2gxPMsnRMIZufzEsUFVQK0FhYX-Elv0k1DJTu3kNqDvpLBqLbKjkCTAZRj_0UHtLxLKbiLe01cJzEINgeZURvT068_CSaHoU0oEjaEcTxUrbtVqYda1kf1b/s320/Pantallazo-note+%5BLocal+Element%5D+-+Properties.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjLam7UC0n92eNpYGYUppGLd2gxPMsnRMIZufzEsUFVQK0FhYX-Elv0k1DJTu3kNqDvpLBqLbKjkCTAZRj_0UHtLxLKbiLe01cJzEINgeZURvT068_CSaHoU0oEjaEcTxUrbtVqYda1kf1b/s1600-h/Pantallazo-note+%5BLocal+Element%5D+-+Properties.png)

... clic en Close.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiUO_jtolggA7NCr4qgFnWknWzVSuemoh85lE_P1NIE4WLBwuYzap2RgHJBhtN5sosOycrKejhnCjqqrCXk15q23K_E6lriAbpJrYp2uH4c0ESM2t9Mx8iGjUdW6ikQEPpSuAwJysbOYTao/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-5.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiUO_jtolggA7NCr4qgFnWknWzVSuemoh85lE_P1NIE4WLBwuYzap2RgHJBhtN5sosOycrKejhnCjqqrCXk15q23K_E6lriAbpJrYp2uH4c0ESM2t9Mx8iGjUdW6ikQEPpSuAwJysbOYTao/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-5.png)

Ahora, el tipo más complejo de todos: shiporderType. Estará compuesto de:

- orderperson (stringType)
- shipto (shiptoType)
- item (itemType)
Además, debe contar con un atributo obligatorio llamado "orderid" que es de tipo "orderIdType"

Repetiremos la misma secuencia, solo que para el elemento shipto, debemos seleccionar la categoría "ComplexType > shiptoType"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhmgIhwwsXsbEAvsYm9rTHdwuhyphenhyphenAYaZ7lUnXBB3sNOqXTeH7lW8Y5ON8KOjVoxFsbLd-CrCrMeyJuToFb1bRMVYC_KfUCoJiuMqaqZH3EXyLbOynkaJAskOWxzMrBWAPQoBwuWIUQi3qNb/s320/Pantallazo-Add+Element-2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhmgIhwwsXsbEAvsYm9rTHdwuhyphenhyphenAYaZ7lUnXBB3sNOqXTeH7lW8Y5ON8KOjVoxFsbLd-CrCrMeyJuToFb1bRMVYC_KfUCoJiuMqaqZH3EXyLbOynkaJAskOWxzMrBWAPQoBwuWIUQi3qNb/s1600-h/Pantallazo-Add+Element-2.png)

.. de similar manera para item (itemType)
Ahora, este item debe permitir de uno a más elementos. Por omisión siempre permitirá unicamente un solo tag. Para esto, hacemos clic derecho sobre este elemento item recien creado, y seleccionamos "properties". Luego, cambiamos el atributo "max occurs" con el valor "unbounded".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7aN0Uebu0JmY19lWpCseO_eJw32bhS-UIg3fhe_BegzmESwOgqaHwD3rVQgE-ifPZCTfF9RdfU8fZ2FFFQH8Gt8af6w_jwE9yweSwjrToQUaM4YhmdHI-f9KaaRwMHq_cV2MDTbhH7QFO/s320/Pantallazo-item+%5BLocal+Element%5D+-+Properties.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7aN0Uebu0JmY19lWpCseO_eJw32bhS-UIg3fhe_BegzmESwOgqaHwD3rVQgE-ifPZCTfF9RdfU8fZ2FFFQH8Gt8af6w_jwE9yweSwjrToQUaM4YhmdHI-f9KaaRwMHq_cV2MDTbhH7QFO/s1600-h/Pantallazo-item+%5BLocal+Element%5D+-+Properties.png)

.. clic en Close.

Ahora, debemos crear el atributo para shiporderType.Hacemos clic derecho sobre "shiporderType" y seleccionamos "Add > Attribute..."

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh5c8LeN8GCIj4myqCWmeSSdqGkmhbz7K-1g6GZ23REjqsc5duXUAhcH2k2bKEnsIazDFIcb5YTUjG9E62Sa_GzfzY9Bt4o_d6Xw91Jf5b0NwfoDOMrTDStionUvvHInri9-oz5kFR8_avy/s400/add-atribute.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh5c8LeN8GCIj4myqCWmeSSdqGkmhbz7K-1g6GZ23REjqsc5duXUAhcH2k2bKEnsIazDFIcb5YTUjG9E62Sa_GzfzY9Bt4o_d6Xw91Jf5b0NwfoDOMrTDStionUvvHInri9-oz5kFR8_avy/s1600-h/add-atribute.png)

... escribimos el nombre del atributo "orderid" de tipo "Simple Type > orderIdType"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgah26HmUsz_5qP8OqGo4NZe5riCVQReArRpUZyR_myxgGqbn3HiRTQhxly_uQCftLbDo7Pe6X6B4dzSWBUMMcb0gmVq4rj2x3ZBS9q9p_KFxnOdbWwQBTALAo3eP7-XNrGgecLLwodNDEv/s320/Pantallazo-Add+Attribute.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgah26HmUsz_5qP8OqGo4NZe5riCVQReArRpUZyR_myxgGqbn3HiRTQhxly_uQCftLbDo7Pe6X6B4dzSWBUMMcb0gmVq4rj2x3ZBS9q9p_KFxnOdbWwQBTALAo3eP7-XNrGgecLLwodNDEv/s1600-h/Pantallazo-Add+Attribute.png)

Y este atributo, es obligatorio, por ello hacemos clic derecho sobre el atributo recién creado, seleccionamos "properties", y cambiamos el valor de "use" a "required".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgKx0JtAc80Xmd894iovt_d2OcOHVh1SCqazBQrXpe0dAKGJAuKEPPV6QkskNwvyQ28SZg_bZOuHEEnVrhF1Hp3EV6DPUlpfgnksS2OZgw2SYOhf73kiWTlmClEuOqcgBELvgYpLzqX4gU_/s320/Pantallazo-orderid+%5BLocal+Attribute%5D+-+Properties.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgKx0JtAc80Xmd894iovt_d2OcOHVh1SCqazBQrXpe0dAKGJAuKEPPV6QkskNwvyQ28SZg_bZOuHEEnVrhF1Hp3EV6DPUlpfgnksS2OZgw2SYOhf73kiWTlmClEuOqcgBELvgYpLzqX4gU_/s1600-h/Pantallazo-orderid+%5BLocal+Attribute%5D+-+Properties.png)

.. clic en Close.

**Paso 4: Creando el elemento principal**
ya creados los tipos simples y complejos, debemos crear el elemento raiz de todo el XML: shiporder de tipo shiporderType.

Hacemos clic derecho sobre la categoría "Elements" y seleccionamos "Add Element"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhGG7zc3BSS06k-ZV1YBdR1tKccczYX2sdjANkLWxlnKCyOlAL6N2WxoH2hev4e2qA_bYZp-yRIVq7las09IFETkuqhQJWPPFuVhgoHZCnMg622lXspZBrrhmCIKW2n0GGDny5v3Vc5H6j2/s320/add-element.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhGG7zc3BSS06k-ZV1YBdR1tKccczYX2sdjANkLWxlnKCyOlAL6N2WxoH2hev4e2qA_bYZp-yRIVq7las09IFETkuqhQJWPPFuVhgoHZCnMg622lXspZBrrhmCIKW2n0GGDny5v3Vc5H6j2/s1600-h/add-element.png)

... el nombre del elemento es "shiporder" de tipo complejo "shiporderType"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqDTVT4hlZ1P3u4Yxq5VaonhpY53d0hHyRmfGBeTRcxNpCG0lVNsATD_m3z2HmryhPd0G2EUKJ1qbQrRNwvbfbhNNfgaGJYt4tpuenih0if5c3_K_adDcCQXQy4pOQk99Su5aqr8eIjy2A/s320/Pantallazo-Add+Element-3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqDTVT4hlZ1P3u4Yxq5VaonhpY53d0hHyRmfGBeTRcxNpCG0lVNsATD_m3z2HmryhPd0G2EUKJ1qbQrRNwvbfbhNNfgaGJYt4tpuenih0if5c3_K_adDcCQXQy4pOQk99Su5aqr8eIjy2A/s1600-h/Pantallazo-Add+Element-3.png)

A esta altura, ya todo es tan automático y rápido que no necesita explicación.

Y listo. Podemos ver en el modo "Design" cómo ha quedado nuestro esquema.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0__jvv96NdwLkaNP8CCWH_06je7B8BcQ9Jesn2CzjuKz3wF1VR-Yv7w1OYz44HoSjPfuBzCX1kW0cCHGsQDGivkmbD5s7fjRf6qqSG4xBd237boaR1n5PIZYl1EV4S0k_qiymd-VJ8Zv7/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-6.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0__jvv96NdwLkaNP8CCWH_06je7B8BcQ9Jesn2CzjuKz3wF1VR-Yv7w1OYz44HoSjPfuBzCX1kW0cCHGsQDGivkmbD5s7fjRf6qqSG4xBd237boaR1n5PIZYl1EV4S0k_qiymd-VJ8Zv7/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-6.png)

Y si deseas, puedes ver el XML resultante.

```java
<code><?xml version="1.0" encoding="UTF-8"?><br /><br /><xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"<br />    targetNamespace="http://xml.netbeans.org/schema/shiporder"<br />    xmlns:tns="http://xml.netbeans.org/schema/shiporder"<br />    elementFormDefault="qualified"><br />    <xsd:simpleType name="intType"><br />        <xsd:restriction base="xsd:positiveInteger"/><br />    </xsd:simpleType><br />    <xsd:simpleType name="stringType"><br />        <xsd:restriction base="xsd:string"/><br />    </xsd:simpleType><br />    <xsd:simpleType name="decType"><br />        <xsd:restriction base="xsd:decimal"/><br />    </xsd:simpleType><br />    <xsd:simpleType name="orderIdType"><br />        <xsd:restriction base="xsd:string"/><br />    </xsd:simpleType><br />    <xsd:complexType name="shiptoType"><br />        <xsd:sequence><br />            <xsd:element name="name" type="tns:stringType"></xsd:element><br />            <xsd:element name="address" type="tns:stringType"></xsd:element><br />            <xsd:element name="city" type="tns:stringType"></xsd:element><br />            <xsd:element name="country" type="tns:stringType"></xsd:element><br />        </xsd:sequence><br />    </xsd:complexType><br />    <xsd:complexType name="itemType"><br />        <xsd:sequence><br />            <xsd:element name="title" type="tns:stringType"></xsd:element><br />            <xsd:element name="note" type="tns:stringType" minOccurs="0"></xsd:element><br />            <xsd:element name="quantity" type="tns:intType"></xsd:element><br />            <xsd:element name="price" type="tns:decType"></xsd:element><br />        </xsd:sequence><br />    </xsd:complexType><br />    <xsd:complexType name="shiporderType"><br />        <xsd:sequence><br />            <xsd:element name="orderperson" type="tns:stringType"></xsd:element><br />            <xsd:element name="shipto" type="tns:shiptoType"></xsd:element><br />            <xsd:element name="item" type="tns:itemType" maxOccurs="unbounded"></xsd:element><br />        </xsd:sequence><br />        <xsd:attribute name="orderid" type="tns:orderIdType" use="required"/><br />    </xsd:complexType><br />    <xsd:element name="shiporder" type="tns:shiporderType"></xsd:element><br /></xsd:schema><br /><br /><br /></code>
```

Muy parecido al explicado en W3 Schools... y más práctico.

**Paso 5: Crear un XML usando este XSD.**
Crearemos un nuevo XML, pero en el tercer paso de la creación desde NetBeans, seleccionamos que use un Schema.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-xB-TJybCLE3839VQrwTf11c4B8jsojbdyjjX91oXcWMk3El9Oe1F4BTzOnZOQ3_A1fVEkdgylvLGyaaNwkAVYl3lhc9YKfoCg8dMsQ-Ya6GBpl4QmtlcFzz1oj66Gme3oTz778SokmYX/s320/Pantallazo-New+File-1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-xB-TJybCLE3839VQrwTf11c4B8jsojbdyjjX91oXcWMk3El9Oe1F4BTzOnZOQ3_A1fVEkdgylvLGyaaNwkAVYl3lhc9YKfoCg8dMsQ-Ya6GBpl4QmtlcFzz1oj66Gme3oTz778SokmYX/s1600-h/Pantallazo-New+File-1.png)

En el paso siguiente, hacemos clic en "browse"...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiaAO0IAkySQ3Mb84XoDX_JNM72xA02YnfriVzhO9UOUSjEJySH79LeQYgxpm5H-FXe7n6tQ-VIJFw79w2z1gBwXECz0heMGN2Pc7MHSBLVcQRTeyZK3yRexvxJ5Y1aZr2PanZENKf8VcAB/s320/Pantallazo-New+File-2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiaAO0IAkySQ3Mb84XoDX_JNM72xA02YnfriVzhO9UOUSjEJySH79LeQYgxpm5H-FXe7n6tQ-VIJFw79w2z1gBwXECz0heMGN2Pc7MHSBLVcQRTeyZK3yRexvxJ5Y1aZr2PanZENKf8VcAB/s1600-h/Pantallazo-New+File-2.png)

...para seleccionar el xsd que acabamos de crear.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdiqADnvkexU27ZZiRJHa4QPF5bTqRHavcoh_J0y2ZvCPJsgy0xqeucK6i5qnOX2qthVvpcVd_TD5SavHKo85H-hiL3oZWrHqj-UFHEzzcL2NOWr0D7TxDInTYedxL90YeyTGpmzZb59_w/s320/Pantallazo-Schema+Browser.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdiqADnvkexU27ZZiRJHa4QPF5bTqRHavcoh_J0y2ZvCPJsgy0xqeucK6i5qnOX2qthVvpcVd_TD5SavHKo85H-hiL3oZWrHqj-UFHEzzcL2NOWr0D7TxDInTYedxL90YeyTGpmzZb59_w/s1600-h/Pantallazo-Schema+Browser.png)

Luego, seleccionamos cual es el esquema principal para nuestro XML (el unico) y podemos editar el prefijo (prefix) que usaremos para referirnos a ese esquema. Yo le puse "so" (ship order)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg-h3j-HRMPrQsUG9TS_EsyghnXcXhX4AhBPirQEQcytAwn5kgiXE2iKYby3Dgmr_jVfu-_8_m29L7QqCjx6FgSPtqgEAtsQ9WJfHEhEXu-MTZuickObtPj8nkwFueCQ8wdlz78P3ZyrE9F/s320/Pantallazo-New+File-3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg-h3j-HRMPrQsUG9TS_EsyghnXcXhX4AhBPirQEQcytAwn5kgiXE2iKYby3Dgmr_jVfu-_8_m29L7QqCjx6FgSPtqgEAtsQ9WJfHEhEXu-MTZuickObtPj8nkwFueCQ8wdlz78P3ZyrE9F/s1600-h/Pantallazo-New+File-3.png)

.. y para finalizar, el NetBeans nos propone crear tags en blanco usando basándose en el esquema:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjOVzJ1sEtjor1EkP9gU1QW228sHE0oKVQouQ_fjgFH-YtAOCwV5PEtBG9wCaKynsznL21q22mMZqUU27OR2UemZN0WTInizbY2b_KzqZB8dR21QTICIkNDmPu4bidJ8ixTEwh-Xd7JXHu9/s400/Pantallazo-New+File-4.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjOVzJ1sEtjor1EkP9gU1QW228sHE0oKVQouQ_fjgFH-YtAOCwV5PEtBG9wCaKynsznL21q22mMZqUU27OR2UemZN0WTInizbY2b_KzqZB8dR21QTICIkNDmPu4bidJ8ixTEwh-Xd7JXHu9/s1600-h/Pantallazo-New+File-4.png)

.. y listo:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg7Ri23zaRPnZKKWDeuN3HcXlDa4Jqp5eaw-MA9ZAh-RlIDclELSbpoHSPxVPZOHxuwEUjlbnwunfWdqfL9FwEXBDXEwGb_oKniEc9ik5RLQF6pOCqMBeZsrhxarce92Zn7FmIT0jIL8Hb7/s400/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-7.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg7Ri23zaRPnZKKWDeuN3HcXlDa4Jqp5eaw-MA9ZAh-RlIDclELSbpoHSPxVPZOHxuwEUjlbnwunfWdqfL9FwEXBDXEwGb_oKniEc9ik5RLQF6pOCqMBeZsrhxarce92Zn7FmIT0jIL8Hb7/s1600-h/Pantallazo-JavaApplication1+-+NetBeans+IDE+Dev+200906261401-7.png)

Un esquema de XML creado con puros clics.
