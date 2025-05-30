import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../api/authentication_api.dart';
import '../../navigation/app_routes.dart';
import '../../widgets/error_snackbar_widget.dart';

class SettingsController extends GetxController {
  void onLogout() {
    AuthenticationApi.signOutUser().then((response) {
      if (!response.success) {
        ErrorSnackbarWidget.showSnackbar(
            title: "Logout Failed",
            messages: response.message,);
        return;
      }

    debugPrint("Logout successful");
    Get.offAllNamed(AppRoutes.registration);

    });
  }
}
