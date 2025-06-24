import 'dart:convert';
import 'package:computing_project/api/api_response_json.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/api_response.dart';

class CreateCategoryApi {
  String name;
  String? description;
  String color;

  CreateCategoryApi({
    required this.name,
    this.description,
    required this.color,
  });

  static Future<ApiResponse> createCategory({
    required String name,
    String? description,
    required String color,
  }) async {
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
          .from('cw_categories')
          .insert({
            'cw_category_name': name,
            'cw_category_description': description,
            'cw_category_color': color,
            'cw_user_id': user.id,
          })
          .select();

      if (response.isEmpty) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["Create category failed"],
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["Category created successfully"],
        data: {
          "uid": user.id,
          "name": name,
          "description": description,
          "color": color,
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