import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:go_router/go_router.dart';
import 'package:youknow/global.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/router.dart';
import 'dart:math' as math;

class ModuleView extends StatefulWidget {
  const ModuleView({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleViewState();
}

class _ModuleViewState extends State<ModuleView> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 30))
        ..repeat();
  late final Animation<double> _animation =
      Tween<double>(begin: 0, end: 1).animate(_animationController);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.randomLightish(),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Stack(
          children: [
            RotationTransition(
              turns: _animation,
              child: SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 180, 140),
                      child: SizedBox(
                        width: 80,
                        height: 160,
                        child: TextButton(
                          style: _buttonStyle,
                          onPressed: () {
                            GoRouter.of(context).push('/pinyin');
                          },
                          child: Transform.rotate(
                              angle: math.pi / 2, child: const Text('音')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(180, 140, 40, 0),
                      child: SizedBox(
                        width: 80,
                        height: 160,
                        child: TextButton(
                          style: _buttonStyle,
                          onPressed: () {
                            GoRouter.of(context).push('/hanzi');
                          },
                          child: Transform.rotate(
                              angle: math.pi / 2, child: const Text('字')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(140, 40, 0, 180),
                      child: SizedBox(
                        width: 160,
                        height: 80,
                        child: TextButton(
                          style: _buttonStyle,
                          onPressed: () {
                            MyChars.locChars().then((value) {
                              myChars = value;
                              channel.invokeMethod(keyRouteNative, [
                                'HandwritingVC',
                                jsonEncode(myChars),
                              ]);
                            });
                          },
                          child: const Text("写"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 180, 140, 40),
                      child: SizedBox(
                        width: 160,
                        height: 80,
                        child: TextButton(
                          style: _buttonStyle,
                          onPressed: () async {
                            MyChars.locChars().then((value) {
                              myChars = value;
                              router.push('/work');
                            });
                          },
                          child: const Text("练"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    router.push('/settings');
                  },
                  icon: Image.asset(
                    'resources/images/settings.png',
                    color: MyColor.random(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  late final ButtonStyle _buttonStyle = ButtonStyle(
      textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 30, color: Colors.white)),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        return MyColor.randomLight();
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        return MyColor.randomLight();
      }));
}
