---
layout: post
title: "Jakarta EE 9 Essentials Archetype"
date: 2022-06-21T17:20:00Z
last_modified_at: 2022-06-21T17:20:02.806Z
author: "Diego Silva Límaco"
permalink: /2022/06/jakarta-ee-9-essentials-archetype.html
canonical_url: https://www.apuntesdejava.com/2022/06/jakarta-ee-9-essentials-archetype.html
description: "Acabo de publicar mi primer arquetipo a Maven 🎉🎉🎉"
tags:
  - "jakarta ee"
  - "maven"
---

[![](https://docs.google.com/drawings/d/e/2PACX-1vS1F3QuggZKhp8qj29lsYOUekW-qyBq7u3tB09LNAOMtH1oZSeoUwYRmdNopMHv1WqQiiMgutD485fB/pub?w=1440&h=810)](https://docs.google.com/drawings/d/e/2PACX-1vS1F3QuggZKhp8qj29lsYOUekW-qyBq7u3tB09LNAOMtH1oZSeoUwYRmdNopMHv1WqQiiMgutD485fB/pub?w=1440&h=810)

Acabo de publicar mi primer arquetipo a Maven 🎉🎉🎉

Se llama "Jakarta EE 9 Essentials Archetype".

Permite crear un proyecto básico con las mínimas dependencias, compatible para cualquier servidor Jakarta EE 9. Tiene una nada de dependencias y de plugins, solo lo necesario para que se construya una aplicación Jakarta EE.

- El sitio web del proyecto:[https://apuntesdejava.github.io/jakartaee9-essentials-archetype/](https://apuntesdejava.github.io/jakartaee9-essentials-archetype/)
- Detalles del arquetipo en el repositorio central: [https://search.maven.org/artifact/com.apuntesdejava/jakartaee9-essentials/0.1/maven-archetype](https://search.maven.org/artifact/com.apuntesdejava/jakartaee9-essentials/0.1/maven-archetype)

## Modo de uso

Para crear un proyecto basta con ejecutar el siguiente comando desde la consola desde una carpeta / directorio en blanco:

```java
mvn -DarchetypeGroupId=com.apuntesdejava \
    -DarchetypeArtifactId=jakartaee9-essentials \
    org.apache.maven.plugins:maven-archetype-plugin:generate
```

Si se ejecuta así, el maven preguntará por el nombre el grupo, del artefacto y del paquete del proyecto a crear.

### Con NetBeans

[![]({{ '/assets/blogger/netbeans64_srJ03Cnr1E.png' | relative_url }})]({{ '/assets/blogger/netbeans64_srJ03Cnr1E.png' | relative_url }})

#### Con IntelliJ

[![]({{ '/assets/blogger/idea64_esKasRmecl.png' | relative_url }})]({{ '/assets/blogger/idea64_esKasRmecl.png' | relative_url }})

#### Con Visual Studio Code

[![]({{ '/assets/blogger/Code_Gv6ZcUBr8u.png' | relative_url }})]({{ '/assets/blogger/Code_Gv6ZcUBr8u.png' | relative_url }})

#### Con Eclipse IDE

[![]({{ '/assets/blogger/eclipse_Ol3tG84h4x.png' | relative_url }})]({{ '/assets/blogger/eclipse_Ol3tG84h4x.png' | relative_url }})

## Motivación

En principio, porque cuando creaba un proyecto Jakarta EE usando algún IDE, éste me creaba con muchas dependencias y plugins.

Otra motivación es porque este proyecto es un anticipo de otro **proyecto que estamos desarrollando**. Ya lo estaré compartiendo por este medio y por las redes.
