# Push App

Aplicación de práctica creada con Flutter para recibir notificaciones push enviadas desde un emisor externo, en este caso Firebase Cloud Messaging (FCM). La app solicita permisos al usuario, obtiene el token del dispositivo, escucha los mensajes entrantes en cualquier estado de la aplicación (primer plano, segundo plano o cerrada), los guarda en una lista y permite abrir cada uno en una pantalla de detalle.

El objetivo principal no es construir una aplicación de producción, sino entender el ciclo completo de una notificación push en Flutter: configurar Firebase, gestionar permisos, reaccionar a los mensajes según el estado de la app, mostrar notificaciones locales cuando la app está abierta y navegar a la pantalla correcta al pulsar sobre una notificación.

## Demo

<p align="center">
  <img src="images/notifications_list.png" alt="Lista de notificaciones con una notificación entrante" width="320">
  <img src="images/notification_detail.png" alt="Detalle de una notificación push" width="320">
</p>

## Estado de las plataformas

| Plataforma | Estado |
| --- | --- |
| Android | Probado por completo: permisos, recepción en primer plano, segundo plano y con la app cerrada, notificación local con sonido personalizado y navegación al detalle. |
| iOS | La app compila y se ejecuta en un dispositivo físico, pero no se ha podido probar la recepción de notificaciones push. Apple exige una cuenta de Apple Developer de pago para configurar APNs (Apple Push Notification service), que es el canal que usa FCM para entregar mensajes en iOS. |

## Tecnologías usadas

- Flutter con Material 3.
- Dart.
- `firebase_core` para inicializar Firebase.
- `firebase_messaging` para recibir notificaciones push de Firebase Cloud Messaging.
- `flutter_local_notifications` para mostrar notificaciones locales cuando la app está en primer plano.
- `flutter_bloc` para la gestión de estado.
- `equatable` para comparar estados y eventos por valor.
- `go_router` para la navegación declarativa.

## Estructura del proyecto

```text
lib/
|-- config/
|   |-- local_notifications/
|   |   `-- local_notifications.dart
|   |-- presentation/
|   |   |-- blocs/
|   |   |   `-- notifications/
|   |   |       |-- notifications_bloc.dart
|   |   |       |-- notifications_event.dart
|   |   |       `-- notifications_state.dart
|   |   `-- screens/
|   |       |-- details_screen.dart
|   |       `-- home_screen.dart
|   |-- router/
|   |   `-- app_router.dart
|   `-- theme/
|       `-- app_theme.dart
|-- domain/
|   `-- entities/
|       `-- push_message.dart
|-- firebase_options.dart
`-- main.dart
```

La app se organiza en estas áreas:

- `config/local_notifications`: envoltorio sobre `flutter_local_notifications`.
- `config/presentation`: el `NotificationsBloc` y las dos pantallas de la app.
- `config/router` y `config/theme`: rutas y tema compartidos.
- `domain/entities`: la entidad `PushMessage`, independiente de Firebase.
- `firebase_options.dart`: configuración generada por FlutterFire CLI para cada plataforma.

## Configuración de Firebase

El proyecto se conectó a Firebase con FlutterFire CLI, que generó:

- `firebase.json`: descripción de las apps registradas en el proyecto de Firebase.
- `lib/firebase_options.dart`: `DefaultFirebaseOptions.currentPlatform` con las claves de cada plataforma.
- `android/app/google-services.json` e `ios/Runner/GoogleService-Info.plist`: archivos de configuración nativos.

En Android, además, se aplica el plugin `com.google.gms.google-services` y se habilita `coreLibraryDesugaring`, que es un requisito de `flutter_local_notifications`. En iOS, la plataforma mínima se ha subido a iOS 15.0.

## Punto de entrada

La aplicación arranca en `lib/main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationsBloc.initializeFirebaseNotifications();
  //await LocalNotifications.initializeLocalNotifications();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => NotificationsBloc(
          requestLocalNotificationPermissions: LocalNotifications.requestPermissionLocalNotifications,
          showLocalNotifications: LocalNotifications.showLocalNotifications,
        ),
      ),
    ],
    child: const MainApp(),
  ));
}
```

Antes de lanzar la UI se registra el manejador de mensajes en segundo plano y se inicializa Firebase. El `NotificationsBloc` se provee en la raíz de la app para que cualquier pantalla pueda leer las notificaciones recibidas.

La inicialización de las notificaciones locales está comentada actualmente para poder ejecutar la app en iOS, ya que la configuración de iOS de `flutter_local_notifications` todavía está pendiente (`// TODO iOS`).

`MainApp` construye un `MaterialApp.router` y envuelve toda la navegación con `HandleNotificationInteractions` mediante la propiedad `builder`.

## Navegación con GoRouter

La navegación se define en `lib/config/router/app_router.dart`:

```dart
GoRoute(
  path: '/push-details/:messageId',
  builder: (context, state) => DetailsScreen(
    pushMessageId: state.pathParameters['messageId'] ?? '4',
  ),
)
```

| Ruta | Pantalla | Propósito |
| --- | --- | --- |
| `/` | `HomeScreen` | Estado de los permisos y lista de notificaciones recibidas |
| `/push-details/:messageId` | `DetailsScreen` | Detalle de una notificación concreta |

`appRouter` se declara como variable global para poder navegar también desde fuera del árbol de widgets, por ejemplo, desde el callback que se ejecuta al pulsar una notificación local.

## Tema

`AppTheme.getTheme()` devuelve un `ThemeData` de Material 3 generado a partir de `Colors.red` como color semilla.

## Entidad PushMessage

Archivo: `lib/domain/entities/push_message.dart`.

`PushMessage` representa una notificación dentro de la app, sin depender de las clases de Firebase:

```dart
class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;
  ...
}
```

Convertir el `RemoteMessage` de Firebase en una entidad propia hace que la UI no dependa de Firebase y trabaje solo con los campos que necesita.

## Gestión de estado con NotificationsBloc

Archivos: `lib/config/presentation/blocs/notifications/`.

### Estado y eventos

`NotificationsState` guarda el estado de los permisos y la lista de notificaciones recibidas:

```dart
class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  final List<PushMessage> notifications;
  ...
}
```

Los eventos son dos:

- `NotificationsStatusChanged`: cambia el estado de autorización de las notificaciones.
- `NotificationReceived`: añade una nueva notificación al principio de la lista.

```dart
void _onPushMessageRecived(NotificationReceived event, Emitter<NotificationsState> emit) {
  emit(state.copyWith(
    notifications: [event.pushMessage, ...state.notifications],
  ));
}
```

### Permisos y token FCM

Al crearse, el bloc consulta el estado actual de los permisos con `messaging.getNotificationSettings()`. Cuando el usuario pulsa el icono de ajustes del `AppBar`, se llama a `requestPermission()`, que pide permiso a Firebase Messaging y también a `flutter_local_notifications` (necesario en Android 13 o superior):

```dart
NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  badge: true,
  criticalAlert: true,
  sound: true,
  ...
);
```

Cuando el estado es `AuthorizationStatus.authorized`, el bloc obtiene el token FCM del dispositivo con `messaging.getToken()` y lo imprime por consola. Ese token es el que se usa en la consola de Firebase (o en cualquier otro emisor) para enviar mensajes de prueba a ese dispositivo en concreto.

### Recepción de mensajes

`handleRemoteMessage` transforma un `RemoteMessage` en un `PushMessage`:

```dart
final notification = PushMessage(
  messageId: message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
  title: message.notification!.title ?? '',
  body: message.notification!.body ?? '',
  sentDate: message.sentTime ?? DateTime.now(),
  data: message.data,
  imageUrl: Platform.isAndroid
      ? message.notification!.android?.imageUrl
      : message.notification!.apple?.imageUrl,
);
```

Se eliminan los caracteres `:` y `%` del `messageId` para poder usarlo como parámetro de la ruta `/push-details/:messageId` sin romper la URL. La imagen se lee de la parte específica de Android o de Apple según la plataforma.

Después, si se ha inyectado `showLocalNotifications`, se muestra una notificación local y se añade el evento `NotificationReceived` al bloc.

### Dependencias inyectadas

`requestLocalNotificationPermissions` y `showLocalNotifications` se pasan al bloc por el constructor como funciones opcionales en lugar de llamar directamente a `LocalNotifications`. Así el bloc no depende de forma rígida del plugin de notificaciones locales y resulta más fácil de probar o de reutilizar.

## Mensajes según el estado de la app

| Estado de la app | Cómo se gestiona |
| --- | --- |
| Primer plano | `FirebaseMessaging.onMessage.listen(handleRemoteMessage)` dentro del bloc. El sistema no muestra la notificación por sí solo, así que se lanza una notificación local. |
| Segundo plano | El sistema muestra la notificación. Al pulsarla, `FirebaseMessaging.onMessageOpenedApp` la procesa y navega al detalle. |
| Cerrada | El sistema muestra la notificación. Al abrir la app desde ella, `FirebaseMessaging.instance.getInitialMessage()` la recupera y navega al detalle. |

El manejador `firebaseMessagingBackgroundHandler` debe ser una función de nivel superior porque Firebase lo ejecuta en un isolate separado, fuera del árbol de widgets.

### HandleNotificationInteractions

Este `StatefulWidget` de `lib/main.dart` configura, en su `initState`, los dos casos en los que el usuario abre la app pulsando una notificación:

```dart
Future<void> setupInteractedMessage() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) _handleMessage(initialMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  context.read<NotificationsBloc>().handleRemoteMessage(message);

  final messageId = message.messageId?.replaceAll(':', '').replaceAll('%', '');
  appRouter.push('/push-details/$messageId');
}
```

Primero se registra el mensaje en el bloc y después se navega a su detalle, de forma que `DetailsScreen` puede encontrarlo por su id.

## Notificaciones locales

Archivo: `lib/config/local_notifications/local_notifications.dart`.

`LocalNotifications` agrupa en métodos estáticos todo lo relacionado con `flutter_local_notifications`:

- `requestPermissionLocalNotifications()`: pide permiso de notificaciones en Android.
- `initializeLocalNotifications()`: configura el plugin con el icono `app_icon` y registra el callback que se ejecuta al pulsar una notificación.
- `showLocalNotifications(...)`: muestra una notificación con importancia máxima y un sonido personalizado (`res/raw/notification.mp3`).
- `onDidReceiveNotificationResponse(...)`: navega a `/push-details/<payload>`, donde el `payload` es el `messageId` del mensaje.

```dart
const androidDetails = AndroidNotificationDetails(
  'channelId',
  'channelName',
  playSound: true,
  sound: RawResourceAndroidNotificationSound('notification'),
  importance: Importance.max,
  priority: Priority.high,
);
```

Por ahora esta clase solo tiene configuración para Android; la parte de iOS está marcada como `TODO`.

## Pantallas

### HomeScreen

Archivo: `lib/config/presentation/screens/home_screen.dart`.

- El título del `AppBar` muestra el estado actual de los permisos usando `context.select`, de modo que solo se reconstruye cuando cambia `status`.
- El icono de ajustes llama a `requestPermission()` en el bloc.
- El cuerpo es un `ListView.builder` con las notificaciones recibidas: título, cuerpo e imagen (si la tiene). Al pulsar un elemento se navega a su detalle.

### DetailsScreen

Archivo: `lib/config/presentation/screens/details_screen.dart`.

Recibe el `pushMessageId` desde la ruta y busca el mensaje con `getMessageById`. Si existe, muestra la imagen, el título, el cuerpo y el contenido del campo `data`; si no, muestra el texto `Notificación no existe`.

## Enviar una notificación de prueba

1. Ejecutar la app en un dispositivo Android y pulsar el icono de ajustes para conceder permisos.
2. Copiar el token FCM que aparece en la consola de depuración.
3. En la consola de Firebase, ir a **Messaging** y crear una nueva campaña de notificación.
4. Rellenar el título, el texto y, opcionalmente, una imagen y datos adicionales (clave/valor).
5. Usar **Enviar mensaje de prueba** y pegar el token del dispositivo.

La notificación se puede probar con la app en primer plano, en segundo plano o cerrada para comprobar los tres flujos.

## Conceptos de Flutter practicados

Esta app es útil para practicar:

- Integración de Firebase en un proyecto Flutter con FlutterFire CLI.
- Firebase Cloud Messaging: permisos, token del dispositivo y recepción de mensajes.
- Diferencias entre mensajes en primer plano, en segundo plano y con la app cerrada.
- Manejadores de nivel superior para mensajes en segundo plano.
- Notificaciones locales con canal, prioridad y sonido personalizados.
- Navegación a partir de la interacción con una notificación.
- `Bloc` con eventos, estado inmutable y `Equatable`.
- Inyección de dependencias por constructor para desacoplar el bloc de los plugins.
- Separación entre la entidad de dominio (`PushMessage`) y el modelo de Firebase (`RemoteMessage`).
- Rutas con parámetros en GoRouter y navegación fuera del árbol de widgets.
- Configuración nativa específica de Android e iOS.

## Ejecutar el proyecto

Instalar dependencias:

```bash
flutter pub get
```

Ejecutar la aplicación:

```bash
flutter run
```

Analizar el código:

```bash
flutter analyze
```

Ejecutar tests, si se añaden tests al proyecto:

```bash
flutter test
```

Para usar un proyecto de Firebase propio, hay que volver a generar la configuración con FlutterFire CLI:

```bash
flutterfire configure
```

## Resumen

`Push App` es una aplicación de aprendizaje centrada en las notificaciones push con Firebase Cloud Messaging. Cubre todo el recorrido de un mensaje, desde que se envía desde Firebase hasta que se muestra en la lista y en su pantalla de detalle, con un `Bloc` como fuente única de verdad y notificaciones locales para los mensajes que llegan con la app abierta. La parte de Android está probada por completo; la de iOS se ejecuta en un dispositivo físico, pero la recepción de push queda pendiente de disponer de una cuenta de Apple Developer.

## Navegación

- [Volver a la descripción general del repositorio](../../README_es.md)
