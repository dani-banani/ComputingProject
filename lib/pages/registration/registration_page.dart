import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../navigation/app_routes.dart';
import './registration_controller.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: const AlwaysScrollableScrollPhysics()
            .applyTo(BouncingScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: colorScheme.onPrimary,
                    
                    style: TextStyle(color: colorScheme.onPrimary,fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: colorScheme.onPrimary),
                      border: InputBorder.none,
                    ),
                    controller: controller.emailController.value,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: colorScheme.onPrimary,
                    style: TextStyle(color: colorScheme.onPrimary,fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: colorScheme.onPrimary),
                      border: InputBorder.none,
                    ),
                    controller: controller.passwordController.value,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    foregroundColor: colorScheme.onSecondary,
                    minimumSize: Size(Get.width * 0.2,50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                    onPressed: controller.onLogin, child: const Text("Login"))
              ],
                    ),
          ),
      ),
    );
  }
}
