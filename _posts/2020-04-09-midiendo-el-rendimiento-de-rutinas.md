---
layout: post
title: "Midiendo el rendimiento de rutinas"
date: 2020-04-10T03:35:00.005Z
last_modified_at: 2022-01-27T21:09:09.190Z
author: "Diego Silva Límaco"
permalink: /2020/04/midiendo-el-rendimiento-de-rutinas.html
canonical_url: https://www.apuntesdejava.com/2020/04/midiendo-el-rendimiento-de-rutinas.html
description: "Mediremos el rendimiento de algunas rutinas que utilizamos ¿Cuál es la más rápida?"
tags:
  - "rendimiento"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vSwgB10eTI90vEFdB4aQHmnnaGy324JzXQRIuSylrrUHgZfhe7tyIy-eHyGcG2usHkXfm9erpNmKj1-/pub?w=960&h=540)](https://docs.google.com/drawings/d/e/2PACX-1vSwgB10eTI90vEFdB4aQHmnnaGy324JzXQRIuSylrrUHgZfhe7tyIy-eHyGcG2usHkXfm9erpNmKj1-/pub?w=960&h=540)

Estos días me ha tocado revisar código hecho por otros, y encontré un par de rutinas que me parecieron interesantes para revisar. Estas las publiqué en la cuenta de twitter:

>

[#CodeReviewChallenge](https://twitter.com/hashtag/CodeReviewChallenge?src=hash&ref_src=twsrc%5Etfw)

A ver, cómo optimizarían este código (que encontré)? [pic.twitter.com/PUWZy0erpG](https://t.co/PUWZy0erpG)

— ☕ Apuntes de Java ☕ 😷🏠 (@apuntesdejava) [April 6, 2020](https://twitter.com/apuntesdejava/status/1247284131513470982?ref_src=twsrc%5Etfw)

 <script async="" charset="utf-8" src="https://platform.twitter.com/widgets.js"></script>

>

[#CodeReviewChallenge](https://twitter.com/hashtag/CodeReviewChallenge?src=hash&ref_src=twsrc%5Etfw) [#QuedateEnCasa](https://twitter.com/hashtag/QuedateEnCasa?src=hash&ref_src=twsrc%5Etfw) [#StayHome](https://twitter.com/hashtag/StayHome?src=hash&ref_src=twsrc%5Etfw)
¿Cómo simplificarían el contenido de este método? (sin usar bibliotecas adicionales) [pic.twitter.com/rfRn8Qb2Ga](https://t.co/rfRn8Qb2Ga)

— ☕ Apuntes de Java ☕ 😷🏠 (@apuntesdejava) [April 7, 2020](https://twitter.com/apuntesdejava/status/1247565151219351559?ref_src=twsrc%5Etfw)

 <script async="" charset="utf-8" src="https://platform.twitter.com/widgets.js"></script>

He recibido respuestas interesantes.

Lo que publicaré en este post y en un vídeo es ver cuál es la rutina más rápida, en base a sus respuestas.

## Validando que una lista no esté vacía

He creado una clase `Utils` con tres métodos que validará que una lista no esté vacía. La primera es la manera como encontré en el código, la segunda y la tercera es usando sus respuestas.

```java
public static boolean isValidListIf(List<?> list) {
        if (list != null) {
            if (list.size() > 0) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public static boolean isValidListInline(List<?> list) {
        return list != null && !list.isEmpty();
    }

    public static boolean isValidListOptional(List<?> list) {
        return Optional.ofNullable(list).map((l) -> !l.isEmpty()).orElse(Boolean.FALSE);
    }
```

¿Cuál cree que es más rápido?

## Validando que una cadena no esté vacía

Esta también es similar, solo que se asegura que no tenga espacios en blanco. Igual, tendremos tres métodos:

```java
public static boolean isValidStringIf(String str) {
        if (str != null) {
            if (str.trim().length() > 0) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public static boolean isValidStringInLine(String str) {
        return str != null && !str.trim().isEmpty();
    }

    public static boolean isValidStringOption(String str) {
        return Optional.ofNullable(str).map(s -> !s.trim().isEmpty()).orElse(Boolean.FALSE);
    }
```

## Vídeo

Aquí veremos el código en ejecución y veremos el resultado, además daremos un veredicto ¿cuál crees que es el resultado?

<iframe allowfullscreen="" class="BLOG_video_class" height="270" src="https://www.youtube.com/embed/3VMdCflryiY" width="480" youtube-src-id="3VMdCflryiY"></iframe>

## Código fuente

Aquí publico el código fuente para que también lo intentes y pruebas en tu máquina:

[https://github.com/apuntesdejava/test-performance/](https://github.com/apuntesdejava/test-performance/)
