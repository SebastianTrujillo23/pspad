import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'componentes/level.dart';

import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/painting.dart';

import 'componentes/player.dart';
  class CoinGame extends FlameGame
  with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;

  final world = Level(levelName: 'Level-01');
  Player player = Player(character: 'Mask Dude');
  //late JoystickComponent joystick;
  //bool showJoystick = false;

  @override
  Future<void> onLoad() async {
  // Cargar todas las imagenes dentro del cache
  await images.loadAllImages();

  final world = Level(
  player: player,
  levelName: 'Level-01',
  );

  cam = CameraComponent.withFixedResolution(
  world: world, width: 640, height: 360);
  cam.viewfinder.anchor = Anchor.topLeft;

  addAll([cam, world]);

  //if (showJoystick) {
  //addJoystick();
  //}

  return super.onLoad();
  }

  //@override

  }
