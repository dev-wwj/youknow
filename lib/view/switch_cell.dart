import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwitchCell extends StatefulWidget {
  final String title;
  bool onOff;
  final ValueChanged<bool> onChanged;

  SwitchCell(
      {super.key,
      required this.title,
      required this.onOff,
      required this.onChanged});

  @override
  State<StatefulWidget> createState() => _SwitchCellState();
}

class _SwitchCellState extends State<SwitchCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.title),
                const Spacer(),
                Switch(
                    value: widget.onOff,
                    onChanged: (value) {
                      widget.onChanged(value);
                      widget.onOff = value;
                      setState(() {});
                    })
              ],
            ),
            const Divider(height: 0.5, indent: 0, color: Colors.grey),
          ],
        ));
  }
}
