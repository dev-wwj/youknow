import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/global.dart';
import 'package:youknow/router.dart';
import 'package:youknow/view/draw_cell.dart';

class DrawIndex extends StatefulWidget {
  const DrawIndex({super.key});

  @override
  State<StatefulWidget> createState() => DrawIndexState();
}

class DrawIndexState extends State<DrawIndex> {
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryItemCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('我的字'),
          elevation: 0,
        ),
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              return DrawCell(
                index: index,
              );
            },
            itemCount: count,
          ),
        ));
  }

  void queryItemCount() async {
    Future<dynamic> value =
        channel.invokeMethod(keyMethodNative, ['drawCount']);
    value.then((value) {
      count = value;
      setState(() {});
    });
  }
}
