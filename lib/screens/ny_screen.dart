import 'package:flutter/material.dart';

import '../media/sprite_type.dart';
import 'sprite.dart';

class NyScreen extends StatefulWidget {
  const NyScreen({Key? key}) : super(key: key);

  @override
  State<NyScreen> createState() => _NyScreenState();
}

class _NyScreenState extends State<NyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Инициализация AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Добавление CurvedAnimation для изменения кривой
    _animation = Tween<double>(begin: -1, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Ускорение ближе к крайним значениям
    ));

    // Запуск бесконечной анимации
    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..forward();
  }

  // ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // ---------------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Stack(children: [
        const Positioned.fill(
          child: ColoredBox(
            color: Colors.white,
          ),
        ),

        Positioned.fill(
          child: Image.asset(
            'assets/images/bg.jpg',
            repeat: ImageRepeat.repeat,
            color: const Color(0x8F7aaa1f),
            colorBlendMode: BlendMode.modulate,
          ),
        ),

        /// tree
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SizedBox(
              width: 280,
              height: 360,
              child: LightedSprite(
                shadowXOffset: _animation.value * 20,
                sprite: SpriteType.tree,
              ),
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('ball1'),
          left: 70,
          top: 20,
          child: SizedBox(
            width: 70,
            height: 120,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.ball1,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('ball2'),
          left: 250,
          top: 40,
          child: SizedBox(
            width: 70,
            height: 120,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.ball2,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('ball3'),
          left: 530,
          top: 30,
          child: SizedBox(
            width: 70,
            height: 120,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.ball3,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('ball1-1'),
          left: 710,
          top: 70,
          child: SizedBox(
            width: 75,
            height: 120,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.ball1,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('ball3-1'),
          left: 160,
          top: 100,
          child: SizedBox(
            width: 70,
            height: 120,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.ball3,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('bell2'),
          left: 50,
          top: 190,
          child: SizedBox(
            width: 100,
            height: 80,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.bell2,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('bell1'),
          right: 170,
          top: 180,
          child: SizedBox(
            width: 100,
            height: 80,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.bell1,
            ),
          ),
        ),

        ///
        Positioned(
          left: 50,
          top: 290,
          child: SizedBox(
            width: 100,
            height: 110,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.gift1,
            ),
          ),
        ),

        ///
        Positioned(
          key: const ValueKey('sock1'),
          left: 720,
          top: 230,
          child: SizedBox(
            width: 80,
            height: 90,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.sock1,
            ),
          ),
        ),

        ///
        Positioned(
          left: 570,
          top: 290,
          child: SizedBox(
            width: 100,
            height: 110,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.gift1,
            ),
          ),
        ),

        ///
        Positioned(
          left: 180,
          top: 310,
          child: SizedBox(
            width: 100,
            height: 110,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.gift2,
            ),
          ),
        ),

        ///
        Positioned(
          right: 70,
          top: 310,
          child: SizedBox(
            width: 100,
            height: 110,
            child: LightedSprite(
              shadowXOffset: _animation.value * 20,
              sprite: SpriteType.gift1,
            ),
          ),
        ),
      ]),
    );
  }
}
