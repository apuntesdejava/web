---
layout: post
title: "NetBeans con Node.js"
date: 2015-07-12T00:44:00.002Z
last_modified_at: 2015-07-12T00:44:41.200Z
author: "Diego Silva Límaco"
permalink: /2015/07/netbeans-con-nodejs.html
canonical_url: https://www.apuntesdejava.com/2015/07/netbeans-con-nodejs.html
tags:
  - "node"
  - "netbeans"
  - "netbeans 8.1"
  - "javascript"
---

[![NetBeans con Node.js](/assets/blogger/nodejs-light.png)](/assets/blogger/nodejs-light.png)

La nueva versión de NetBeans 8.1 permitirá desarrollar HTML5 con Node.

Para ello, primero se debe tener bien instalado el Node.js con el paquete npm, e instalado el módulo express [[http://expressjs.com/starter/generator.html](http://expressjs.com/starter/generator.html)].

Luego, configuramos el IDE indicando la ubicación de Node, npm y express

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjg6A6ACB8Sp_FomAPm4iT3asYLhOlKzlD_X85nXcHIyn37YhqwRZjt0zsn3p2q-hliTj4ls_TDNj_McE-qS-GFSqhJuNyiFi7UShHmr0I3ajsdqUf3zNgLktw3Wy3rOYsiw1yB3eOp0Ys/s640/Captura+de+pantalla+de+2015-07-11+17%253A28%253A44.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjg6A6ACB8Sp_FomAPm4iT3asYLhOlKzlD_X85nXcHIyn37YhqwRZjt0zsn3p2q-hliTj4ls_TDNj_McE-qS-GFSqhJuNyiFi7UShHmr0I3ajsdqUf3zNgLktw3Wy3rOYsiw1yB3eOp0Ys/s1600/Captura+de+pantalla+de+2015-07-11+17%253A28%253A44.png)

Y con eso, podemos crear nuestro proyecto tranquilamente.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi9NBBOloQQsVOllAkpJH9qnR4YyKCPXRa5GyYqU2cPEGQGAcgF15X7ybLlifWN8yEO57W1qB1vptlQW3eXKsfTbfhIRqrsZ9GRCAt3RWIrY3gQRxS5vEbDZiJaHMcdJBfgW3wxy4ANSnw/s640/Captura+de+pantalla+de+2015-07-11+17%253A22%253A44.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi9NBBOloQQsVOllAkpJH9qnR4YyKCPXRa5GyYqU2cPEGQGAcgF15X7ybLlifWN8yEO57W1qB1vptlQW3eXKsfTbfhIRqrsZ9GRCAt3RWIrY3gQRxS5vEbDZiJaHMcdJBfgW3wxy4ANSnw/s1600/Captura+de+pantalla+de+2015-07-11+17%253A22%253A44.png)

Le indicamos la ubicación del proyecto:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiBBGTw8eU-a2uCBeX0ktXgF4ULkuqzDQrmFr8NoLXW18qT-gzACk0pC9jVHAXOf0gSKnn0eAeaAAnN14-WRIp1D4rW-rAWw66dnaHAVYG1pqUXMcYtzMyeFTQTtpZrC72Eieqr4Cfot5Q/s640/Captura+de+pantalla+de+2015-07-11+17%253A30%253A09.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiBBGTw8eU-a2uCBeX0ktXgF4ULkuqzDQrmFr8NoLXW18qT-gzACk0pC9jVHAXOf0gSKnn0eAeaAAnN14-WRIp1D4rW-rAWw66dnaHAVYG1pqUXMcYtzMyeFTQTtpZrC72Eieqr4Cfot5Q/s1600/Captura+de+pantalla+de+2015-07-11+17%253A30%253A09.png)

También le decimos que cree el archivo de configuración del proyecto:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhPquszg0Ga2gT-XP_e8OMRUKvBlqEZCfDu-3Q3f2MDXI5cA0_nRUwm0ANcY9KDjCWJHWXhByya9PWrmLEZxxspr6gKoWvq31l8DIKjIPPDySdH_JCPOMOzXt-M-4Ap7SRZkaqGI2J9ILI/s640/Captura+de+pantalla+de+2015-07-11+17%253A31%253A54.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhPquszg0Ga2gT-XP_e8OMRUKvBlqEZCfDu-3Q3f2MDXI5cA0_nRUwm0ANcY9KDjCWJHWXhByya9PWrmLEZxxspr6gKoWvq31l8DIKjIPPDySdH_JCPOMOzXt-M-4Ap7SRZkaqGI2J9ILI/s1600/Captura+de+pantalla+de+2015-07-11+17%253A31%253A54.png)

... dejamos que cocine un rato.... y listo

Además, desde el mismo IDE se pueden agregar las bibliotecas necesarias para la aplicación

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKeOqlqTuep9DhJJwH8oNtBFYllRnF7-rcGrXIAHidomqOF3OH7W6oOY56nAcQ4oyM9IRzmVoWs-01946RXf9RWQf12pr3AMl2XguI_bgXlWG-xFHbZqLrIHZxFfllQQfxq4dzMGsfrvU/s640/Captura+de+pantalla+de+2015-07-11+17%253A51%253A02.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKeOqlqTuep9DhJJwH8oNtBFYllRnF7-rcGrXIAHidomqOF3OH7W6oOY56nAcQ4oyM9IRzmVoWs-01946RXf9RWQf12pr3AMl2XguI_bgXlWG-xFHbZqLrIHZxFfllQQfxq4dzMGsfrvU/s1600/Captura+de+pantalla+de+2015-07-11+17%253A51%253A02.png)

... hacemos un programa...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCEhyphenhyphensG_rRgPlu58wUGodxkXFY3RBG5dylVyRScqnIfOR69BkVsoNYLOZbl3GQXiMM21wjWAeeU-uX-BHuVYmXr9JNMHZuDgaIJXRF1XMspjZjpemvXQRYoTohrasZncYwVCcwOwmzFH8/s640/Captura+de+pantalla+de+2015-07-11+19%253A39%253A45.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhCEhyphenhyphensG_rRgPlu58wUGodxkXFY3RBG5dylVyRScqnIfOR69BkVsoNYLOZbl3GQXiMM21wjWAeeU-uX-BHuVYmXr9JNMHZuDgaIJXRF1XMspjZjpemvXQRYoTohrasZncYwVCcwOwmzFH8/s1600/Captura+de+pantalla+de+2015-07-11+19%253A39%253A45.png)

.. lo ejecutamos.... y lo probamos..!!

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizP63I6kirMpqxsisnDKwhCXsm8ajYYhg8eBbQCECJXLcByKYyqayAjDqKEHOqPBSyXiad8Gplos1qiA_jNOXfJA1RFLsUZWr3ENC-wyGLwtZClnO5h0Wqqs8NxJEwuhFl5MByUjZLjtA/s640/Captura+de+pantalla+de+2015-07-11+19%253A42%253A01.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEizP63I6kirMpqxsisnDKwhCXsm8ajYYhg8eBbQCECJXLcByKYyqayAjDqKEHOqPBSyXiad8Gplos1qiA_jNOXfJA1RFLsUZWr3ENC-wyGLwtZClnO5h0Wqqs8NxJEwuhFl5MByUjZLjtA/s1600/Captura+de+pantalla+de+2015-07-11+19%253A42%253A01.png)

Listo, Node.js ya tiene un IDE.. y esperen a que vean el depurador!

Si te gustó este artículo, dale +1; y si te es útil, compártelo... es gratis!
