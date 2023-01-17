import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:youknow/model/character_latin.dart';

class WorkLinkView extends StatefulWidget {
  final CharRandom charRandom;

  const WorkLinkView({super.key, required this.charRandom});

  @override
  State<StatefulWidget> createState() => WorkLinkViewState();
}

class WorkLinkViewState extends State<WorkLinkView> {
  late List<Widget> _leftRows;
  late List<Widget> _rightRows;
  int index = 0;
  @override
  void initState() {
    List<String> chars = widget.charRandom.randomChars;
    _leftRows = List<Widget>.generate(
        chars.length,
        (index) => _Card(
            key: UniqueKey(),
            title: chars[index],
            isSelected: index == 0 ? true : false));
    List<CharLatin> latinChars = widget.charRandom.orderChars;
    _rightRows = List<Widget>.generate(
        latinChars.length,
        (index) => _Card(
            key: UniqueKey(),
            title: latinChars[index].latin ?? "",
            isSelected: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _leftRows,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _rightRows,
          ),
        ],
      ),
    ));
  }
}

class _Card extends StatelessWidget {
  final String title;
  final bool isSelected;

  const _Card({super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2.0,
              color: isSelected
                  ? CupertinoColors.systemGreen
                  : CupertinoColors.inactiveGray)),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
