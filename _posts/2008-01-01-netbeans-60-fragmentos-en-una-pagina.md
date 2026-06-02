---
layout: post
title: "NetBeans 6.0 - Fragmentos en una página web con Visual JSF"
date: 2008-01-02T01:12:00Z
last_modified_at: 2009-04-25T21:55:03.309Z
author: "Diego Silva"
permalink: /2008/01/netbeans-60-fragmentos-en-una-pagina.html
canonical_url: https://www.apuntesdejava.com/2008/01/netbeans-60-fragmentos-en-una-pagina.html
tags:
  - "tiles"
  - "netbeans"
  - "jsf"
  - "web"
---

Cuando desarrollamos en web, muchas veces nos hemos encontrado con la necesidad de repetir un fragmento de la página, ya sea el título, el menú principal, el banner superior.. etc.

JSF tiene la característica de reutilizar fragmentos de páginas, de tal manera solo editaríamos el fragmento del contenido y toda la web siempre usarán los mismos fragmentos.

NetBeans 6.0 viene con el plugin Visual JSF que permite la programación y diseño visual de la web sobre JSF. Aquí veremos un ejemplo aplicado.

## ¿Qué necesitamos?

- NetBeans 6.0
- El plugin Visual JSF. Esto se puede encontrar en Tools > Plugins, y en la pestaña Installed buscamos Visual JSF. Si no se encuentra, lo podemos decargar de la pestalla Available Plugins.
- Descargar el siguiente banner

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhPlD6acCFVa_BfWytBbpn0cyiOGRd1YiSvNfLxlFpNhW_enzCKK2u7WOp4atpetFwQwQwEtaqLquyMKoVG6-rn62Fr54pFXwGc6UjlvKzraaanna8aJGxYm_r4jmhBiTn550zbH74ZxoBJ/s320/java-banner.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhPlD6acCFVa_BfWytBbpn0cyiOGRd1YiSvNfLxlFpNhW_enzCKK2u7WOp4atpetFwQwQwEtaqLquyMKoVG6-rn62Fr54pFXwGc6UjlvKzraaanna8aJGxYm_r4jmhBiTn550zbH74ZxoBJ/s1600-h/java-banner.jpg)

## Creando el proyecto web

-  Elegimos File > New project, seleccionamos de la categoría "Web" el proyecto "Web Application".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhbokVgGotjVTWOdMenA7huDjL_kkh24Pw3fyYSlUdhBxrbFqjcmPxEn0D4-nHm0PWpX8BX-_CYpBqc-ErsavnC6vZCp1qio6OJfJa4LwznOT144udxK0lDRqGVb9hX_g9bGXwITUN5WWES/s320/fragment1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhbokVgGotjVTWOdMenA7huDjL_kkh24Pw3fyYSlUdhBxrbFqjcmPxEn0D4-nHm0PWpX8BX-_CYpBqc-ErsavnC6vZCp1qio6OJfJa4LwznOT144udxK0lDRqGVb9hX_g9bGXwITUN5WWES/s1600-h/fragment1.jpg)Clic en "Next"
- Escribimos como nombre del proyecto DemoFragment
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhfQz4RizvjFzHLlF6auOEj85jJSdqUs9tG6iGihjG8lb97aHilx6QCp6D51Imzu43Ngg-S6QhojYaawt2zcY2rpSSFYC1aPvNP9l496Z28p-zBBGoCWkSo4pfHeUSPO-FlUdAppxEbJG4H/s320/fragment2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhfQz4RizvjFzHLlF6auOEj85jJSdqUs9tG6iGihjG8lb97aHilx6QCp6D51Imzu43Ngg-S6QhojYaawt2zcY2rpSSFYC1aPvNP9l496Z28p-zBBGoCWkSo4pfHeUSPO-FlUdAppxEbJG4H/s1600-h/fragment2.jpg)Clic en "Next".
- Activamos el framework "Visual Web JavaServer Faces"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiXsCo_MfTiSKNzYpuCA1I-FcL8GNZsaQG_fyd6sRI7e2e5FHYQTXdAD2un72fDDAcVwmeUIbs2YVWMI_wXgjiU1BZcNPuKiQV5M2NDkNU1vGV4LpFw1Qcf7yUD05LseSwKgDhiXqwG1g6Z/s320/fragment3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiXsCo_MfTiSKNzYpuCA1I-FcL8GNZsaQG_fyd6sRI7e2e5FHYQTXdAD2un72fDDAcVwmeUIbs2YVWMI_wXgjiU1BZcNPuKiQV5M2NDkNU1vGV4LpFw1Qcf7yUD05LseSwKgDhiXqwG1g6Z/s1600-h/fragment3.jpg)Clic en "Finish"
Con eso ya tenemos nuestro proyecto inicial, y se nos muestra el archivo Page1.jsp desde un editor visual.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZRs9j4DppfNugus7pUIJN6fUOpD5JgpIAEm2LrD1B71bKVD7_QdFDEskKbcIpM505EQ4HAqCZdUGHHIHpVKKybbkBFcsuu5ohNd-jk64-0qqGw2fO2tqvo1n_X6hbzPGJpKVg8MtMzQFr/s320/fragment4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjZRs9j4DppfNugus7pUIJN6fUOpD5JgpIAEm2LrD1B71bKVD7_QdFDEskKbcIpM505EQ4HAqCZdUGHHIHpVKKybbkBFcsuu5ohNd-jk64-0qqGw2fO2tqvo1n_X6hbzPGJpKVg8MtMzQFr/s1600-h/fragment4.jpg)
Muy parecido cuando diseñamos los formularios Swing... tiene la paleta de controles en el lado derecho, y podemos arrástralos y ponerlo en la web. Todo un lujo.

## Diseñando la página que tendrá los fragmentos

 A este .jsp le definiremos regiones que serán fragmentos de otras páginas, para ello hacemos lo siguiente:

- Presionamos Ctrl + Shift + 8 para mostrar la paleta de componentes. Luego seleccionamos de la sección "Layout" el componente "Page Fragment Box".
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgHKT_HsEPNX-5XRBJEOHbDvQtWDlqSACKVlngZzPQpfnb69jLZHMarorw98y4LXaIgsTktpKWPKcxVrzBSAH4cSiCyQLew-uM_q5_aGG_Be8Q673XBDgcIm3-Z6eO7u-8lRInOwevk-jWD/s320/fragment5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgHKT_HsEPNX-5XRBJEOHbDvQtWDlqSACKVlngZzPQpfnb69jLZHMarorw98y4LXaIgsTktpKWPKcxVrzBSAH4cSiCyQLew-uM_q5_aGG_Be8Q673XBDgcIm3-Z6eO7u-8lRInOwevk-jWD/s1600-h/fragment5.jpg)Lo arrastramos y lo soltamos sobre la esquina superior izquierda de Page1.jsp.

- Nos mostrará la ventana  "Select Page Fragment" [![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZGYy96QD5LDEkcFtBAB751FLQDYKquFN9q0XtuZAuqUzNwfocaiE4zlOjSRQ-Rihw_zgp_9sgeguycuGlZY7sLX81kyPA15e0JB33W37Lt6ZM-PZrh_lCPF0aqO8OCLh_tYoPkAp23rL-/s320/fragment6.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZGYy96QD5LDEkcFtBAB751FLQDYKquFN9q0XtuZAuqUzNwfocaiE4zlOjSRQ-Rihw_zgp_9sgeguycuGlZY7sLX81kyPA15e0JB33W37Lt6ZM-PZrh_lCPF0aqO8OCLh_tYoPkAp23rL-/s1600-h/fragment6.jpg)
Como no hay ningún fragmento anterior, hacemos clic en el botón "Create New Page Fragment".

- Escribimos como nombre de fragmento el valor "banner".
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEic_8oRTZB1uV2Dz04Dk0WYos2Z3BMmqbguxImjWq6d55iNge2b1pGf28samwcf0dasPgX_V8XWg_cOnM8fXkE4tjCSGZ1Tb0YC14ZsJd2EPIz8zOg7Zoet0JbIUP6VNe_0Rz-fg0yvqPvP/s320/fragment7.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEic_8oRTZB1uV2Dz04Dk0WYos2Z3BMmqbguxImjWq6d55iNge2b1pGf28samwcf0dasPgX_V8XWg_cOnM8fXkE4tjCSGZ1Tb0YC14ZsJd2EPIz8zOg7Zoet0JbIUP6VNe_0Rz-fg0yvqPvP/s1600-h/fragment7.jpg)Clic en "OK"

- Con esto se habrá creado un archivo banner.jspf (JSP Fragment)
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0ntl7hdHbqsmlWKN_jLC2BXzgH5Nin_7zpOi9c7v6yEXZ20fBibkbXNPb9jZu3P8uNbwrYF0fsrpVzPk9cKdcg2JXE651LfjHqzlniJkFaYOV76L-UmtZlq5NUXgILSzUWTw9D1Qa8sAU/s320/fragment10.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh0ntl7hdHbqsmlWKN_jLC2BXzgH5Nin_7zpOi9c7v6yEXZ20fBibkbXNPb9jZu3P8uNbwrYF0fsrpVzPk9cKdcg2JXE651LfjHqzlniJkFaYOV76L-UmtZlq5NUXgILSzUWTw9D1Qa8sAU/s1600-h/fragment10.jpg)También aparece en el panel "Navigator" un tag div indicando que se está incluyendo el banner.jspf
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjM0MKKKBCQamIW4lrN1t89UHybCOXO-zZXALj2gdQmEQvj_ci6xcsZqp-Sulo_fapazkJE-WuJfvqhkLdqax6ZDNWpcGe_9cPJQVJllG5qlLYYsbjGGsySHtVl0wXFTIxhtWJBpGSQ2p01/s320/fragment9.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjM0MKKKBCQamIW4lrN1t89UHybCOXO-zZXALj2gdQmEQvj_ci6xcsZqp-Sulo_fapazkJE-WuJfvqhkLdqax6ZDNWpcGe_9cPJQVJllG5qlLYYsbjGGsySHtVl0wXFTIxhtWJBpGSQ2p01/s1600-h/fragment9.jpg)
y también aparecerá en la lista desplegable.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEipm4fOxI-SRK4lJGwd0VzLeA9wJ4neuiSBzuCcc5W2GBmEIdFm8n083mVdQjfW0ga7OKF9lD_IDrG_oyyR84CKLQ1NoFab2iDNtnV4LRa_-lGkFF3LOUgoNMIlJ6JjpIV3SlbSWp4ZDzMd/s320/fragment8.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEipm4fOxI-SRK4lJGwd0VzLeA9wJ4neuiSBzuCcc5W2GBmEIdFm8n083mVdQjfW0ga7OKF9lD_IDrG_oyyR84CKLQ1NoFab2iDNtnV4LRa_-lGkFF3LOUgoNMIlJ6JjpIV3SlbSWp4ZDzMd/s1600-h/fragment8.jpg)
Así que lo seleccionamos... y hacemos clic en "Close".
Veremos que se el Page1.jsp ahora muestra un rectángulo con líneas punteadas. Por omisión el año de ese rectángulo es de 400 px y 200 de altura.

- Repetiremos del paso 2 al  4 para crear un fragmento llamado "Menu". Solo que esta vez se situará debajo del fragmento "Banner" en el lado izquierdo.

- Desde la paleta, en la sección "Basic" arrastramos un Static Text y lo soltamos a la derecha del fragment Menu que acabamos de colocar. Debe estar al lado derecho del fragmento, no dentro del fragmento. Escribiremos cualquier texto, por ejemplo yo le puse "Java Web Site"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEckLerFCeQa22_uf3ziAToIqHxnraivTK2gSD9jkGGSMsTy2iU3Ajqh3Pbm1t1UrxbZAN_3Ue0cicy2XvKW1hMafE4V8TRQwJpsor9IuIl6I8ZV8N_T-PfJJIlgejjMzjqqENpHld_ozg/s320/fragment11.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEckLerFCeQa22_uf3ziAToIqHxnraivTK2gSD9jkGGSMsTy2iU3Ajqh3Pbm1t1UrxbZAN_3Ue0cicy2XvKW1hMafE4V8TRQwJpsor9IuIl6I8ZV8N_T-PfJJIlgejjMzjqqENpHld_ozg/s1600-h/fragment11.jpg)
- hacemos clic en cualquier parte de la página pero que no tenga un fragmento o el Static text. Luego vamos al panel de Properties (Shift + Ctrl + 7) y escribimos en la propiedad Title el valor "Java Web Site"
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiw6SRQFV0YwBUb0Gdo654VmGyNh5TIyaJxe9fXFfZ9g25yo7Z_4WAh2OFqWcav0NCuv0I5qU9t5s0FFUlP8pKBcVirWWH8OndW8o9y9Gj5JBMSNFkVsIsNCWXoxnTM2_RH8qT4k8m8PXL4/s320/fragment12.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiw6SRQFV0YwBUb0Gdo654VmGyNh5TIyaJxe9fXFfZ9g25yo7Z_4WAh2OFqWcav0NCuv0I5qU9t5s0FFUlP8pKBcVirWWH8OndW8o9y9Gj5JBMSNFkVsIsNCWXoxnTM2_RH8qT4k8m8PXL4/s1600-h/fragment12.jpg)

## Diseñando el fragmento del banner

- Estando aun en el Page1.jsp, hacemos doble clic en el fragmento banner. Esto nos abrirá ese fragmento banner en modo de diseño visual. Sólo desde aquí podemos modificar el tamaño del fragmento desde el panel Properties. Así que editaremos el ancho a 720px y el alto a 125px.
- Desde la paleta, en la sección Basic arrastramos el componente Image y lo soltamos en la parte superior izquierda en el editor visual del fragmento banner.
- Seleccionamos las propiedades de ese image y en la propiedad url seleccionamos la imagen  java-banner.jpg que se mencionó al inicio de este post. Previamente lo habremos descargado y puesto dentro de la carpeta web del proyecto.

- Regresamos al Page1.jsp y veremos que ya se actualizó el contenido del fragmento.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiYguGvfhV2zYCY0cb4qpDOubBYJKmv43P0mV3FtinmvD7kkGEeJLZ5MFgunevP26xZcesA0fxnUIkTOiZtOzq-d6-3wq8H7uw6MKnJYFJzqjQyvWYLsAuf-m0GAYpWA3LuTSajWRMzLFB8/s320/fragment13.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiYguGvfhV2zYCY0cb4qpDOubBYJKmv43P0mV3FtinmvD7kkGEeJLZ5MFgunevP26xZcesA0fxnUIkTOiZtOzq-d6-3wq8H7uw6MKnJYFJzqjQyvWYLsAuf-m0GAYpWA3LuTSajWRMzLFB8/s1600-h/fragment13.jpg)

## Diseñando el fragmento del menú

- Desde el diseño visual de Page1.jsp hacemos doble clic sobre el fragmento menu. Esto nos abrirá el diseñador visual de Menu.jspf
- Desde el panel de propiedades modificaremos el tamaño del fragmento a 150px de ancho y  100px de alto.
- Desde la paleta, en la sección Basic arrastramos un Hyperlink y lo soltamos dentro del diseño del fragmento. Deberá tener como texto "Inicio".
- En las propiedades de ese componente, modificamos la propiedad url y establecemos el valor /faces/Page1.jsp
- Repetimos el paso 3 y 4 para crear un nuevo Hyperlink solo que esta vez el texto del enlace será "Noticias" y el valor de la propiedad url será /faces/News.jsp
Podemos ver el diseño visual de Page1.jsp. Arreglamos un poco los componentes para que vean mejor.
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJdatFk1rR8qTiKhmN4ixBpmkByEUwhX3v4xZNUPsiWmN7_NKZIJmr1hsiSqzMaQ4sbl8hlRb-0KA_zLvZXkwPQ-UU8IkSVCC0tGB8n8l1hIl4YXDUH0vvpIcu2yFC22FqLCsCpAlXUrmU/s320/fragment14.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJdatFk1rR8qTiKhmN4ixBpmkByEUwhX3v4xZNUPsiWmN7_NKZIJmr1hsiSqzMaQ4sbl8hlRb-0KA_zLvZXkwPQ-UU8IkSVCC0tGB8n8l1hIl4YXDUH0vvpIcu2yFC22FqLCsCpAlXUrmU/s1600-h/fragment14.jpg)

## Haciendo la segunda página reutilizando los fragmentos

- Del panel de proyecto, seleccionamos a Page1.jsp. Hacemos clic derecho y seleccionamos Copy.
- Hacemos clic derecho en el nodo Web pages  y seleccionamos Paste. Esto nos creará un archivo llamado Page1_1.jsp.

- Lo renombramos presionando la teclado F2. El nombre nombre será News.
- Aceptamos la refactorización que solicita.
- Abrimos el archivo News.jsp. Vemos que luce igual que Page1.jsp.

- Cambiamos el valor del Static Text a "Noticias", así como la propiedad title de News.jsp.

## Ejecutando el proyecto

Pues simplemente presionamos la tecla F6 y vemos los resultados en el navegador
[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgrMCkipSF0jv0rU7QYsLA5PDAfqUUeHGCu1UNdfy7_dpEH8lrC5XHmSwMpxOXn1SxsJGm4mCkmDCcs5lUdq307-m7FVHvTTgJkWleRjDpJP8RcmX5D5mvtFmyH8C2JWPkN2iRM3q6irzNO/s320/fragment15.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgrMCkipSF0jv0rU7QYsLA5PDAfqUUeHGCu1UNdfy7_dpEH8lrC5XHmSwMpxOXn1SxsJGm4mCkmDCcs5lUdq307-m7FVHvTTgJkWleRjDpJP8RcmX5D5mvtFmyH8C2JWPkN2iRM3q6irzNO/s1600-h/fragment15.jpg)Y cuando hacemos clic en cualquiera de los enlaces, ambas páginas muestran el mismo diseño.

## Finalmente

 En adelante, cuando hagamos una web usando fragmentos, solo nos preocuparemos en modificar los .jsp que tienen el contenido, ya que los fragmentos siempre serán los mismos para todos.

## Recursos

El proyecto que usé en este post está disponible aquí: [http://diesil-java.googlecode.com/files/DemoFragment.tar.gz](http://diesil-java.googlecode.com/files/DemoFragment.tar.gz)
