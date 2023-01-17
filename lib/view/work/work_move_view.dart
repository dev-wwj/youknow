import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:reorderables/reorderables.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/model/character_latin.dart';

class WorkMoveView extends StatefulWidget {
  // final List<String> chars;
  final CharRandom charRandom;

  const WorkMoveView({super.key, required this.charRandom});

  @override
  State<StatefulWidget> createState() => WorkMoveViewState();
}

class WorkMoveViewState extends State<WorkMoveView> {
  late List<Widget> _itemRows;
  late List<Widget> _moveRows;

  @override
  void initState() {
    List<String> chars = widget.charRandom.randomChars;
    _itemRows = List<Widget>.generate(
        chars.length, (index) => _Card(title: chars[index]));
    List<CharLatin> latinChars = widget.charRandom.orderChars;
    _moveRows = List<Widget>.generate(
        latinChars.length,
        (index) =>
            _Card(key: UniqueKey(), title: latinChars[index].latin ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _onReorder(int oldIndex, int newIndex) async {
      widget.charRandom.swithOrderItem(oldIndex, newIndex);
      setState(() {
        Widget row = _moveRows.removeAt(oldIndex);
        _moveRows.insert(newIndex, row);
      });
    }

    return Center(
        child: SizedBox(
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _itemRows,
          ),
          ReorderableColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              onReorder: _onReorder,
              children: _moveRows)
        ],
      ),
    ));
  }
}

class _Card extends StatelessWidget {
  final String title;

  const _Card({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      color: MyColor.randomLightish(),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
