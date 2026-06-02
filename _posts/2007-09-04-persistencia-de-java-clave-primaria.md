---
layout: post
title: "Persistencia de Java: Clave Primaria compleja con objeto"
date: 2007-09-04T21:05:00Z
last_modified_at: 2009-04-25T21:55:03.710Z
author: "Diego Silva"
permalink: /2007/09/persistencia-de-java-clave-primaria.html
canonical_url: https://www.apuntesdejava.com/2007/09/persistencia-de-java-clave-primaria.html
tags:
  - "jpa"
---

Como se vió, con el API de Persistencia de Java (Java Persistence API - JPA) se puede mapear todas las tablas de una base de datos como entidades para ser manipuladas desde objetos java.

Ahora, ¿qué pasa con entidades débiles?
Una entidad débil es aquella que depende su existencia de otra entidad. Por ejemplo, el detalle de una factura no puede existir sin una factura. Si se traslada este concepto a una base de datos, entonces, la clave primaria del detalle de factura será: la clave primaria de la factura a quien pertenece, y el número de orden que se muestra en la lista.

Mapear la entidad FACTURA es simple:

```java
<code>@Entity<br />public class Factura implements Serializable {<br /><br />@Id<br />@GeneratedValue(strategy = GenerationType.AUTO)<br />@Column(name="ID_FACTURA")<br />private Long id;<br /></code>
```

La entidad DETALLE_FACTURA tiene la clave primaria compuesta por dos campos: ID_FACTURA y NRO_ORDEN. En java, toda la clave primara es un objeto con el mismo nombre de la clase primaria más el sufijo "PK". Pero además, esta clave primaria debe tener una referencia a la misma factura de quien pertenece. Entonces, debemos crear la entidad primaria así:

```java
<code>@Embeddable<br />public class FacturaDetallePK implements java.io.Serializable {<br />@Column(name="id_factura",nullable=false)<br />private int idFactura;<br />@Column(name="nro_orden",nullable=false)<br />private int nroOrden;<br /><br /></code>
```

Como se ve, solo va el atributo que se enlazará con la tabla, que debe ser del mismo tipo (a menos que especifique lo contrario).

Ahora, al mapear la entidad FACTURA_DETALLE, esta debería tener la clave primaria (PK) además, del objeto que hará referencia con su 'padre', es decir, con FACTURA:

```java
<code>@Entity<br />@Table(name="FACTURA_DETALLE")<br />public class FacturaDetalle implements java.io.Serializable {<br />@EmbeddedId<br />private FacturaDetallePK facturaDetallePK;<br /><br />@JoinColumn(name="ID_FACTURA",referencedColumnName="ID_FACTURA")<br />@ManyToOne<br />private Factura factura;<br /><br /></code>
```

Se podrá pensar "pero, no se estará haciendo redundancia?, porque ya en el PK ya está el objeto Factura. tengo que volverlo a declarar como atributo de FacturaDetalle". Pues sí, de otra manera el API no podrá saber cómo hacer referencia desde la entidad FACTURA_DETALLE con FACTURA.

"¿No se haría más pesado tener que programar que cada vez que agrego una detalle a la factura colocar en ambos atributos el valor de su cabecera?"
Bueno, sí, pero utilizando una buena implementación del patrón DAO, este se puede hacer cargo de él. Además, debería de hacer persistente a cada línea de detalle. Aquí un ejemplo:

```java
<code>        emf = Persistence.createEntityManagerFactory("facturaPU");<br />      Factura factura=new Factura();<br />      FacturaDetalle det1=new FacturaDetalle();<br />      det1.setDescripcion("PCs");<br />      FacturaDetalle det2=new FacturaDetalle();<br />      det2.setDescripcion("Monitores");<br />      persist(factura);<br />      factura.agregarDetalle(det1);<br />      persist(det1);<br />      factura.agregarDetalle(det2);<br />      persist(det2);<br /><br /></code>
```

Y el método *agregarDetalle()* sería así:

```java
<code>    @OneToMany(cascade = CascadeType.ALL, mappedBy = "factura")<br />   private Collection<FacturaDetalle> facturaDetalleCollection=new ArrayList<FacturaDetalle>();<br /><br />void agregarDetalle(FacturaDetalle det) {<br />    <br />      this.facturaDetalleCollection.add(det);<br />      det.setFacturaDetallePK(new FacturaDetallePK(this.facturaDetalleCollection.size(),this.idFactura));<br />  }<br /></code>
```
