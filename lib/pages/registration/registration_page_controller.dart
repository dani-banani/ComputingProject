import 'package:get/get.dart';

import '../../navigation/app_routes.dart';
import '../../api/registration_api.dart';

//This page is like the state manager for the registration page, and this is where I will call the APi class functions. So basicaclly each page will be placed in a folder like this, one page, one controller.

class RegistrationPageController extends GetxController {
  void loginUser() {

    //For exampke, I call tne API function like that
    RegistrationApi.signUpUser(
        email: "hanskimxiqi@gmail.ccom", password: "abcdefg");
    Get.toNamed(AppRoutes.home);
  }
}
