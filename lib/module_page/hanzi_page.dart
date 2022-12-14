import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:youknow/view/character_view.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HanziPage extends StatefulWidget {
  const HanziPage({super.key});

  @override
  State<StatefulWidget> createState() => _HanziPageState();
}

class _HanziPageState extends State<HanziPage> {
  late PageController _pageController;

  bool _showNext = false;
  set showNext(value) {
    if (_showNext != value) {
      _showNext = value;
      setState(() {});
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: myChars.indexStart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('第${myChars.section + 1}课'),
          actions: _showNext
              ? [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.navigate_next))
                ]
              : [],
        ),
        body: Container(
          decoration: BoxDecoration(color: MyColor.randomLightish()),
          child: SafeArea(
              child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                itemBuilder: (context, index) {
                  return CharacterView(character: myChars.chars[index]);
                },
                controller: _pageController,
                itemCount: myChars.chars.length,
                onPageChanged: (index) {
                  if (myChars.switchSection(index)) {
                    setState(() {});
                  }
                  showNext = myChars.indexAtSectionLast(index);
                },
              )
            ],
          )),
        ));
  }
}
