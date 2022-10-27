import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:youknow/router.dart';

class DrawCell extends StatefulWidget {
  final int index;

  DrawCell({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _DrawCellState();
}

class _DrawCellState extends State<DrawCell> {

  static final borderColor = MyColor.randomLight();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFromSandbox();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.randomLightish(),
      shape: BeveledRectangleBorder(
        side: BorderSide(
          width: 0.5,
          color: borderColor,
          style: BorderStyle.solid,
        )
      ),
      child:  FutureBuilder<Uint8List>(
        future: getImageFromSandbox(),
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Image.memory(snapshot.requireData);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Future<Uint8List> getImageFromSandbox() async {
    List<int>? images = [];
    try {
      images = (await channel
              .invokeListMethod(keyMethodNative, ['byteAtIndex', widget.index]))
          ?.cast<int>();
    } on PlatformException {
      rethrow;
    }
    return Uint8List.fromList(images!);
  }
}
