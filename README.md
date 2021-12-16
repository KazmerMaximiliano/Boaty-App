# BOATY

![](/md_assets/portada.png)

## Índice

- [Funcionalidades](#funcionalidades)
  - [Estados](#estados)
- [Manual](#manual)
  - [Dueños](#dueños)
    - [Registro](#registro)
    - [Botes](#botes)
    - [Disponibilidades](#disponibilidades)
    - [Información](#información)
  - [Clientes](#clientes)
    - [Cuenta](#cuenta)
    - [Barcos](#barcos)
    - [Favoritos](#favoritos)
    - [Reservas](#reservas)
    - [Cancelación](#cancelación)
    - [Pagos](#pagos)
    - [Calificaciones](#calificaciones)
- [Errores](#errores)
  - [Reportes](#reportes)

## Funcionalidades

| Función                                                                  | Estado                   |                                                                                                                           Comentarios                                                                                                                            |
| :----------------------------------------------------------------------- | :----------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| Registro                                                                 | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Inicio de sesion con correo electrónico                                  | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Registro de usuario en stripe                                            | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Registro de datos relacionados con cripto monedas                        | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Listado de botes                                                         | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Busqueda de bote                                                         | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Marcar/desmarcar botes como favoritos                                    | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Listar botes favoritos                                                   | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Detalles del bote                                                        | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Formulario para agregar botes, se incluyen datos generales, mapa y fotos | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Agregar/editar disponibilidades al bote                                  | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Listado de los botes creados por el dueño                                | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Perfil del dueño del bote                                                | Finalizado               | Para la nueva versión, sería conveniente agregar en esta pantalla la visualización de los datos relacionados con la facturación y reservas del dueño, en esta versión no se implementó por el tiempo de desarrollo y por la falta de diseño de algunas pantallas |
| Ayuda y preguntas frecuentes                                             | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Cambiar de un cliente a dueño y visceversa                               | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Reservar botes                                                           | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Listado de reservas y estados de las mismas                              | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Cancelar reservas                                                        | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Calificar reservas                                                       | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Pagar reservas                                                           | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Pago con tarjetas                                                        | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Pago con cripto divisas                                                  | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Perfil del usuario                                                       | Finalizado               |                                                                   Faltaria agregar información adicional en una futura versión, como un calendario o los pagos que realizó, su historial, etc                                                                    |
| Dashboard gestion de usuarios                                            | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Dashboard gestión de roles                                               | Finalizado               |                                                                                                                                \_                                                                                                                                |
| Registro/Inicio de sesión con redes sociales                             | Disponible en produccion |                                                                                                                                \_                                                                                                                                |
| Compartir bote                                                           | Disponible en producción |                                                                                            Disponible en producción ya que se requiere compartir el enlace de la app                                                                                             |
| Pago con transferencias                                                  | En revisión              |                                            Debido a los cambios recientes de Stripe, esta funcionalidad se encuentra en revisión, principalmente en el arena de los bancos internacionales (fuera de estados unidos)                                             |
| Dashboard gestión de pagos                                               | En revisión              |                                                                                                                                \_                                                                                                                                |
| Registro de usuario en Stripe desde la app                               | Cancelado                |                                                     Debido a los recientes cambios en stripe y a una alta complejidad en las validaciones de los datos a enviar, se ha decidido cancelar esta funcionalidad                                                      |

### Estados

- Finalizado: La funcionalidad está completa e implementada en la actual versión de la aplicación.
- Disponible en producción: La funcionalidad está completa pero se implementara en una futura versión de la aplicación.
- En revisión: La funcionalidad está completa pero necesita revisión.
- Cancelada: por diferentes motivos, la funcionalidad no se ha implementado y no se planea implementar.

## Manual

### Dueños

#### Registro

Desde la pantalla principal, tocar el botón de la esquina superior derecha (Ingresar) y posteriormente el botón de la parte inferior (registrarse).

![](/md_assets/imagen_1.png)

A continuación, rellenar el formulario con los datos solicitados. Una vez finalizado el registro, indicar que se es dueño de un bote.

![](/md_assets/imagen_2.png)

En esta pantalla, indica si se desea recibir o no pagos con cripto monedas, en caso de ser así, registrar la dirección de los pagos. Al tocar el botón inferior será redirigido a la página oficial de Stripe para finalizar con el registro. Por favor asegúrese de completar el mismo antes de continuar en Boaty (Para esta versión de prueba, asegúrese de completar la información bancaria con datos de prueba)

![](/md_assets/imagen_3.png)

#### Botes

Desde la pantalla principal luego de haber finalizado el registro o el inicio de sesión, diríjase a la pantalla botes y luego toque el botón “+” ubicado en la esquina inferior derecha de la pantalla.

![](/md_assets/imagen_4.png)

Complete los primeros datos de la embarcación y a continuación toque el botón “continuar” para completar los datos referentes al precio y capacidad del mismo.

![](/md_assets/imagen_5.png)

A continuación, se le solicitará su permiso para conocer su ubicación, este es necesario para mostrar el mapa donde registrará la ubicación de su nuevo bote y recomendamos dar los permisos para usarlo siempre así los mismos no se vuelven a solicitar cada vez que quiera registrar un bote.

![](/md_assets/imagen_6.png)

Registre la ubicación de su bote y a continuación agregue imágenes desde su cámara o galería. Al hacer tocar el botón siguiente, se cargan las imágenes del bote a los servidores (sea paciente, dependiendo de la velocidad de internet este proceso puede tardar unos minutos) y una vez finalizado el registro, podrá ver sus botes cargados desde la sección “botes”.

![](/md_assets/imagen_7.png)

#### Disponibilidades

Desde la sección “botes” puede seleccionar un bote tocando el botón “ver detalle”, sera redirigido a una pantalla con los detalles de la embarcación donde podra modificar la disponibilidad del mismo tocando el botón “Modificar Disponibilidad”

![](/md_assets/imagen_8.png)

A continuación, tendrá a su disposición un calendario en el cual podrá seleccionar los días para establecerlos como disponibles a la hora de registrar una reservación (Los días marcados con azul serán días disponibles). Al tocar el botón “actualizar” ya estarán registrados los nuevos días disponibles de su embarcación.

![](/md_assets/imagen_9.png)

#### Información

Desde la pestaña “Admin” podrá encontrar varios accesos directos:

- Facturación (Dashboard de stripe)
- Facturación cripto (Dashboard de Boaty para cripto divisas)
- Quiero alquilar un bote (Ingreso directo a la app como cliente).

![](/md_assets/imagen_10.png)

Desde la pestaña “Ayuda” podrá encontrar información adicional y respuestas a preguntas frecuentes.

![](/md_assets/imagen_11.png)

### Clientes

#### Cuenta

El registro de clientes es exactamente igual al de dueños, con la pequeña diferencia que al finalizar el mismo hay que seleccionar la opción “Quiero alquilar un bote”

#### Barcos

Desde la pestaña “buscar” puede escribir términos de búsqueda en el formulario superior y la app actualizará el listado de botes automáticamente con aquello que coincida en su título o descripción con el término de búsqueda ingresado.

#### Favoritos

Desde la pestaña “buscar” puede marcar botes como favoritos tocando el boton con forma de corazon que se encuentra en la esquina superior izquierda de cada bote, el mismo cambiara de color si es su favorito y podra sacarlo de la lista de favoritos tocando el boton nuevamente. En caso de que no haya iniciado sesión, aparecerá una alerta indicando que es necesario iniciar sesión.

![](/md_assets/imagen_12.png)

Podrá ver la lista de sus botes favoritos en la pestaña “favoritos”

![](/md_assets/imagen_13.png)

#### Reservas

Desde la pestaña “buscar” o “favoritos” puede ver el detalle de un bote tocando el botón “ver detalle” a continuación podrá consultar su disponibilidad tocando el botón “verificar disponibilidad”.

El formulario para realizar una reserva es muy sencillo de seguir, simplemente indique los días que quiera reservar entre los disponibles (Los días disponibles tiene el fondo blanco y los no disponibles tienen un fondo gris. Los dias seleccionados tienen fondo de color azul) y a continuacion el numero de pasajeros para la reserva (no puede sueperar el limite del bote).

![](/md_assets/imagen_14.png)

Al tocar el botón reservar, su reserva será procesada y cargada y podrá visualizarla en la pestaña “reservas”.

![](/md_assets/imagen_15.png)

#### Cancelación

Para cancelar una reserva, solo tiene que tocar el botón “cancelar”, a continuación, aparecerá una alerta solicitando que confirme su decisión.

![](/md_assets/imagen_16.png)

#### Pagos

Para pagar una reserva, solo tiene que tocar el botón “pagar”, a continuación, será redirigido a una nueva pantalla donde deberá seleccionar el tipo de pago que desea realizar. Ya sea por tarjeta de crédito o por transferencia con cripto divisas, de cualquier forma, solo tiene que completar el formulario y seguir las instrucciones de la aplicación para concretar el pago.

![](/md_assets/imagen_17.png)

![](/md_assets/imagen_18.png)

IMPORTANTE para esta versión de prueba, si elige la opción de pagar con tarjeta por favor rellene los datos de la siguiente forma

- Número: 4242 4242 4242 4242
- Fecha de vencimiento: cualquier fecha posterior a hoy
- Nombre: cualquier nombre
- CVC: 3 números cualesquiera.

#### Calificaciones

Para calificar una reserva, tan solo tiene que tocar el botón “calificar” una vez haya pagado la misma. A continuación aparecerá una alerta solicitando su calificación, la misma impacta directamente en el bote asociado a esta y será de ayuda para otros usuarios.

![](/md_assets/imagen_19.png)

## Errores

- Errores funcionales: Si se presentan errores en la funcionalidad de la app que impidan o modifiquen directamente su funcionamiento, por favor reportarlos acompañados de la lista de pasos a seguir para reproducirlos. Si se pueden acompañar con capturas de pantallas mucho mejor. Estos errores tendrán prioridad alta.

- Errores gráficos: Los errores gráficos por lo general se presentan en dispositivos de gama más baja, ya que todo el desarrollo de la aplicacions se centralizó para dispositivos con pantallas de 5.5 en adelante, por lo que pueden aparecer elementos superpuestos o elementos que no pertenecen al diseño, para reportarlos acompañarlos si o si de capturas de pantalla además de la resolución de la pantalla del celular o en su defecto marca y modelo. Estos errores tendrán prioridad media.

- Modificaciones gráficas o de diseño: Los reportes sobre el diseño que no son errores en sí mismo, como por ejemplo, modificación del tamaño, color, orientación, etc de diferentes elementos, serán considerados como modificaciones gráficas y tendrán una prioridad baja. Acompañar estos reportes con capturas de pantalla e instrucciones de que es lo que se desea modificar y de qué forma.

### Reportes

| Reporte       | Descripcion                                       | Estado        |
| :------------ | :------------------------------------------------ | :------------ |
| Cancelaciones | El botón de cancelar reservas no cancela la misma | En desarrollo |
