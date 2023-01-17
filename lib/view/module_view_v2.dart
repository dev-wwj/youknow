import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/extension/style_ex.dart';
import 'package:go_router/go_router.dart';
import 'package:youknow/global.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/router.dart';

class ModuleViewV2 extends StatefulWidget {
  const ModuleViewV2({super.key});

  @override
  State<StatefulWidget> createState() => ModuleViewV2State();
}

class ModuleViewV2State extends State<ModuleViewV2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: TextButton(
                style: MyButtonStyle.randomBgFontLarger(),
                onPressed: () {
                  GoRouter.of(context).push('/pinyin');
                },
                child: const Text('拼音'),
              )),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: TextButton(
                style: MyButtonStyle.randomBgFontLarger(),
                onPressed: () {
                  GoRouter.of(context).push('/hanzi');
                },
                child: const Text('识字'),
              )),
          StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: TextButton(
                style: MyButtonStyle.randomBgFontMaximum(),
                onPressed: () {
                  MyChars.locChars().then((value) {
                    channel.invokeMethod(keyRouteNative, [
                      'HandwritingVC',
                      jsonEncode(value),
                    ]);
                  });
                },
                child: const Text('书写'),
              )),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: TextButton(
                style: MyButtonStyle.randomBgFontLarger(),
                onPressed: () {
                  MyChars.locChars().then((value) {
                    myChars = value;
                    router.push('/work');
                  });
                },
                child: const Text('拖一下'),
              )),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: TextButton(
                style: MyButtonStyle.randomBgFontLarger(),
                onPressed: () {
                  MyChars.locChars().then((value) {
                    myChars = value;
                    router.push('/work/link');
                  });
                },
                child: const Text('连连看'),
              )),
        ],
      ),
    );
  }
}
