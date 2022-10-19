import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/model/lesson.dart';

class LessonCell extends StatelessWidget {
  final Lesson lesson;
  final GestureTapCallback? onTap;

  const LessonCell({super.key, required this.lesson,this.onTap});

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

            Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),child:  Wrap(alignment: WrapAlignment.center,children: _chars(),),)

            // Wrap(
            //     mainAxisAlignment: MainAxisAlignment.center,
          ],
        ),
      ),
    );
  }

  List<Widget> _chars() {
    List<Widget> chars = [];
    for (var c in lesson.chars) {
      chars.add(Padding(padding: const EdgeInsets.only(top: 3),child: Text(c),));
      chars.add(const SizedBox(
        width: 12,
      ));
    }
    return chars;
  }
}
