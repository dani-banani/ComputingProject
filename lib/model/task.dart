class Task {
  int id;
  String name;
  String description;
  int categoryId;
  int difficulty;
  int priority;
  int reminderFrequency;
  int daysBeforeReminderStart;
  DateTime dueDate;
  DateTime createdDate;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.difficulty,
    required this.priority,
    required this.reminderFrequency,
    required this.daysBeforeReminderStart,
    required this.dueDate,
    required this.createdDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['cw_task_id'],
      name: json['cw_task_name'],
      description: json['cw_task_description'],
      categoryId: json['cw_category_id'],
      difficulty: json['cw_task_difficulty'],
      priority: json['cw_task_priority'],
      reminderFrequency: json['cw_task_reminder_frequency'],
      daysBeforeReminderStart: json['cw_task_days_before_reminders'],
      dueDate: json['cw_task_due_date'],
      createdDate: json['cw_task_created_date'],
    );
  }
}
