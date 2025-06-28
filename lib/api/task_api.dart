import 'dart:convert';

import 'package:computing_project/api/api_response_json.dart';
import 'package:computing_project/api/authentication_api.dart';
import 'package:computing_project/model/task_list.dart';
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
      if (userAuthResponse == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
          session: false,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final userId = userAuthResponse.data.userId;

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
        'cw_user_id': userId
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

  static Future<ApiResponse> getUserTasks() async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (userAuthResponse == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
          session: false,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final userId = userAuthResponse.data.userId;

      final response = await Supabase.instance.client
          .from('cw_user_tasks')
          .select()
          .eq('cw_user_id', userId);

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["user tasks pulled"],
        data: {'tasks': response},
      );
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse));
  }

  static Future<ApiResponse<TaskList>> getUserCategoriesWithTasks() async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (userAuthResponse == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
          session: false,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final userId = userAuthResponse.data.userId;

      final categories = await Supabase.instance.client
          .from('cw_user_categories')
          .select('cw_category_id, cw_category_name, cw_category_color')
          .eq('cw_user_id', userId);
      final tasks = await Supabase.instance.client
          .from('cw_user_tasks')
          .select()
          .eq('cw_user_id', userId);

      categories.sort((a, b) =>
          (a['cw_category_id'] as int).compareTo(b['cw_category_id'] as int));
      tasks.sort(
          (a, b) => (a['cw_task_id'] as int).compareTo(b['cw_task_id'] as int));

      final Map<int, List<dynamic>> tasksByCategory = {};

      for (final task in tasks) {
        final categoryId = task['cw_category_id'];
        tasksByCategory.putIfAbsent(categoryId, () => []).add(task);
      }

      final List<Map<String, dynamic>> categoriesWithTasks = [];
      for (final category in categories) {
        final categoryId = category['cw_category_id'];
        categoriesWithTasks.add({
          ...category,
          'tasks': tasksByCategory[categoryId] ?? [],
        });
      }

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["user task and categories pulled"],
        data: {
          'taskList': categoriesWithTasks,
        },
      );


    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse),fromJson: TaskList.fromJson);
  }

  static Future<ApiResponse> editTask({
    required int taskId,
    required Map<String, dynamic> fieldsToUpdate,
  }) async {
    String jsonResponse = "";
    try {
      final userAuthResponse = await AuthenticationApi.authenticateUser();
      if (userAuthResponse == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
          session: false,
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
      if (userAuthResponse == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
          session: false,
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
