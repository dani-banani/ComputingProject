import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation/app_routes.dart';
import 'widgets/footer_navbar_widget.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://sfdvrbbsjbmbkjbnmbes.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmZHZyYmJzamJtYmtqYm5tYmVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4OTM2NzEsImV4cCI6MjA2MTQ2OTY3MX0.KGD6Dt2kWrtwTvjhgY65rcRMYuG7GrCEWeq0z1iZvNs',
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final supabase = Supabase.instance.client;
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
      navigatorKey: Get.key,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              Positioned(bottom: 0, left: 0, right: 0,child: FooterNavbarWidget())
            ],
          ),
        );
      },
    );
  }
}
