# Tok Tik

Este proyecto es una aplicación en Flutter inspirada en TikTok. Muestra un feed vertical de videos cortos con botones de interacción para likes, vistas y reproducción.

## Descripción

La aplicación carga una lista local de publicaciones de video mediante un flujo simple por capas y las presenta en una experiencia de pantalla completa. Cada video se muestra dentro de un `PageView` vertical, permitiendo al usuario desplazarse entre publicaciones como en un feed de videos cortos.

Cada publicación incluye:

- Un video local desde assets
- Un texto descriptivo
- Un contador de likes
- Un contador de vistas
- Botones de acción animados

Este proyecto está enfocado en entender la reproducción de video, el uso de assets locales, la gestión de estado, la separación entre repositorios y fuentes de datos, el mapeo de modelos, el uso de entidades y la composición de interfaces de pantalla completa en Flutter.

## Demo

<p align="center">
  <a href="demo.mp4">
    <img src="demo.png" alt="Vista previa de la demo de Tok Tik" width="320">
  </a>
</p>

## Conceptos clave

- Provider para la gestión de estado
- ChangeNotifier para actualizar la interfaz
- Videos locales como assets en Flutter
- Reproducción de video con video_player
- Abstracciones de repositorio y fuente de datos
- Inyección de dependencias desde main.dart
- Mapeo de datos locales a modelos de Dart
- Separación entre entidades y modelos
- Navegación vertical usando PageView.builder
- Interfaces de pantalla completa con Stack y Positioned
- Formateo de números con intl
- Animaciones simples con animate_do
- Tema oscuro personalizado con Material 3

## Funcionalidades

- Mostrar un feed de videos cortos
- Desplazarse verticalmente entre videos
- Reproducir videos locales en pantalla completa
- Repetir los videos automáticamente
- Silenciar los videos por defecto
- Mostrar likes y vistas de cada publicación
- Formatear números grandes en valores legibles
- Mostrar botones de acción animados
- Cargar los datos de videos mediante un Provider respaldado por un repositorio
- Tema oscuro personalizado con Material 3

## Flujo de datos de videos

El flujo de carga de videos está separado por responsabilidades:

1. `shared/data/local_video_post.dart` mantiene los datos locales crudos de los videos como una lista de mapas.
2. `LocalVideoDatasource` implementa `VideoPostDataSource` y sabe cómo leer esos datos locales.
3. `LocalVideoModel` mapea cada mapa local a un modelo de Dart y lo convierte en la entidad de dominio `VideoPost`.
4. `VideoPostsRepositoryImpl` implementa `VideoPostRepository` y delega la obtención de videos en el datasource configurado.
5. `DiscoverProvider` depende solo de `VideoPostRepository`, solicita la siguiente página de videos, actualiza el estado y notifica a la interfaz.
6. `main.dart` conecta las dependencias concretas creando un `VideoPostsRepositoryImpl` con `LocalVideoDatasource` e inyectándolo en `DiscoverProvider`.

Esto mantiene la capa de presentación independiente de la fuente de datos concreta. Si más adelante la app lee videos desde una API en lugar de datos locales, el provider puede seguir usando el mismo contrato del repositorio.

## Tecnologías

- Flutter
- Dart
- Provider
- video_player
- animate_do
- intl

## Propósito

Este proyecto amplía ejercicios anteriores de Flutter introduciendo una aplicación más visual y centrada en contenido multimedia.

El objetivo es conectar datos locales con la capa de presentación mediante contratos de dominio, gestionar el estado con Provider, reproducir videos locales y construir una experiencia móvil de pantalla completa similar a las aplicaciones modernas de videos cortos.

## Navegación

- [Volver a la descripción general del repositorio](../../README_es.md)
