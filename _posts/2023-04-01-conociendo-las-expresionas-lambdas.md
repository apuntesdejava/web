---
layout: post
title: "Conociendo las Expresionas Lambdas: desde lo simple hasta lo avanzado."
date: 2023-04-01T18:24:00.004Z
last_modified_at: 2023-04-07T05:36:59.699Z
author: "Diego Silva Límaco"
permalink: /2023/04/conociendo-las-expresionas-lambdas.html
canonical_url: https://www.apuntesdejava.com/2023/04/conociendo-las-expresionas-lambdas.html
description: "Veamos las expresiones Lambda, desde lo simple hasta lo complejo, para saber cómo aplicarlo y por qué aplicarlo."
tags:
  - "lambda"
  - "colecciones"
  - "java"
  - "stream"
  - "listas"
---

![](/assets/blogger/java-lambda-expression.png)

  Veamos las expresiones Lambda, desde lo simple hasta lo complejo, para saber
  cómo aplicarlo y por qué aplicarlo.

Vamos

(Esta es una traducción libre de:
https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)

## Caso

Tenemos la siguiente estructura de datos:

```java
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public record Person(String name, LocalDate birthday, Sex gender, String email) {

    public long getAge() {
        return ChronoUnit.YEARS.between(LocalDate.now(), birthday);
    }

    public void print() {
        System.out.printf("name:%s birthday:%s gender:%s email:%s\n",
                name, birthday, gender, email);
    }
}

enum Sex {
    MALE, FEMALE
}
```

### Paso 1: Crear método que liste las personas con características específicas

  La manera más simple es crear métodos que busquen específicamente de acuerdo a
  una característica, por ejemplo, los que tienen una edad indicada:

```java
static void printPersonsOlderThan(List<Person> persons, int age) {
        for (var person : persons) {
            if (person.getAge() >= age) {
                person.print();
            }
        }
    }
```

  El problema de hacer esto es que deberíamos crear tantos métodos cómo
  variaciones de búsquedas y combinaciones necesitamos. Por ejemplo, un rango de
  edades:

### Paso 2: Crear método que liste las personas con características más específicas

```java
static void printPersonsWithinAgeRange(List<Person> persons, int low, int high) {
        for (var person : persons) {
            if (person.getAge() >= low && person.getAge() <= high) {
                person.print();
            }
        }
    }
```

  Ahora bien ¿qué pasa si quisiéramos poner más filtros, buscar por nombre,
  restringir por correo y/o por sexo? crear más métodos?
  **¿Por qué no crear un método genérico y que la condición sea lo que
    cambie?

### Paso 3: Criterio de búsqueda en una clase aparte

  Ok, para esto vamos crear una interfaz que va a tener una función que
  devolverá `true` si el elemento recibido por parámetro es
  considerado en el filtro o no. Y, dependiendo de su implementación, podremos
  crear tantas clases como criterios de selección necesitemos:

```java
interface CheckPerson {

    boolean evaluate(Person p);
}
```

  Y modificamos nuestro método de listado de personas de la siguiente manera:

```java
static void printPersons(List<Person> persons, CheckPerson checkPerson) {
        for (var person : persons) {
            if (checkPerson.evaluate(person)) {
                person.print();
            }
        }
    }
    </pre
>
<br />
<p>
  Ahora sí, tenemos un método más limpio, más "genérico" y reutilizable... y esa
  es la idea principal cuando hacemos programas con poco código.... aunque ¿cómo
  implementamos el filtro?. Veamos. Queremos filtrar todas las personas que son
  masculinas y que tengan edad entre 18 y 25 años. Para ello necesitamos
  implementar la interfaz, instanciar esa clase y pasarla como parámetro del
  método, así:
</p>
<pre class="brush:java;first-line:158">
// Implementando la interfaz
class SelectPersonCheckPerson implements CheckPerson {

    @Override
    public boolean evaluate(Person person) {
        return person.gender() == Sex.MALE
                && person.getAge() >= 18
                && person.getAge() <= 15;
    }

}
```

```java
// Invocando al método
  printPersons(persons, new SelectPersonCheckPerson());
```

  Pero.... ¿tendríamos que hacer tantas clases como criterios que necesitamos?
  Se va a gastar mi tinta!

### Paso 4: Usando clases anónimas

  Una de las características de Java es permitir instanciar interfaces sin
  necesitar de implementarlas. Es decir, ni bien se hace `new` a la
  interfaz, en ese mismo momento se puede implementar su lógica. Eso nos ahorra
  mucho código. Así que, para evitar crear la clase
  `SelectPersonCheckPerson`, podemos hacer la siguiente invocación en
  el método `printPersons()`:

```java
printPersons(persons, new CheckPerson() {
            @Override
            public boolean evaluate(Person person) {
                 return person.gender() == Sex.MALE
                && person.getAge() >= 18
                && person.getAge() <= 15;
            }
        });
```

### Paso 5: Especificando criterio de búsqueda con Expresiones Lambda

  Ahora sí, después de toda esta introducción, vamos a ver cómo se aplica las
  funciones lambdas. El código anterior se puede reducir a esto:

```java
printPersons(persons, (Person person) -> person.gender() == Sex.MALE
                && person.getAge() >= 18
                && person.getAge() <= 15);
```

  Esto funciona porque la interfaz `CheckPerson` es una interfaz
  funcional.
  Una interfaz funcional es una interaz que contiene un solo método
    abstracto. Puede tener otros métodos default, estáticos, pero solo tiene uno
  abstracto. Y como tiene uno solo, se puede omitir en la implementación. Por
  eso es que allí ya no vemos el nombre del método, solo el parámetro (Person),
  una flecha (que indica que a partir de allí es la función en una sola línea) y
  el resultado de esa línea es lo que devuelve esa función.

  Como "bonus code track" para asegurarnos de que esa interfaz solo acepte una
  única clase, agreguemos la siguiente notación:
  `@FunctionalInterface`:

```java
@FunctionalInterface
interface CheckPerson {

    boolean evaluate(Person p);
}
```

### Paso 6: Usando interfaces estándar con Expresiones Lambda

  Nuestra interfaz `CheckPerson` es bastante simple. El JDK ya está
  implementado con varias interfaces funcionales para que nosotros lo
  utilicemos. Por ejemplo, nuestra interfaz solo permite un tipo. Existe otra
  interfaz funcional que usa genéricos y permite cualquier clase como parámetro:
  `java.util.function.Predicate.

Por ello, nuestro método de imprimir personas sería así:

```java
static void printPersonsWithPredicate(List<Person> persons, Predicate<Person> checkperson) {
        for (var person : persons) {
            if (checkperson.test(person)) {
                person.print();
            }
        }
    }
```

Y la llamada al método es similar al que hicimos antes:

```java
printPersonsWithPredicate(persons, person -> person.gender() == Sex.MALE
                && person.getAge() >= 18
                && person.getAge() <= 15);
```

### Paso 7: Usando Expresiones Lambdas más allá, en toda la aplicación

Reconsideremos nuestro último método que hemos creado.

```java
static void printPersonsWithPredicate(List<Person> persons, Predicate<Person> checkperson) {
        for (var person : persons) {
            if (checkperson.test(person)) {
                person.print();
            }
        }
    }
```

  Sabemos que funciona bastante bien. Pero veamos nuevamente lo que hace:
  Verifica cada instancia de la lista de personas. Si cumple con los
    criterios que está enviado por parámetro, invoca al método
    print()` de cada instancia.. Si antes estábamos "amarrados" con el criterio de selección y pensábamos
  que deberíamos crear un método por cada criterior, ahora tenemos un problema
  similar. En todos los casos invoca** al método `print()`. ¿No
  deberíamos, también, generalizar esa acción? ¿Y si también lo ponemos como un
  lambda?

  Como se mencionó antes, hay varias interfaces funcionales ya preparadas en el
  JDK que podemos echar mano de ellas. Hay una interfaz que representa a una
  invocación a un método, no devuelve nada pero recibe un parámetro. Se llama
  `java.util.function.Consumer

Y con ello creariamos nuestro método así:

```java
static void processPersons(List<Person> persons,
            Predicate<Person> checkPerson,
            Consumer<Person> consumer) {

        for (var person : persons) {
            if (checkPerson.test(person)) {
                consumer.accept(person);
            }
        }
    }
```

Y se invoca de la siguiente manera:

```java
processPersons(
                persons,
                p -> p.gender() == Sex.MALE
                && p.getAge() >= 18
                && p.getAge() <= 15,
                p -> p.print());
```

  Y así como existe la interfaz Consumer` que solo recibe un
  parámetro, también existe la interfaz
  `java.util.function.Function
  que recibe un parámetro y devuelve un valor. Por ejemplo queremos que después
  de todo ese filtro, queremos que se reciba su correo electrónico y lo imprima.
  El método debería recibir la función que debería procesar genéricamente esos
  parámetros. Recordemos que ese método sigue siendo agnóstico. No sabe lo que
  va a recibir, solo hará algo genérico:

```java
static void processPersonsWithFunction(
            List<Person> persons,
            Predicate<Person> checkPerson,
            Function<Person, String> getField,
            Consumer<String> consumer
    ) {
        for (var person : persons) {
            if (checkPerson.test(person)) {
                String data = getField.apply(person); //esta es la función
                consumer.accept(data);
            }
        }
    }
```

Y la invocación sería:

```java
processPersonsWithFunction(
                persons,
                p -> p.gender() == Sex.MALE
                && p.getAge() >= 18
                && p.getAge() <= 15,
                p -> p.email(),
                email -> System.out.println(email));
                </pre
>
<br />
<p>
  También hay otras que reciben dos parámetros, tres, etc. Solo hay que mirar
  más ese paquete.
</p>
<br />
<h3>Paso 8: Más genéricos</h3>
<br />
<p>Reconsideremos nuestro último método que ha evolucionado bastante:</p>

<br />
<pre class="brush:java;first-line:122">
    static void processPersonsWithFunction(
            List<Person> persons,
            Predicate<Person> checkPerson,
            Function<Person, String> getField,
            Consumer<String> consumer
    ) {
        for (var person : persons) {
            if (checkPerson.test(person)) {
                String data = getField.apply(person); //esta es la función
                consumer.accept(data);
            }
        }
    }
```

  Podemos darnos cuenta que dentro del método no estamo usando ningún atributo
  propio de nuestro registro Person`. Practicamente todos los
  procesamientos son datos en los parámetros. Los únicos tipos definidos son:
  `Person` y `String` y de eso dependen los parámetros....
  o los parámetros hacen depender a quiénes llaman. Así que vamos hacer un
  último cambio a este método: usar genérico para todo, porque - al final - este
  método puede servir para otros tipos de datos, y también habrá un filtro y un
  procesamiento de datos. Para hacerlo más genérico, usaremos la interfaz más
  genérica de `List` de tal manera que puera ser utilizada en un
  `for`.... y eso es un `Iterable`. Así que vamos a por
  ello:

```java
static <X, Y> void processElements(
            Iterable<X> iterable,
            Predicate<X> tester,
            Function<X, Y> mapper,
            Consumer<Y> consumer
    ) {
        for (X element : iterable) {
            if (tester.test(element)) {
                Y data = mapper.apply(element);
                consumer.accept(data);
            }
        }
    }
    </pre
>
<br />
<p>Y la invocación sería:</p>
<br />
<pre class="brush:java;first-line:53">
        processElements(
                persons,
                p -> p.gender() == Sex.MALE
                && p.getAge() >= 18
                && p.getAge() <= 15,
                p -> p.email(),
                email -> System.out.println(email));
```

### Paso 9: Operaciones agregadas. Todo, lo mismo, pero desde la misma colección.

  Ahora que ya estamos muy bien preparados sobre cómo funciona las expresiones
  lambdas, podemos recorrer la colección `persons` y allí mismo hacer
  todo lo anterior, sin crear funciones adicionales, ni usar `for`.
  Las colecciones, a partir de Java 8, tienen una característica llamada
  Streams, que permite recorrer sus elementos como - justamente - flujos, y allí
  se pueden usar expresiones lambdas. Veamos cómo sería usando todo lo visto
  hasta ahora pero desde un stream de la colección:

```java
persons
                .stream() //obtiene la fuente de los objetos
                .filter( //filtra los objetos. Debe devolver un boolean
                        p -> p.gender() == Sex.MALE
                        && p.getAge() >= 18
                        && p.getAge() <= 15
                )
                .map( //obtiene un nuevo valor a partir del parámetro
                        p -> p.email()
                ).forEach( //realiza un acción por cada elemento recibido
                        email -> System.out.println(email)
                );
```

¿Qué hace cada método? Aquí veamos utilizado en el código anterior:

- `Stream<E> stream()`: Obtiene una fuente de objetos

-
    `Stream<T> filter(Predicate<? super T> predicate)`:
    Filtra los objetos que coincidan con el objeto Predicado

-
    `<R> Stream<R> map(Function<? super T,? extends R>
      mapper): Mapea, convierte, transforma el resultado recibido por parámetro y lo
    devuelve al stream

-
    void forEach(Consumer<? super T> action)`: Realiza una
    acción específica por cada elemento recibido en el parámetro.

## Finalizando

  Espero que esta explicación haya sido satisfactoria. Como dije al inicio me he
  basado en el tutorial que tiene Oracle, y traté de hacerlo un poco más
  explicativo.

El código fuente lo puedes encontrar a continuación:

  https://github.com/apuntesdejava/lambda-expressions-example
