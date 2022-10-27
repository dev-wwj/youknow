import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:youknow/home.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/module_page/draw_page.dart';
import 'package:youknow/module_page/hanzi_page.dart';
import 'package:youknow/module_page/lesson_page.dart';


const channel = MethodChannel('flutter.io');

late MyChars myChars;

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(
      path: '/hanzi',
      builder: (context, state) {
        return const HanziPage();
      }),
  GoRoute(
      path: '/lesson',
      builder: (context, state) {
        if (myChars != null) {
          return const LessonPage();
        } else {
          return const HomePage();
        }
      }),
  GoRoute(
      path: '/draw',
      builder: (context, state) {
        return const DrawPage();
      })
]);
