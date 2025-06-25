import 'package:computing_project/navigation/app_routes.dart';
import 'package:computing_project/widgets/error_snackbar_widget.dart';
import 'package:computing_project/widgets/button_widget.dart';
import 'package:computing_project/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:computing_project/api/category_api.dart';

class ColorSelection {
  final Color color;
  final bool isSelected;

  ColorSelection({required this.color, required this.isSelected});
}

class TaskListController extends GetxController {
  final ColorScheme colorScheme = Get.theme.colorScheme;

  Rx<TextEditingController> categoryNameController = TextEditingController().obs;

  final RxList<bool> isExpanded = [false, false].obs;
  final RxList<String> categories = ["Test Category 1", "Test Category 2"].obs;

  Rx<int> selectedColorIndex = (-1).obs;
  String selectedColor = "0xFFFFFFFF";

  List<Color> colorOptions = [
    Color(0xFFA8D8D8), // Darker sky blue (coolest)
    Color(0xFFA8D8B8), // Darker seafoam (cool)
    Color(0xFFB8D8B8), // Darker mint green (cool)
    Color(0xFFB8D8A8), // Darker lime green (neutral-cool)
    Color(0xFFB8A8D8), // Darker lavender (neutral)
    Color(0xFFD8A8B8), // Darker pink lavender (warm)
    Color(0xFFD8A8A8), // Darker peach (warm)
    Color(0xFFFFB366), // Light orange (warmest)
  ];

  void onAddTask() {
    Get.toNamed(AppRoutes.addTask);
  }

  void addCategory() async{
    List<String> errors = [];

    if(categoryNameController.value.text.isEmpty){
      errors.add("Category name is required");
    }

    if(errors.isNotEmpty){
      ErrorSnackbarWidget.showSnackbar(title: "Error", messages: errors);
      return;
    }

    final response = await CategoryApi.createCategory(
      name: categoryNameController.value.text,
      color: selectedColor,
    );

    if(!response.success){
      ErrorSnackbarWidget.showSnackbar(title: "Error", messages: response.message);
      return;
    }

    Get.back();
  }

  void togglePanel(int index) {
    isExpanded[index] = !isExpanded[index];
  }
}