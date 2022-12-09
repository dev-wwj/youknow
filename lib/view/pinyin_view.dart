import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/userdefaults.dart';

class PinyinView extends StatefulWidget {
  final Pinyin pinyin;

  const PinyinView({super.key, required this.pinyin});

  @override
  State<StatefulWidget> createState() => _PinyinViewState();
}

class _PinyinViewState extends State<PinyinView> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    isAutoplay().then((value) {
      if (value) {
        speak();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColor.randomLightish()),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.pinyin.latin,
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
        ],
      ),
    );
  }

  void speak() {
    // channel.invokeMethod(keyMethodNative, ['speak', widget.pinyin.sound]);
    spelling(widget.pinyin.sound);
    speakAnimate();
  }

  Future<void> speakAnimate() async => await Future.delayed(
      const Duration(milliseconds: 200), () => _controller.forward());
}
