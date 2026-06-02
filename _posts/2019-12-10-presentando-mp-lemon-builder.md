---
layout: post
title: "Presentando MP Lemon Builder"
date: 2019-12-10T18:45:00.001Z
last_modified_at: 2019-12-10T19:01:18.011Z
author: "Diego Silva Límaco"
permalink: /2019/12/presentando-mp-lemon-builder.html
canonical_url: https://www.apuntesdejava.com/2019/12/presentando-mp-lemon-builder.html
description: "Es un generador de proyectos MP (MicroProfile), y en esta primera versión permite crear una aplicación asegurada con JWT. La autenticación utilizará el realm del servidor (en esta primera versión utiliza a Payara) y la validación de los roles lo hará utilizando el estándar de JakartaEE."
tags:
  - "microprofile"
  - "seguridad"
  - "payara"
  - "jwt"
  - "jakarta ee"
---

Aquí les presento la primera versión de mi aplicación [MP Lemon Builder](https://github.com/apuntesdejava/mp-lemon-builder).

### ¿En qué consiste?

Es un generador de proyectos MP (MicroProfile), y en esta primera versión permite crear una aplicación asegurada con JWT. La autenticación utilizará el realm del servidor (en esta primera versión utiliza a Payara) y la validación de los roles lo hará utilizando el estándar de JakartaEE.

Aquí muestro un vídeo de cómo funciona.

<iframe allowfullscreen="" frameborder="0" height="270" src="https://www.youtube.com/embed/AafDYt4uF0M" width="480"></iframe>

### Fuentes

Esta aplicación está basada en dos proyectos:

- La publicación de Victor Orozco: [A simple MicroProfile JWT token provider with Payara realms and JAX-RS](https://vorozco.com/blog/2019/2019-10-02-MicroProfile-JWT-Token-Provider-Servlet.html)

- [JWT dispenser](http://jwtenizr.sh/) de [Adam Bien](http://www.adam-bien.com/roller/abien/entry/authentication_and_authorization_with_jwt).

### ¿Por qué "Lemon"?

Porque me gustan las frutas, y el limón es una de mis preferidas.

[![](https://i.imgflip.com/3gdg6k.gif)](https://imgflip.com/gif/3gdg6k)
