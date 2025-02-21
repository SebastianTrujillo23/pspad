import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import '../CoinGame.dart';
import 'player.dart';

class Hud extends PositionComponent with HasGameRef<CoinGame> {
  late TextComponent scoreText;
  late Player player; // Referencia al jugador
  late RectangleComponent healthBarBackground; // Fondo de la barra de salud
  late RectangleComponent healthBar; // Barra de salud

  Hud(this.player) {
    scoreText = TextComponent(
      text: 'Frutas: 0',
      position: Vector2(10, 10), // Arriba a la izquierda
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    healthBarBackground = RectangleComponent(
      position: Vector2(10, 50), // Justo debajo del contador de frutas
      size: Vector2(200, 20), // Tamaño de la barra de salud
      paint: Paint()..color = Colors.grey[700]!, // Fondo de la barra
    );

    healthBar = RectangleComponent(
      position: Vector2(10, 50),
      size: Vector2(200, 20), // Mismo tamaño que el fondo
      paint: Paint()..color = Colors.green, // Barra de salud inicial
    );
  }

  @override
  Future<void> onLoad() async {
    add(scoreText);
    add(healthBarBackground);
    add(healthBar);
  }

  // Método para actualizar el contador de frutas
  void updateScore(int score) {
    scoreText.text = 'Frutas: $score';
  }

  // Método para actualizar la barra de vida
  void updateHealthBar(int health) {
    // Actualizar la longitud de la barra según la salud del jugador
    healthBar.size = Vector2(200 * (health / 100), 20);

    // Cambiar el color de la barra de salud según el porcentaje
    if (health <= 30) {
      healthBar.paint.color = Colors.red;
    } else if (health <= 60) {
      healthBar.paint.color = Colors.yellow;
    } else {
      healthBar.paint.color = Colors.green;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateHealthBar(player.health); // Actualizar la barra de vida en cada frame
  }
}
