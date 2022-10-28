import 'package:go_router/go_router.dart';
import 'package:youknow/global.dart';
import 'package:youknow/home.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/module_page/draw_index.dart';
import 'package:youknow/module_page/hanzi_index.dart';
import 'package:youknow/module_page/hanzi_page.dart';
import 'package:youknow/module_page/pinyin_index.dart';
import 'package:youknow/module_page/pinyin_page.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(
      path: '/hanzi',
      builder: (context, state) {
        return const HanziIndex();
      }),
  GoRoute(
      path: '/lesson',
      builder: (context, state) {
        if (myChars != null) {
          return const HanziPage();
        } else {
          return const HomePage();
        }
      }),
  GoRoute(
      path: '/draw',
      builder: (context, state) {
        return const DrawIndex();
      }),
  GoRoute(
      path: '/pinyin',
      builder: (context, state) {
        return const PinyinIndex();
      }),
  GoRoute(
      path: '/pinyin/page',
      builder: (context, state) {
        PinyinGroup grope = state.extra as PinyinGroup;
        return PinyinPage(pinyinGroup: grope,);
      })
]);
