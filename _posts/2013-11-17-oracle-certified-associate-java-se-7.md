---
layout: post
title: "Oracle Certified Associate, Java SE 7 Programmer: Mi experiencia"
date: 2013-11-18T03:38:00.002Z
last_modified_at: 2013-11-18T03:38:56.948Z
author: "Diego Silva Límaco"
permalink: /2013/11/oracle-certified-associate-java-se-7.html
canonical_url: https://www.apuntesdejava.com/2013/11/oracle-certified-associate-java-se-7.html
tags:
  - "certificación"
  - "comentarios"
  - "off topic"
---

[![]({{ '/assets/blogger/OCA_JavaSE7Programmer_clr.png' | relative_url }})]({{ '/assets/blogger/OCA_JavaSE7Programmer_clr.png' | relative_url }})

Los que me siguen en [Facebook](http://facebook.com/apuntesdejava) y [Google+](http://google.com/+apuntesdejava) habrán notado que de cuando en cuando he estado posteando preguntas de "tipo certificación". No era para retarlos, ni para ver quien sabía más. Sencillamente era para compartir con ustedes - los seguidores de este humilde blog - algunas preguntas curiosas que he encontrado mientras estaba estudiando para mi primer examen de certificación: la [OCAJP 7](http://education.oracle.com/pls/web_prod-plq-dad/db_pages.getpage?page_id=458&get_params=p_track_id:JSE7Prog). Y, gracias a Dios, y a mucho estudio, aprobé `:)`. Y en este post quiero compartir mi experiencia para poder aprobar este examen.

Para empezar, antes de que Sun fuera adquirido por completo por Oracle, Sun estuvo lanzando masivamente ofertas de certificación a través de los Centros de Estudios afiliados a Sun, entre ellos estaban las universidad. En esa vez, yo me preparé para la versión última de ese momento: la SCJP 5. Me conseguí un libro electrónico, lo imprimí (en ese tiempo no habían *tablets*), estudié todo el libro, no habían muchos simuladores de examen ( y si habían, eran realmente caros) y por motivos económicos, no pude dar el examen, y yo ya había dejado de estudiar en la universidad. Así que mis sueños de dar mi examen de certificación se esfumaron. Y esperé a que la adquisición por parte de Oracle mejorara las certificaciones, aunque corriera el riesgo de que pasaran muchos años, se pusieran más estrictos en los exámenes, y se esfumaran por completo mis ganas de certificarme.

Lo bueno que lo aprendido en ese libro me ayudó mucho para mejorar las sintaxis de los programas, por lo tanto, aprendí más haciendo de lo aprendido, practiqué continuamente las mejores prácticas de codificación Java, y compartí con los demás todas las maravillas de Java.

Y pasó lo que estaba esperando: toda el plan curricular de la certificación de Oracle cambió, no sé si fue para bien o para mal, pero era diferente.

Antes, con Sun, la certificación "associate" era:

- Básica

- Solo era para conocer un poco de la arquitectura Java

- No venía sintaxis, ni nada de compilador

- Y, sobretodo, opcional. Por tanto, casi nadie la tomaba

Y, la de tipo "programmer" sí era:

- Más sintaxis

- Uso del compilador

- Uso del empaquetador

- Buenas prácticas de codificación.

- Manejo de archivos (InputStream / OutputStream)

- Más tópicos en menos tiempo para responder.

- y, Si querías subir un nivel de certificación, necesariamente deberías pasar primero este examen.

Pasó la SCJP 6, que ya estaba migrando a la OCJP6 (prefijo O de Oracle), y entre el 2012 y 2013 ya se completó el nuevo modelo de examen de certificación de Oracle, y se lanzó para la versión Java 7

Ahora, [el examen "associate"](http://education.oracle.com/pls/web_prod-plq-dad/db_pages.getpage?page_id=5001&get_params=p_exam_id:1Z0-803&p_org_id=&lang=) es:

- El primer de todo tipo de certificación: ni no apruebas este, no puedes dar otro examen.(Ya no era opcional)

- Entra más codificación, compilación, sintaxis, buenas práctica, parámetros, teoría de objetos

- NO entraban Streams, ni empaquetación

- Menos tópicos que el SCJP5

- Era el primer examen para ser certificado como Programador (sí, solo era el examen I).

Y [el examen "programmer"](http://education.oracle.com/pls/web_prod-plq-dad/db_pages.getpage?page_id=5001&get_params=p_exam_id:1Z0-804&p_org_id=&lang=) se extendió un poco más:

- Empaquetación

- UML

- Manejo de archivos

- Manejo de base de datos (lo cual me parece bien, ya que uno termina haciendo programas con base de datos)

- Diseño de clases

- Principios de POO

- Genericos y colecciones (esto era parte del SCJP5)

- Hilos y concurrencia

- y más que lo verán en el link: [http://education.oracle.com/pls/web_prod-plq-dad/db_pages.getpage?page_id=5001&get_params=p_exam_id:1Z0-804&p_org_id=&lang=](http://education.oracle.com/pls/web_prod-plq-dad/db_pages.getpage?page_id=5001&get_params=p_exam_id:1Z0-804&p_org_id=&lang=)

Continuando con mi preparación de examen, me conseguí el libro para dar el examen de OCAJ7 1Z0-803  (ahora podía leerlo desde mi celular) y me compré un simulador. Este simulador es realmente barato. Se llama [http://enthuware.com/](http://enthuware.com/)

Este simulador tiene una técnica muy buena para aprender para el examen: Al final de cada simulación de examen, uno puede ver las respuestas malas y está explicada cada respuesta por qué es correcta y por qué es incorrecta. Si había dudas, uno podía entrar a un foro para discutir la respuesta y aclarar las dudas. Además, tiene un método de aprendizaje llamado "Leitner" que permite repasar pregunta por pregunta y validar las respuestas en ese momento: si la respuesta es correcta, pasará a otro nivel, y si falla una pregunta, volverá a empezar nuevamente el aprendizaje. La idea no es aprender las respuestas, sino el motivo de las respuestas. Esta técnica me ayudó muchísimo. Ejecutaba el simulador una vez al día, practicaba mis respuestas, y si tenía dudas, las verificaba con el compilador, o con el libro.

Finalmente llegó el día de mi examen. No puedo negar que me llené de mucha ansiedad, pero con mucha oración por tranquilidad (claro, no le voy a pedir a Dios de que me sople las respuestas) comencé a ver las preguntas del examen. Y me di cuenta de algo: las preguntas del examen eran más fáciles que la del simulador. Pensé que era una broma... pero las preguntas de sintaxis eran mucho más difíciles del simulador que del examen mismo. Claro, habían preguntas realmente complicadas, pero fueron pocas.

El simulador me ayudó mucho en lo siguiente, y es lo que les quiero compartir si quieren dar este examen de certificación:

- Aunque parezca obvio, la pregunta está compuesta por el enunciado, la pregunta en sí, y en las respuestas. Es decir, no hay que guiarse por la primera respuesta que uno encuentra, sino uno debe encontrar la mejor respuesta. En el examen, había una pregunta que decía "dada la siguiente clase.." (y mostraba una clase con atributos públicos, y un método set) "... cuál es la manera de cambiar un atributo". y de las cinco preguntas, tres eran obviamente malas que ni compilaba en el papel , pero dos eran:
- obj.name="Jhon";
- obj.setName("Jhon");
Ambos códigos cambiaban el valor del atributo, pero solo podía marcar uno. Entonces ¿cuál era la respuesta correcta? Naturalmente la que usa el método "set".

- Las alternativas son para que uno se confunda, se emocione y marque mal. Por tanto, hay que leer todas las alternativas. Una pregunta decía: con cual método uno puede ejecutar una clase, y estas eran las alternativas:
- public static void main(String arg)
- public static void Main(String[] arg)
- static public void main(String[] arg)
- public static main(String[] arg)
- public static void main(String[] arg)
Y debía de marcar dos. Por emoción marqué la primera y la tercera, pero cuando vi la quinta,entré en duda... la comparé con la primera y me di cuenta en el error que casi caigo ¿puedes ver por qué?

- Un buen amigo me dijo hace tiempo: si ves que entre las alternativas hay una que dice "no compila", casi siempre esa es la respuesta, así que antes que analices la lógica del programa, verifica la sintaxis. Y así fue: habían las clásicas preguntas "qué imprime este programa" y habían unos bucles espantosos, con variables con nombres raros, con varías lineas... y encontré una alternativa que decía "no compila"... verifiqué la sintaxis... y cierto, no compilaba.

- Durante el estudio, no solo quedarse con lo que dice el libro o el simulador, sino: toma el compilador o el IDE y ve probando todas las posibilidades que se te ocurran con la pregunta. Como dice un viejo dicho: "la práctica hace al maestro".

Pues bien, aprobé con 93% siendo el mínimo para aprobar 77% de 90 preguntas. (en qué habré fallado?) Aunque también hay casos que [aprobaron al 100%](http://www.coderanch.com/t/623836/sr/certification/Passed-OCAJP-today).

Te animo a que des tu examen de certificación. Si tienes experiencia en programación en Java, mejórala estudiando. Yo al inicio me creía que sabía mucho, y me estrellé contra una pared de granito cuando resolví las primeras preguntas del libro de SCJP5. Me bajó de mi nube, me volvió humilde y a no presumir, y aprendí mucho más de lo que necesitaba. Una buena experiencia acompañada de un "cartón" que dice que sabes, vale mucho más que la experiencia sola o que el cartón solo.

Ahora, voy a prepararme para la siguiente certificación, así que no se molesten si posteo algunas preguntas de certificación en el FB y el G+.

**Un abrazo a todos, **

**Bendiciones..!**
