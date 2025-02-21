import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'CoinGame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: CoinGame(),
          overlayBuilderMap: {
            'startMenu': (context, CoinGame game) {
              return StartMenu(
                game: game,
              );
            },
          },
          initialActiveOverlays: const ['startMenu'],
        ),
      ),
    ),
  );
}