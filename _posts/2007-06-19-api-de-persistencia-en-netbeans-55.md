---
layout: post
title: "API de Persistencia en NetBeans 5.5"
date: 2007-06-19T23:08:00Z
last_modified_at: 2009-04-25T22:07:33.883Z
author: "Diego Silva"
permalink: /2007/06/api-de-persistencia-en-netbeans-55.html
canonical_url: https://www.apuntesdejava.com/2007/06/api-de-persistencia-en-netbeans-55.html
tags:
  - "java ee"
  - "jpa"
  - "java"
  - "netbeans"
  - "tutorial"
---

El artículo que traduje "[Usando el API de persistencia en aplicaciones de escritorio (Introducción)]({{ '/2007/06/usando-el-api-de-persistencia-en.html' | relative_url }})" ahora pasará a la práctica usando NetBeans 5.5

Pues comenzamos por crear un nuevo proyecto llamado Persistence.  Luego, crearemos la unidad de persistencia entrando a New | File dentro de la categoría Persistence.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj62kCRS3zwFPuhViEM65qBuh23DXc5HeEJYR-Hncs8pkOasrWJFcmeD02fG5HrHo5huC3bOClZRkyz8DjyMQvH1PqM2Z-A2fNj8ggaEW96tSTtP7gwx-8nMZR4afqfV3xYCe2SsFkkxims/s320/persistence-00.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj62kCRS3zwFPuhViEM65qBuh23DXc5HeEJYR-Hncs8pkOasrWJFcmeD02fG5HrHo5huC3bOClZRkyz8DjyMQvH1PqM2Z-A2fNj8ggaEW96tSTtP7gwx-8nMZR4afqfV3xYCe2SsFkkxims/s1600-h/persistence-00.jpg)Definiremos el nombre de la unidad de persistencia (por omisión usaremos el nombre propuesto: PersistencePU). Recordemos que es una buena práctica utilizar el mismo nombre de la base de datos, aunque no necesariamente tengan que ser los nombres. Para la conexión de base de datos, crearemos uno nuevo:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjabPd5TNC0MArTduI_DTZ-X7gNUmN7OZ-fAt5cyViUZNfQN_HzUm8s93HUCpABDoij82Jsxx57h3J-Pn2s4f4RKjsdYf6mLeVanj8ErKNLqI87aBUxAO3jouTBKq4uKsQnBL2W4codSrjd/s320/persistence-01.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjabPd5TNC0MArTduI_DTZ-X7gNUmN7OZ-fAt5cyViUZNfQN_HzUm8s93HUCpABDoij82Jsxx57h3J-Pn2s4f4RKjsdYf6mLeVanj8ErKNLqI87aBUxAO3jouTBKq4uKsQnBL2W4codSrjd/s1600-h/persistence-01.jpg)Podemos usar cualquier base de datos. Naturalmente debemos contar con el driver para el JDBC. Yo utilizaré el Firebird, por tanto los valores de la conexión a la base de datos son como sigue:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdWBBV-dGlvRI1Rut3JEY4Ir1a3K6NVCIdVsSU5zXLaotK7zHHKFEUdmNiSh-CTQe9PmGHtW7tdJDUyOGNu-qBIGJij7r_HpE9QyTUJ43Z_xZxQ73H8mGYEO8nOOmZFburG-l3BL3bp310/s320/persistence-02.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdWBBV-dGlvRI1Rut3JEY4Ir1a3K6NVCIdVsSU5zXLaotK7zHHKFEUdmNiSh-CTQe9PmGHtW7tdJDUyOGNu-qBIGJij7r_HpE9QyTUJ43Z_xZxQ73H8mGYEO8nOOmZFburG-l3BL3bp310/s1600-h/persistence-02.jpg)
Ahora vemos que creó el archivo persistence.xml dentro de META-INF, además ya tiene los valores de la plantilla como se mencionó en el artículo:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1IBzUMqD-mJK2ANQJ0cygWVlW15bz5UCbCwpwmLg8mVzYEwW3PQ3HZl8QU8KtsRa4lyhdQbeV9dWqu2X3EVrMYcwp1G2fbQ8D7V6p-24hBZLnLn1QznnzSCpPLccjHCZczQhoU0lG_SGm/s320/persistence-03.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1IBzUMqD-mJK2ANQJ0cygWVlW15bz5UCbCwpwmLg8mVzYEwW3PQ3HZl8QU8KtsRa4lyhdQbeV9dWqu2X3EVrMYcwp1G2fbQ8D7V6p-24hBZLnLn1QznnzSCpPLccjHCZczQhoU0lG_SGm/s1600-h/persistence-03.jpg)

Ahora, entraremos a New | File para crear una clase Entidad.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbl62DwDGcrqOGXyLUs1HMve3LK48bIl3HyB5HtSJX9hwu8tQw6Ah2Cm8WM4JreF8OCM9clnenQ9vPVFC53z-B8G6GSYfn5SqyZQmXsqaMdHsGqiPJKkb3lXXjULUKtJi5lf7ehrKAsOja/s320/persistence-0.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbl62DwDGcrqOGXyLUs1HMve3LK48bIl3HyB5HtSJX9hwu8tQw6Ah2Cm8WM4JreF8OCM9clnenQ9vPVFC53z-B8G6GSYfn5SqyZQmXsqaMdHsGqiPJKkb3lXXjULUKtJi5lf7ehrKAsOja/s1600-h/persistence-0.jpg)
Para seguir con las clases mencionadas en el artículo, crearemos la clase Player:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhSDzoU2_UuaLjG-h3DzbsmYia1DbxCT-iVomgJAQzsTNs8Jrvwo8TvnL-BlgVtEvG7QVcJa16a18ERbvhyE9WZI-Q_NDTxH77AwZT5wVs9qG8E-ZbitFycnG6p-Ny3gLAwr9fm1_p70nHA/s320/persistence-11.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhSDzoU2_UuaLjG-h3DzbsmYia1DbxCT-iVomgJAQzsTNs8Jrvwo8TvnL-BlgVtEvG7QVcJa16a18ERbvhyE9WZI-Q_NDTxH77AwZT5wVs9qG8E-ZbitFycnG6p-Ny3gLAwr9fm1_p70nHA/s1600-h/persistence-11.jpg)

A la clase creada, le agregamos las siguientes líneas

```java
<code>    private String  lastName;<br />private String  firstName;<br />private int     jerseyNumber;<br />@Transient<br />private String  lastSpokenWords;<br /><br />public String getLastName() {<br />return lastName;<br />}<br /><br />public void setLastName(String lastName) {<br />this.lastName = lastName;<br />}<br /><br />public String getFirstName() {<br />return firstName;<br />}<br /><br />public void setFirstName(String firstName) {<br />this.firstName = firstName;<br />}<br /><br />public int getJerseyNumber() {<br />return jerseyNumber;<br />}<br /><br />public void setJerseyNumber(int jerseyNumber) {<br />this.jerseyNumber = jerseyNumber;<br />}<br />public String getLastSpokenWords() {<br />return lastSpokenWords;<br />}<br /><br />public void setLastSpokenWords(String lastSpokenWords) {<br />this.lastSpokenWords = lastSpokenWords;<br />}<br /></code>
```

Podemos agregar mas anotaciones como se mencionó en el artículo.
Crearemos también la clase entidad  Team y agregamos los siguientes campos

```java
<code>    private String teamName;<br />private String division;<br />private Collection<Player> players;<br /><br /></code>
```

Lo interesante es este punto es que Netbeans encuentra la referencia con la clase Player, y nos propone hacer una asociación muchos-a-uno o uno-a-muchos:
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpsnnXNhOrP3YsknAqg610yG1U0VyKLQ_XaoVdj_ZxUcp_lg5o333aYSjvuXRE22_ceBVO1XnnpFSndjynaRd5FQPZf1psLcjRtjQ39rehQh_vwOy7iQusZplLKWALYtcLfuUqDuqiXXpg/s320/persistence-12.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhpsnnXNhOrP3YsknAqg610yG1U0VyKLQ_XaoVdj_ZxUcp_lg5o333aYSjvuXRE22_ceBVO1XnnpFSndjynaRd5FQPZf1psLcjRtjQ39rehQh_vwOy7iQusZplLKWALYtcLfuUqDuqiXXpg/s1600-h/persistence-12.jpg)Así que seleccionaremos la opción bidireccional uno-a-muchos. Al hacer esto, el NetBeans no dirá que creará un nuevo campo para la relación en la base de datos, y la propiedad respectiva en la clase Player.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO2IONYvK2QAfBrnc80fBPtFYeceb02up56fjXZpS9OgVtugYaFgrQL9jgIQ8Nvg0W9F9YfmFUYudcfKBmya5K4AU9qn3s6AABbrDR_EwSRNAE2uU3pxZ_j4i4kAXohgjFkf5CTTYPwe3b/s320/persistence-13.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhO2IONYvK2QAfBrnc80fBPtFYeceb02up56fjXZpS9OgVtugYaFgrQL9jgIQ8Nvg0W9F9YfmFUYudcfKBmya5K4AU9qn3s6AABbrDR_EwSRNAE2uU3pxZ_j4i4kAXohgjFkf5CTTYPwe3b/s1600-h/persistence-13.jpg)Podemos crear los campos de la clase y dejar que el Netbeans cree los métodos set & get de ellos. Entramos a Refactor | Encapsulated fields...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdcl34ow1acslm51qicCLZL83tzFubMtAdf2VjXcIlR9-Oe183QoWmhaMImgHOyy8S0unczeH8rxgTc770hCa8x9HAUgyLZh26Px70M28n09q4HGEx4Khz-T601Z0eJl9UujP235THeuy0/s320/persistence-14.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjdcl34ow1acslm51qicCLZL83tzFubMtAdf2VjXcIlR9-Oe183QoWmhaMImgHOyy8S0unczeH8rxgTc770hCa8x9HAUgyLZh26Px70M28n09q4HGEx4Khz-T601Z0eJl9UujP235THeuy0/s1600-h/persistence-14.jpg)
Ahora, usaremos la persistencia. Para ello crearemos una clase Main que tendrá el método main(). Luego hacemos clic derecho sobre el código y seleccionamos Persistence | Use Entity Manager

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiLP07EI0vlzDgL4nwm5iwmKbbsBrJeNE3W4bW_dXqb9Y7b838SXeGL2zBnt5mcAkd-EXuCgdIXgwcym0gROCRVyEb07r56VusGmC1g3cjftWGh03HvMFzyodgJL2a41F5XU7P0NC-HOzvc/s320/persistence-20.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiLP07EI0vlzDgL4nwm5iwmKbbsBrJeNE3W4bW_dXqb9Y7b838SXeGL2zBnt5mcAkd-EXuCgdIXgwcym0gROCRVyEb07r56VusGmC1g3cjftWGh03HvMFzyodgJL2a41F5XU7P0NC-HOzvc/s1600-h/persistence-20.jpg)
Y vemos que crea una propiedad estática que accede a la unidad de persistencia:

```java
<code>private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("PersistencePU");<br /></code>
```

Además, nos muestra un ejemplo de cómo acceder a la persistencia.
Por tanto, haremos un simple ejemplo de guardar en la base de datos:

```java
<code>    private void guardar() {<br />EntityManager em = emf.createEntityManager();<br />em.getTransaction().begin();<br />try {<br />Team[] teams =new Team[] {<br /> new Team("Los Angeles Dodgers", "National"),<br /> new Team("San Francisco Giants", "National"),<br /> new Team("Anaheim Angels", "American"),<br /> new Team("Boston Red Sox", "American")<br />};<br /><br />Player[] players = new Player[] {<br /> // name, number, last quoted statement<br /> new Player("Lowe", "Derek", 23, "The sinker's been good to me."),<br /> new Player("Kent", "Jeff", 12, "I wish I could run faster."),<br /> new Player("Garciaparra", "Nomar", 5,"No, I'm not superstitious at all.")};<br /><br />for(Team team: teams) {<br /> em.persist(team);<br />}<br /><br /><br />for(Player player:players){<br /> player.setTeam(teams[0]);<br /> teams[0].addPlayer(player);<br /> em.persist(player);<br />}<br /><br /><br />em.getTransaction().commit();<br />} catch (Exception e) {<br />e.printStackTrace();<br />em.getTransaction().rollback();<br />} finally {<br />em.close();<br />}<br />}<br /></code>
```

No olvidar agregar el .jar correspondiente para la base de datos dentro del proyecto.
Ejecutamos el proyecto con F6.. y listo, veamos la base de datos qué registro.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgUFpsrHSJn8d0JSLQhfa_UAuxf8QUSUhCt_kw9m-TVzYAHHGkNbHBy-lmNpCbvnI-yJsdm-i8Ql4GWuOJKh29M2iyAjyFRRqnBi8SLSmHiOmochsjlhIFBYdB8ItHTWTgxF6yZSn6NEwBV/s320/persistence-21.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgUFpsrHSJn8d0JSLQhfa_UAuxf8QUSUhCt_kw9m-TVzYAHHGkNbHBy-lmNpCbvnI-yJsdm-i8Ql4GWuOJKh29M2iyAjyFRRqnBi8SLSmHiOmochsjlhIFBYdB8ItHTWTgxF6yZSn6NEwBV/s1600-h/persistence-21.jpg)[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHc5eFrO5ghN69iPwHbIUftQye2KPII6ALmthdXxS3pDJt64SZluSDBt0uhYMUnvvIUiVDLsdJQI_cMI4zmtSQusBXegIvrXVW64hb0O7KtnaWi22TlLbnRVpne4bRUh_Q5PWznlD7croK/s320/persistence-22.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHc5eFrO5ghN69iPwHbIUftQye2KPII6ALmthdXxS3pDJt64SZluSDBt0uhYMUnvvIUiVDLsdJQI_cMI4zmtSQusBXegIvrXVW64hb0O7KtnaWi22TlLbnRVpne4bRUh_Q5PWznlD7croK/s1600-h/persistence-22.jpg)
Vemos que también creó una tabla llamada SEQUENCE. Pues bien, como los campos autonuméricos no son estándar en todos los motores de base de datos, el API de persistencia crea una tabla que le permitirá crear un nuevo rango de valores para los campos autonuméricos.

#### Recuperando registros

¿De qué sirve una solución de persistencia de datos que permita grabar datos si no se pueden recuperar?

El API de persistencia de Java permite obtener registros a través del id del registro:

```java
<code>Player p=em.find(Player.class,55L);<br />Team t=em.find(Team.class,52L);<br /></code>
```

... u obtener una lista

```java
<code>Query query=em.createQuery("select c from Player c");<br />List<Player> lista=query.getResultList();<br /><br /></code>
```

... y qué mejor que una lista filtrada

```java
<code>Query query=em.createQuery("select c from Player c where c.team.id=51");<br />List<Player> lista=query.getResultList();<br /></code>
```

Hay mucho que revisar en la documentación de Java respecto al [API de persistencia](http://java.sun.com/javaee/5/docs/api/javax/persistence/package-summary.html). Así que ya no hay excusas para reducir el código de acceso a la base de datos.

#### Recursos

Aquí está el [proyecto ejemplo](http://diesil-java.googlecode.com/files/persistence.tar.gz) que usé.
