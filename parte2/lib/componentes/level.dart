import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'player.dart';



class Level extends World {
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    add(level);
    add(
      Player(
          character: 'Mask Dude'
      ),
    );

    return super.onLoad();
  }