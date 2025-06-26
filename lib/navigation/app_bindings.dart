import 'package:get/get.dart';

import 'package:computing_project/pages/registration/registration_controller.dart';
import 'package:computing_project/pages/settings/settings_controller.dart';
import 'package:computing_project/pages/add_task/add_task_controller.dart';
import 'package:computing_project/pages/task_list/task_list_controller.dart';
import 'package:computing_project/pages/home_page/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => AddTaskController());
    Get.lazyPut(() => TaskListController());
    // Make HomeController permanent so it persists across pages
    Get.put(HomeController(), permanent: true);
  }
}
