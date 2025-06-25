import 'package:computing_project/pages/task_list/task_list_controller.dart';
import 'package:computing_project/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:computing_project/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class TaskListPage extends GetView<TaskListController> {
  final ColorScheme colorScheme;
  const TaskListPage({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(() {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          colorScheme: colorScheme,
                          onPressed: controller.onAddTask,
                          width: constraints.maxWidth * 0.35,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Add Task"), Icon(Icons.add)],
                          ),
                        ),
                        ButtonWidget(
                          colorScheme: colorScheme,
                          onPressed: () => showAddCategoryDialog(constraints),
                          width: constraints.maxWidth * 0.45,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Add Category"), Icon(Icons.add)],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: constraints.maxWidth,
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      child: Text(
                        "Task List",
                        style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.zero,
                      materialGapSize: 0,
                      dividerColor: Colors.transparent,
                      expansionCallback: (panelIndex, isExpanded) {
                        controller.togglePanel(panelIndex);
                      },
                      children: controller.categories
                          .map(
                            (category) => ExpansionPanel(
                              canTapOnHeader: true,
                              backgroundColor: colorScheme.secondary,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(
                                    category,
                                    style: TextStyle(
                                        color: colorScheme.onSecondary),
                                  ),
                                );
                              },
                              body: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Test Task 1",
                                      style: TextStyle(
                                          color:
                                              colorScheme.onPrimaryContainer),
                                    ),
                                    tileColor: colorScheme.primaryContainer,
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Test Task 2",
                                      style: TextStyle(
                                          color:
                                              colorScheme.onPrimaryContainer),
                                    ),
                                    tileColor: colorScheme.primaryContainer,
                                  ),
                                ],
                              ),
                              isExpanded: controller.isExpanded[
                                  controller.categories.indexOf(category)],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void showAddCategoryDialog(BoxConstraints constraints) {
    showDialog(
      context: Get.context!,
      builder: (context) => Obx(
        () => AlertDialog(
          contentPadding: EdgeInsets.all(20),
          actionsPadding:
              EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 0),
          clipBehavior: Clip.hardEdge,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: colorScheme.onSurface,
                      )),
                ],
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: "Category Name",
                textController: controller.categoryNameController.value,
                isTextHidden: false,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 20),
              buildColorPicker(),
            ],
          ),
          actions: [
            ButtonWidget(
              colorScheme: colorScheme,
              onPressed: () {
                controller.addCategory();
              },
              child: Text("Add Category"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorPicker() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 100,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.0,
        children: controller.colorOptions.map((color) {
          return GestureDetector(
            onTap: () {
              controller.selectedColorIndex.value =
                  controller.colorOptions.indexOf(color);
              controller.selectedColor = color.toARGB32().toRadixString(16).padLeft(9, '0x').toUpperCase();
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                if (controller.selectedColorIndex.value ==
                    controller.colorOptions.indexOf(color))
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: colorScheme.primary,
                      size: 20,
                      weight: 2,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
