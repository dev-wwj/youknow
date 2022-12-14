// ignore_for_file: empty_catches

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:youknow/router.dart';
import 'package:lottie/lottie.dart';
import 'package:youknow/userdefaults.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({super.key, required this.character});

  final String character;

  @override
  State<StatefulWidget> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView>
    with TickerProviderStateMixin {
  String _pinying = '';
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    queryTrans();
    isAutoplay().then((value) {
      if (value) {
        speak();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColor.randomLightish()),
      child: Column(
        children: [
          const Spacer(),
          Text(
            _pinying,
            style: const TextStyle(fontSize: 32, color: Color(0xFF999999)),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.character,
            style: const TextStyle(
                fontSize: 84,
                color: Color(0xFF222222),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialButton(
            onPressed: () {
              if (_controller.isAnimating) {
                return;
              }
              speak();
            },
            child: Lottie.asset('resources/animations/sound.json',
                width: 80, controller: _controller, onLoaded: (composition) {
              _controller
                ..duration = const Duration(milliseconds: 400)
                // ..forward()
                ..addStatusListener((status) {
                  switch (status) {
                    case AnimationStatus.completed:
                      _controller.reverse();
                      break;
                    case AnimationStatus.dismissed:
                      break;
                  }
                });
            }),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void queryTrans() async {
    try {
      Future<dynamic> value = channel.invokeMethod(
          keyMethodNative, ['applyingTransform', widget.character]);
      value.then((value) {
        _pinying = value;
        setState(() {});
      });
    } on PlatformException {}
  }

  void speak() {
    spelling(widget.character);
    speakAnimate();
  }

  Future<void> speakAnimate() async => await Future.delayed(
      const Duration(milliseconds: 200), () => _controller.forward());
}
