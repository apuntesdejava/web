---
layout: post
title: "Instalando Portal Pack en NetBeans 6.9"
date: 2010-07-02T05:00:00.040Z
last_modified_at: 2010-07-02T05:00:00.492Z
author: "Diego Silva"
permalink: /2010/07/instalando-portal-pack-en-netbeans-69.html
canonical_url: https://www.apuntesdejava.com/2010/07/instalando-portal-pack-en-netbeans-69.html
tags:
  - "netbeans 6.9"
  - "web"
  - "portalpack"
  - "tutorial"
  - "netbeans"
  - "portlets"
---

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiA5n_4TCgJzZw3VpijdtcPpERWFqYgnxkHbjT-lDmqqgb-YXFzAykrgpzFQe-LSViv5ijd7GIvA9PEGdtIDqx2NR2J4K_EVgfNLYy5T6ctEkqtkUtILFvrrJr12ArazUkCUPIffKM6jLzX/s1600/portal-pack-site-logo-medium.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiA5n_4TCgJzZw3VpijdtcPpERWFqYgnxkHbjT-lDmqqgb-YXFzAykrgpzFQe-LSViv5ijd7GIvA9PEGdtIDqx2NR2J4K_EVgfNLYy5T6ctEkqtkUtILFvrrJr12ArazUkCUPIffKM6jLzX/s1600/portal-pack-site-logo-medium.png)

Para comenzar con tutoriales de Portlets, es necesario preparar nuestro IDE para programar con Porlets. Por ello primero vamos en este Post vamos a ver cómo instalar el [Portal Pack](http://contrib.netbeans.org/portalpack/)  para NetBeans.

- Descargar de [http://contrib.netbeans.org/portalpack/](http://contrib.netbeans.org/portalpack/) el PortalPack. A la fecha de este post, la versión disponible es la 3.0.3 ([http://contrib.netbeans.org/portalpack/pp30/download303.html](http://contrib.netbeans.org/portalpack/pp30/download303.html)). Aquí doy el acceso directo para descargar el PortalPack que se utilizará en este post.

[http://netbeans.org/projects/contrib/downloads/download/portalpack/pp303/portal-pack-plugin-3_0_3_websynergy.zip](http://netbeans.org/projects/contrib/downloads/download/portalpack/pp303/portal-pack-plugin-3_0_3_websynergy.zip)

- Descomprimir el contenido. Este tendrá una carpeta y dentro unos archivos .nbm. Estos son los módulos que necesitamos instalar desde NetBeans.

- Abrimos el NetBeans y entramos a Herramientas > Complementos. Seleccionamos la ficha "Descargado" para instalar los complementos descargados hace un momento. Hacemos clic en el botón "Agregar complementos..." y **seleccionamos todos los .nbm** que hemos descomprimido, **excepto**:

- org-netbeans-modules-portalpack-websynergy-palette.nbm

- org-netbeans-modules-portalpack-saw.nbm

- org-netbeans-modules-portalpack-cms.nbm

- org-netbeans-modules-portalpack-commons-palette.nbm

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2IALmKKtGfdpNshMxqwzN22Hr43KULP8q66iZoXxP-dwH9haV-bvpcARqljWWFTXXeTnEpPmYSg80bU3fQ-w-E8Gpy5R2Ra51RXJYDQJJ5nz6gDYZ9QryjMo0EU-Uy-LNq2kGiliKmp1c/s400/pp1.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2IALmKKtGfdpNshMxqwzN22Hr43KULP8q66iZoXxP-dwH9haV-bvpcARqljWWFTXXeTnEpPmYSg80bU3fQ-w-E8Gpy5R2Ra51RXJYDQJJ5nz6gDYZ9QryjMo0EU-Uy-LNq2kGiliKmp1c/s1600/pp1.png)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgPWbdT6UBL9oUz9U2VhFdmWfa0TEvAtmB7rywNrz0UpkiYZaIAHid4CMiHZrFimTG51_AMnFeQjefzJ24E16Kc2S-PZnCN6qGvc97t2ZWnxOrqJT2_uPYtefq-Iok2DVewKMahAN-p6P_U/s640/pp2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgPWbdT6UBL9oUz9U2VhFdmWfa0TEvAtmB7rywNrz0UpkiYZaIAHid4CMiHZrFimTG51_AMnFeQjefzJ24E16Kc2S-PZnCN6qGvc97t2ZWnxOrqJT2_uPYtefq-Iok2DVewKMahAN-p6P_U/s1600/pp2.png)

- Hacemos clic en "Instalar". Es posible que nos avise que va  activar otros complementos como el Rake y Ruby. Le damos clic en "Siguiente".

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgbKKhR745jzVVlXNl81vgNth_5KoipOJgPrr8XL5xmZl2JhXZPJTzzXA8z08DNhHyBaxDypL_MN8UrBCG0ur5EfWEXIG2wcyQP5vmaERAX7CMSFMH17WjDg6UxpZQs1xL2nRBguMe6aVv/s1600/pp3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgbKKhR745jzVVlXNl81vgNth_5KoipOJgPrr8XL5xmZl2JhXZPJTzzXA8z08DNhHyBaxDypL_MN8UrBCG0ur5EfWEXIG2wcyQP5vmaERAX7CMSFMH17WjDg6UxpZQs1xL2nRBguMe6aVv/s1600/pp3.png)

- Y listo, después de instalar y pasar por ventanas de confirmación, se habrá instalado correctamente.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgeolH7Q4roi7ND8pvjdJz_yhEDummJRT-P71F3PrmYaNxRmQBuXyHMf19vaHm-6gyTguGkK_2k8SQXLNeSztIucLsVq6_O9ELUmPhYJlpPIW2ci-QoBfy7hzPFpuJrWfNbL8GEsyFbgNWn/s400/pp4.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgeolH7Q4roi7ND8pvjdJz_yhEDummJRT-P71F3PrmYaNxRmQBuXyHMf19vaHm-6gyTguGkK_2k8SQXLNeSztIucLsVq6_O9ELUmPhYJlpPIW2ci-QoBfy7hzPFpuJrWfNbL8GEsyFbgNWn/s1600/pp4.png)

En otro Post veremos cómo configurar NetBeans con un servidor configurado de Portlets.
