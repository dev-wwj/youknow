// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chooser extends StatefulWidget {
  final List<String> options;

  late int def;

  final ValueChanged<int>? onChanged;

  Chooser({super.key, required this.options, required this.def, this.onChanged});

  @override
  State<StatefulWidget> createState() => _ChooserState();
}

class _ChooserState extends State<Chooser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('选择声音'),
            Wrap(
              children: _items(),
            ),
            // const Divider(height: 1.0, indent: 0, color: Colors.grey),
          ],
        ));
  }

  List<Widget> _items() {
    List<Widget> radios = [];
    for (var element in widget.options) {
      radios.add(SizedBox(
        width: 150,
        child: Row(
          children: [
            Radio(
                value: element,
                groupValue: widget.options[widget.def],
                onChanged: (value) {
                  widget.def = widget.options.indexOf(value!);
                  setState(() {
                  });
                  widget.onChanged!(widget.def);
                }),
            Text(element),
          ],
        ),
      ));
    }
    return radios;
  }
}
