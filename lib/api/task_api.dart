import 'dart:convert';

import 'package:computing_project/api/api_response_json.dart';
import 'package:computing_project/api/authentication_api.dart';
import 'package:computing_project/model/category.dart';
import 'package:computing_project/model/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/api_response.dart';

class TaskApi {
  static Future<ApiResponse> createTask({
    required DateTime dueDate,
    required int priority,
    required int difficulty,
    required String description,
    required String name,
    int? category,
    int daysBeforeReminder = 0,
    int reminderFrequency = 0,
  }) async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (!userAuthResponse.success) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          statusCode: 401,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final userId = userAuthResponse.data['userId'];

      final response =
          await Supabase.instance.client.from('cw_user_tasks').insert({
        'cw_category_id': category,
        'cw_task_due_date': dueDate.toIso8601String(),
        'cw_task_days_before_reminders': daysBeforeReminder,
        'cw_task_reminder_frequency': reminderFrequency,
        'cw_task_priority': priority,
        'cw_task_difficulty': difficulty,
        'cw_task_description': description,
        'cw_task_name': name,
        'cw_user_id': userId,
        'cw_task_completion_status': false,
      }).select();

      if (response.isEmpty) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["Create task failed, UID may not exist"],
        );

        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["User profile updated successfully"],
        data: {
          "uid": userId,
          "dueDate": dueDate.toIso8601String(),
          "category": category,
          "priority": priority,
          "difficulty": difficulty,
          "description": description,
          "name": name,
          "daysBeforeReminder": daysBeforeReminder,
          "reminderFrequency": reminderFrequency
        },
      );
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse));
  }

  static Future<ApiResponse<List<Category>?>> getUserTasksWithCategories() async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (!userAuthResponse.success) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          statusCode: 401,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final userId = userAuthResponse.data['userId'];

      final categories = await Supabase.instance.client
          .from('cw_user_categories')
          .select('cw_category_id, cw_category_name, cw_category_color')
          .eq('cw_user_id', userId);

      final tasks = await Supabase.instance.client
          .from('cw_user_tasks')
          .select()
          .eq('cw_user_id', userId);

      final taskIds = tasks.map((t) => t['cw_task_id'] as int).toList();

      List subtasks = [];
      if (taskIds.isNotEmpty) {
        subtasks = await Supabase.instance.client
            .from('cw_subtasks')
            .select()
            .inFilter('cw_task_id', taskIds);
      }

      final Map<int, List<dynamic>> subtasksByTask = {};
      for (final subtask in subtasks) {
        final tid = subtask['cw_task_id'];
        if (tid != null) {
          subtasksByTask.putIfAbsent(tid, () => []).add(subtask);
        }
      }

      categories.sort((a, b) =>
          (a['cw_category_id'] as int).compareTo(b['cw_category_id'] as int));
      tasks.sort(
          (a, b) => (a['cw_task_id'] as int).compareTo(b['cw_task_id'] as int));

      final Map<int, List<dynamic>> groupedTasks = {0: []};
      categories.forEach((category) {
        groupedTasks.putIfAbsent(category['cw_category_id'], () => []);
      });
      tasks.forEach((task) {
        final tid = task['cw_task_id'];
        task['subtasks'] = subtasksByTask[tid] ?? [];
        if (groupedTasks.containsKey(task['cw_category_id'])) {
          groupedTasks[task['cw_category_id']]?.add(task);
        } else {
          groupedTasks[0]!.add(task);
        }
      });

      final List<Map<String, dynamic>> categoryList = [];
      for (final category in categories) {
        final categoryId = category['cw_category_id'];
        categoryList.add({
          ...category,
          'tasks': groupedTasks[categoryId] ?? [],
        });
      }

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        data: {
          'categories': categoryList,
        },
      );

      return ApiResponse.fromJson(jsonDecode(jsonResponse),
          fromJson: (json) => List<Category>.from(
              json['categories'].map((item) => Category.fromJson(item))));
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
      return ApiResponse.fromJson(jsonDecode(jsonResponse));
    }
  }

  static Future<ApiResponse> editTask({
    required int taskId,
    required Map<String, dynamic> fieldsToUpdate,
  }) async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (!userAuthResponse.success) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          statusCode: 401,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      if (fieldsToUpdate.isEmpty) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["No fields to update"],
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final response = await Supabase.instance.client
          .from('cw_user_tasks')
          .update(fieldsToUpdate)
          .eq('cw_task_id', taskId)
          .select();

      if (response.isEmpty) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["Edit task failed"],
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["Task updated successfully"],
        data: {
          "taskId": taskId,
          ...fieldsToUpdate,
        },
      );
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse));
  }

  static Future<ApiResponse> deleteTask({
    required int taskId,
  }) async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (!userAuthResponse.success) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          statusCode: 401,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      await Supabase.instance.client
          .from('cw_user_tasks')
          .delete()
          .eq('cw_task_id', taskId);

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["Task deleted successfully"],
        data: {
          "taskId": taskId,
        },
      );
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse));
  }
}
