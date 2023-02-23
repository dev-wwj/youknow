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
                        return WorkLinkView(
                            key: UniqueKey(), charRandom: charRandom);
                      } else {
                        return const SizedBox();
                      }
                    })),
            const Center(
              child: Text('将对应的汉字和拼音连起来'),
            )
          ],
        )));
  }
}
