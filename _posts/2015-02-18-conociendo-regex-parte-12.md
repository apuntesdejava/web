---
layout: post
title: "Conociendo RegEx (Parte 1/2)"
date: 2015-02-18T22:42:00Z
last_modified_at: 2015-02-18T22:42:10.789Z
author: "Diego Silva Límaco"
permalink: /2015/02/conociendo-regex-parte-12.html
canonical_url: https://www.apuntesdejava.com/2015/02/conociendo-regex-parte-12.html
tags:
  - "regex"
  - "tutorial"
  - "java"
  - "java 7"
---

[![Conociendo RegEx](/assets/blogger/regex.jpg)](/assets/blogger/regex.jpg)

Este post tiene por objetivo aprender un poco sobre las expresiones regulares.

Conoceremos al menos lo más básico como para que uno pueda dar el examen de certificación, y - con la práctica y experiencia - pueda uno llegar a ser tan experto como este tipo:

[![](/assets/blogger/code-03.gif)](/assets/blogger/code-03.gif)

(Indios)

### ¿Para que sirve una expresión regular o RegEx?

Comenzaremos con definir un problema recurrente en todo tipo de programación: la búsqueda de texto. Es lo más común que necesitamos para validar o encontrar algún en base a un patrón de texto.

Lo común es buscar una cadena dentro de otra, usamos el método [indexOf()](http://docs.oracle.com/javase/8/docs/api/java/lang/String.html#indexOf-int-) y se acabó el problema ¿cierto? Pero ¿qué pasaría que la búsqueda se trata de encontrar un número de teléfono válido, o un correo electrónico, o un código de asegurado con un formato muy caprichoso?.. y que sea personalizable en el tiempo? Uhmm.. se pone interesante.

Pues bien, las expresiones regular son un motor de búsqueda que atraviesa el dato textual usando instrucciones que son codificadas en expresiones. Una expresión regex es como un pequeño programa o *script*.

En adelante usaremos un pequeño código que lo saqué de un libro para probar las expresiones regulares. Consiste en evaluar una expresión regular pasada como argumento al programa, y la cadena donde se va a evaluar la expresión. Aquí está:

<script src="https://gist.github.com/apuntesdejava/8d9b469a210d2b7226a5.js"></script>

Pero, le hice unos pequeños cambios, para que sea más profesional al momento de mostrar nuestros resultados

<script src="https://gist.github.com/apuntesdejava/f99f0b78b14c9bf54e54.js"></script>

Y, para evitarnos abrir el IDE, o el Notepad++ y evitar compilarlo en nuestra PC/Mac/Servidor, lo haremos aún más profesional: lo compilaremos en la nube.

Aquí colgué el mismo código, pero este se puede compilar y ejecutar: [http://www.browxy.com/SavedCode/28386](http://www.browxy.com/SavedCode/28386)

Como les dije hace un momento, vamos a evaluar una expresión regular en una cadena. Ambas cadenas serán los argumentos de este programa.

¿Dónde se pone los argumentos? Acá arriba

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgcxmt-0G-JjYY_nHei0EhMzxvAqp34qWDTlo8g20-GMYDRatpibxuGGjCJ8YIVKLLA8HlEgJqJ5sgrA7L-cZo0r_p5mJDma1sreOkWdzTgf563zZ_FfaZNAT3ok_27j3mHB3cX3ma2Amk/s1600/04-02-2015+11-18-42+a.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgcxmt-0G-JjYY_nHei0EhMzxvAqp34qWDTlo8g20-GMYDRatpibxuGGjCJ8YIVKLLA8HlEgJqJ5sgrA7L-cZo0r_p5mJDma1sreOkWdzTgf563zZ_FfaZNAT3ok_27j3mHB3cX3ma2Amk/s1600/04-02-2015+11-18-42+a.m..png)

El primer argumento es la expresión, y el segundo es la cadena a tratar. Así que ejecutaremos con los siguientes argumentos

```java
ab abaaaba
```

El resultado que produce es:

```java
expression:ab
source:ab
 index:012345678901234567890
       0         1         2

match positions:
0 4

Con marcas:
source:abaaaba
 index:012345678901234567890
       *   *
```

¿Qué pasó? Buscó la cadena `ab` en la segunda cadena. Y encontró en las posiciones 0 y 4. Lo podemos comprobar en la salida "con marcas" ya que está pintando un asterisco donde encontró la coincidencia.

Cuando encuentra una cadena, es tomada toda la cadena, y no se vuelve a utilizar en la siguiente búsqueda.

Veamos qué ocurre cuando usamos los siguientes argumentos

```java
aba abababa
```

El resultado es:

```java
expression:aba
source:aba
 index:012345678901234567890
       0         1         2

match positions:
0 4

Con marcas:
source:abababa
 index:012345678901234567890
       *   *
```

Como vemos, la cadena que está desde la posición 2 a la 4 no es considerada, porque la letra "a" de la posición 2 es parte de la primera búsqueda (del 0 al 2) y ya fue utilizada.

Hasta aquí (bien rápido) hemos visto la búsqueda exacta de caracteres. Pero ¿que deberíamos hacer si deseamos usar búsquedas un poco más dinámicas?

### Usando metacaracteres

Queremos buscar todos los números de una cadena. Para buscar dígitos numéricos se usa la siguiente expresión:

```java
\d
```

(Con la barra invertida). Ambos hacen un solo caracter.

El resultado es el siguiente

```java
expression:\d
source:a12c3e456f
 index:012345678901234567890
       0         1         2

match positions:
1 2 4 6 7 8

Con marcas:
source:a12c3e456f
 index:012345678901234567890
        ** * ***
```

Como vemos, encuentra un caracter numérico, y están en las posiciones 1, 2, 4, 6, 7 y 8

Regex proporciona un conjunto de metacaracteres. Este se encuentra en la documentación de [java.util.regex.Pattern](http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html) que no entraremos en detalle. Solo describiremos los siguientes:

- `\d` Es un dígito (0-9)

- `\D` no es un dígito (cualquier caracter menos de 0-9)

- `\s` Un caracter en blanco (como el espacio, `\t` (tabulación), `\n` (nueva línea), `\f`, `\r`)

- `\S` Un caracter que no sea en blanco

- \w Un caracter para palabras (letras de la "a" a la "z" y de la "A" a la "Z", dígitos, o el subguión ("_")

- `\W` (Sí, adivinaron)Un caracter que no sea para palabras

- `\b` Un límite de palabra (los finales de cadenas y entre un `\w` y un `\W`)

- `\B` Un límite de no palabras (entre dos \w y dos no \w)

Probemos con los siguientes argumentos:

```java
\w "a 1 56 _Z"
```

(con comillas para hacerlo una sola cadena)

Y el resultado es....

```java
expression:\w
source:a 1 56 _Z
 index:012345678901234567890
       0         1         2

match positions:
0 2 4 5 7 8

Con marcas:
source:a 1 56 _Z
 index:012345678901234567890
       * * ** **
```

La expresión `\w` marcó todas las letras, números y el signo de subguión, y ningún espacio en blanco..

Los primeros seis metacaracteres (\d,\D,\s, \D, \w, \W) son bastantes sencillos, ya que devuelve la posición de la ocurrencias... y sus opuestos. Por ejemplo:

```java
expression:\S
source:w1w w$ &#w1
 index:012345678901234567890
       0         1         2

match positions:
0 1 2 4 5 7 8 9 10

Con marcas:
source:w1w w$ &#w1
 index:012345678901234567890
       *** ** ****
```

Encuentra todos los caracteres que no sean espacio en blanco.

Pero los dos últimos metacaracteres (`\b` y `\B`) son un poco diferentes. En este caso, la expresión regular busca una relación entre dos caracters adyacentes. Cuando coinciden, se obtiene la posición del segundo caracter. Notemos que el final de una cadena es considerado el caracter .

```java
expression:\b
source:w2w w$ &#w2
 index:012345678901234567890
       0         1         2

match positions:
0 3 4 5 9 11

Con marcas:
source:w2w w$ &#w2
 index:012345678901234567890
       *  ***   *
```

Primero, recordemos que los caracteres de palabra son A-Z, a-z y 0-9. No hay nada de truco para entender que en este ejemplo coinciden en las posiciones 3,4,5 y 9. Regex nos está diciendo que los caracteres 2 y 3 son la limitación entre un caracter de palabra y un caracter de no-palabra. (el espacio y los signos). Pero las posiciones 0 y 11 confunde un poco ¿cierto?· Para el examen, imaginemos que para los caracteres \b y \B existe un caracter oculto no-palabra en cada extremo de la cadena.  Algo así

```java
expression:\b
source:#ab de#
 index:012345678901234567890
       0         1         2

match positions:
1 3 4 6

Con marcas:
source:#ab de#
 index:012345678901234567890
        * ** *
```

En este caso, las coincidencias deberían ser intuitivas, están marcando el segundo caracter en un par de caracteres que representan el límite. Pero aquí:

```java
expression:\B
source:#ab de#
 index:012345678901234567890
       0         1         2

match positions:
0 2 5 7

Con marcas:
source:#ab de#
 index:012345678901234567890
       * *  *
```

... en este caso, asumiendo que son invisibles, los caracteres no-palabra en cada final de cadena, vemos que no son límites.

### Búsqueda usando rangos

Podemos especificar un conjunto de caracteres para buscar usando unos corchetes y el rango de caracteres, y un guión:

- `[abc]` Busca los caracteres a,b y c

- `[a-f]` Busca los caracteres a,b,c,d,e y f

En resumen, podemos buscar varios caracteres usando rangos a la vez.

- `[a-fA-F]` Busca los seis primeros caracteres mayúsculas y minúsculas, pero no la combinación `fA`

```java
expression:[a-cA-C]
source:cafeBABE
 index:012345678901234567890
       0         1         2

match positions:
0 1 4 5 6

Con marcas:
source:cafeBABE
 index:012345678901234567890
       **  ***
```

### Usando cuantificadores

Ahora, supongamos que deseamos crear un patrón regex para buscar número hexadecimales. Sería algo como esto:

```java
0[xX][0-9a-FA-F]
```

Que se interpretaría así:

>
Encontrar un conjunto de caracteres en el que el primer caracter sea el "0", el segundo caracter es una "x" o una "X", el tercer caracter es un dígito de "0" a "9", una letra de "a" a "f", o una letra maúscula de "A" a "F"

Probaremos con nuestro súper código, y este sería el resultado:

```java
expression:0[xX][0-9a-fA-F]
source:12 0x 0x12 0Xf 0xg
 index:012345678901234567890
       0         1         2

match positions:
6 11

Con marcas:
source:12 0x 0x12 0Xf 0xg
 index:012345678901234567890
             *    *
```

Este regex marca los caracteres en las posiciones 6 y 11 (Notemos que tanto 0x y 0xg no son n´meros hexadecimales correctos).

Un segundo paso, pensemos en un problema más fácil. ¿Qué pasa si deseamos un regex para buscar donde aparecen números enteros? Los enteros pueden ser de uno o más dígitos, así que sería genial si podemos decirle a la expresión "uno o más". Aquí es donde se puede construir regex con cuantificadores que nos ayuda con frases como "uno o más". De hechoel caracter que dice "uno o más" es el caracter "+". Otra cuestión es que cuando se está buscnado algo que su longitud es variable, solo estamos recibiendo el inicio de la cadena encontrada. Así que, además de obtener las posiciones de inicio, modificaremos el código para obtener toda el grupo de caracteres que coinciden con la búsqueda.

<script src="https://gist.github.com/apuntesdejava/6cd0ea4a429bb6a0b89e.js"></script>

Y el código ejecutable en línea está aquí: [http://www.browxy.com/SavedCode/29760](http://www.browxy.com/SavedCode/29760)

Ejecutemos con los siguientes argumentos:

```java
\d+ "1 a12 234b"
```

Y este sería el resultado:

```java
expression:\d+
source:1 a12 234b
 index:012345678901234567890
       0         1         2

pos  grupo:
0    1
3    12
6    234
```

Aquí podemos leer "en la posición 0 hay un entero con el valor 1, luego en la posición 3 con el valor 12, y en la posición 6 con el valor 234".

Volviendo con nuestra búsqueda de número hexadecimales, lo último que necesitamos es saber cómo especificarle el cuantificador a nuestro regex. En este caso, deberíamos tener exactamente al menos una coincidencia después de 0x o 0X. Probemos con esta expresión

```java
0[xX]([0-9a-fA-F])+
```

El signo "+" es el cuantificador para la expresión que está entre los paréntesis. Es decir, los paréntesis hacen que todo eso sea una sola regla, un solo caracter.

>
Una vez que encuentre el caracter `0x` o `0X`, buscar al menos un caracter que sea hexadecimal.

```java
expression:0[xX]([0-9a-fA-F])+
source:12 0x 0x12 0Xf 0xg
 index:012345678901234567890
       0         1         2

pos  grupo:
6    0x12
11    0Xf
```

Existen otros dos cuantificadores:

- `*` Cero o más coincidencias

- `?` Cero o una coincidencia

Esto es todo lo que veremos hasta hoy, luego veremos más ejemplos de RegExp.

*Si te gustó, hazlo saber (Like o +1).. y si crees que es útil, compártelo. Es gratis*

*
*
