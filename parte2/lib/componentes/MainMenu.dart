import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../CoinGame.dart'; // Asegúrate de que la ruta sea correcta

class MainMenu extends StatelessWidget {
  final CoinGame game;

  // Constructor que recibe el juego
  MainMenu({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // Fondo semitransparente
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título del juego
            Text(
              'CoinGame',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30), // Espacio entre el título y el botón
            // Botón para comenzar el juego
            ElevatedButton(
              onPressed: () {
                // Cambia el overlay a la pantalla del juego cuando se presiona el botón
                game.overlays.remove('MainMenu');
                game.overlays.add('GameHUD');
              },
              child: Text(
                'Comenzar Juego',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
