---
layout: post
title: "SCJP 5 - Genericos"
date: 2006-11-21T04:28:00Z
last_modified_at: 2009-04-25T21:55:03.918Z
author: "Diego Silva"
permalink: /2006/11/scjp-5-genericos.html
canonical_url: https://www.apuntesdejava.com/2006/11/scjp-5-genericos.html
tags:
  - "java"
  - "scjp"
---

Estudiando para dar mi examen de SCJP 5 encontré algo que  llaman  "genéricos". Recordarás que ahora las colecciones ahora pueden ser con tipo:
*
ArrayList

 perros=new ArrayList

();
perros.add(new Perro("Fido"));*

se ve bonito, y luego bueno de esto es que el ** compilador ** no permitirá algo como esto:
*
perros.add(new Integer(1));*

Así, también se cumple la herencia:
***
List****

 perros=new **** ArrayList****

();*

Pero esto no se puede hacer:
*
import java.util.*;*
*
class Animal{}
class Perro extends Animal{}*
*
public class Test {
    public static void main(String[] args){
        List**** Animal**** > animales=new ArrayList**** Perro**** >();
    }

}*

¿Por qué? ¡si Perro ES-UN animal! Pues bien, esto corrige un problema que tienen los arreglos comunes:

*
import java.util.*;
class  Animal{}
class Perro extends Animal{}
class Gato extends Animal{}
public class Test {
    public static void main(String[] args){**
        Perro[] perros=new Perro[]{new Perro()}; //arreglo de perros**
        agregar(perros);
    }
    **
    private static void agregar(Animal[] animales) { //es permisible xq Perro ES-UN Animal****
        animales[0]=new Gato(); //OUCH!! esto no debería ser****
    }

}*

Compila, y cuando se ejecuta manda una excepción (ArrayStoreException). La cuestión es que las colecciones con tipo asegura que los valores que se les pasa no tengan errores de este tipo al momento de la compilación. Por ello, debe asegurar que sean del mismo tipo-de-la-colección. Entonces, esto no compilaría, porque las colecciones se aseguran que tengan el mismo tipo.
*
//...
    public static void main(String[] args){
        List

 perros=new ArrayList

();
        perros.add(new Perro());****
        agregar(perros); //no se puede aplicar tipos de colecciones diferentes.****
    }

    private static void agregar(List animales) {
        animales.add(new Gato());
    }
//...*

Pero, claro está, ** no vamos a crear tantos métodos cómo subclases tengamos** . Aquí entran los "genéricos". Se puede declarar parámetros de métodos que sean de tipo (subtipos o supertipos) de una clase en especial. Entonces, para que nuestro método compile aceptando cualquier colección, debería ser así:
*
//..
    public static void main(String[] args){
        List

 perros=new ArrayList

();
        perros.add(new Perro());
        agregar(perros);
****
        List gatos=new ArrayList();
        agregar(gatos); //tambien puedo llamar al mismo método****

    }
    ****
    private static void agregar(List animales) {    //usando genéricos   ****
        //animales.add(new Gato()); //pero esta línea no va a compilar
       for(Animal animal:animales) {
        //pero puedo manejar cada elemento por igual
       }
    }
//..*

Ajá, con esto aseguro que solo se permitan manejar todos por igual. Pero, si deseo agregar elementos a la colección? Java no va a permitir cualquier cosa que se agregue. Para ello se puede utilizar la palabra clave ** super**  en lugar de ** extends** . Aquí un código más completo para entender cómo funciona:
*
import java.util.*;
abstract class  Animal{ //la clase Animal, tambien puede ser interface
    public abstract void dejarseRevisar();
}
class Perro extends Animal{ //La implementacion en Perro
    public void dejarseRevisar() {
        System.out.println("El Perro se deja revisar");
    }}
class Gato extends Animal{ //La implementacion en Gato
    public void dejarseRevisar() {
        System.out.println("El Gato se deja revisar");
    }}
class Poodle extends Perro{ //La implementacion en Poodle que ES-UN Perro
    public void dejarseRevisar() {
        System.out.println("El Poodle se deja revisar");
    }}
public class Test {
    public static void main(String[] args){****
        Veterinario veterinario=new Veterinario(); //tenemos un Veterninario****

        List

 perros=new ArrayList

(); //creamos nuestra lista de perros
        perros.add(new Perro()); //agregamos uno****
        veterinario.revisar(perros); //lo mandamos a revisar, es tratado como Animal ****

        List gatos=new ArrayList(); //creamos nuestra lista de gatos
        gatos.add(new Gato());****
        veterinario.revisar(gatos); //lo mandamos a revisar, es tratado como un Animal ****

        List

 poodles=new ArrayList

(); //creamos nuestra lista de poodles
        poodles.add(new Poodle());****
        veterinario.revisar(poodles); //.... idem...****

        List animales=new ArrayList(); //creamos una lista de animales ****
        veterinario.agregarPerros(animales); //y lo manejamos solo para perros a pesar que es una coleccion de animales****
    }

}
class Veterinario{****
    void revisar(List animales){ //todos son tratados como animales****
        for(Animal animal:animales)
            animal.dejarseRevisar();
    }****
    void agregarPerros(List perros){****
        perros.add(new Perro());
        perros.add(new Poodle());****
        //perros.add(new Gato()); //no lo permite, porque lo vamos a manejar como colección de Perros****

    }
}*

Bacán, no? (je). además, esto fue un ejemplo para los argumentos, pero también funciona en variables (con ejemplos de los que no pueden ser compilablres):
*
        List list = new ArrayList

(); //compila
        List aList = new ArrayList

();  //compila****
        List foo = new ArrayList(); //no compila
        List cList = new ArrayList(); //no compila porque Integer no ES-UN Perro****
        List bList = new ArrayList(); //compila****
        List dList = new ArrayList

(); //no compila porque Perro no es una super-clase de Animal***

Ahora, dirás "yo también quiero tener mi clase que permita genéricos". Pues es sencillo. Pongamos el escenario: imaginemos que tengamos una lógica para manejar los alquileres de lo que fuere:
*
import java.util.*;
class Alquilar{
    private List listaAlquiler;
    private int maxAlquiler;
    public Alquilar(int max, List lista){
        maxAlquiler=max;
        listaAlquiler=lista;
    }
    public Object alquilar(){
        //algo que maneje la disponibilidad de alquiler
        return listaAlquiler.get(0);
    }
    public void regresa(Object o){ //regresa el elemento alquilado
        listaAlquiler.add(o);
    }
}*

Ahora, queremos implementar esta lógica para alquilar autos:
*
class Auto{}
class AlquilarAuto extends Alquilar{
    public AlquilarAuto(int m,List l){
        super(m,l);
    }

    public Object alquilar() {
        return super.alquilar();
    }

    public void regresa(Object o) {
        if (o instanceof Auto)
            super.regresa(o);
        else
            System.err.println("Aqui no se devuelve");
    }
}
*
Pero, si queremos usar la misma lógica para alquilar casas, uartos, computadoras? ¿tendriamos que extender siempre la misma la clase para hacer solo llamadas al * super* ? Bastaría con tener una misma lógica, y dependiendo de cómo se instancie, debería de comportarse por igual, no? además no deberí haber esa validación de * instanceof*  en el método regresa().
*
class **** AlquilarGenerico****** **** { //de algun **** T**** ipo****
    private List listaAlquiler; //manejará el mismo tipo****
    private int maxAlquiler;****
    public AlquilarGenerico(int max, ****** List******  lista){ //recibe el mismo tipo con que fue instanciado****
        maxAlquiler=max;
        listaAlquiler=lista;
    }****
    public ****** T ****** alquilar(){ //retorna el mismo Tipo****
        //algo que maneje la disponibilidad de alquiler
        return listaAlquiler.get(0);
    }****
    public void regresa(****** T o****** ){ //recibe del mismo tipo que fue instanciado****
        listaAlquiler.add(o);
    }
}*

Podría haber sido cualquier letra en lugar de T, pero por convencion, se usa la letra T para referirse a los Tipos. Entonces, ya se podría usar algo así:
*
//...
class Auto{}
class Casa{}*
*
public class Test2 {
    public static void main(String[] args){
        List autos=new ArrayList();
        autos.add(new Auto());
        AlquilarGenerico alquilarAuto=new AlquilarGenerico(100,autos);
        Auto a1=alquilarAuto.alquilar();
        alquilarAuto.regresa(a1);

        List casas=new ArrayList();
        casas.add(new Casa());
        AlquilarGenerico alquilarCasa=new AlquilarGenerico(100,casas);
        Casa c1=alquilarCasa.alquilar();
        alquilarCasa.regresa(c1);

    }

}*
Ahora, no solo depende de cómo fue instanciado, sino también depende de cómo se llame al método. Es decir, así:

*
class CreateAnArrayList {****
    public ******  void ****** makeArrayList(T t) {****

        List list = new ArrayList();
        list.add(t); //un método nada útil, pero se conoce como influye el
    }
}*

Pareciera que la el método es de tipo  y a la vez es un void. Pues escrito así dice que todo lo que está con  será el tipo genérico. Esto se podría llamar así:
*
        CreateAnArrayList cal=new CreateAnArrayList();
        Auto a2=new Auto();
        cal.makeArrayList(a2); *

también podriamos restringirlo para que solo permita números
*
class CreateAnArrayList {****
    public ******  ****** void makeArrayList(T t) {****

        List list = new ArrayList();
        list.add(t);
    }
}*
y el bloque anterior ya no compilaría, porque a2 es un Auto y  no es  Number.

Ahora, también serviría como constructor de una clase.*
class Radio {****
   public  Radio(T t) { }  ****
}*
