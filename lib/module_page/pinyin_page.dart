import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/view/pinyin_view.dart';

class PinyinPage extends StatefulWidget {
  final PinyinGroup pinyinGroup;

  const PinyinPage({super.key, required this.pinyinGroup});
  @override
  State<StatefulWidget> createState() => _PinyinPageState();
}

class _PinyinPageState extends State<PinyinPage> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pinyinGroup.name),
      ),
      body: Container(
        color: MyColor.randomLightish(),
        child: SafeArea(
          child: PageView.builder(
            itemBuilder: (context, index) {
              return PinyinView(pinyin: widget.pinyinGroup.items[index]);
            },
            controller: _pageController,
            itemCount: widget.pinyinGroup.items.length,
          ),
        ),
      ),
    );
  }
}
