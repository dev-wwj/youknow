// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final String title;

  final VoidCallback? onPressed;

  bool? showSeparator = true;

  Indicator({super.key, required this.title, this.showSeparator, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          onPressed: onPressed,
          child: Row(
            children: [
              Text(title),
              const Spacer(),
              const Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Divider(height: 1.0, indent: 0, color: showSeparator == false ? Colors.transparent : Colors.grey),
      ],
    );
    //
    // return Button(
    //   onTap: () {
    //     print('onTap');
    //   },
    //   child:
    // );
  }
}
