import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:youknow/global.dart';
import 'package:youknow/main.dart';
import 'package:youknow/view/character_view.dart';
import 'package:youknow/model/lesson.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<StatefulWidget> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late  PageController _pageController;

  late List<Lesson> _lessons;
  late Lesson _lesson;

  int _groupStart = 0;
  bool _showNext = false;
  set showNext(value) {
    if (_showNext != value) {
      _showNext = value;
      setState(() {});
    }
  }

  String? charAt(index) {
    var count = 0;
    for (var element in _lessons) {
      count += element.chars.length;
      if (count > index) {
        _groupStart = count - element.chars.length;
        var i = element.chars.length - (count - index);
        _lesson = element;
        return element.chars[i.toInt()];
      }
    }
    return null;
  }

  int indexAtLessons(){
    var count = 0;
    for (var element in _lessons) {
      if (_lesson == element) {
        return count;
      }
      count += element.chars.length;
    }
    return 0;
  }

  @override
  void initState() {
    _lesson = widget.lesson;
    lessons.then((value) {
      _lessons = value;
      _groupStart = indexAtLessons();
      _pageController = PageController(initialPage: _groupStart);
      setState(() {
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第${_lesson.index}课'),
          actions: _showNext ? [IconButton(onPressed: (){}, icon: const Icon(Icons.navigate_next))] : [],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: IconButton(
          onPressed: () {
            channel.invokeMethod(keyRouteNative, [
              'GameViewController',
              jsonEncode(widget.lesson),
              _pageController.page
            ]);
          },
          icon: Image.asset(
            'resources/images/write.png',
          ),
          iconSize: 60,
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                itemBuilder: (context, index) {
                  return CharacterView(
                    character: charAt(index) ?? "",
                  );
                },
                controller: _pageController,
                itemCount: 1000,
                onPageChanged: (value) {
                  bool show = value - _groupStart == _lesson.chars.length - 1 ;
                  showNext = show;
                  if (value - _groupStart == _lesson.chars.length) {
                    setState(() {

                    });
                  }
                },
              ),
            ],
          ),
        ));
  }

  
}
