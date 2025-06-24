import 'package:computing_project/navigation/app_routes.dart';
import 'package:computing_project/pages/add_task/add_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPage extends GetView<AddTaskController> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("Add Task Page"),)
    );
  }
}
