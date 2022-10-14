// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:youknow/home.dart';
import 'package:youknow/lesson_page.dart';
import 'package:youknow/model/lesson.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: '',
    );
  }
}

const channel = MethodChannel('flutter.io');
// try {
//   channel.invokeMethod('push_native', ["GameViewController",lesson.toJson()]);
//   // ignore: empty_catches
// } on PlatformException {}

final GoRouter _router = GoRouter(routes: <GoRoute>[
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(
      path: '/lesson',
      builder: (context, state) {
        final lesson = state.extra as Lesson;
        if (lesson != null){
          return LessonPage(lesson: lesson);
        } else {
          return const HomePage();
        }
      })
]);

