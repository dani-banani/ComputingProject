import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final supabase = Supabase.instance.client;

  final List<String> noFooterRoutes = [AppRoutes.registration];

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute;

    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffBCB6A5),
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: const TextStyle(fontSize: 36),
          bodyMedium: const TextStyle(fontSize: 14),
          bodySmall: const TextStyle(fontSize: 12),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.registration,
      getPages: AppRoutes.pages,
      navigatorKey: Get.key,
      navigatorObservers: [
        GetObserver((routing) => {
          SchedulerBinding.instance.addPostFrameCallback((_){
              setState(() {
                currentRoute = Get.currentRoute;
              });
            })
  })
      ],
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              (noFooterRoutes.contains(currentRoute))
                  ? const SizedBox.shrink()
                  :
                   Positioned(
                      bottom: 0, left: 0, right: 0, child: FooterNavbarWidget(currentPage: currentRoute,))
            ],
          ),
        );
      },
    );
  }
}
