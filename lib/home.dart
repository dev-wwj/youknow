import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youknow/model/lesson.dart';
import 'package:youknow/view/v_lesson.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const pushChannel = MethodChannel('flutter.io');
  void _onPressedAction(Lesson lesson) {
    try {
      pushChannel.invokeMethod('push_native', ["GameViewController",lesson.toJson()]);
      // ignore: empty_catches
    } on PlatformException {}
  }

  Future<List<Lesson>> lessons = Lesson.lessons();
  Future<Widget> _body() async => lessons.then((value) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1/0.618),
          itemBuilder: (BuildContext context, int index) {
            var lesson =  value[index];
            return LessonView(lesson:lesson, onTap: (){
                _onPressedAction(lesson);
            },);
          },
          itemCount: value.length,
        );
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: FutureBuilder<Widget>(
        future: _body(),
        initialData: const SizedBox.shrink(),
        builder: (context, snapshot) {
          return Center(child: snapshot.data);
        },
      ),
    );
  }
}
