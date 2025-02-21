# parte2

A new Flutter project.

Este proyecto es un videojuego en el que un personaje interactúa con un mapa creado a partir de imágenes descargadas. El juego permite al jugador mover al personaje, saltar, y ser afectado por la gravedad, mientras enfrenta desafíos como colisiones y recolecta frutas. A continuación, se detallan las características principales del juego:

Características del Proyecto
Mapa: El mapa se ha creado utilizando imágenes descargadas e incorporadas al proyecto. El diseño del mapa permite una experiencia visual atractiva y funcional.

Movimiento del Personaje: El personaje puede moverse de forma horizontal y saltar. Se ha implementado una física que afecta al personaje por la gravedad, haciendo que caiga con el tiempo si no está en contacto con el suelo.

Colisiones:

Bloques: El personaje puede chocar contra bloques del mapa, lo que evita que atraviese ciertos objetos.
Plataformas: Existen plataformas que el personaje puede atravesar por debajo, lo que facilita su movimiento en algunas áreas del mapa.
Frutas: Se han colocado frutas en el mapa que el personaje puede recolectar. Cada vez que el personaje recoge una fruta, se actualiza un contador que lleva el registro de cuántas frutas ha recogido.

Barra de Vida: El personaje cuenta con una barra de vida que se va reduciendo al colisionar con ciertos enemigos o peligros en el mapa. Esta barra se actualiza en tiempo real.

Estructura del Proyecto
Mapa: Las imágenes utilizadas para crear el mapa se encuentran dentro de la carpeta assets/images y se cargan al inicio del juego.

Personaje: El personaje está configurado para moverse y saltar con controles de teclado. Su estado se actualiza para reflejar si está en el aire, cayendo, o en el suelo.

Colisiones: Se implementaron dos tipos de colisiones: una para los bloques que impiden el paso del personaje, y otra para las plataformas que permiten atravesar por debajo.

Contador de Frutas: Se ha creado un contador que muestra cuántas frutas ha recogido el jugador. Esta información se muestra en la interfaz gráfica (HUD).

Barra de Vida: Se ha añadido una barra de vida en la interfaz para reflejar la salud del personaje. Esta barra se reduce conforme el personaje pierde vida.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
