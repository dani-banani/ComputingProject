import 'package:computing_project/navigation/app_routes.dart';
import 'package:computing_project/pages/add_task/add_task_controller.dart';
import 'package:computing_project/pages/home_page/home_controller.dart';
import 'package:computing_project/widgets/error_snackbar_widget.dart';
import 'package:computing_project/widgets/button_widget.dart';
import 'package:computing_project/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:computing_project/model/task_list.dart';
import 'package:computing_project/model/api_response.dart';
import 'package:computing_project/api/category_api.dart';
import 'package:computing_project/api/task_api.dart';

class ColorSelection {
  final Color color;
  bool isSelected;

  ColorSelection({required this.color, required this.isSelected});
}

class AccordionItem {
  final ListItem listItem;
  bool isExpanded;

  AccordionItem({required this.listItem, required this.isExpanded});
}

class TaskListController extends GetxController {
  HomeController homeController = Get.find();

  final ColorScheme colorScheme = Get.theme.colorScheme;

  Rx<TextEditingController> categoryNameController =
      TextEditingController().obs;

  Rx<int> selectedColorIndex = (-1).obs;
  String selectedColor = "";

  RxList<AccordionItem> taskAccordions = <AccordionItem>[].obs;

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

  @override
  void onInit() async {
    onRefresh();
    super.onInit();
  }

  void onRefresh() async {
    final response = await TaskApi.getUserCategoriesWithTasks();  
    if (!response.success) {
      ErrorSnackbarWidget.showSnackbar(title: "Error", messages: response.message);
      return;
    }

    taskAccordions.value = response.data.listItems
        .map((item) => AccordionItem(listItem: item, isExpanded: false))
        .toList();
  }

  void onAddTask() async {
    Get.toNamed(AppRoutes.addTask);
    return;
  }

  void addCategory() async {
    List<String> errors = [];

    if (categoryNameController.value.text.isEmpty) {
      errors.add("Category name is required");
    }

    if (errors.isNotEmpty) {
      ErrorSnackbarWidget.showSnackbar(title: "Error", messages: errors);
      return;
    }

    final response = await CategoryApi.createCategory(
      name: categoryNameController.value.text,
      color: selectedColor,
    );

    if (!response.success) {
      if (!response.session) {
        Get.offAllNamed(AppRoutes.registration);
        ErrorSnackbarWidget.showSnackbar(
            title: "Error", messages: response.message);
        return;
      }
      ErrorSnackbarWidget.showSnackbar(
          title: "Error", messages: response.message);
      return;
    }

    onRefresh();
    Get.back();
  }

  void togglePanel(int index) {
    taskAccordions[index].isExpanded = !taskAccordions[index].isExpanded;
    taskAccordions.refresh();
  }
}
