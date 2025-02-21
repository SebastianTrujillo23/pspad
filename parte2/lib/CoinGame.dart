import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/painting.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'componentes/hud.dart';
import 'componentes/level.dart';
import 'componentes/player.dart';

class CoinGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {

  late final CameraComponent cam;
  late final Hud hud;
  Player player = Player(character: 'Virtual Guy');
  bool isGameStarted = false;
  int fruitCount = 0;
  bool isGameOver = false;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    overlays.add('startMenu');

    hud = Hud();
    add(hud);
  }

  Future<void> startMusic() async {
    await FlameAudio.audioCache.loadAll(['musica_fondo.mp3']);
    await FlameAudio.bgm.play('musica_fondo.mp3', volume: 0.5);
  }

  @override
  void onRemove() {
    super.onRemove();
    FlameAudio.bgm.stop();
  }

  void startGame() {
    isGameStarted = true;
    isGameOver = false;
    fruitCount = 0;
    overlays.remove('startMenu');
    overlays.remove('gameOver');
    startMusic();

    final world = Level(player: player, levelName: 'Level-01');
    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
  }

  void onFruitCollected() {
    if (isGameOver) return;

    fruitCount++;
    hud.updateScore(fruitCount);

    if (fruitCount >= 10) {
      endGame();
    }
  }

  void endGame() {
    if (isGameOver) return;
    isGameOver = true;
    FlameAudio.bgm.stop();

    // Eliminamos todos los elementos del juego antes de mostrar el Game Over
    children.forEach((component) => component.removeFromParent());

    overlays.add('gameOver');
  }
}

class StartMenu extends StatelessWidget {
  final CoinGame game;

  StartMenu({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            game.startGame();
          },
          child: Text('Comenzar'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            textStyle: TextStyle(fontSize: 24),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          ),
        ),
      ),
    );
  }
}

class GameOverMenu extends StatelessWidget {
  final CoinGame game;

  GameOverMenu({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GAME OVER',
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.startGame();
              },
              child: Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                textStyle: TextStyle(fontSize: 24),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}