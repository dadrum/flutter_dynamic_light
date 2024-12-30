import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../media/shaders_service.dart';
import '../../media/sprites_service.dart';
import '../environment/builders.dep_gen.dart';
import '../media/shader_type.dart';
import '../media/sprite_type.dart';

class LightedSprite extends StatefulWidget {
  const LightedSprite({
    super.key,
    required this.shadowXOffset,
    required this.sprite,
  });

  final double shadowXOffset;
  final SpriteType sprite;

  @override
  State<LightedSprite> createState() => _LightedSpriteState();
}

class _LightedSpriteState extends State<LightedSprite> {
  late ui.Image _kegiSprite;
  late FragmentShader _shader;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final service = context.depGen().g<SpritesService>();
    final serviceShader = context.depGen().g<ShadersService>();
    _kegiSprite = service.getSprite(widget.sprite);
    _shader = serviceShader.getShader(ShaderType.lightShader);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpritePainter(
        shader: _shader,
        shadowXOffset: widget.shadowXOffset,
        image: _kegiSprite,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
class _SpritePainter extends CustomPainter {
  _SpritePainter({
    required this.shader,
    required this.image,
    required this.shadowXOffset,
  });

  final FragmentShader shader;
  final ui.Image image;
  final double shadowXOffset;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setImageSampler(0, image)
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, image.width.toDouble())
      ..setFloat(3, image.height.toDouble())
      ..setFloat(4, shadowXOffset);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_SpritePainter oldDelegate) =>
      shadowXOffset != oldDelegate.shadowXOffset;
}
