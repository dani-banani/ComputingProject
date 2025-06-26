import 'dart:convert';
import 'package:computing_project/api/api_response_json.dart';
import 'package:computing_project/api/authentication_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/api_response.dart';

class CategoryApi {
  static Future<ApiResponse> createCategory({
    required String name,
    required String color,
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
          await Supabase.instance.client.from('cw_user_categories').insert({
        'cw_category_name': name,
        'cw_category_color': color,
        'cw_user_id': userId,
      }).select();

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
      );
      
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse));
  }

  static Future<ApiResponse> getUserCategories() async {
    String jsonResponse = "";
    try {
      // final user = Supabase.instance.client.auth.currentUser;
      // if (user == null) {
      //   jsonResponse = ApiResponseJson.dataSessionResponseHandler(
      //     success: false,
      //     message: ["User not authenticated"],
      //   );
      //   return ApiResponse.fromJson(jsonDecode(jsonResponse));
      // }

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
          .from('cw_categories')
          .select()
          .eq('cw_user_id', userId);

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["user categories pulled"],
        data: {'categories': response},
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
