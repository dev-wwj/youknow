import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/model/pinyin.dart';

class PinyinCell extends StatelessWidget {
  final PinyinGroup pyGroup;

  final GestureTapCallback? onTap;

  const PinyinCell({super.key, required this.pyGroup, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.randomLightish(),
      child: InkWell(
        highlightColor: MyColor.randomLight(),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 30),
              child: Text(
                pyGroup.name,
                style: const TextStyle(fontSize: 20, color: Color(0xFF222222)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 80, bottom: 15),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runAlignment: WrapAlignment.start,
                children: _chars(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _chars() {
    List<Widget> chars = [];
    for (var c in pyGroup.items) {
      chars.add(Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text(
          c.latin,
          style: const TextStyle(fontSize: 21, color: Color(0xFF666666)),
        ),
      ));
    }
    return chars;
  }
}
