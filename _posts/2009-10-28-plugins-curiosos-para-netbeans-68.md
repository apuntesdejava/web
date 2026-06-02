---
layout: post
title: "Plugins curiosos para NetBeans 6.8"
date: 2009-10-28T20:15:00Z
last_modified_at: 2009-10-28T20:15:05.283Z
author: "Diego Silva"
permalink: /2009/10/plugins-curiosos-para-netbeans-68.html
canonical_url: https://www.apuntesdejava.com/2009/10/plugins-curiosos-para-netbeans-68.html
tags:
  - "netbeans 6.8"
  - "java"
  - "netbeans"
  - "tips"
---

Considero que la capacidad de un software también se mide por la de sus complementos.

Aún no sale la versión oficial de NB 6.8 (en este momento está en versión [Beta](http://www.netbeans.org/community/releases/68/)) y he podido ver algunos *plugins* que me llaman la atención.

Para este post, estoy utilizando la versión construida el 28/10/2009 (o sea, el día que escribo este post).

Los plugins (en orden alfabético, y no por preferencia) que considero interesantes hoy, son los siguientes:

- Entity Relationship Diagrama Support

- Explore from here

- Graphical Class View

- Java Go to implementation

- Run Terminal

- User tasks

Comencemos...

Previa instalación de los plugins desde Tools > plugins, y previa lectura de la licencia (la que nadie lee ninguno leemos), y después del reinicio del IDE, nos pondremos  probar cada uno de estos plugins, y ver si son buenos o no. Ya ustedes hacen su veredicto.

**1. Entity Relationship Diagrama Support**

Tenemos una base de datos, con relaciones, contraints, foreing keys y demás cosas propias de una base de datos. Le podriamos pedir al DBA que nos dé su diagrama de entidad-relación, pues para saber qué vamos a trabajar. O quizás se hizo la base de datos usando la capacidad mental de un DBA: de memoria. (Recomiendo usar mejor una diagrama ER antes de crear las tablas). Existen diagramadores de ER que hacen ingenieria inversa a una base de datos creada, por ejemplo el MySQL Workbench, y otros más para otros más. Este plugin de NB no hace ingeniera inversa (ya que no vamos a hacer un modelo editable) solo nos muestra cómo está la base de datos en este momento. Y esto es lo que haremos:

[](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjjIZIYe2ROiMtxPvVw5N-OCrzGvlNBoCsYs3-lwDZ7cRduaXPbfgkTm79wRzR9PFaB-IdMt_I89z-_46bcGlyF6B5zOEWdP6vxSQ1PV0LGSz7cihf-H-BeqVB62jDoDaRlOFrZel-_Dl6/s1600-h/nb-er3.jpg)

- Debemos tener una conexión desde NB a una base de datos en el panel Services (Ctrl+5). Naturalmente, el JDBC de una base de datos ya debe existir.

- También debemos tener un proyecto ya trabajando. Desde ahí, creamos un nuevo archivo (File > New File o Ctrl+N) y seleccionamos la categoría "Persistence" y el tipo de archivo "ER Diagram"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNWc0FL5SdEAXQJ_jbN6525OGfozre36ILAJ-u459zhSY5YA5j_oxWX8oyVnTqPVoGY_SnCUcNMbAYOScBZ8D6tuMfAI3MeBtAc1wt22HieNvr9s3d8gOPJggDIFJTdq3_cvBoGi6WzMSx/s400/nb-er.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjNWc0FL5SdEAXQJ_jbN6525OGfozre36ILAJ-u459zhSY5YA5j_oxWX8oyVnTqPVoGY_SnCUcNMbAYOScBZ8D6tuMfAI3MeBtAc1wt22HieNvr9s3d8gOPJggDIFJTdq3_cvBoGi6WzMSx/s1600-h/nb-er.jpg)

- Clic en "Next". Indicamos el nombre del archivo y la ubicación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiIXN6g_nl6ZHUXz3SCXGCZ8LCi-WZW4CWaomvWZPxsRjCzPqMhoJsSwiKodPRAn5WwmUElfHffjKAN2NaNhIladLJRJQdxP3OQf2FP0hZBxjmKX5qJwpjeSehFE0YRlIjQvc2SU3NZ8YYh/s320/nb-er2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiIXN6g_nl6ZHUXz3SCXGCZ8LCi-WZW4CWaomvWZPxsRjCzPqMhoJsSwiKodPRAn5WwmUElfHffjKAN2NaNhIladLJRJQdxP3OQf2FP0hZBxjmKX5qJwpjeSehFE0YRlIjQvc2SU3NZ8YYh/s1600-h/nb-er2.jpg)

- Clic en Next. Seleccionamos la conexión de la base de datos que vamos a trabajar. Este debió de haberse creado previamente, como se mencionó en el paso 1.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjjIZIYe2ROiMtxPvVw5N-OCrzGvlNBoCsYs3-lwDZ7cRduaXPbfgkTm79wRzR9PFaB-IdMt_I89z-_46bcGlyF6B5zOEWdP6vxSQ1PV0LGSz7cihf-H-BeqVB62jDoDaRlOFrZel-_Dl6/s320/nb-er3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjjjIZIYe2ROiMtxPvVw5N-OCrzGvlNBoCsYs3-lwDZ7cRduaXPbfgkTm79wRzR9PFaB-IdMt_I89z-_46bcGlyF6B5zOEWdP6vxSQ1PV0LGSz7cihf-H-BeqVB62jDoDaRlOFrZel-_Dl6/s1600-h/nb-er3.jpg)

- Clic en Finish. Encontraremos el archivo creado en el explorador del proyecto.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZnsjzkakrOcoFSj0G6NSe6iMRkDebap95f3Atw7TCCt_kdws3uM2W-8uDdhUmwHSsDFqWoJ24EV50PN5l6eznlLj4-vu1BlVpJ_9DVHQINimOnemLxjvfWXSnKgPg57L_WsbPCgeeWN5B/s320/nb-er4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZnsjzkakrOcoFSj0G6NSe6iMRkDebap95f3Atw7TCCt_kdws3uM2W-8uDdhUmwHSsDFqWoJ24EV50PN5l6eznlLj4-vu1BlVpJ_9DVHQINimOnemLxjvfWXSnKgPg57L_WsbPCgeeWN5B/s1600-h/nb-er4.jpg)

- Y al abrirlo, veremos la tablas de la base de datos y sus respectivas relaciones.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEggyg5R1PyjjdWlo7cmLckclT3U0lIbMfHQR2UV_2BcnQPjiTxM_tgFrJyAw78GzJ8-hOo2yEj6jrNgqdsV7rN3IWLnm92T9wBncmkMmZzbVnbruLBz-QO4MQIGXh8aLVwf5LydS77qclQL/s320/nb-er5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEggyg5R1PyjjdWlo7cmLckclT3U0lIbMfHQR2UV_2BcnQPjiTxM_tgFrJyAw78GzJ8-hOo2yEj6jrNgqdsV7rN3IWLnm92T9wBncmkMmZzbVnbruLBz-QO4MQIGXh8aLVwf5LydS77qclQL/s1600-h/nb-er5.jpg)

**2. Explore here**

¿El proyecto es tan grande que necesitamos concentrarnos en una carpeta o en un paquete?

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj00wGEVC-d9uI4Hqjp-Gf-JoLs8O8sTbxrdXpB2tgUr0J9RbtPlv6sBgbtAoNdU5NZeefwrpb_EEP_7oA1Ma9FPSCqqtswdYuvwIb8pUkPJDRbNhBXHL-XVU5hc1iTouWHwfPX9h6RSJig/s320/nb-eh1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj00wGEVC-d9uI4Hqjp-Gf-JoLs8O8sTbxrdXpB2tgUr0J9RbtPlv6sBgbtAoNdU5NZeefwrpb_EEP_7oA1Ma9FPSCqqtswdYuvwIb8pUkPJDRbNhBXHL-XVU5hc1iTouWHwfPX9h6RSJig/s1600-h/nb-eh1.jpg)

Bueno, aquí está la solución. Clic derecho sobre la carpeta, seleccionar "Explore here"...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJRBeA-4AeLMFPE0PoZ0YYiv2TIL6cAJ3Rw6YHM8bftevbzuYwC_PeMU4R8IQCivzGFwMtcn9pBq5Fr11GcBxtpgyQOe663bXkFxhIhronzHICTSxa8JudK8JcM2BXBVKWZChFdAcynz_-/s320/nb-eh2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJRBeA-4AeLMFPE0PoZ0YYiv2TIL6cAJ3Rw6YHM8bftevbzuYwC_PeMU4R8IQCivzGFwMtcn9pBq5Fr11GcBxtpgyQOe663bXkFxhIhronzHICTSxa8JudK8JcM2BXBVKWZChFdAcynz_-/s1600-h/nb-eh2.jpg)

... y listo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1rL31TIlHs5Kvh-WaZl_PTX-e8C3xPIlW-_hZFCNCI_gdRG9iOfIOuAb8GNzogZRR6n8GrC-622H4gbjwc_zjQj1U6eIxPDn-guNPzA0SK5Bq8uSJ47SJ70m4haCvpr-bDZ0O6o4Fd02F/s320/nb-eh3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1rL31TIlHs5Kvh-WaZl_PTX-e8C3xPIlW-_hZFCNCI_gdRG9iOfIOuAb8GNzogZRR6n8GrC-622H4gbjwc_zjQj1U6eIxPDn-guNPzA0SK5Bq8uSJ47SJ70m4haCvpr-bDZ0O6o4Fd02F/s1600-h/nb-eh3.jpg)

**3. Graphical Class View**

"Una imagen vale más que mil palabras" (dicho popular)

"Perdimos una imagen, consigan mil palabras" (Dr. House).

Tenemos asociaciones de clases, interacciones entre ellas, variables de tipo clase, etc.. y perdimos el rastro.

Clic derecho sobre una clase, y seleccionar "graphical view"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyAADHGZTh8-fd9YmTsNArGk3I4XGrWjMfWGIUBReT3RyK-QHN7oSYd87yAyNfZthgLAdt12q9mQDS8lvVtC5vlxeoWwPGBDORG5sMK_eHt_JMKaa7bRvoqdDjY5dBPjK74VdP3-KuOD-b/s320/nb-gv1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyAADHGZTh8-fd9YmTsNArGk3I4XGrWjMfWGIUBReT3RyK-QHN7oSYd87yAyNfZthgLAdt12q9mQDS8lvVtC5vlxeoWwPGBDORG5sMK_eHt_JMKaa7bRvoqdDjY5dBPjK74VdP3-KuOD-b/s1600-h/nb-gv1.jpg)

Y después de un instante, se verán las asociaciones

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjB4NjqyAA_BMrrwxoYGlD_yWpnwEuvPs7o4UwfIoch-pHl8xt0DgB8nn5DqSldibHc6ek5kDBhyvGwVcuIHRSEISVbfcwZuFdq3UKM9M4PIuHWof9nuw3P-go6DO2vv5QCgRuQjNP_sDth/s320/nb-gv2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjB4NjqyAA_BMrrwxoYGlD_yWpnwEuvPs7o4UwfIoch-pHl8xt0DgB8nn5DqSldibHc6ek5kDBhyvGwVcuIHRSEISVbfcwZuFdq3UKM9M4PIuHWof9nuw3P-go6DO2vv5QCgRuQjNP_sDth/s1600-h/nb-gv2.jpg)

OJO: no es un diagrama de clases UML, es solo una representación de cómo interactúan con la clase seleccionada.

**4. Java Go to implementation**

Esta funcionalidad la vi en Eclipse, y recién vi un plugin de NB en la versión 6.7.

Tenemos una interfaz o una clase abstracta con métodos abstractos. Queremos saber y ver las clases que lo implementan. Clic derecho sobre el método que el método abstracto. Seleccionar Navigate > Go to implementation

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjiGxaGZqEKeb-p0jMlbGU0vfZSRJV-Gravaj3g3llZ-YgDudqKq59PQIDJQMvlXcjOiyhjudrWEYWvTUEuVu1LvyIrpqSsFGVv7TYIKCvLMV3LnhtGD3kEnCmMEqzgd8hh4NqD2NCfoi8G/s320/nb-gti1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjiGxaGZqEKeb-p0jMlbGU0vfZSRJV-Gravaj3g3llZ-YgDudqKq59PQIDJQMvlXcjOiyhjudrWEYWvTUEuVu1LvyIrpqSsFGVv7TYIKCvLMV3LnhtGD3kEnCmMEqzgd8hh4NqD2NCfoi8G/s1600-h/nb-gti1.jpg)

Se mostrará los métodos que lo implementan.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhW34ZrFeHaJTWQCcU1dS6ljv3vO9nFxpvQ_y84yJ0KRb4W_UyGtN5BiE2PYdWIeuzrpc0k0cuv0kyBZV-adpocBC-D_1kxp2_0PN1yLsC-6AC2R3dJ6CsumYdFLBIKxDgIfKQqmXmyf4_G/s320/nb-gti2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhW34ZrFeHaJTWQCcU1dS6ljv3vO9nFxpvQ_y84yJ0KRb4W_UyGtN5BiE2PYdWIeuzrpc0k0cuv0kyBZV-adpocBC-D_1kxp2_0PN1yLsC-6AC2R3dJ6CsumYdFLBIKxDgIfKQqmXmyf4_G/s1600-h/nb-gti2.jpg)

Seleccionamos uno y el NB nos mostrará la implementación.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7ht7kyYWFoEWmMTivT53aaNXUGV9aSFpKvLPHfYh_3zdBWkwMswBrEP0pn8DCw4V-CxFp7BCb7T2Hp4M1W9IqFOHm4z6l6Z4_rGMjO8hkCL3WXRerx02PbOBOJKpHIQYfqe14FIJbpRa8/s320/nb-gti3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj7ht7kyYWFoEWmMTivT53aaNXUGV9aSFpKvLPHfYh_3zdBWkwMswBrEP0pn8DCw4V-CxFp7BCb7T2Hp4M1W9IqFOHm4z6l6Z4_rGMjO8hkCL3WXRerx02PbOBOJKpHIQYfqe14FIJbpRa8/s1600-h/nb-gti3.jpg)

**5. Run Terminal**

Para mi es muy útil: Quiero entrar desde la consola del sistema operativo al contenido de una carpeta o paquete. Tendría que abrir una ventana del consola del sistema operativo, y luego hacer cd hasta llegar al directorio. Con este plugin es más fácil. Solo hacemos clic derecho sobre la carpeta que queremos acceder en la consola, y seleccionamos Tools > Run Terminal.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFkaor-LaDxLDEuuvqXK1g4t74maRV8AxaPnF8DYQVGWFS4TrcAYqH7FKMat7wWVo_nOpW2dPeem1b8tB-Smu2W42faugwJ2pIKjEirwVQtcetzMffbx7I6DAzSQAyZzPKBtET1KHxYDBM/s320/nb-rt1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFkaor-LaDxLDEuuvqXK1g4t74maRV8AxaPnF8DYQVGWFS4TrcAYqH7FKMat7wWVo_nOpW2dPeem1b8tB-Smu2W42faugwJ2pIKjEirwVQtcetzMffbx7I6DAzSQAyZzPKBtET1KHxYDBM/s1600-h/nb-rt1.jpg)

Y listo.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZ7GAvEONHW2H3s9KpHXMSUda1imbrp4EYJQMfZznHOroKbjqW-3OZEVUm-qSZFCmmxnDDFXQvRNHl08WXDbKfLeV5BgC9daT3F9IqADABmU5kWSzWvilVjC3QTb00p_D-YoYutj428EZe/s320/nb-rt2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZ7GAvEONHW2H3s9KpHXMSUda1imbrp4EYJQMfZznHOroKbjqW-3OZEVUm-qSZFCmmxnDDFXQvRNHl08WXDbKfLeV5BgC9daT3F9IqADABmU5kWSzWvilVjC3QTb00p_D-YoYutj428EZe/s1600-h/nb-rt2.jpg)

**6. User tasks**

 Si no tenemos una lista de lo que tenemos que hacer, no sabremos qué vamos hacer. Es mejor tener una lista de tareas.. y además saber cuánto demoramos en resolver una tarea... y cuánto no hacemos nada.

Este plugin lo vi desde la version 6.1. Es muy útil. Permite al desarrollador listar todas las tareas que tiene que hacer, y también permite definir subtareas. Todas estas pueden estar asociadas a una línea de código especial.

Podemos acceder a él, desde Window > Other > User tasks.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhMbkdoqpFzHK1Cq37DKSSLdjOLxXog7Yk6Zx4CR2H2G_UdRdKzVda57kK585vgjdyZlxt4RNtqyjzfE4QkbIOah9iKQH-LcJ3IEFsFDGP6_7NhjdsHut-gzirdruhqNKMi0g75e6AlgnXv/s320/nb-ut.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhMbkdoqpFzHK1Cq37DKSSLdjOLxXog7Yk6Zx4CR2H2G_UdRdKzVda57kK585vgjdyZlxt4RNtqyjzfE4QkbIOah9iKQH-LcJ3IEFsFDGP6_7NhjdsHut-gzirdruhqNKMi0g75e6AlgnXv/s1600-h/nb-ut.jpg)

Es un panel inferior al editor. Ahí demos declarar nuestras tareas. Y cuando queremos hacer seguimiento a nuestro trabajo, presionamos en el botón verde (o clic derecho y seleccinamos Start). El plugin detectará cuanto tiempo estamos trabajando en el IDE. Y cuando seleccionamos "Pause", no registrará el tiempo. Se supondrá que hemos detenido nuestro trabajo. Luego, podemos indicar cuánto del trabajo hemos avanzado. Cuando esté el 100% de la tarea, el plugin nos dirá cuánto tiempo realmente nos hemos dedicado a esta tarea.

Así que con esto podemos asegurar a nuestro jefe que hemos trabajo....  o nos puede condenar.

Hay muchos más plugins, que ya no me dió tiempo de postearlo. Así que después seguiré continuando con este tipo de artículo.
