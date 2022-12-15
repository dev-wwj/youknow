import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:youknow/model/character_latin.dart';
import 'package:youknow/view/work_view.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class WorkIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WorkIndexState();
}

class WorkIndexState extends State<WorkIndex> {
  late CharRandom _charRandom;
  @override
  void initState() {
    _charRandom = CharRandom(myChars.charsAt(myChars.section), myChars.section == 0 ? 2 : 5, _orderBack);
    super.initState();
  }

  void next() {
    if (myChars.section == myChars.numOfSection() - 1) {
      return;
    }
    myChars.section++;
    _charRandom = CharRandom(myChars.charsAt(myChars.section), 5, _orderBack);
    setState(() {});
  }

  String keyAgain = 'again';
  String keyNext = 'next';

  void _orderBack(bool success) async {
    if (success) {
      var result = await showAlertDialog(
          context: context,
          title: '厉害了',
          message: '全都做对了',
          actions: [
            AlertDialogAction(key: keyAgain, label: '再来一次', textStyle: const TextStyle(color: Colors.blue)),
            AlertDialogAction(key: keyNext, label: '下一课', textStyle: const TextStyle(color: Colors.red))
          ]);
      print(result);
      if (result == keyAgain) {
        setState(() {
        });
      }else if(result == keyNext) {
        next();
      }

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
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(color: MyColor.randomLightish()),
            child: SafeArea(
                child: Column(
                  children: [
                    Expanded(child:  FutureBuilder(
                        future: _charRandom.refreshGroup(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return WorkView(
                              key: UniqueKey(),
                              charRandom: _charRandom,
                            );
                          } else {
                            return const SizedBox();
                          }
                        })),
                    const Center(child: Text('移动右侧拼音，与左侧汉字同行'),)
                  ],
                ))));
  }
}
