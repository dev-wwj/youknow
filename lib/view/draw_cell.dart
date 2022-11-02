// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

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
    _getImageFromSandbox();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        _preview();
      },
      color: MyColor.randomLightish(),
      shape: BeveledRectangleBorder(
        side: BorderSide(
          width: 0.5,
          color: borderColor,
          style: BorderStyle.solid,
        )
      ),
      padding: EdgeInsets.zero,
      child:  FutureBuilder<Uint8List>(
        future: _getImageFromSandbox(),
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

  Future<Uint8List> _getImageFromSandbox() async {
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

  void _preview() async {
    Uint8List data =  await _getImageFromSandbox();
    showImageViewer(context, MemoryImage(data), onViewerDismissed: () {
      
    }, backgroundColor:  MyColor.randomLightish(), useSafeArea: true, closeButtonColor: Colors.black);
  }
}
