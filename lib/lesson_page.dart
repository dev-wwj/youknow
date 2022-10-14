import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youknow/global.dart';
import 'package:youknow/main.dart';
import 'package:youknow/view/character_view.dart';
import 'package:youknow/model/lesson.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第${widget.lesson.index}课'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: IconButton(onPressed: (){
          channel.invokeMethod(keyRouteNative, ['GameViewController', jsonEncode(widget.lesson), pageController.page]);
        }, icon: Image.asset('resources/images/write.png',),iconSize: 60,),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(itemBuilder: (context, index) {
                return CharacterView(character: widget.lesson.chars[index],);
              }, controller: pageController, itemCount: widget.lesson.chars.length,),
              Positioned(
                bottom: 20,
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: widget.lesson.chars.length,
                  effect: const SwapEffect(dotHeight: 10, dotWidth: 10),
                  onDotClicked: (idx) {},
                ),
              )
            ],
          ),
        ));
  }
}
