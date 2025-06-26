import 'package:computing_project/model/task_list.dart';
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
                      expandIconColor: colorScheme.onSecondary,
                      expansionCallback: (panelIndex, isExpanded) {
                        if (controller.taskAccordions[panelIndex].listItem.tasks
                            .isNotEmpty) {
                          controller.togglePanel(panelIndex);
                        }
                      },
                      children: controller.taskAccordions
                          .map(
                            (taskList) => ExpansionPanel(
                              canTapOnHeader: true,
                              backgroundColor: colorScheme.secondary,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(
                                    taskList.listItem.categoryName,
                                    style: TextStyle(
                                        color: colorScheme.onSecondary),
                                  ),
                                  leading: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: taskList
                                              .listItem.categoryColor.isEmpty
                                          ? colorScheme.onSecondary
                                          : Color(int.parse(
                                              taskList.listItem.categoryColor)),
                                    ),
                                  ),
                                );
                              },
                              body: Column(
                                children: [
                                  ...taskList.listItem.tasks
                                      .map((task) => ListTile(
                                            onTap: () {
                                              showTaskDetailModal(
                                                  context,
                                                  constraints,
                                                  colorScheme,
                                                  taskList.listItem,
                                                  task);
                                            },
                                            title: Text(
                                              task.taskName,
                                              style: TextStyle(
                                                  color: colorScheme
                                                      .onPrimaryContainer),
                                            ),
                                            tileColor:
                                                colorScheme.primaryContainer,
                                          )),
                                ],
                              ),
                              isExpanded: taskList.isExpanded,
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
              controller.selectedColor = color
                  .toARGB32()
                  .toRadixString(16)
                  .padLeft(9, '0x')
                  .toUpperCase();
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

    void showTaskDetailModal(BuildContext context, BoxConstraints constraints,
      ColorScheme colorScheme, ListItem listItem, TaskItem task) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => SizedBox(
        height: constraints.maxHeight * 0.9,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: Text(
                "${listItem.categoryName} - ${task.taskName}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimary),
              ),
            ),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFieldWidget(
                      colorScheme: colorScheme,
                      hintText: "Task Description",
                      textController:
                          TextEditingController(text: task.taskDescription),
                      isTextHidden: false,
                      minLines: 3,
                      maxLines: 7,
                    ),
                  ],
                ),
              ),
            ),
            // Text(task.taskDescription),
          ],
        ),
      ),
    );
  }
}
