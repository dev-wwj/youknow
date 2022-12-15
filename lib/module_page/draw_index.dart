import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/global.dart';
import 'package:youknow/router.dart';
import 'package:youknow/view/draw_cell.dart';
import 'package:empty_widget/empty_widget.dart';

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
          title: const Text('记录'),
          elevation: 0,
          leading: IconButton(
              onPressed: (){
                if (router.canPop()) {
                  Navigator.pop(context);
                }else {
                  channel.invokeMethod(keyRouteNative, ['pop']);
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54,)
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<int>(builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.data! > 0) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  return DrawCell(
                    index: index,
                  );
                },
                itemCount: snapshot.data!,
              );
            }else {
              return EmptyWidget(
                image: 'resources/images/icon_180.png',
                subTitle: '您还没有写字',
                hideBackgroundAnimation: true,
              );
            }
          }, future: queryItemCount(),),
        ));
  }

  Future<int> queryItemCount() async {
    int count =
        await channel.invokeMethod(keyMethodNative, ['drawCount']);
    return count;
  }
}
