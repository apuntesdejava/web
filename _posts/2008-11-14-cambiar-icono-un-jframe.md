---
layout: post
title: "Cambiar ícono a un JFrame"
date: 2008-11-14T18:21:00.002Z
last_modified_at: 2009-10-07T19:16:04.381Z
author: "Diego Silva"
permalink: /2008/11/cambiar-icono-un-jframe.html
canonical_url: https://www.apuntesdejava.com/2008/11/cambiar-icono-un-jframe.html
tags:
  - "swing"
  - "java"
  - "netbeans"
  - "tips"
---

Un visitante de mi blog me pidió que le dijera cómo cambiar el ícono de los JFrame. Pero como este tip puede ser útil para toda la comunidad, decidí escribirlo aquí en mi blog.

Paso 1

El ícono debe ser una imagen de extensión PNG. Esto se hace más fácil, ya que conseguir una figura y convertirlo en formato .ico es muy complicado. Los PNG nos ayudan bastante.

Paso 2

La imagen que será el ícono debe estar dentro del paquete de fuentes, como si fuera una clase más. Si estuviera dentro de un paquete, sería mucho mejor.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiDjO-o1qNh5NZIPiswvQYRv8PnwnE6uzjBEVuKErvbC6wR-CuAL6ApT2cKAhADAY0gUONTCW1doj9VDs6X4Val2DKNHCbnARpRD0pF07qHFI_ERkOdyJGI1PXeZLbf2lYSzO20UGlRdIYQ/s320/jframe-icono1.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiDjO-o1qNh5NZIPiswvQYRv8PnwnE6uzjBEVuKErvbC6wR-CuAL6ApT2cKAhADAY0gUONTCW1doj9VDs6X4Val2DKNHCbnARpRD0pF07qHFI_ERkOdyJGI1PXeZLbf2lYSzO20UGlRdIYQ/s1600-h/jframe-icono1.jpg)

Paso 3

En el código del JFrame que vamos a poner el ícono, sobreescribimos el método getIconImage() conteniendo el siguiente código: (notar cómo se está llamando a la imagen .png)

```java
<code>
@Override
public Image getIconImage() {
   Image retValue = Toolkit.getDefaultToolkit().
         getImage(ClassLoader.getSystemResource("resources/icono.png"));

   return retValue;
}
</code>
```

Paso 4

En la vista de diseño del JFrame, lo seleccionamos y vamos sus propiedades, buscamos la propiedad "iconImagen" y hacemos clic en el botón de puntos suspensivos. Se mostrará una ventana de diálogo como esta:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhEgqfvLGY7qp5O2jEw14xTkCoU_ZbLsscqLTHqqu9xWZXhNr3WP9gT_Fg4VNfBQiTX0Az-OugE73vg172e2ZYMathDs3HFxUNkuMEqctpWpTpAUN1UwohK4587nQyFmvVTDqofNR6kXDw8/s320/jframe-icono2.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhEgqfvLGY7qp5O2jEw14xTkCoU_ZbLsscqLTHqqu9xWZXhNr3WP9gT_Fg4VNfBQiTX0Az-OugE73vg172e2ZYMathDs3HFxUNkuMEqctpWpTpAUN1UwohK4587nQyFmvVTDqofNR6kXDw8/s1600-h/jframe-icono2.jpg)

De la lista desplegable, seleccionamos "Valor de componente existente". Esto hará que cambie la ventana a la siguiente forma:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMRosV0oTFjhDd2mg0xiG5Mou-IObqpkht4oJ5LvzmrHkKfRWGYYAkz1idrKVEEMEcfAmiMfo0UKpNPxvRdhmTZk05dGvdbcnYsBWzLy7pFJ7VO6UMyC9ylxlLzYSqpKhAbzL_kh9EKB9c/s320/jframe-icono3.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMRosV0oTFjhDd2mg0xiG5Mou-IObqpkht4oJ5LvzmrHkKfRWGYYAkz1idrKVEEMEcfAmiMfo0UKpNPxvRdhmTZk05dGvdbcnYsBWzLy7pFJ7VO6UMyC9ylxlLzYSqpKhAbzL_kh9EKB9c/s1600-h/jframe-icono3.jpg)

Seleccionamos la opción "Propiedad" y hacemos clic en el botón de puntos suspendidos. Aparecerá una ventana de diálogo más pequeña, y seleccionamos la propiedad "iconImage" que aparece ahí.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhj5VccLamhfnspBBDj4let7MXgOgFdXzV-kRY9Ferrjhuzu4LNxuoqKahXbGfFAHADdLfFEYS0InncfosHsgbupUXjG5NoVkGZwXwZl_JPMzr-RYGDOa36JM_9fxGP0bLeR7X1QpLL3MV3/s320/jframe-icono4.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhj5VccLamhfnspBBDj4let7MXgOgFdXzV-kRY9Ferrjhuzu4LNxuoqKahXbGfFAHADdLfFEYS0InncfosHsgbupUXjG5NoVkGZwXwZl_JPMzr-RYGDOa36JM_9fxGP0bLeR7X1QpLL3MV3/s1600-h/jframe-icono4.jpg)

Clic en Aceptar, y se verá así:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJgrh0CihVvmyN_QjiJTEPkBskg68E_jyCZUoZpODBS2_CcIhkfx10OTO6DiK0E4fIQC5R_dNkbwQGyf9F9oLcoLoQ7IxuKwYxmhNjvnxN9JjQ7PW3ROuipDTIOq7O2ms-39meOD-ap0_C/s320/jframe-icono5.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjJgrh0CihVvmyN_QjiJTEPkBskg68E_jyCZUoZpODBS2_CcIhkfx10OTO6DiK0E4fIQC5R_dNkbwQGyf9F9oLcoLoQ7IxuKwYxmhNjvnxN9JjQ7PW3ROuipDTIOq7O2ms-39meOD-ap0_C/s1600-h/jframe-icono5.jpg)

y nuevamente clic en "Aceptar" para cerrar la ventana de selección de imagen.

Ahora, veremos que las propiedades del JFrame ya tiene un nuevo valor

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj6llkw5j2O_FGvGH3a99h2igMJPhjUspe7woe-AMMe1tUJG_z7YYKDVLTgeUm-yx9Lb_aNERZMu2KWqe9BaO_je4vT6XSVaItz2pnxsFzXRMZxVnWFcjdQUjdF7vGD4ZAnwkBxhZvx3Vpz/s320/jframe-icono6.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj6llkw5j2O_FGvGH3a99h2igMJPhjUspe7woe-AMMe1tUJG_z7YYKDVLTgeUm-yx9Lb_aNERZMu2KWqe9BaO_je4vT6XSVaItz2pnxsFzXRMZxVnWFcjdQUjdF7vGD4ZAnwkBxhZvx3Vpz/s1600-h/jframe-icono6.jpg)

Paso 5

Ejecutamos la aplicación con el JFrame, y voila! nuestro JFrame con un ícono diferente

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLOjgQRGTxn8YwRWMNbQd9vKIqgoqC6xjCTd1TWIq8KdbV-t5roCdS0FX7GizmNpYNNG7knvHXdfKCYi6FfKrcPS_jGuwHk-dOBzRoS_iRDEcBLf_tVE_ozLnnHdUOKeEvk4MbHsgs1zQv/s320/jframe-icono7.jpg)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLOjgQRGTxn8YwRWMNbQd9vKIqgoqC6xjCTd1TWIq8KdbV-t5roCdS0FX7GizmNpYNNG7knvHXdfKCYi6FfKrcPS_jGuwHk-dOBzRoS_iRDEcBLf_tVE_ozLnnHdUOKeEvk4MbHsgs1zQv/s1600-h/jframe-icono7.jpg)
