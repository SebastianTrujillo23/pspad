import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'componentes/level.dart';

class CoinGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;

  final world = Level();

  @override
  FutureOr<void> onLoad() {
    Future<void> onLoad() async {
      // Cargar todas las imagenes dentro del cache
      await images.loadAllImages();

      cam = CameraComponent.withFixedResolution(
          world: world, width: 640, height: 360);
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);

      return super.onLoad();
    }
  }
}
