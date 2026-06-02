---
layout: post
title: "AOP Programación Orientada a Aspectos con Spring 2.5 y NetBeans 6.1"
date: 2008-06-03T03:08:00Z
last_modified_at: 2015-11-17T16:18:11.066Z
author: "Diego Silva"
permalink: /2008/06/aop-programacion-orientada-aspectos-con.html
canonical_url: https://www.apuntesdejava.com/2008/06/aop-programacion-orientada-aspectos-con.html
tags:
  - "spring"
  - "aop"
  - "netbeans"
---

[![](https://docs.google.com/drawings/d/1lgRMknE64I5RlJrH948up4AjJ6sv67bPRYSiBbpxUHA/pub?w=224&h=120)](https://docs.google.com/drawings/d/1lgRMknE64I5RlJrH948up4AjJ6sv67bPRYSiBbpxUHA/pub?w=224&h=120)

Mucho se ha oído o leído sobre la Programación Orientada a Aspectos (AOP), pero ¿qué es realmente? Simplemente, es una ayuda para los programadores que permite reducir código de rutinas que siempre deberían ejecutarse y no se puede usar la herencia. Además, cada lógica de negocio solo tendrá lógica de negocio, y no código adicional que son repetitivas y no son parte del negocio. Por ejemplo, un método que se encargue de una transferencia de dinero, debería ser tan simple como esto

```java
void transfer(Account fromAccount, Account toAccount, int amount){
  if (fromAccount.getBalance() < class="br0">) {
    throw new InsufficientFundsException();
  }

  fromAccount.withdraw(amount);
  toAccount.deposit(amount);
}
```

Pero realmente, se vuelve así:

```java
void transfer(Account fromAccount, Account toAccount, int amount) throws Exception {
if (!getCurrentUser().canPerform(OP_TRANSFER)) {
throw new SecurityException();
}

if (amount < 0) {
throw new NegativeTransferException();
}

Transaction tx = database.newTransaction();
try {

if (fromAccount.getBalance() < amount) {
throw new InsufficientFundsException();
}
fromAccount.withdraw(amount);
toAccount.deposit(amount);

tx.commit();
systemLog.logOperation(OP_TRANSFER, fromAccount, toAccount, amount);
}
catch(Exception e) {
tx.rollback();
throw e;
}
}
```

Donde se incorpora rutinas de registro (log), inicio de transacciones de la base de datos, validación de cantidades, además de posibles excepciones que se puedan lanzar.

Y si hacemos un método que se encargue únicamente del depósito, el resultado sería similar. Aquí es donde entra los Aspectos.

## Algunos conceptos

A continuación, mencionaré algunos conceptos utilizados en la Programación Orientada a Aspectos

- **Aspect** (*Aspecto*) es la funcionalidad que se cruza a lo largo de la aplicación (cross-cutting) que se va a implementar de forma modular y separada del resto del sistema. El ejemplo más común y simple de un aspecto es el logging (registro de sucesos) dentro del sistema, ya que necesariamente afecta a todas las partes del sistema que generan un suceso.

- **Jointpoint** (*Punto de Cruce*) es un punto de ejecución dentro del sistema donde un aspecto puede ser conectado, como una llamada a un método, el lanzamiento de una excepción o la modificación de un campo. El código del aspecto será insertado en el flujo de ejecución de la aplicación para añadir su funcionalidad.

- **Advice** (*Consejo*) es la implementación del aspecto, es decir, contiene el código que implementa la nueva funcionalidad. Se insertan en la aplicación en los Puntos de Cruce.

- **Pointcut** (*Puntos de Corte*) define los Consejos que se aplicarán a cada Punto de Cruce. Se especifica mediante Expresiones Regulares o mediante patrones de nombres (de clases, métodos o campos), e incluso dinámicamente en tiempo de ejecución según el valor de ciertos parámetros.

- **Introduction** (*Introducción*) permite añadir métodos o atributos a clases ya existentes. Un ejemplo en el que resultaría útil es la creación de un Consejo de Auditoría que mantenga la fecha de la última modificación de un objeto, mediante una variable y un método setUltimaModificacion(fecha), que podrían ser introducidos en todas las clases (o sólo en algunas) para proporcionarlas esta nueva funcionalidad.

- **Target** (*Destinatario*) es la clase aconsejada, la clase que es objeto de un consejo. Sin AOP, esta clase debería contener su lógica, además de la lógica del aspecto.

- **Proxy** (*Resultante*) es el objeto creado después de aplicar el Consejo al Objeto Destinatario. El resto de la aplicación únicamente tendrá que soportar al Objeto Destinatario (pre-AOP) y no al Objeto Resultante (post-AOP).

- **Weaving** es el proceso de aplicar Aspectos a los Objetos Destinatarios para crear los nuevos Objetos Resultantes en los especificados Puntos de Cruce. Este proceso puede ocurrir a lo largo del ciclo de vida del Objeto Destinatario:

- Aspectos en Tiempo de Compilación, que necesita un compilador especial.

- Aspectos en Tiempo de Carga, los Aspectos se implementan cuando el Objeto Destinatario es cargado. Requiere un ClassLoader especial.

- Aspectos en Tiempo de Ejecución.

## Comenzando AOP con Spring 2.5

Antes de comenzar, debemos recordar (o conocer)  lo que es el Patrón de Diseño Proxy. Para resumir toda la definición, un proxy es un objeto que luce como otro objeto pero añade funcionalidad especial de forma transparente. En Spring, una interfaz puede ser usado tras un proxy.

### Proxy

En NB 6.1, creemos un proyecto simple (Java > Java Application) llamado SpringProxy. Luego, agregamos la biblioteca Spring Framework 2.5

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhosg73wlPkcYbW-qZqR9eaTipn0op-Tsst8XX2ZvDH4yrz2kVW-1sk4XfdbGSIyHHvrm6Y86u4ahlmSoquS5cBmHRxn71jsKjgYE55gS_kQK9XTWD1uYHPvscEzy9Xknkh3z9IlN0YKn8T/s320/Pantallazo-Project+Properties+-+SpringProxy.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhosg73wlPkcYbW-qZqR9eaTipn0op-Tsst8XX2ZvDH4yrz2kVW-1sk4XfdbGSIyHHvrm6Y86u4ahlmSoquS5cBmHRxn71jsKjgYE55gS_kQK9XTWD1uYHPvscEzy9Xknkh3z9IlN0YKn8T/s1600-h/Pantallazo-Project+Properties+-+SpringProxy.png)Luego, crearemos la interfaz Conversacion, que tendrá un método llamado iniciarSesion().

```java
package springproxy;

public interface Conversacion {

void iniciarSesion();
}
```

Y tenemos la siguiente implementación de la Interfaz

```java
package springproxy;

public class ChatInterno implements Conversacion{

private String servidor;

public void setServidor(String servidor) {
 this.servidor = servidor;
}

public void iniciarSesion() {
 System.out.println("["+this.getClass().getName()+":"+this.toString()+"]");
 System.out.println("Iniciando sesion del servidor "+servidor);
}

}
```

Ahora, crearemos un archivo .xml para Spring. Entramos a File > New File, y seleccionamos Other | Spring XML Configuration File.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFGCPqQp4KLHDPTTKORpq9ITPfCY3uabzOlbFzJhRTVKW3t01n9VLsWd4_ObcZPN9rvt2i2djPeuBnZJrDClfjT_odJkpC6UfTch_P3pBq_k9zQNu3GZYMG53mP5i12B-82mRRCsKqJeGh/s320/Pantallazo-New+File.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFGCPqQp4KLHDPTTKORpq9ITPfCY3uabzOlbFzJhRTVKW3t01n9VLsWd4_ObcZPN9rvt2i2djPeuBnZJrDClfjT_odJkpC6UfTch_P3pBq_k9zQNu3GZYMG53mP5i12B-82mRRCsKqJeGh/s1600-h/Pantallazo-New+File.png)Lo llamaremos "aop-spring", y lo colocaremos en la carpeta src del proyecto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiESJ6vQeyeq2OHqGqEjHE0Q4I-GlwOtIDl8aB7OKSciZfIlKvlobk-wTlaZ3trHI9VPNVKf9AZSTBq9e8j-BQHP1N0sIOn-YBN6A48K1agxjOeEIOw2RZ-gdwQteZ4onoQyrwXPO5ztfSK/s320/Pantallazo-New+Spring+XML+Configuration+File.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiESJ6vQeyeq2OHqGqEjHE0Q4I-GlwOtIDl8aB7OKSciZfIlKvlobk-wTlaZ3trHI9VPNVKf9AZSTBq9e8j-BQHP1N0sIOn-YBN6A48K1agxjOeEIOw2RZ-gdwQteZ4onoQyrwXPO5ztfSK/s1600-h/Pantallazo-New+Spring+XML+Configuration+File.png)Clic en "Next".

No seleccionamos nada en la última página, y hacemos clic en "Finish".

Notar que solo se está llamando al esquema "beans".

Escribimos el siguiente código en el archivo aop-spring.xml

```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">
<bean id="chatInterno" class="springproxy.ChatInterno">
    <property name="servidor" value="Servidor Spring Framework"/>
</bean>
<bean id="chatProxy" class="org.springframework.aop.framework.ProxyFactoryBean">
    <property name="proxyInterfaces" value="springproxy.Conversacion" />
    <property name="target" ref="chatInterno"/>
</bean>
</beans>
```

Notemos cómo NB 6.1 nos ayuda a escribir el código, llenando los atributos, asignando variables de beans ya creados, etc.

Ahora, escribamos el siguiente código de nuestra clase Main.

```java
public static void main(String[] args) {
     ApplicationContext ctx = new ClassPathXmlApplicationContext("aop-spring.xml");
     Conversacion chat = (Conversacion) ctx.getBean("chatInterno");
     chat.iniciarSesion();
     System.out.println("corrido de " + chat.getClass());
     System.out.println();

     Conversacion proxy = (Conversacion) ctx.getBean("chatProxy");
     proxy.iniciarSesion();
     System.out.println("corrido de " + proxy.getClass());
 }
```

Ejecutemos el proyecto y veamos la salida:

```java
[springproxy.ChatInterno:springproxy.ChatInterno@633e5e]
Iniciando sesion del servidor Servidor Spring Framework
corrido de class springproxy.ChatInterno

[springproxy.ChatInterno:springproxy.ChatInterno@633e5e]
Iniciando sesion del servidor Servidor Spring Framework
corrido de class $Proxy0
```

Vemos que se trata del mismo objeto (vemos el ID ChatInterno@633e5e en ambos casos) pero realmente son dos clases diferentes. El primero es de la clase springproxy.ChatInterno y el segundo es de $Proxy0.

El Proxy contiene al objeto de ChatInterno, y cuando se ejecuta los métodos del Proxy, llama al método del objeto contenido.

El objeto de ChatInterno no sabrá de donde fue llamado. El Proxy podría realizar un código antes o después de llamar al método del objeto ChatInterno. Esto es lo que queremos hacer al usar AOP.

### Un simple Advice

Lo que haremos ahora es que se ejecute un código antes de iniciar la sesión del chat. Para ello crearemos la clase ChatLogger que implementará la interfaz MethodBeforeAdvice.

```java
package springproxy;

import java.lang.reflect.Method;
import java.util.Date;
import org.springframework.aop.MethodBeforeAdvice;

public class ChatLogger implements MethodBeforeAdvice{

  public void before(Method metodo, Object[] args, Object objetivo) throws Throwable {
      System.out.println("["+(new Date())+"] "+metodo.getName()+" llamado desde "+objetivo);
  }

}
```

Ahora, lo instanciemos en el Spring

```java
<bean id="chatLogger" class="springproxy.ChatLogger" />
```

y lo agreguemos  en la lista de interceptores

```java
<bean id="chatProxy" class="org.springframework.aop.framework.ProxyFactoryBean">
      <property name="proxyInterfaces" value="springproxy.Conversacion" />
      <property name="target" ref="chatInterno"/>
     <span style="font-weight: bold;"> <property name="interceptorNames">
          <list>
              <value>chatLogger</value>
          </list>
      </property></span>
  </bean>
```

Ejecutemos el proyecto, y veremos lo que pasa:

```java
[springproxy.ChatInterno:springproxy.ChatInterno@17494c8]
Iniciando sesion del servidor Servidor Spring Framework
corrido de class springproxy.ChatInterno

<span style="font-weight: bold;">[Tue Jun 03 00:52:34 PET 2008] iniciarSesion llamado desde springproxy.ChatInterno@17494c8</span>
[springproxy.ChatInterno:springproxy.ChatInterno@17494c8]
Iniciando sesion del servidor Servidor Spring Framework
corrido de class $Proxy0
```

AOP usando proxy. Como ves, no hemos modificado nada de la clase ChatInterno.

En la clase ChatLogger podemos agregar el código que deseemos, sin modificar la funcionalidad de nuestra lógica de negocio.

El proyecto de este post se encuentra aquí: [http://diesil-java.googlecode.com/files/SpringProxy.tar.gz](http://diesil-java.googlecode.com/files/SpringProxy.tar.gz)

... esta historia continuará...

## Bibliografía

- [Wikipedia: Programación Orientada a Aspectos](http://es.wikipedia.org/wiki/Programaci%C3%B3n_Orientada_a_Aspectos)

- [JavaRanch Journal: April 2008](http://www.javaranch.com/journal/2008/04/Journal200804.jsp#a2)
