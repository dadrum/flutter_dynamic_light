import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'sprite_type.dart';

class SpritesService {
  // preloaded images
  final Map<SpriteType, ui.Image> _cachedSprites = {};

  // ---------------------------------------------------------------------------
  String getSpritePath(SpriteType spriteType) => switch (spriteType) {
        SpriteType.ball1 => 'assets/images/ball1.png',
        SpriteType.ball2 => 'assets/images/ball2.png',
        SpriteType.ball3 => 'assets/images/ball3.png',
        SpriteType.bell1 => 'assets/images/bell1.png',
        SpriteType.bell2 => 'assets/images/bell2.png',
        SpriteType.gift1 => 'assets/images/gift1.png',
        SpriteType.gift2 => 'assets/images/gift2.png',
        SpriteType.sock1 => 'assets/images/sock1.png',
        SpriteType.tree => 'assets/images/tree.png',
      };

  // ---------------------------------------------------------------------------
  /// preloading all sprites
  Future<void> cacheAllSprites() async {
    for (final spriteType in SpriteType.values) {
      await cacheSprite(spriteType);
    }
  }

  // ---------------------------------------------------------------------------
  /// preloading the sprite
  Future<void> cacheSprite(
    SpriteType spriteType,
  ) async {
    // изображение уже загружено
    if (_cachedSprites.containsKey(spriteType)) {
      return;
    }

    final String assetPath = getSpritePath(spriteType);

    final imageData = await rootBundle.load(assetPath);
    final decodedImage =
        await decodeImageFromList(imageData.buffer.asUint8List());

    _cachedSprites[spriteType] = decodedImage;
  }

  // ---------------------------------------------------------------------------
  /// getting a cached image
  ui.Image getSprite(SpriteType spriteType) {
    return _cachedSprites[spriteType]!;
  }
}
