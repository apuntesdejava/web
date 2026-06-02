---
layout: post
title: "Descargar XLS y PDF sin abrirlos en el navegador"
date: 2007-04-10T19:23:00Z
last_modified_at: 2009-04-25T21:55:03.825Z
author: "Diego Silva"
permalink: /2007/04/descargar-xls-y-pdf-sin-abrirlos-en-el.html
canonical_url: https://www.apuntesdejava.com/2007/04/descargar-xls-y-pdf-sin-abrirlos-en-el.html
tags:
  - "php"
  - "web"
---

Más de uno ha querido solucionar este problema: un link en un archivo para descargar un XLS o PDF (o DOC) sin que se abra en el navegador. Pues aquí tengo la solución (con PHP)

Primero, los enlaces deberían como estos:
`
<a href="download.php?link=Plantilla.xlt">XLT</a>
<a href="download.php?link=Libro.pdf">PDF</a>
`
Y el archivo download.php es el siguiente:

<?php $doc=$_GET["link"];
header('Content-Type:application/octet-stream');
header('Content-Disposition:attachment; filename="'.$doc.'"');
readfile($doc);
?>
