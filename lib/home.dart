import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youknow/view/module_view.dart';
import 'package:youknow/view/module_view_v2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('朵朵学字'),
        actions: [
          IconButton(onPressed: (){
            GoRouter.of(context).push('/settings/about_us');
          }, icon: const Icon(Icons.settings)),
        ],
      ),
      body: const ModuleViewV2(),
    );
  }
}
