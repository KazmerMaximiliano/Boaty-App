# BOATY

![](/md_assets/portada.png)

---

## Índice

- [Introducción](#introducción)
- [Instalación](#instalacion)
  - [Flutter](#flutter)
  - [Aplicación](#aplicación)
- [Configuración](#configuracion)
- [Producción](#producción)
  - [Android](#android)
  - [iOS](#iOS)
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

---

## Introducción

Boaty es un aplicación destina a al alquiler de embarcaciones bajo demanda.
Esta principalmente desarrollada con flutter desde el frontend y con laravel desde el backend.

## Instalación

#### Flutter

[Instalar flutter y los entornos de desarrollo necesarios](https://docs.flutter.dev/get-started/install)

#### Aplicación

Una vez finalizada la instalación de Flutter, se puede proceder con la instalación de la aplicación.

Primero, instalamos las dependecias de la aplicación:

```
flutter pub get
```

Si estamos trabajando en iOS, tambien sera necesario instalar las dependecias de iOS

```
cd ios && pod install
```

Para finalizar, podra ejecutar su aplicación tanto en android como en iOS como en Android con el siguiente comando:

```
flutter run
```

Sin embargo recomendamos usar las herramientas de desarrollo para flutter integradas en VsCode.

[Instalar las herramientas de desarrollo para flutter integradas en VsCode](https://docs.flutter.dev/development/tools/vs-code)

---

## Configuración

Para ejecutar la aplicación de forma correcta, sera necesario copiar el contenido del archivo
".env.example" en un un nuevo archivo nombrado ".env" y completar los varoles de las variables
de entorno del mismo.

URL => Hace referencia a la Api/Url a la cual se consultara la información de la aplicación.

ASSETS_URL => Hace referencia a la Api/Url a la cual se consultara la información de las imagenes de la aplicación. Suele ser la misma que la URL, solo que sin la terminación "/api".

---

## Producción

IMPORTANTE: Para la compilación de la aplicación en producción para android, los archivos de firma de app ya se encuentran genrados y estan en la carpeta android/app.

#### [Android](https://docs.flutter.dev/deployment/android)

#### [iOS](https://docs.flutter.dev/deployment/ios)

---

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
