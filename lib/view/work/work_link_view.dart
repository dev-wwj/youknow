import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/extension/style_ex.dart';
import 'package:youknow/model/character_latin.dart';

var _colors = [
  MyColor.random(),
  MyColor.random(),
  MyColor.random(),
  MyColor.random(),
  MyColor.random(),
  MyColor.random(),
  MyColor.random(),
  MyColor.random(),
];

class WorkLinkView extends StatefulWidget {
  final CharRandom charRandom;

  const WorkLinkView({super.key, required this.charRandom});

  @override
  State<StatefulWidget> createState() => WorkLinkViewState();
}

class WorkLinkViewState extends State<WorkLinkView> {
  late List<String> chars;
  late List<CharLatin> latinChars;

  final LinePainter painter = LinePainter();

  int selectIndex = 0;
  @override
  void initState() {
    chars = widget.charRandom.randomChars;
    latinChars = widget.charRandom.orderChars;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 300,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _Card(
                title: chars[index],
                borderColor: _colors[index],
                isSelected: index == selectIndex,
                onTap: () {
                  setState(() {
                    selectIndex = index;
                  });
                },
              );
            },
            itemCount: chars.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          )),
          CustomPaint(
            painter: painter,
            size: Size(50, chars.length * 60),
          ),
          Flexible(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _Card(
                title: latinChars[index].latin ?? "",
                isSelected: false,
                onTap: () {
                  onTapRight(index);
                },
              );
            },
            itemCount: latinChars.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ))
        ],
      ),
    ));
  }

  void onTapRight(int index) {
    var link = WorkLink(
        index: selectIndex, color: _colors[selectIndex], matching: index);
    painter.addLink(link);
    if (painter.links.length == chars.length) {
      // 判读是否正确
      widget.charRandom.judgeLink(painter.links);
    } else {
      var temp = selectIndex;
      var indexes = <int>[];
      for (var element in painter.links) {
        indexes.add(element.index);
      }
      while (indexes.contains(temp)) {
        temp++;
        if (temp >= chars.length) {
          temp = 0;
        }
      }
      selectIndex = temp;
      setState(() {});
    }
  }
}

class _Card extends StatefulWidget {
  final String title;
  final Color borderColor;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const _Card(
      {super.key,
      required this.title,
      this.borderColor = CupertinoColors.inactiveGray,
      required this.isSelected,
      this.onTap});
  @override
  State<StatefulWidget> createState() => _CardState();
}

class _CardState extends State<_Card> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2.0,
                color: widget.isSelected
                    ? widget.borderColor
                    : CupertinoColors.inactiveGray)),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Text(
            widget.title,
            style: MyTextStyle.black(22),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  var links = <WorkLink>[];
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    drawLine(canvas, rect);
  }

  void drawLine(Canvas canvas, Rect rect) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;
    for (var element in links) {
      if (element.matching >= 0) {
        paint.color = element.color;
        canvas.drawLine(Offset(0, 30 + element.index * 60),
            Offset(50, 30 + element.matching * 60), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Future<void> addLink(WorkLink link) async {
    var temp = links.where((element) => element.index != link.index).toList();
    temp.add(link);
    links = temp;
  }
}
