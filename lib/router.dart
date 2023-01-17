import 'package:go_router/go_router.dart';
import 'package:youknow/global.dart';
import 'package:youknow/home.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/module_page/about_us.dart';
import 'package:youknow/module_page/draw_index.dart';
import 'package:youknow/module_page/hanzi_index.dart';
import 'package:youknow/module_page/hanzi_page.dart';
import 'package:youknow/module_page/pinyin_index.dart';
import 'package:youknow/module_page/pinyin_page.dart';
import 'package:youknow/module_page/settings_index.dart';
import 'package:youknow/module_page/work/work_base.dart';
import 'package:youknow/module_page/work/work_link.dart';
import 'package:youknow/module_page/work/work_move.dart';

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
      path: '/work',
      builder: (context, state) {
        return WorkMove();
      }),
  GoRoute(
      path: '/work/link',
      builder: (context, state) {
        return WorkLink();
      }),
  GoRoute(
      path: '/pinyin/page',
      builder: (context, state) {
        PinyinGroup grope = state.extra as PinyinGroup;
        return PinyinPage(pinyinGroup: grope,);
      }),
  GoRoute(path: '/settings', builder: (context, state) {
    return const SettingsIndex();
  }),
  GoRoute(path: '/settings/about_us', builder: (context, state) {
    return const AboutUs();
  })
  //
]);
