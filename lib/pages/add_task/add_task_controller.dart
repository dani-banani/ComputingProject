import 'package:computing_project/api/task_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:computing_project/api/authentication_api.dart';

import '../../model/user_data.dart';
import '../../navigation/app_routes.dart';
import '../../widgets/error_snackbar_widget.dart';

class AddTaskController extends GetxController {
  Rx<TextEditingController> taskNameController = TextEditingController().obs;
  Rx<TextEditingController> taskDescriptionController =
      TextEditingController().obs;
  Rx<DateTime> taskDueDate = DateTime.now().obs;
  Rx<int> difficulty = 1.obs;
  Rx<int> priority = 1.obs;
  Rx<int> daysBeforeReminder = 0.obs;
  Rx<int> reminderFrequency = 0.obs;
  Rx<int> categoryId = 1.obs;
  Rx<bool> isDueDateSelected = false.obs;

  void onAddTask() async {
    List<String> errorMessages = [];

    if (taskNameController.value.text.isEmpty) {
      errorMessages.add("Task name is empty");
    }

    // if (taskDescriptionController.value.text.isEmpty) {
    //   errorMessages.add("Task description is empty");
    // }

    //TODO:temporary
    if (categoryId.value == 0) {
      errorMessages.add("Category is empty");
    }

    if (!isDueDateSelected.value) {
      errorMessages.add("Due date is empty");
    }

    if (errorMessages.isNotEmpty) {
      ErrorSnackbarWidget.showSnackbar(
          title: "Failed to Add Task", messages: errorMessages);
      return;
    }

    final response = await TaskApi.createTask(
      name: taskNameController.value.text,
      description: taskDescriptionController.value.text,
      dueDate: taskDueDate.value,
      category: categoryId.value,
      difficulty: difficulty.value,
      priority: priority.value,
      // daysBeforeReminder: daysBeforeReminder.value,
      // reminderFrequency: reminderFrequency.value,
    );

    if (!response.success) {
      ErrorSnackbarWidget.showSnackbar(
          title: "Failed to Add Task", messages: response.message);
      return;
    }

    Get.offAllNamed(AppRoutes.taskList);
  }

  void onDatePickerTap(BuildContext context) {
    showDatePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 100)),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: "Select Due Date",
    ).then((date) {
      if (date == null) return;
      if (date == taskDueDate.value) return;

      taskDueDate.value = date;
      isDueDateSelected.value = true;
    });
  }

  //Category (Fetch from category table)

  //Dropdown days before reminder (Choose a date)
  //Reminder frequency (Daily, Weekly, Biweekly and Custom)
}
