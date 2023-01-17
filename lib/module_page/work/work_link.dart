import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/module_page/work/work_base.dart';
import 'package:youknow/view/work/work_link_view.dart';

class WorkLink extends WorkBase {
  const WorkLink({super.key});

  @override
  State<StatefulWidget> createState() => WorkLinkState();
}

class WorkLinkState extends WorkBaseState {
  @override
  Widget createBody() {
    return Container(
        decoration: BoxDecoration(color: MyColor.randomLightish()),
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: charRandom.refreshGroup(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const SizedBox();
                      } else {
                        return WorkLinkView(
                            key: UniqueKey(), charRandom: charRandom);
                      }
                    })),
            const Center(
              child: Text('移动右侧拼音，与左侧汉字同行'),
            )
          ],
        )));
  }
}
