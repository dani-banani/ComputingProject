import 'package:computing_project/pages/registration/registration_page_controller.dart';
import 'package:get/get.dart';

import '../pages/smile_page.dart';
import '../pages/home_page.dart';
import '../pages/add_task_page.dart';
import '../pages/settings_page.dart';
import '../pages/task_list_page.dart';
import '../pages/registration/registration_page.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.home,
        page: () => HomePage(),
        // transitionDuration: Duration(seconds: 5),
        transition: Transition.circularReveal,
        transitionDuration: Duration(seconds: 2)),
    GetPage(
        name: AppRoutes.addTask,
        page: () => AddTaskPage(),
        transition: Transition.upToDown,
        transitionDuration: Duration(seconds: 2)),
    GetPage(
        name: AppRoutes.settings,
        page: () => SettingsPage(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(seconds: 2)),
    GetPage(
        name: AppRoutes.taskList,
        page: () => TaskListPage(),
        transition: Transition.native,
        transitionDuration: Duration(seconds: 2)),
    GetPage(name: AppRoutes.smile, page: () => SmilePage()),
    GetPage(
        name: AppRoutes.registration,
        page: () => RegistrationPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RegistrationPageController());
        }))
  ];

  static const String home = '/pages/home_page.dart';
  static const String addTask = '/pages/random_page.dart';
  static const String settings = '/pages/settings_page.dart';
  static const String taskList = '/pages/task_list_page.dart';
  static const String smile = '/pages/smile_page.dart';
  static const String registration =
      '/pages/registration/registration_page.dart';
}
