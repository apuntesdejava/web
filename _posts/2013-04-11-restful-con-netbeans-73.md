---
layout: post
title: "RESTful con NetBeans 7.3"
date: 2013-04-11T17:51:00.002Z
last_modified_at: 2013-04-11T17:51:38.684Z
author: "Diego Silva Límaco"
permalink: /2013/04/restful-con-netbeans-73.html
canonical_url: https://www.apuntesdejava.com/2013/04/restful-con-netbeans-73.html
tags:
  - "glassfish"
  - "glassfish v3"
  - "restful"
  - "netbeans 7.3"
  - "netbeans"
  - "actualizacion"
---

[![](/assets/blogger/rest-ful-webservice-baner.png)](/assets/blogger/rest-ful-webservice-baner.png)

Este post es solo una actualización del primer apunte [RESTful... la forma más ligera de hacer WebServices (Parte 1)](/2010/11/restful-la-forma-mas-ligera-de-hacer.html) ya que esa vez se hizo con NetBeans 6.9.1.

Cuando se crea una nueva clase y queremos que sea un servicio web, le agregamos antes de la declaración los tag `@Path` y `@Stateless`. En el NetBeans 7.3 nos va a sugerir cómo queremos crear el recurso asociado al webservice.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi4EpJM69nU4pHp2u3eg7ZOu22MgxDwUcTb4YI8nVnes8hLefwSh7YGXPHcbVDl8r3A9igLTs9WibOX5vdtHv4sUYuCxZEhej3EPvr1yjPCLzKNH5Rf6dUcDU63LrC0KNf_DhNRAr9G7GY/s320/11-04-2013+12-34-12+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi4EpJM69nU4pHp2u3eg7ZOu22MgxDwUcTb4YI8nVnes8hLefwSh7YGXPHcbVDl8r3A9igLTs9WibOX5vdtHv4sUYuCxZEhej3EPvr1yjPCLzKNH5Rf6dUcDU63LrC0KNf_DhNRAr9G7GY/s1600/11-04-2013+12-34-12+p.m..png)

Si escogemos JEE6, nos creará una clase preconfigurada.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhlK-VtYKckdq6PxQwQ388ksMNE1s4b7JaJtau8MeJdd5edUdVQR5X4y8x7T9UjnwyvsFfxHdya5-UHdnbalQXJnC7L0iHox4pbEPEgQ6zyxfto80hYhgjz-oXBafWEAQcY2LHABcqTo6Q/s1600/11-04-2013+12-42-03+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhlK-VtYKckdq6PxQwQ388ksMNE1s4b7JaJtau8MeJdd5edUdVQR5X4y8x7T9UjnwyvsFfxHdya5-UHdnbalQXJnC7L0iHox4pbEPEgQ6zyxfto80hYhgjz-oXBafWEAQcY2LHABcqTo6Q/s1600/11-04-2013+12-42-03+p.m..png)

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhxQ0jfxsIAeB7njCppPD25gbe7Y4OLIfNh4PfbHfFKq7H74LiQ0SOIiWZD7aTqtcTm-FUy5u57n9DFakRj_AXkv8H1YnHZ3omem36u6hgeBOE-7naOiywQt_Bfzwux1tTGn4tkp3t36as/s320/11-04-2013+12-43-19+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhxQ0jfxsIAeB7njCppPD25gbe7Y4OLIfNh4PfbHfFKq7H74LiQ0SOIiWZD7aTqtcTm-FUy5u57n9DFakRj_AXkv8H1YnHZ3omem36u6hgeBOE-7naOiywQt_Bfzwux1tTGn4tkp3t36as/s1600/11-04-2013+12-43-19+p.m..png)

Entonces, el recurso se encontrará dentro de "webresources". Podemos cambiarlo desde la misma clase ApplicationConfig.

Si optamos por la solución Jersey...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-cBJYMUg4VmyHa9LeZ0tqAOHpi1XbLzyA2l2yUxaiitm0qpc3fFdKvsTFq2cYAaHUHnaTlS2kf17LXCde6xo6UlzqKGR2yn3iG5S5qp3IW2VAciETMvkYjBbmjePapTnHfwCBtIB60Wc/s320/11-04-2013+12-45-48+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh-cBJYMUg4VmyHa9LeZ0tqAOHpi1XbLzyA2l2yUxaiitm0qpc3fFdKvsTFq2cYAaHUHnaTlS2kf17LXCde6xo6UlzqKGR2yn3iG5S5qp3IW2VAciETMvkYjBbmjePapTnHfwCBtIB60Wc/s1600/11-04-2013+12-45-48+p.m..png)

... el NetBeans agregará todas las bibliotecas necesarias...

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgZ60ZiK5og0tp1J_KlXvQdWwk31wLKtioEpDs3q27e79D4nDuRAi0AASIx874cN0IHBUnZVd_afpuaNCgElDAdfL7R6gVCnm6ZLNySqyYvEwrRNnDEtA0Z66WBNntzp-Hwzi5gF2yRAKw/s320/11-04-2013+12-47-53+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgZ60ZiK5og0tp1J_KlXvQdWwk31wLKtioEpDs3q27e79D4nDuRAi0AASIx874cN0IHBUnZVd_afpuaNCgElDAdfL7R6gVCnm6ZLNySqyYvEwrRNnDEtA0Z66WBNntzp-Hwzi5gF2yRAKw/s1600/11-04-2013+12-47-53+p.m..png)

... y configurará un servlet con el nombre del recurso "webresources"

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEho6Eqa6Xq1pDRpPkLkpN2O5MhjpiMF2nGEWkIS9Kjq8MF9HKUBaw6y8m9cbGTBvgBkfEaulDtohI-w4VkE4f3HIDPBw2b5VnUO4cmXLvrIKl8wFom6Sy3ReHzuYPGRJkDBgG6hqM6MyWQ/s320/11-04-2013+12-50-41+p.m..png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEho6Eqa6Xq1pDRpPkLkpN2O5MhjpiMF2nGEWkIS9Kjq8MF9HKUBaw6y8m9cbGTBvgBkfEaulDtohI-w4VkE4f3HIDPBw2b5VnUO4cmXLvrIKl8wFom6Sy3ReHzuYPGRJkDBgG6hqM6MyWQ/s1600/11-04-2013+12-50-41+p.m..png)

... y la ruta del recurso se cambiaría en el web.xml como servlet.

Eso es todo
