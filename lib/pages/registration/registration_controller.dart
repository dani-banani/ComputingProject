import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation/app_routes.dart';
import '../../api/authentication_api.dart';

//This page is like the state manager for the registration page, and this is where I will call the APi class functions. So basicaclly each page will be placed in a folder like this, one page, one controller.

enum UserState {
  login,
  signUp,
}

class RegistrationController extends GetxController {
  Rx<UserState> userState = UserState.login.obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  RxString email = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit() {
    // TODO: Check user auth session
    super.onInit();
  }

  void onLogin() {
    List<String> errorMessages = [];
    if (emailController.value.text.isEmpty) {
      errorMessages.add("Email field is empty");
    }

    if (passwordController.value.text.isEmpty) {
      errorMessages.add("Password field is empty");
    }

    if (errorMessages.isNotEmpty) {
      Get.snackbar(
        "",
        "",
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        titleText: const Center(child: Text("Login Failed", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
        messageText: Center(child: Text(errorMessages.join('\n'),textAlign: TextAlign.center,style: const TextStyle(color: Colors.white))),
      );
      return;
    }

    RegistrationApi.signUpUser(
        email: emailController.value.text, password: passwordController.value.text).then((value) {
      if(value.success){
        Get.toNamed(AppRoutes.home);
      }else{
        Get.snackbar(
          "Error",
          value.message.map((e) => e.toString()).join('\n'),
        );
      }
    });

  }

}
