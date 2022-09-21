import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MineItemView extends StatelessWidget {


  MineItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(
          children: [
            const Text('第一课'),

          ],
        ),
      ),
    );
  }
}