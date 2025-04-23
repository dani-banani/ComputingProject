  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  import 'navigation/app_routes.dart';
  import 'widgets/footer_navbar_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
    );
  }
}
