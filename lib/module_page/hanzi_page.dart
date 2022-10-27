import 'package:flutter/material.dart';
import 'package:youknow/router.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/view/lesson_cell.dart';
import 'package:go_router/go_router.dart';

class HanziPage extends StatefulWidget {
  const HanziPage({super.key});

  @override
  State<StatefulWidget> createState() => _HanziPageState();
}

class _HanziPageState extends State<HanziPage> {
  void _onPressedAction(section) {
    myChars!.section = section;
    GoRouter.of(context).push('/lesson', extra: myChars);
  }

  void _drawPageAction() {
    GoRouter.of(context).push('/draw');
  }

  Future<Widget> _body() async => MyChars.locChars().then((value){
    myChars = value;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 0.618),
      itemBuilder: (BuildContext context, int index) {
        var lesson = value.charsAt(index);
        return LessonCell(
          index: index,
          chars: lesson,
          onTap: () {
            _onPressedAction(index);
          },
        );
      },
      itemCount: value.numOfSection(),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('500字'),
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
