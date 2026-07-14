---
layout: post
title: "La Gran Mentira de Kubernetes: Desmontando el Hype con la Suite de HashiCorp"
date: 2026-01-31T17:30:00Z
last_modified_at: 2026-01-31T17:30:15.497Z
author: "Diego Silva Límaco"
permalink: /2026/01/la-gran-mentira-de-kubernetes.html
canonical_url: https://www.apuntesdejava.com/2026/01/la-gran-mentira-de-kubernetes.html
description: "Cómo construir un clúster de alto rendimiento (Nomad + Fabio + Quarkus) sin vender tu alma al YAML."
---

###

## La Mentira

Nos han vendido una mentira industrial.

Te han repetido hasta el cansancio que, para desplegar software moderno,
necesitas la complejidad de Google. Te han dicho que si no usas Kubernetes
(K8s), tu infraestructura es "legacy", irrelevante o amateur. Te han
convencido de que sacrificar 4GB de RAM solo para mantener vivo el plano de
control es "el costo de hacer negocios".

La realidad es más oscura:
**Kubernetes es un monstruo de sobre-ingeniería** diseñado para venderte
nubes costosas y horas de consultoría eterna.

La "Herejía" que propongo hoy es simple:
**No necesitas esa complejidad**. Puedes tener orquestación,
descubrimiento de servicios, balanceo de carga y escalado automático
consumiendo una fracción de los recursos y con una curva de aprendizaje
humana.

Hoy vamos a desmontar el mito. Vamos a levantar una infraestructura completa
usando la "Vía HashiCorp" (Nomad & Consul) sobre un entorno hostil
(WSL2), y vamos a probar su resistencia con fuego real (k6).

### La Estrategia: "Componentes que hacen una sola cosa"

En lugar de capas infinitas de abstracción opaca, usaremos componentes que
siguen la filosofía UNIX: hacer una cosa y hacerla perfecta.

- **El Cerebro (Nomad):**
  Orquestación simple. Un solo binario. Sin
  *etcd*, sin
  nodos maestros que devoran memoria.

- **El Mapa (Consul):** *Service Discovery*. Si un microservicio respira, Consul sabe dónde vive.

-  **El Enrutador (Fabio):** Un balanceador de carga que se configura solo leyendo el mapa de Consul. Cero configuración manual.

-  **El Músculo (Quarkus):** Microservicios Java que arrancan en milisegundos, no en minutos.

-  **El Terreno (WSL2):** El campo de batalla. Un entorno Linux real, sin la pesadez de una VM
        tradicional.

### Fase 1: El Monolito Frágil (Lo que la mayoría hacemos)

  Para entender la solución, primero debemos ver el problema. La mayoría de
  los desarrolladores desplegamos así: Un nodo. Un puerto fijo. Una base de
  datos.

  Este es nuestro archivo
  `[monolith.nomad](https://github.com/apuntesdejava/nomad-quarkus-reference-arch/blob/main/monolith.nomad)`. Es funcional, pero es un castillo de naipes. Al menos funciona para un
  "Hola Mundo".

```hcl
group "backend" {
    count = 1  # El punto único de fallo
    network {
      port "http" { static = 8080 } # Puerto rígido
    }
    # ...
```

Si ejecuto esto, funciona. Puedo llamar a
`localhost:8080` y
Quarkus responde. Pero, ¿qué pasa si el proceso falla? ¿Qué pasa si recibo más
tráfico del que un solo hilo puede manejar?

Hice la prueba. Lancé un ataque con
**k6** y maté el proceso
manualmente. **Resultado:**
`Connection Refused`. El servicio murió instantáneamente (obviamente). Tiempo de inactividad
total. Pérdida de dinero.

Esta es la fragilidad que te obliga a buscar "orquestadores". Y aquí es donde
K8s te atrapa. Pero hay otra salida.

### Fase 2: La Evolución (El Clúster Resiliente)

Aquí es donde rompemos la Matrix. Vamos a transformar ese monolito en un
sistema distribuido, tolerante a fallos y auto-balanceado.

Para lograrlo en WSL2 (que tiene una red notoriamente aislada), tuve que usar
una técnica poco documentada. Tuve que romper la cuarta pared.

En lugar de crear redes virtuales complejas (Overlay Networks) como hace K8s
con Flannel o Calico, le ordenamos a nuestros contenedores que se anuncien con
la IP real del host.

### El Código de la Victoria (stack.nomad):

```terraform
service {
  name = "api-quarkus"
  address_mode = "host" #   La clave de la simplicidad. Sin proxys.

  tags = [
    "urlprefix-/api",   #  Fabio lee esto y enruta el tráfico. Magia.
    "quarkus"
  ]
}
```

Al desplegar esto, ocurren tres cosas simultáneamente:

- **Nomad** levanta 3 réplicas de Quarkus en puertos aleatorios.

- **Consul** detecta que están vivas (Health Check).

- **Fabio** ve la etiqueta `urlprefix-/api` y automáticamente empieza a repartir tráfico entre las 3.

Sin reiniciar el balanceador. Sin escribir archivos de configuración de Nginx.
Sin YAMLs de 500 líneas.

Estado de los nodos:

  [![](https://i.imgur.com/RfnyvuE.png)](https://i.imgur.com/RfnyvuE.png)

Estado del balanceador:

  [![](https://i.imgur.com/0XHuuUZ.png)](https://i.imgur.com/0XHuuUZ.png)

### La Prueba de Fuego: Benchmark con k6

Las palabras se las lleva el viento. Los datos no. Sometí al clúster
evolucionado a una prueba de estrés para demostrar la diferencia.

**Escenario de Ataque:**

-  **Virtual Users:** 50 concurrentes golpeando el API sin piedad.

-  **Duración:** 60 segundos.

-  **Evento Caótico:** Durante la prueba, asesiné manualmente uno de los contenedores de Quarkus.

**Los Resultados:**

  [![](https://i.imgur.com/nDxo2xf.png)](https://i.imgur.com/nDxo2xf.png)

  Mientras yo mataba nodos, Fabio redirigía el tráfico instantáneamente a los
  supervivientes. Nomad detectaba la muerte y levantaba un reemplazo en
  segundos. El usuario final (k6) jamás se enteró del caos que ocurría tras
  bambalinas.

  Y todo esto, corriendo en mi laptop, consumiendo menos recursos que dos
  pestañas de Chrome.

### Conclusión

La mentira de Kubernetes es hacerte creer que la complejidad es necesaria para escalar. **No lo es.** La complejidad es necesaria para venderte soluciones a problemas que ellos mismos crearon.

La suite de HashiCorp (Nomad + Consul) representa el retorno a la ingeniería sensata: piezas pequeñas, bien conectadas, que entiendes y controlas. He logrado en una tarde, y con un solo archivo de configuración, lo que en K8s requiere un equipo de DevOps dedicado.

El código está disponible en mi repositorio. La puerta de salida de la "Matrix" está abierta.

¿Te atreves a cruzarla?

### 🔗 Repositorio del Proyecto

El código fuente del proyecto, con los archivos nomad, las instrucciones de cómo levantar el entorno y las pruebas de estress, se encuentran aquí:

[https://github.com/apuntesdejava/nomad-quarkus-reference-arch/](https://github.com/apuntesdejava/nomad-quarkus-reference-arch/)
