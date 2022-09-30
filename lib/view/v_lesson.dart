import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/model/lesson.dart';

class LessonView extends StatelessWidget {
  final Lesson lesson;
  final GestureTapCallback? onTap;

  const LessonView({super.key, required this.lesson,this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: MyColor.randomLightish(),
      child: InkWell(
        highlightColor: MyColor.randomLight(),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '第${lesson.index}课',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _chars()),
          ],
        ),
      ),
    );
  }

  List<Widget> _chars() {
    List<Widget> chars = [];
    for (var c in lesson.chars) {
      chars.add(Text(c));
      chars.add(const SizedBox(
        width: 10,
      ));
    }
    return chars;
  }
}
