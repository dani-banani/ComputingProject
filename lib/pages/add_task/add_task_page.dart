import 'package:computing_project/pages/add_task/add_task_controller.dart';
import 'package:computing_project/widgets/date_picker_widget.dart';
import 'package:computing_project/widgets/category_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:computing_project/widgets/text_field_widget.dart';
import 'package:computing_project/widgets/slider_widget.dart';
import 'package:computing_project/widgets/button_widget.dart';
import 'package:computing_project/model/category.dart';

class AddTaskPage extends GetView<AddTaskController> {
  final ColorScheme colorScheme;
  const AddTaskPage({super.key, required this.colorScheme});

  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = Get.arguments;
    final Category? defaultCategory = arguments?["category"];
    if (defaultCategory != null) {
      controller.onCategoryChange(defaultCategory);
    }

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Obx(() {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics()
                .applyTo(const BouncingScrollPhysics()),
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add A Task",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                      colorScheme: colorScheme,
                      hintText: "Task Name",
                      textController: controller.taskNameController.value,
                      isTextHidden: false),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                      colorScheme: colorScheme,
                      hintText: "Task Description",
                      textController:
                          controller.taskDescriptionController.value,
                      isTextHidden: false,
                      minLines: 3,
                      maxLines: 5),
                  const SizedBox(height: 20),
                  CategorySelectionWidget(
                      label: "Select Task Category",
                      onChanged: (value) {
                        controller.onCategoryChange(value);
                      },
                      defaultCategoryId: defaultCategory?.categoryId),
                  const SizedBox(height: 20),
                  Text("Difficulty"),
                  SliderWidget(
                      colorScheme: colorScheme,
                      value: controller.difficulty.value,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      onChanged: (value) {
                        controller.difficulty.value = value;
                      }),
                  const SizedBox(height: 20),
                  Text("Priority"),
                  SliderWidget(
                      colorScheme: colorScheme,
                      value: controller.priority.value,
                      min: 1,
                      max: 3,
                      divisions: 2,
                      onChanged: (value) {
                        controller.priority.value = value;
                      }),
                  const SizedBox(height: 20),
                  DatePickerWidget(
                      colorScheme: colorScheme,
                      onDateSelected: (context) {
                        controller.onDatePickerTap(context);
                      },
                      isSelected: controller.isDueDateSelected.value,
                      selectedDate: controller.taskDueDate.value,
                      helpText: "Select Due Date"),
                  const SizedBox(height: 40),
                  ButtonWidget(
                      colorScheme: colorScheme,
                      child: const Text("Submit"),
                      onPressed: controller.onAddTask,
                      width: Get.width * 0.4,
                      height: 50)
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
