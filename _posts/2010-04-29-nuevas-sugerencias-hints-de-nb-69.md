---
layout: post
title: "Nuevas sugerencias (hints) de NB 6.9"
date: 2010-04-29T21:34:00.001Z
last_modified_at: 2010-05-11T19:27:29.766Z
author: "Diego Silva"
permalink: /2010/04/nuevas-sugerencias-hints-de-nb-69.html
canonical_url: https://www.apuntesdejava.com/2010/04/nuevas-sugerencias-hints-de-nb-69.html
tags:
  - "netbeans 6.9"
  - "java"
  - "netbeans"
  - "tips"
  - "trucos"
---

He estado revisando el nuevo NetBeans 6.9 y he encontrado algunos interesantes hints.

- No concatenar en un StringBuilder/StringBuffer

- El logger debe ser final

- Parametriza el logger, no lo concatenes

### No concatenar en un StringBuilder/StringBuffer

Las reglas de rendimiento (y por definición) explica que es mejor usar la clase StringBuilder o StringBuffer para manipular cadenas que usar el mismo `java.lang.String`. ¿Por qué? Porque cada cadena es de por sí un objeto. Aún cuando se concatena, se está creando otro objeto. Y si se usa de manera indiscriminada, se puede saturar la memoria. Por tanto, es mejor usar `StringBuilder` o `StringBuffer` para concatenar, insertar, buscar, etc en una cadena. (La diferencia en ambas clases es que la primera no utiliza sincronización por lo que es más rápido el manejo de cadenas que la segunda)

Entonces... si en el NetBeans usando algo como esto:

```java
<code>       StringBuilder sb=new StringBuilder();
       String cad1="Hola",cad2="a",cad3="todos";
       sb.append(cad1);
       sb.append(" "+cad2+" "+cad3);
       sb.append("mis amigos");

</code>
```

... el IDE mostrará una sugerencia

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYTgSf052XNoYjQpbDELMfUmDLSLWto62p3TETDFhSMlkrirgy3VI3N3Z41lhrvHgqrMer4R17QkC0P4XZzw92brZx0x79d6wntpNoxZJ_Vr__ulVtr3T5-cT2u-wOAoA-J4qG48f1bIGr/s640/stringbuilder.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYTgSf052XNoYjQpbDELMfUmDLSLWto62p3TETDFhSMlkrirgy3VI3N3Z41lhrvHgqrMer4R17QkC0P4XZzw92brZx0x79d6wntpNoxZJ_Vr__ulVtr3T5-cT2u-wOAoA-J4qG48f1bIGr/s1600/stringbuilder.jpg)

 "Usar cadena de métodos .append en lugar de una concatenación de cadenas"

Hacemos clic ahí y...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiPZ-yzbtVVZwClzlWRMtxR8Y7LEK4oJqgKdoMYX8WjoIMhtIGyMrhTBwW37nsfy9MbbORcZmf_qumACaF1yjmnz7Ffb57o3DKvQ1yUcPP3EX6CdfTvNbxEGamCve7-HGtvWQxNOvnGLFBo/s640/stringbuilder2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiPZ-yzbtVVZwClzlWRMtxR8Y7LEK4oJqgKdoMYX8WjoIMhtIGyMrhTBwW37nsfy9MbbORcZmf_qumACaF1yjmnz7Ffb57o3DKvQ1yUcPP3EX6CdfTvNbxEGamCve7-HGtvWQxNOvnGLFBo/s1600/stringbuilder2.jpg)

### El logger debe ser final

La clase `java.util.Logger` debe ser usada para mostrar mensajes en la pantalla, en lugar del `System.out.println()` y `System.err.println()` Pero debe ser declarada como `final`

Antes:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgvm9txKpFgtCPGhiYx7gyrEsotu8uOq9bk6YfdLxEuosSEJBC6hSFBUgNERrqAB0o30EzmaitlbPE6ljTABrj9lx5b26MZyeG-javVqY2SXUDTrhpHY3sTV9ow-aU9Sb2g5rK-lI2KasQ/s640/logger.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgvm9txKpFgtCPGhiYx7gyrEsotu8uOq9bk6YfdLxEuosSEJBC6hSFBUgNERrqAB0o30EzmaitlbPE6ljTABrj9lx5b26MZyeG-javVqY2SXUDTrhpHY3sTV9ow-aU9Sb2g5rK-lI2KasQ/s1600/logger.jpg)

Después:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjMSdW-KyuVX9ipTFNPTAjftbk790NbkF3rXsATzFRXQ92s1g5p1iAHIshDcuNNsMeo7kLeGH17JqHUm9X95W5Se_Qj2beK6ivRpByWfBWRgJyKIAxHxXFUCLPdfmeXdKMmL75TOcOmmxav/s640/logger2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjMSdW-KyuVX9ipTFNPTAjftbk790NbkF3rXsATzFRXQ92s1g5p1iAHIshDcuNNsMeo7kLeGH17JqHUm9X95W5Se_Qj2beK6ivRpByWfBWRgJyKIAxHxXFUCLPdfmeXdKMmL75TOcOmmxav/s1600/logger2.jpg)

### Parametriza el logger, no lo concatenes

Por costumbre tendemos a concatenar todo lo que se desea mostrar en la consola. Ya que no vamos a usar el `System.out.println()`, entonces concatenariamos en el logger? Veamos lo que nos dice el NetBeans:

Antes:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFbPigxuCRx9BPKoQiB5WiQJhltG_xiEMJ_Zk2ixK-ZfFANLux63pzax2ZTSzcPbVZ_zBuI8EmzSepd3xmY4haZnBfmIwupMM9ANl9MMaEalfw3z4SX__7lFTYCWdUu8J_Z5gudHFMS0eW/s640/logger3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFbPigxuCRx9BPKoQiB5WiQJhltG_xiEMJ_Zk2ixK-ZfFANLux63pzax2ZTSzcPbVZ_zBuI8EmzSepd3xmY4haZnBfmIwupMM9ANl9MMaEalfw3z4SX__7lFTYCWdUu8J_Z5gudHFMS0eW/s1600/logger3.jpg)

Después:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEie7h9aJjnO6YYdKmYGfK3F6Xt4orIVDeIpg4MU28YLCllzFvyUtxsumurC6S5gqDFCZMNFMAZ1SxaNKrKa2mgv5UC9pr3aHaTbJt86bF6ghZhuzH3xubxWct4_xXjbKLt_gRMNeg2L86dg/s640/logger4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEie7h9aJjnO6YYdKmYGfK3F6Xt4orIVDeIpg4MU28YLCllzFvyUtxsumurC6S5gqDFCZMNFMAZ1SxaNKrKa2mgv5UC9pr3aHaTbJt86bF6ghZhuzH3xubxWct4_xXjbKLt_gRMNeg2L86dg/s1600/logger4.jpg)

Más legible, no?

Hay muchos hints más. Lo puedes desactivar o no. Y estos se encuentran en Tools > Options, bajo el ficha Editor > Hints

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOAfS_xnzSNust6Tgih3-QG7u6V0XkiGXEqO7d3v5CF0J3V3dtoV4IX6v0lNkUZfgsNrAjFpPCq3UEN9CvHJbp7zRoStzZ30vMszCUQErrrO3OW5pgKtPjaj-SLAwgHbU8rEQVLFbaf3Eg/s400/hints.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOAfS_xnzSNust6Tgih3-QG7u6V0XkiGXEqO7d3v5CF0J3V3dtoV4IX6v0lNkUZfgsNrAjFpPCq3UEN9CvHJbp7zRoStzZ30vMszCUQErrrO3OW5pgKtPjaj-SLAwgHbU8rEQVLFbaf3Eg/s1600/hints.jpg)
