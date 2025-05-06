import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation/app_routes.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics()
            .applyTo(BouncingScrollPhysics()),
        child: Column(
          children: [
            const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
            TextField(),
            TextField(),
            ElevatedButton(onPressed: () => {Get.toNamed(AppRoutes.home)}, child: Text("Go to home page"))
           
          ],
        ),
      ),
    );
  }
}