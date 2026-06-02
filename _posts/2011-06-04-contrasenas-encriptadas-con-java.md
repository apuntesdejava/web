---
layout: post
title: "Contraseñas encriptadas con Java"
date: 2011-06-04T22:27:00Z
last_modified_at: 2011-06-04T22:27:06.567Z
author: "Diego Silva Límaco"
permalink: /2011/06/contrasenas-encriptadas-con-java.html
canonical_url: https://www.apuntesdejava.com/2011/06/contrasenas-encriptadas-con-java.html
tags:
  - "apache"
  - "java"
  - "seguridad"
  - "commons"
---

[![]({{ '/assets/blogger/encryption.jpg' | relative_url }})]({{ '/assets/blogger/encryption.jpg' | relative_url }})

¿Quién no ha querido encriptar texto o archivo? Hay diversas maneras para hacer eso, por ejemplo, utilizando un diccionario donde se reemplazara cada caracter por un código.. y para poder desencriptarlo se debería utilizar el mismo diccionario para revertir el proceso. Pero si el diccionario cae en manos de alguien que no queremos que lo sepa, entonces estamos en peligro.

Cuando yo programaba en pascal, mi encriptación favorita era invirtiendo los bits... pero cualquiera también puede invertir los bits y listo.

Pero ya gente experta logró algoritmos de encriptación populares. Los más conocidos: MD5 y SHA.

En este post hablaremos cómo encriptar texto, sobretodo las contraseñas, utilizando MD5 o SHA.

La historia de la [criptografía](http://es.wikipedia.org/wiki/Criptograf%C3%ADa)es bastante larga e interesante, pero para nuestro día a día, solo necesitamos cómo utilizar las bibliotecas existentes en el mercado.

Hace un tiempo, hice un post de ello ([MD5 en Java]({{ '/2009/03/md5-en-java.html' | relative_url }})) que consistía en utilizar el mismo API de Java para generar MD5.Pero ahora mostraré una biblioteca muy útil proporcionada por la fundación [ASF](http://apache.org/).

## Commons Codec

Podemos descargar su biblioteca desde aquí [http://commons.apache.org/codec/download_codec.cgi](http://commons.apache.org/codec/download_codec.cgi)

Descomprimimos el archivo y tomamos el .jar llamado `commons-codec-1.5.jar` y lo agregamos al proyecto. En NetBeans solo le damos clic derecho en `Libraries` del Proyecto y seleccionamos el .jar.

[![]({{ '/assets/blogger/biblio-jar.jpg' | relative_url }})]({{ '/assets/blogger/biblio-jar.jpg' | relative_url }})

La clase [DigestUtils](http://commons.apache.org/codec/apidocs/org/apache/commons/codec/digest/DigestUtils.html) es nuestra clase principal para utilizar los diferentes algoritmos de encriptación.

### MD5

```java
<code>        String texto="Saludos desde Apuntesdejava.com";
        String encriptMD5=DigestUtils.md5Hex(texto);
        System.out.println("md5:"+encriptMD5);
</code>
```

La salida resultante es:

```java
<code>md5:e5adf3f9fe476c7816eacd3873f5b51f</code>
```

Para comprobarlo, yo utilizo la consola de MySQL

[![]({{ '/assets/blogger/md5-mysql.png' | relative_url }})]({{ '/assets/blogger/md5-mysql.png' | relative_url }})

### SHA-HEX

Similar al MD5, solo es otro método

```java
<code>        String texto="Saludos desde Apuntesdejava.com";
        String encript=DigestUtils.shaHex(texto);
        System.out.println("shaHex:"+encript);
</code>
```

La salida resultante es:

```java
<code>shaHex:2b05363b154309d7fc069cd922f316fa3f3ff866</code>
```

Y en MySQL:

[![]({{ '/assets/blogger/sha-mysql.jpg' | relative_url }})]({{ '/assets/blogger/sha-mysql.jpg' | relative_url }})

### SHA-256 / 512

Para el SHA 256 se utiliza el método [DigestUtils.sha256](http://commons.apache.org/codec/apidocs/org/apache/commons/codec/digest/DigestUtils.html#sha256%28java.lang.String%29), y para 512, se utiliza [DigestUtils.sha512](http://commons.apache.org/codec/apidocs/org/apache/commons/codec/digest/DigestUtils.html#sha512%28java.lang.String%29). Los resultados son como siguen:

```java
<code>sha-256:9a4557a0f654365312b430b80f0da46be2c3a9db6a083f545145398fc66c92d8
sha-512:4c0a2187e03531011c7787752b66e8848a5f146e8aa08e5b5615030c5daa9cd756150e225943b5182de2434d925a4d6889b2d129ed87f23943bce9a8342b02bd</code>
```

Como podemos ver.. a mayor bits, mayor confiabilidad.

Su contraparte, en MySQL, se utiliza la función [sha2()](http://dev.mysql.com/doc/refman/5.5/en/encryption-functions.html#function_sha2). Ojo, esta función recién está disponible en la versión 5.5.5.

[![]({{ '/assets/blogger/sha2-mysql.jpg' | relative_url }})]({{ '/assets/blogger/sha2-mysql.jpg' | relative_url }})
