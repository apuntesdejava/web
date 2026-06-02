---
layout: post
title: "JPA: Maestro / detalle con clave primaria compartida"
date: 2016-05-20T19:10:00Z
last_modified_at: 2016-05-20T19:15:06.119Z
author: "Diego Silva Límaco"
permalink: /2016/05/jpa-maestro-detalle-con-clave-primaria.html
canonical_url: https://www.apuntesdejava.com/2016/05/jpa-maestro-detalle-con-clave-primaria.html
description: "Hace casi 10 años (wow!) había publicado un artículo sobre las claves compuestas en entidades de tipo Maestro / Detalle. Bueno, aquí está una super actualización. Esa vez fue hecha con JPA 1.0, ahora lo mostraré más actualizado y mejorado con con el JPA 2.0."
tags:
  - "java ee"
  - "jpa"
  - "java ee 7"
  - "jpa 2.0"
---

[![](https://docs.google.com/drawings/d/1qA82Kiyq3VnnR7z_rQjin3JTf5-2Ny2RWrMZKLNJblA/pub?w=442&h=181)](https://docs.google.com/drawings/d/1qA82Kiyq3VnnR7z_rQjin3JTf5-2Ny2RWrMZKLNJblA/pub?w=442&h=181)

Hace casi 10 años (wow!) había publicado un artículo sobre las [claves compuestas en entidades de tipo Maestro / Detalle](/2007/09/persistencia-de-java-clave-primaria.html). Bueno, aquí está una super actualización. Esa vez fue hecha con JPA 1.0, ahora lo mostraré más actualizado y mejorado con con el [JPA 2.0](https://docs.oracle.com/javaee/7/api/javax/persistence/package-summary.html).

El ejemplo será usado del clásico: Factura / Detalle factura; donde Factura será el "maestro" y "Detalle Factura" su detalle. La tabla de Detalle deberá tener el código de la factura y un correlativo. Ambos campos serán parte de la clave primaria del detalle.

[![](https://1.bp.blogspot.com/WWzYGo7Kz1rAi43EL1WpqcMKJI9QyPt8gr41jLcVZiyoTY-I7jlzV4YNN6DUTNl8DCUaVg=s400)](https://1.bp.blogspot.com/WWzYGo7Kz1rAi43EL1WpqcMKJI9QyPt8gr41jLcVZiyoTY-I7jlzV4YNN6DUTNl8DCUaVg=s400)

## Clase "maestro"

Primero comencemos por definir la clase "Maestro":

```java
@Entity
public class Factura implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long facturaId;

    @Temporal(javax.persistence.TemporalType.DATE)
    private Date fechaFactura;

    @OneToMany(mappedBy = "factura")
    private List<FacturaDetalle> detalle;
//...
```

Clase completa en [Factura](https://bitbucket.org/apuntesdejava/jpa-primary-key-master-detail/src/master/src/main/java/com/apuntesdejava/jpa/primary/key/entities/Factura.java).

Como se ve, luce totalmente normal como si fuera una Entidad común y silvestre. Además, tiene una lista (línea 44) que contendrá todas las filas del detalle de la factura.

## Clase "detalle"

Ahora veremos cómo luce esa clase detalle.

```java
@Entity
@Table(name = "FACTURA_DETALLE")
public class FacturaDetalle implements Serializable {

    @EmbeddedId
    private FacturaDetallePK facturaDetallePK;

    @MapsId("facturaId")
    @ManyToOne
    private Factura factura;

    private String descripcion;

    public FacturaDetalle() {
    }

    public FacturaDetalle(long facturaId, int ordenId) {
        facturaDetallePK = new FacturaDetallePK(facturaId, ordenId);
    }
//...
```

Clase completa en :`[FacturaDetalle](https://bitbucket.org/apuntesdejava/jpa-primary-key-master-detail/src/master/src/main/java/com/apuntesdejava/jpa/primary/key/entities/FacturaDetalle.java?)`.

La línea 35 nos parece algo raro, ya que es una clase incrustada `[@EmbeddedId](https://docs.oracle.com/javaee/7/api/javax/persistence/EmbeddedId.html)`. En esta estarán los campos de la clave primaria.

El mapeo entre el detalle y el maestro se dá en la línea 39. Es una relación muchos-a-uno [@ManyToOne,](https://docs.oracle.com/javaee/7/api/javax/persistence/ManyToOne.html) y el campo relacionado entre Factura y el Detalle se dan por el atributo `facturaId`. Esa relación se da en la línea 37 con la anotación `[@MapsId](https://docs.oracle.com/javaee/7/api/javax/persistence/MapsId.html)`.

Ahora veamos qué contiene la clase `FacturaDetallePK`

## Clase Clave primaria de detalle

```java
@Embeddable
public class FacturaDetallePK implements Serializable {
    private long facturaId;
    private int orderId;

//...
```

Clase completa en :`[FacturaDetallePK](https://bitbucket.org/apuntesdejava/jpa-primary-key-master-detail/src/master/src/main/java/com/apuntesdejava/jpa/primary/key/entities/FacturaDetallePK.java)`.

La clase luce como cualquiera con anotación `[@Embeddable](https://docs.oracle.com/javaee/7/api/javax/persistence/Embeddable.html)`. En fin, eso es todo. No requiere mucha anotación adicional.

## ¿Cómo se usa?

La inserción de objetos es mucho más natural. Comencemos con crear un objeto de la clase "Maestro". Ya que después de insertarlo obtendremos el ID generado.

```java
private void start() {
        LOG.info("Insertando objeto factura");
        Factura factura = new Factura();
        factura.setFechaFactura(new Date());
        persist(factura);
        LOG.log(Level.INFO, "Factura insertada:{0}", factura);
//...
```

Ahora bien, necesitamos crear el detalle, y como ya tenemos el ID del Maestro, entonces simplemente le pasamos al objeto. El campo `ordenId` lo he puesto en duro solo para fines de prueba:

```java
//...
        LOG.info("Insertando detalle 1");
        FacturaDetalle det1 = new FacturaDetalle(factura.getFacturaId(), 1);
        det1.setDescripcion("PCs");
        det1.setFactura(factura);
        persist(det1);
        LOG.log(Level.INFO, "detalle 1 insertada{0}", det1);

        LOG.info("Insertando detalle 2");
        FacturaDetalle det2 = new FacturaDetalle(factura.getFacturaId(), 2);
        det2.setDescripcion("Monitores");
        det2.setFactura(factura);
        persist(det2);
        LOG.log(Level.INFO, "detalle 2 insertada{0}", det2);
//...
```

Listo, ya tenemos dos objetos como detalle de la factura. Si lo consultamos, veamos lo que aparece:

```java
//...
        LOG.info("Obteniendo objetos");
        List<Factura> facturas = em.createQuery("SELECT f FROM Factura f", Factura.class).getResultList();
        facturas.stream().forEach((f) -> {
            LOG.log(Level.INFO, "Factura: {0}", f);
        });
```

Pero en las tablas, el resultado será este.

El "maestro":

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEit4PQBKpMXyoSIjg1ch7m1S-M0keeK1yqG9UaAJdz4dQ-aJROwrAYo4E7RHIr17Mpje1ZZp_FIOEVwTKXbyzjsLV_yjwT1W251pjj6vsRkJUsVqiuGkTy4Rkg7mQMzM5v5RxKOMMexXj4/s1600/20-05-2016+02-04-08+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEit4PQBKpMXyoSIjg1ch7m1S-M0keeK1yqG9UaAJdz4dQ-aJROwrAYo4E7RHIr17Mpje1ZZp_FIOEVwTKXbyzjsLV_yjwT1W251pjj6vsRkJUsVqiuGkTy4Rkg7mQMzM5v5RxKOMMexXj4/s1600/20-05-2016+02-04-08+p.m..png)

Y del "detalle" así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh7Ze8AFmuDI_7f3uYcGcZud32nBJSeoJ3nI6fC8sseTv0KweER9P-d1EhfCKITScAxJy8tmwFX8_9ZndTmY94lFz3IsIoI8HjxnzUFMnHU8SIXWKggn7r-fvlb6AS74FrfFxZaQpaG53E/s1600/20-05-2016+02-04-33+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh7Ze8AFmuDI_7f3uYcGcZud32nBJSeoJ3nI6fC8sseTv0KweER9P-d1EhfCKITScAxJy8tmwFX8_9ZndTmY94lFz3IsIoI8HjxnzUFMnHU8SIXWKggn7r-fvlb6AS74FrfFxZaQpaG53E/s1600/20-05-2016+02-04-33+p.m..png)

## Código fuente

El código fuente completo del proyecto lo pueden obtener de aquí:

[https://bitbucket.org/apuntesdejava/jpa-primary-key-master-detail/](https://bitbucket.org/apuntesdejava/jpa-primary-key-master-detail/)

## Social

### Twitter

>

Maestro / detalle con clave primaria compartida. Ejemplo usando [#JPA](https://twitter.com/hashtag/JPA?src=hash) 2.0 [#JavaEE7](https://twitter.com/hashtag/JavaEE7?src=hash)
Si te gusta, dale like..[https://t.co/WoKs2hNycM](https://t.co/WoKs2hNycM)

&mdash; Apuntes de Java (@apuntesdejava) [20 de mayo de 2016](https://twitter.com/apuntesdejava/status/733737146218106880)

<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### Facebook

<iframe src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FApuntesDeJava%2Fposts%2F1180545735290056&width=500" width="500" height="367" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
