import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/view/checked_view.dart';
import 'package:youknow/view/indicator.dart';
import 'package:youknow/view/switch_cell.dart';

class SettingsIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsIndexState();
}

class SettingsIndexState extends State<SettingsIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
        ),
        body: Container(
          decoration: BoxDecoration(color: MyColor.randomLightish()),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.randomLightish(),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        SwitchCell(title: '自动朗读', onOff: false),
                        Chooser(dataSources: [
                          ChooseModel(title: '女声', isChecked: true),
                          ChooseModel(title: '男声', isChecked: false)
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.randomLightish(),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children:  [
                        Indicator(title: "分享"),
                        Indicator(title: '给个好评', showSeparator: false,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.randomLightish(),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children:  [
                        Indicator(title: '关于我们', showSeparator: false,),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}
