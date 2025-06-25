import 'package:computing_project/navigation/app_bindings.dart';
import 'package:get/get.dart';

import '../pages/smile_page.dart';
import '../pages/home_page.dart';
import '../pages/add_task/add_task_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/task_list/task_list_page.dart';
import '../pages/registration/registration_page.dart';
import '../pages/splash_page.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.addTask,
      page: () => AddTaskPage(colorScheme: Get.theme.colorScheme),
      binding: AppBindings()
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsPage(),
      binding: AppBindings()
    ),
    GetPage(
      name: AppRoutes.taskList,
      page: () => TaskListPage(colorScheme: Get.theme.colorScheme),
      binding: AppBindings()
    ),
    GetPage(
      name: AppRoutes.smile,
      page: () => SmilePage(),
    ),
    GetPage(
        name: AppRoutes.registration,
        page: () => RegistrationPage(colorScheme: Get.theme.colorScheme),
        binding: AppBindings()),
    GetPage(name: AppRoutes.splash, page: () => SplashPage())
  ];

  static const String home = '/pages/home_page.dart';
  static const String addTask = '/pages/random_page.dart';
  static const String settings = '/pages/settings_page.dart';
  static const String taskList = '/pages/task_list/task_list_page.dart';
  static const String smile = '/pages/smile_page.dart';
  static const String registration =
      '/pages/registration/registration_page.dart';
  static const String splash = '/pages/splash_page.dart';
}
