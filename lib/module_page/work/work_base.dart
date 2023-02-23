import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/global.dart';
import 'package:youknow/model/character_latin.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

abstract class WorkBase extends StatefulWidget {
  const WorkBase({super.key});
}

abstract class WorkBaseState extends State<WorkBase> {
  late CharRandom charRandom;
  @override
  void initState() {
    charRandom = CharRandom(myChars.charsAt(myChars.section),
        myChars.section == 0 ? 2 : 5, _orderBack);
    super.initState();
  }

  void next() {
    if (myChars.section == myChars.numOfSection() - 1) {
      return;
    }
    myChars.section++;
    charRandom = CharRandom(myChars.charsAt(myChars.section), 5, _orderBack);
    setState(() {});
  }

  String keyAgain = 'again';
  String keyNext = 'next';

  void _orderBack(bool success) async {
    if (success) {
      await madeSuccess();
    }
  }

  Future<void> madeSuccess() async {
    var result = await showAlertDialog(
        context: context,
        title: '厉害了',
        message: '全都做对了',
        actions: [
          AlertDialogAction(
              key: keyAgain,
              label: '再来一次',
              textStyle: const TextStyle(color: Colors.blue)),
          AlertDialogAction(
              key: keyNext,
              label: '下一课',
              textStyle: const TextStyle(color: Colors.red))
        ]);
    if (result == keyAgain) {
      setState(() {});
    } else if (result == keyNext) {
      next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第${myChars.section + 1}课'),
          actions: [
            MaterialButton(
              onPressed: () {
                next();
              },
              child: const Text(
                '下一课',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
        body: createBody());
  }

  @protected
  @factory
  Widget createBody();

}
