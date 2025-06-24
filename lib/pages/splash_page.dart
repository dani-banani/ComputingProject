import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../api/authentication_api.dart';
import '../navigation/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> authenticateUser() async {
    final isAuthenticated = await AuthenticationApi.authenticateUser();
    if (!isAuthenticated) {
      Get.offAndToNamed(AppRoutes.registration);
      return;
    }

    Get.offAndToNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async{
      await Future.delayed(Duration(seconds: 5));
      await authenticateUser();
    });

    return Center(
      child: Text("I am a splash page"),
    );
  }
}
