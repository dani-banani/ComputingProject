import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation/app_routes.dart';

class StudyMethodPage extends StatefulWidget {
  const StudyMethodPage({super.key});

  @override
  State<StudyMethodPage> createState() => _StudyMethodPageState();
}

class _StudyMethodPageState extends State<StudyMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Full Screen Page"),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("Go back previous page")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () => Get.offAndToNamed(AppRoutes.home),
                child: Text("Go back home")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.registration),
                child: Text("Go to registration page")),
          ],
        ));
  }
}
