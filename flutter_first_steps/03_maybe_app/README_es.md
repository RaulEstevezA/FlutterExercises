# Maybe App

Este proyecto es una aplicación de chat en Flutter que simula una conversación y proporciona respuestas automáticas de sí/no cuando el usuario envía una pregunta.

## Descripción

La aplicación permite al usuario escribir mensajes en una interfaz de chat. Cuando un mensaje termina con un signo de interrogación, la app obtiene una respuesta automática desde una API externa y la muestra como respuesta en la conversación.

La respuesta incluye:

- Una respuesta de sí/no
- Una imagen animada relacionada con la respuesta
- Una burbuja de chat con el estilo del mensaje de la otra persona

Este proyecto está enfocado en entender la gestión de estado, el consumo de APIs, el mapeo de modelos y la actualización dinámica de la interfaz en Flutter.

## Captura

<p align="center">
  <img src="maybe_app.png" width="150">
</p>

## Conceptos clave

- Provider para la gestión de estado
- ChangeNotifier para actualizar la interfaz
- Dio para realizar peticiones HTTP
- Mapeo de respuestas JSON a modelos de Dart
- Separación entre entidades y modelos
- Lógica condicional basada en la entrada del usuario
- Interfaz dinámica de chat usando ListView.builder
- ScrollController para desplazar el chat automáticamente
- Carga de imágenes desde URLs de red

## Funcionalidades

- Enviar mensajes mediante un campo de texto
- Mostrar mensajes en burbujas diferentes según quién los envía
- Activar respuestas automáticas cuando el mensaje termina con signo de interrogación
- Obtener respuestas de sí/no desde una API externa
- Mostrar una imagen con cada respuesta automática
- Desplazar automáticamente el chat al último mensaje
- Tema personalizado con Material 3

## Tecnologías

- Flutter
- Dart
- Provider
- Dio

## Propósito

Este proyecto amplía ejercicios anteriores de Flutter introduciendo una estructura de aplicación más completa y la obtención de datos de forma asíncrona.

El objetivo es conectar la interfaz con el estado de la aplicación, consumir un servicio externo y transformar los datos de una API en entidades utilizables por la capa de presentación.

## Navegación

- [Volver a la descripción general del repositorio](../../README_es.md)
