import 'package:get/get.dart';

import 'package:computing_project/pages/registration/registration_controller.dart';
import 'package:computing_project/pages/settings/settings_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
    Get.lazyPut(() => SettingsController());
  }
}

