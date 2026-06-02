---
layout: post
title: "Autenticación con LDAP en ActiveDirectory"
date: 2008-06-24T15:34:00Z
last_modified_at: 2009-04-25T21:55:03.375Z
author: "Diego Silva"
permalink: /2008/06/autenticacion-con-ldap-en.html
canonical_url: https://www.apuntesdejava.com/2008/06/autenticacion-con-ldap-en.html
tags:
  - "java"
  - "windows"
  - "seguridad"
---

ActiveDirectory es un servicio de Windows Server que mantiene información de la red tales como los usuarios registrados, los equipos conectados, etc. Soporta el protocolo LDAP, por lo que este consistirá en hacer una simple clase que permita autenticar un usuario y una contraseña utilizando el ActiveDirectory.

Si estamos haciendo una aplicación que necesite un inicio de sesión, convendría mejor que el usuario usara el mismo nombre de usuario y contraseña que utiliza cuando trabaja en red.

Un ejemplo simple de autenticación con LDAP se encuentra aquí [LDAP Autentication](http://java.sun.com/products/jndi/tutorial/ldap/security/ldap.html).

## Obteniendo la configuración del dominio de red

 En una red windows existe el servidor que contiene toda la información de la red. Este se llama "Servidor de Dominio". Debemos consultar con nuestro administrador de red cuál es el nombre de este equipo para hacer nuestra aplicación.

Para nuestro ejemplo, nuestro servidor de red se llamará **spdom01**.

Necesitamos, además, saber cuáles son las cadenas de utiliza el LDAP. Podemos consultarle, también, a nuestro administrador de red. Pero si él piensa que nos hemos vuelto espesos, mejor averiguémoslo nosotros mismos.

Para ello descargaremos un programa que me resulta muy útil. Se llama [Softerra LDAP Browser](http://www.ldapbrowser.com/download.htm). Es gratuito.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhB4Y_r6mx5BHL7hcFzHegaSFMxLk8iTJ2uIKTXK15SQCS64cguk_8XfGMZiTF5epn5A_9y8J7c7tTIonSIs1fQFBRLfzyPcQXdm2f1wpxzxqZaCOndpwQUUG65UZ3zQEJszVM0jknSbFuZ/s320/ldapbrowser.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhB4Y_r6mx5BHL7hcFzHegaSFMxLk8iTJ2uIKTXK15SQCS64cguk_8XfGMZiTF5epn5A_9y8J7c7tTIonSIs1fQFBRLfzyPcQXdm2f1wpxzxqZaCOndpwQUUG65UZ3zQEJszVM0jknSbFuZ/s1600-h/ldapbrowser.png)

Una vez descargado e instalado, crearemos un perfil. Entramos a la opción File > New profile. Escribimos un nombre de referencia, por ejemplo "Nuestra red".

Cuando aparezca la ventana "Host information" debemos indicar el nombre del servidor de dominio en la casilla "Host"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgv979aBuVn7dR6fC3xQeLjL8TpMc-iJ0wJ_bY0YrwjG3oLE-hqIG98z1c-JNfmYPx6aE5OxoMuF5KncLmSM0IyRIZomMIWggZGiwBUxHG3tTMsUSHS7ncY5WHMlwfzjmbsU_aRpbpnAH8V/s320/host_info.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgv979aBuVn7dR6fC3xQeLjL8TpMc-iJ0wJ_bY0YrwjG3oLE-hqIG98z1c-JNfmYPx6aE5OxoMuF5KncLmSM0IyRIZomMIWggZGiwBUxHG3tTMsUSHS7ncY5WHMlwfzjmbsU_aRpbpnAH8V/s1600-h/host_info.png)Y hacemos clic en el botón "Fetch DNS".

Con esto, el LDAP Browser consultará al servidor y obtendrá las cadenas de base DN. A mi me aparecen unas cadenas que por seguridad no las publicaré.

Clic en "Siguiente".

Luego nos pedirá nuestras credenciales. Pues aquí ingresamos nuestro nombre de usuario y nuestra contraseña.

No sé si está mal configurado este servicio en mi red, ya que no soy el administrador. Yo he tratado de colocar mi usuario normal, pero no ingresa. Después de muchas pruebas, logré ingresar escribiendo el nombre de mi usuario seguido de "@" y el dominio, como si fuera mi correo electrónico. Algo así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYlTbREK881Y_3OzKSvB2LS5NxyxXNxg5rzYNakk9oWqVMeezL6vlS32ety0bWvRzpWa1L_1kHKzslA3yoFI6s6jXB3hYAVJrGn4SKQzAm7YxkWg4r1zSLnLc85ly5R_GaB8YSV5B2usHZ/s320/cred.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYlTbREK881Y_3OzKSvB2LS5NxyxXNxg5rzYNakk9oWqVMeezL6vlS32ety0bWvRzpWa1L_1kHKzslA3yoFI6s6jXB3hYAVJrGn4SKQzAm7YxkWg4r1zSLnLc85ly5R_GaB8YSV5B2usHZ/s1600-h/cred.png)Digo que podría estar mal, ya que mi correo electrónico es diferente. Anyway!.

Escribimos nuestra contraseña, clic en "Finalizar"

Y listo, ya deberíamos visualizar los objetos del servidor.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgx6ZcLWl0Nrh_tP-a7Yc8IWF7lHs7hbNNG4AlVr2YJJpXtI6nmDEBlNN4TAOBVjlUrpg1F2UlWZLpvYPUpSE0jhn7Aa9c4ceQqPFsZbqjzR6WWWDHgvYvQf51uoAMNR-swmBMbuku5WJlo/s320/ldap.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgx6ZcLWl0Nrh_tP-a7Yc8IWF7lHs7hbNNG4AlVr2YJJpXtI6nmDEBlNN4TAOBVjlUrpg1F2UlWZLpvYPUpSE0jhn7Aa9c4ceQqPFsZbqjzR6WWWDHgvYvQf51uoAMNR-swmBMbuku5WJlo/s1600-h/ldap.png)Ahora, examinemos un poco estos objetos. No podemos malograr nada porque supuestamente somos simples usuarios y no administradores del dominio.

Revisemos la carpeta "Users" y busquemos nuestro nombre de usuario.

Yo lo encontré, y esta es la información. Pero hay que notar las siguientes cadenas:

- cn
- DisplayName
- distinguedName

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLVbkVB5kpd1sPEkqcOzEOvAT0JfnY7KqU8eSEcyWuDfnATozbAVW5HRADo2MSSnnUmfn5l2K6i23Z9r1S8LW5n1R13nela_5hnWChusJJ-7N5cPG04LRsRSPhoP4jZiW0hnTvcBu8R3R3/s320/usuario.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLVbkVB5kpd1sPEkqcOzEOvAT0JfnY7KqU8eSEcyWuDfnATozbAVW5HRADo2MSSnnUmfn5l2K6i23Z9r1S8LW5n1R13nela_5hnWChusJJ-7N5cPG04LRsRSPhoP4jZiW0hnTvcBu8R3R3/s1600-h/usuario.png)La cadena CN es lo que nos importa realmente. Revisa el título del LDAP Browser. Allí aparecerá la cadena completa de nuestro usuario.

```java
CN=DIEGO ENRIQUE SILVA LIMACO,CN=Users,DC=andes,DC=com,DC=pe
```

El mio está mal configurado y me aparece todo mi nombre completo. Es decir, que si deseo iniciar sesión usando LDAP debería usar mi nombre completo como nombre de usuario. Bueno, hagamos una clase así, siguiendo el ejemplo de Sun.

Login.java<style type="text/css">BODY { 	COLOR: #000000; FONT-FAMILY: Monospaced; BACKGROUND-COLOR: #ffffff } TABLE { 	COLOR: #000000; FONT-FAMILY: Monospaced; BACKGROUND-COLOR: #e9e8e2 } .line-number { 	BACKGROUND-COLOR: #e9e8e2 } .character { 	COLOR: #ce7b00 } .keyword-directive { 	COLOR: #0000e6 } </style>

```java
<span class="line-number">19</span> <span class="keyword-directive">public</span> <span class="keyword-directive">class</span> Login {<br /><br /><span class="line-number">20</span><br /><br /><span class="line-number">21</span>     <span class="keyword-directive">static</span> <span class="keyword-directive">final</span> String LDAP_URL = <span class="character">"</span><span class="character">ldap://spdom01:389/DC=andes,DC=com,DC=pe</span><span class="character">"</span>;<br /><br /><span class="line-number">22</span><br /><br /><span class="line-number">23</span>     <span class="keyword-directive">public</span> <span class="keyword-directive">boolean</span> login(String username, String password) {<br /><br /><span class="line-number">24</span>         Hashtable env = <span class="keyword-directive">new</span> Hashtable();<br /><br /><span class="line-number">25</span>         env.put(Context.INITIAL_CONTEXT_FACTORY, <span class="character">"</span><span class="character">com.sun.jndi.ldap.LdapCtxFactory</span><span class="character">"</span>);<br /><br /><span class="line-number">26</span>         env.put(Context.PROVIDER_URL, LDAP_URL);<br /><br /><span class="line-number">27</span>         env.put(Context.SECURITY_AUTHENTICATION, <span class="character">"</span><span class="character">simple</span><span class="character">"</span>);<br /><br /><span class="line-number">28</span>         env.put(Context.SECURITY_PRINCIPAL, <span class="character">"</span><span class="character">CN=</span><span class="character">"</span>+username.toUpperCase()+ <span class="character">"</span><span class="character">, cn=Users, DC=andes,DC=com,DC=pe</span><span class="character">"</span>);<br /><br /><span class="line-number">29</span>         env.put(Context.SECURITY_CREDENTIALS, password);<br /><br /><span class="line-number">30</span>         <span class="keyword-directive">try</span> {<br /><br /><span class="line-number">31</span><br /><br /><span class="line-number">32</span>             DirContext ctx = <span class="keyword-directive">new</span> InitialDirContext(env);<br /><br /><span class="line-number">33</span>             <span class="keyword-directive">return</span> <span class="keyword-directive">true</span>;<br /><br /><span class="line-number">34</span>         } <span class="keyword-directive">catch</span> (NamingException ex) {<br /><br /><span class="line-number">35</span>             Logger.getLogger(Login.<span class="keyword-directive">class</span>.getName()).log(Level.SEVERE, <span class="keyword-directive">null</span>, ex);<br /><br /><span class="line-number">36</span>         }<br /><br /><span class="line-number">37</span>         <span class="keyword-directive">return</span> <span class="keyword-directive">false</span>;<br /><br /><span class="line-number">38</span><br /><br /><span class="line-number">39</span><br /><br /><span class="line-number">40</span>     }<br /><br /><span class="line-number">41</span> }<br /><br /><span class="line-number">42</span><br /><br /><span class="line-number">43</span><br /><br />
```

Y cuando queramos usar la clase, simplemente le pasamos el usuario y contraseña.

LoginTest.java<style type="text/css">BODY { 	COLOR: #000000; FONT-FAMILY: Monospaced; BACKGROUND-COLOR: #ffffff } TABLE { 	COLOR: #000000; FONT-FAMILY: Monospaced; BACKGROUND-COLOR: #e9e8e2 } .line-number { 	BACKGROUND-COLOR: #e9e8e2 } .character { 	COLOR: #ce7b00 } .keyword-directive { 	COLOR: #0000e6 } </style>

```java
<span class="line-number">28</span>         String username = <span class="character">"</span><span class="character">DIEGO ENRIQUE SILVA LIMACO</span><span class="character">"</span>;<br /><br /><span class="line-number">29</span>         String password = <span class="character">"</span><span class="character">LoremIpsum</span><span class="character">"</span>;<br /><br /><span class="line-number">30</span>         Login instance = <span class="keyword-directive">new</span> Login();<br /><br /><span class="line-number">31</span>         <span class="keyword-directive">boolean</span> result = instance.login(username, password);<br /><br />
```

Pero en mi caso, como es muy incómodo escribir todo mi nombre como nombre de usuario, modificaré mi clase Login y colocaré:

```java
<span class="line-number">28</span>         env.put(Context.SECURITY_PRINCIPAL, <span class="character"></span>username.toUpperCase()+ <span class="character">"@andes.com.pe</span><span class="character">"</span>);<br /><br /><span class="line-number"></span>
```

Y lo invocaré así:

```java
<span class="line-number">28</span>         String username = <span class="character">"dsilva</span><span class="character">"</span>;<br /><br /><span class="line-number">29</span>         String password = <span class="character">"</span><span class="character">LoremIpsum</span><span class="character">"</span>;<br /><br /><span class="line-number">30</span>         Login instance = <span class="keyword-directive">new</span> Login();<br /><br /><span class="line-number">31</span>         <span class="keyword-directive">boolean</span> result = instance.login(username, password);<br /><br />
```

Y listo
