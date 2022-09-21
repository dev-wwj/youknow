import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youknow/extension/color_ex.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const pushChannel = MethodChannel('flutter.io/push_native');

  void _onPressedAction() {
    try {
      pushChannel.invokeMethod('push_native');
      // ignore: empty_catches
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: MyColor.random(),
              child: TextButton(onPressed: _onPressedAction, child: Text('$index'),),
            );
          }),
    );
  }
}
