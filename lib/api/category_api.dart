import 'dart:convert';
import 'package:computing_project/api/api_response_json.dart';
import 'package:computing_project/api/authentication_api.dart';
import 'package:computing_project/model/category.dart';
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
      if (!userAuthResponse.success) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          statusCode: 401,
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      final userId = userAuthResponse.data['userId'];

      final response = await Supabase.instance.client.from('cw_user_categories').insert({
        'cw_category_name': name,
        'cw_category_color': color,
        'cw_user_id': userId,
      }).select();

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        // data: response.first,
      );
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse));
  }

  static Future<ApiResponse<List<Category>>> getUserCategories() async {
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

      final response = await Supabase.instance.client
          .from('cw_user_categories')
          .select()
          .eq('cw_user_id', userId);

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        data: {'categories': response},
      );
    } catch (e) {
      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
    return ApiResponse.fromJson(jsonDecode(jsonResponse),
        fromJson: (json) => List<Category>.from(
            json['categories'].map((item) => Category.fromJson(item))));
  }

  static Future<ApiResponse> editCategory({
    required int categoryId,
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
          .from('cw_user_categories')
          .update(fieldsToUpdate)
          .eq('cw_category_id', categoryId)
          .select();

      if (response.isEmpty) {
        jsonResponse = ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["Edit category failed"],
        );
        return ApiResponse.fromJson(jsonDecode(jsonResponse));
      }

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["Category updated successfully"],
        data: {
          "categoryId": categoryId,
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

  static Future<ApiResponse> deleteCategory({
    required int categoryId,
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
          .from('cw_user_categories')
          .delete()
          .eq('cw_category_id', categoryId);

      jsonResponse = ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["Category deleted successfully"],
        data: {
          "categoryId": categoryId,
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
