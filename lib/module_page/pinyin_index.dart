import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youknow/global.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/router.dart';
import 'package:youknow/view/pinyin_cell.dart';

class PinyinIndex extends StatefulWidget{
  const PinyinIndex({super.key});
  
  @override
  State<StatefulWidget> createState() => _PinyinIndexState();
}

class _PinyinIndexState extends State<PinyinIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拼音'),
      ),
      body: FutureBuilder<void>(
        future: initializePy(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(itemBuilder: (context, index) {
              return PinyinCell(pyGroup: pyTable[index], onTap: (){
                  PinyinGroup group = pyTable[index];
                  router.push("/pinyin/page",extra: group);
              },);
            }, itemCount: pyTable.length,);
          }else {
            return const Center(child: Text('no data'));
          }
        },
      ),
    );
  }

  Future<void> initializePy() async {
    pyTable = await PinyinGroup.locTable();
  }

}