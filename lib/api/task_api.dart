import 'dart:convert';

import 'package:computing_project/api/api_response_json.dart';
import 'package:computing_project/api/authentication_api.dart';
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
      // final categoriesInDb = await Supabase.instance.client
      //     .from('cw_user_categories')
      //     .select('cw_category_id')
      //     .eq('cw_user_id', user.id);
      // final categoryIds = (categoriesInDb as List)
      //     .map((e) => e['cw_category_id'] as int)
      //     .toList();
      // if (!categoryIds.contains(category)) {
      //   jsonResponse = ApiResponseJson.dataSessionResponseHandler(
      //     success: false,
      //     message: ["Invalid category ID"],
      //   );
      //   return ApiResponse.fromJson(jsonDecode(jsonResponse));
      // }

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

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
        'cw_user_id': user.id
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
          "uid": user.id,
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
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final response = await Supabase.instance.client
          .from('cw_user_tasks')
          .select()
          .eq('cw_user_id', user.id);

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
}
