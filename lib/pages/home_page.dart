import 'package:flutter/material.dart';
import '../widgets/footer_navbar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),
      bottomNavigationBar: FooterNavbarWidget(),
    );
  }
}
