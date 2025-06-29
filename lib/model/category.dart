import 'package:flutter/material.dart';
import 'package:computing_project/model/task.dart';

class Category {
  int categoryId;
  String categoryName;
  String categoryColor;
  List<Task> tasks;

  Category(
      {required this.categoryId,
      required this.categoryName,
      required this.categoryColor,
      required this.tasks});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['cw_category_id'],
      categoryName: json['cw_category_name'],
      categoryColor: json['cw_category_color'],
      tasks: json['tasks'] != null
          ? (json['tasks'] as List<dynamic>)
              .map((taskJson) => Task.fromJson(taskJson))
              .toList()
          : [],
    );
  }

  Color getCategoryColor({Color? defaultColor}) {
    if (categoryColor.isEmpty) {
      if (defaultColor != null) {
        return defaultColor;
      }
      return Colors.transparent;
    }

    return Color(int.parse(categoryColor));
  }

  bool isCategoryColored() {
    return categoryColor.isNotEmpty;
  }

  bool isCategoryEmpty() {
    return tasks.isEmpty;
  }
}
