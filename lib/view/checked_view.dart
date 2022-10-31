import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseModel {
  final String title;
  bool isChecked;
  ChooseModel({required this.title, required this.isChecked});
}

class Chooser extends StatefulWidget {
  final List<ChooseModel> dataSources;

  const Chooser({super.key, required this.dataSources});

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
    widget.dataSources.forEach((element) {
      radios.add(SizedBox(
        width: 150,
        child: Row(
          children: [
            Radio(
                value: element.isChecked, groupValue: 1, onChanged: (value) {}),
            Text(element.title),
          ],
        ),
      ));
    });
    return radios;
  }
}
