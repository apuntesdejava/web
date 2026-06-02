---
layout: post
title: "Liferay 7.2. Service Layer - Consultas personalizadas"
date: 2019-12-10T22:51:00Z
last_modified_at: 2019-12-10T22:58:15.040Z
author: "Diego Silva Límaco"
permalink: /2019/12/liferay-72-service-layer-consultas.html
canonical_url: https://www.apuntesdejava.com/2019/12/liferay-72-service-layer-consultas.html
description: "Hasta el momento hemos creado consultas simples, como listar todos los registros con un campo u otro campo iguales.    Pero necesitamos que nuestros registros puedan ser leídos con cualquier combinación de los cambios."
tags:
  - "liferay"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSLY-6cWrne9MeYlKSeIBIekbN77ZfwWb-Lw4JnQSKq8dtwW2Kz2tVo89LCn-tP2T2FsikQ8fEyOp91/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vSLY-6cWrne9MeYlKSeIBIekbN77ZfwWb-Lw4JnQSKq8dtwW2Kz2tVo89LCn-tP2T2FsikQ8fEyOp91/pub?w=1440&h=810)

Hasta el momento hemos creado consultas simples, como listar todos los registros con un campo u otro campo iguales.

Pero necesitamos que nuestros registros puedan ser leídos con cualquier combinación de los cambios.

El Service Layer nos cubre grandes funcionalidades con las características básicas del CRUD. Además, podemos agregar otros tipos de consultas. Estos tipos de consulta se llama `DynamicQuery`, y es lo que veremos en este post.

La implementación es bastante simple, y se hace en la clase --LocalServiceImpl

```java
//...
public List<Course> findByKeywords(long groupId,String keywords, int start, int end, OrderByComparator<Course> orderByComparator){
  DynamicQuery query = dynamicQuery() //crea la consulta...
    .add(RestrictionsFactoryUtil.eq("groupId", groupId)); // que groupId = al parametro...
  if (Validator.isNotNull(keywords)) {
     Junction disjunction = RestrictionsFactoryUtil.disjunction() //crea el OR...
        .add(
            RestrictionsFactoryUtil.like("name",'%'+ keywords+'%') //... con name como el keyword...
        ).add(
            RestrictionsFactoryUtil.like("description",'%'+ keywords+'%') //... o en description
        );
     query.add(disjunction); //... y lo agrega al AND del where.
  }
  return dynamicQuery(query, start, end, orderByComparator); //... termina ejecutando toda la consulta
}
```

Luce muy parecido al API de JPA 2.x: creando una consulta, y agregando las condiciones a medida que se van encontrando.

Usar un API así para crear las consultas considero que es la mejor manera, y así evitar construir una cadena SQL con todos los parámetros "dinámicos" que hasta puede causar confusión.

**NO OLVIDAR: Hacer build service y refresh project para que surtan efectos los cambios.**

### El vídeo

Aquí un vídeo de la implementación, además de otras características más a considerar a nuestro proyecto.

<iframe allowfullscreen="allowFullScreen" allowtransparency="true" frameborder="0" height="315" src="https://www.youtube.com/embed/tfXnlPcb6xw?ecver=1&amp;iv_load_policy=1&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;width=560&amp;width=560" width="560"><div>
<a id=4PQsRrZZ href="https://www.codeguesser.co.uk/wickes.co.uk ">here</a></div>
<div>
<a id=4PQsRrZZ href="https://www.codeguesser.co.uk/boden.co.uk ">Codeguesser Boden page here</a></div>
<script>function execute_YTvideo(){return youtube.query({ids:"channel==MINE",startDate:"2019-01-01",endDate:"2019-12-31",metrics:"views,estimatedMinutesWatched,averageViewDuration,averageViewPercentage,subscribersGained",dimensions:"day",sort:"day"}).then(function(e){},function(e){console.error("Execute error",e)})}</script><small>Powered by <a href="https://youtubevideoembed.com/ ">Embed YouTube Video</a></small></iframe>

### Código fuente

Aquí está el código fuente (hasta el tema de este post):

- En Github: [https://github.com/apuntesdejava/liferay-virtual-classroom/releases/tag/dinamic-query](https://github.com/apuntesdejava/liferay-virtual-classroom/releases/tag/dinamic-query)

- En Bitbucket: [https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/commits/tag/dinamic-query](https://bitbucket.org/apuntesdejava/liferay-virtual-classroom/commits/tag/dinamic-query)
