// import 'dart:js';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: MyColor.randomLight(),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
