import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';

class LessonCell extends StatelessWidget {
  final int index;
  final List<String> chars;
  final GestureTapCallback? onTap;

  const LessonCell(
      {super.key, required this.index, required this.chars, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.randomLightish(),
      child: InkWell(
        highlightColor: MyColor.randomLight(),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '第${index + 1}课',
              style: const TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: _chars(),
              ),
            )
            // Wrap(
            //     mainAxisAlignment: MainAxisAlignment.center,
          ],
        ),
      ),
    );
  }

  List<Widget> _chars() {
    List<Widget> chars = [];
    for (var c in this.chars) {
      chars.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(c, style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),),
      ));
    }
    return chars;
  }
}
