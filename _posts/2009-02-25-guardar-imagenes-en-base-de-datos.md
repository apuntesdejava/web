---
layout: post
title: "Guardar imágenes en base de datos usando JPA"
date: 2009-02-25T05:14:00.003Z
last_modified_at: 2018-09-25T15:07:48.750Z
author: "Diego Silva"
permalink: /2009/02/guardar-imagenes-en-base-de-datos.html
canonical_url: https://www.apuntesdejava.com/2009/02/guardar-imagenes-en-base-de-datos.html
tags:
  - "jpa"
  - "swing"
  - "java"
  - "tips"
---

Hay infinidad de ejemplos de cómo guardar una imagen a  base de datos con JDBC, y cómo recuperarla.

Pues esta vez mostraré un ejemplo usando JPA.

Supongamos que nuestra clase entidad tiene una propiedad llamada `imagen` que es donde se guardará la imagen. Esta propiedad debe declararse  así:

```java
@Lob
@Column(name = "imagen")
private byte[] imagen;
```

Para guardar una imagen (supongamos una que esté en el disco), debemos realizar lo siguiente:

```java
Entidad i = new Entidad(); // nuestra entidad
File f = new File("D:/Imagen006.jpg"); //asociamos el archivo fisico
InputStream is = new FileInputStream(f); //lo abrimos. Lo importante es que sea un InputStream
byte[] buffer = new byte[(int) f.length()]; //creamos el buffer
int readers = is.read(buffer); //leemos el archivo al buffer
i.setImagen(buffer); //lo guardamos en la entidad
em.persist(i); //y lo colocamos en el EntityManager
```

Ahora, para recuperar el contenido haremos que se muestre el contenido en un JFrame:

```java
Entidad ent = em.find(Entidad.class, new Integer(1)); //ubicamos una entidad
Image image=new ToolkitImage(new ByteArrayImageSource(ent.getImagen())); //lo convertimos a Image
JLabel label=new JLabel(new ImageIcon(image)); //creamos un JLabel con la imagen como icono
JFrame frame=new JFrame("imagen"); //creamos el jframe
frame.setLayout(new BorderLayout()); //.. con un Layout clasico
frame.add(label,BorderLayout.CENTER); //.. agregamos el JLabel en el centro
frame.pack();
frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
frame.setVisible(true); //y lo mostramos
```

Después haré un ejemplo usando JTable, y - si puedo - usando ICEfaces.
