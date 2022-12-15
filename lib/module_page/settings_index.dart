import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:youknow/router.dart';
import 'package:youknow/view/checked_view.dart';
import 'package:youknow/view/indicator.dart';
import 'package:youknow/view/switch_cell.dart';
import 'package:youknow/userdefaults.dart';
import 'package:share_plus/share_plus.dart';

class SettingsIndex extends StatefulWidget {
  const SettingsIndex({super.key});

  @override
  State<StatefulWidget> createState() => SettingsIndexState();
}

class SettingsIndexState extends State<SettingsIndex> {
  late bool onChange = false;
  late int voiceType = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDefault();
  }

  void getUserDefault() async {
    onChange = await  isAutoplay();
    voiceType = await getVoiceType();
    setState(() {
    });
  }

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
                        SwitchCell(title: '自动朗读', onOff: onChange, onChanged: (value) {
                            setAutoplay(value);
                            onChange = value;
                        },),
                        Chooser(options: const ['女声','男声'], def: voiceType, onChanged: (value) {
                          setVoiceType(value);
                          voiceType = value;
                        },),
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
                        Indicator(title: "分享", onPressed: (){
                            Share.share('check out my website https://example.com', subject: '幼儿学习助手');
                        },),
                        Indicator(title: '给个好评', showSeparator: false, onPressed: (){
                          channel.invokeMethod(keyMethodNative, ['write_review']);
                        },),
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
                        Indicator(title: '关于我们', showSeparator: false, onPressed: (){
                          router.push('/settings/about_us');
                        },),
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
