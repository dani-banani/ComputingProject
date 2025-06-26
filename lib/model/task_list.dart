class TaskList {
  List<ListItem> listItems;

  TaskList(
      {required this.listItems});

  factory TaskList.fromJson(Map<String, dynamic> json) {
    return TaskList(
      listItems: (json['taskList'] as List<dynamic>)
          .map((taskJson) => ListItem.fromJson(taskJson))
          .toList(),
    );
  }
}

class ListItem{
  int categoryId;
  String categoryName;
  String categoryColor;
  List<TaskItem> tasks;

  ListItem(
      {required this.categoryId,
      required this.categoryName,
      required this.categoryColor,
      required this.tasks});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      categoryId: json['cw_category_id'],
      categoryName: json['cw_category_name'],
      categoryColor: json['cw_category_color'],
      tasks: (json['tasks'] as List<dynamic>)
          .map((taskJson) => TaskItem.fromJson(taskJson))
          .toList(),
    );
  }
}

class TaskItem {
  int taskId;
  String taskName;
  String taskDescription;
  int difficulty;
  int priority;
  int reminderFrequency;
  int daysBeforeReminderStart;
  DateTime dueDate;
  DateTime createdDate;

  TaskItem({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.difficulty,
    required this.priority,
    required this.reminderFrequency,
    required this.daysBeforeReminderStart,
    required this.dueDate,
    required this.createdDate,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      taskId: json['cw_task_id'],
      taskName: json['cw_task_name'],
      taskDescription: json['cw_task_description'],
      difficulty: json['cw_task_difficulty'],
      priority: json['cw_task_priority'],
      reminderFrequency: json['cw_task_reminder_frequency'],
      daysBeforeReminderStart: json['cw_task_days_before_reminders'],
      dueDate: DateTime.parse(json['cw_task_due_date']),
      createdDate: DateTime.parse(json['cw_task_created_date']),
    );
  }
}
