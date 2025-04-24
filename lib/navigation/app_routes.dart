import 'package:get/get.dart';

import '../pages/home_page.dart';
import '../pages/random_page.dart';
import '../pages/settings_page.dart';


class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.random,
      page: () => RandomPage(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsPage(),
    ),
  ];

  static const String home = '/pages/home_page.dart';
  static const String random = '/pages/random_page.dart';
  static const String settings = '/pages/settings_page.dart';
}
