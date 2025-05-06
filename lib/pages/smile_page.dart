import 'package:flutter/material.dart';

class SmilePage extends StatefulWidget {
  const SmilePage({super.key});

  @override
  State<SmilePage> createState() => _SmilePageState();
}

class _SmilePageState extends State<SmilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.face),
          Text("I dont know what this page should be so it is a page that makes you happy"),
        ],
      ),
    );
  }
}