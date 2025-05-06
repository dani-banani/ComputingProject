import 'package:computing_project/pages/smile_page.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';
import '../pages/add_task_page.dart';
import '../pages/settings_page.dart';
import '../pages/task_list_page.dart';
import '../pages/smile_page.dart';
import '../pages/registration/registration_page.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      // transitionDuration: Duration(seconds: 5),
      // transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.addTask,
      page: () => AddTaskPage(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsPage(),
    ),
    GetPage(name: AppRoutes.taskList, page: () => TaskListPage()),
    GetPage(name: AppRoutes.smile, page: () => SmilePage()),
    GetPage(name: AppRoutes.registration, page: () => RegistrationPage())
  ];

  static const String home = '/pages/home_page.dart';
  static const String addTask = '/pages/random_page.dart';
  static const String settings = '/pages/settings_page.dart';
  static const String taskList = '/pages/task_list_page.dart';
  static const String smile = '/pages/smile_page.dart';
  static const String registration = '/pages/registration/registration_page.dart';
}
