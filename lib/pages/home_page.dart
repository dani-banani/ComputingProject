import 'package:flutter/material.dart';
import '../widgets/footer_navbar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics().applyTo(BouncingScrollPhysics()),
          child: Column(
            children: [
              Text("Home Page"),
              Text("Home Page"),
              Text("Home Page"),
              Text("Home Page"),
              Text("Home Page"),
              Text("Home Page"),
              Text("Home Page"),
              Container(
                color: Colors.red,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
              ),
              Container(
                color: Colors.yellow,
                height: 100,
              ),
              Container(
                color: Colors.purple,
                height: 100,
              ),
                        Container(
                color: Colors.purple,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
