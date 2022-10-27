import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/view/module_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ModuleView(),
    );
  }
}
