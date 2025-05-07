import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation/app_routes.dart';
import './registration_page_controller.dart';

class RegistrationPage extends GetView<RegistrationPageController> {
  const RegistrationPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics()
            .applyTo(BouncingScrollPhysics()),
        child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            TextField(),
            TextField(),
            ElevatedButton(
                onPressed: controller.loginUser,
                child: Text("Go to home page"))
          ],
        ),
      ),
    );
  }
}
