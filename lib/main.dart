// import 'dart:js';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/home.dart';
import 'package:youknow/lesson_page.dart';
import 'package:youknow/model/character.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

const channel = MethodChannel('flutter.io');

late MyChars myChars;

final GoRouter _router = GoRouter(routes: <GoRoute>[
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(
      path: '/lesson',
      builder: (context, state) {
        if (myChars != null) {
          return LessonPage();
        } else {
          return const HomePage();
        }
      })
]);
