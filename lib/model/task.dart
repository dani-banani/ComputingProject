class Task {
  int taskId;
  String taskName;
  String taskDescription;
  int difficulty;
  int priority;
  int reminderFrequency;
  int daysBeforeReminderStart;
  DateTime dueDate;
  DateTime createdDate;

  Task({
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

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
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
