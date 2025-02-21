import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import '../CoinGame.dart';

class Hud extends PositionComponent with HasGameRef<CoinGame> {
  late TextComponent scoreText;

  Hud() {
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
  }

  @override
  Future<void> onLoad() async {
    add(scoreText);
  }

  // Método para actualizar el contador de frutas
  void updateScore(int score) {
    scoreText.text = 'Frutas: $score';
  }
}
