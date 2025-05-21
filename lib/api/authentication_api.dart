import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

import 'api_response_json.dart';

import '../model/api_response.dart';
import '../model/login.dart';


class RegistrationApi {
  final supabase = Supabase.instance.client;

  // Signup
  static Future<ApiResponse> signUpUser({
    required String email,
    required String password,
  }) async {
    String response = "";

    try {
      final signUpResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (signUpResponse.user != null) {
        response = ApiResponseJson.dataSessionResponseHandler(
          success: true,
          message: ["User registered successfully"],
          data: signUpResponse.user!.toJson(),
          session: signUpResponse.session?.toJson() ?? {},
        );

        return ApiResponse.fromJson(jsonDecode(response));
      }
      response = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["User registration failed"],
      );
    } on AuthException catch (e) {
      response = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Sign up failed: ${e.message}"],
      );
    } catch (e) {
      response = ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }

    return ApiResponse.fromJson(jsonDecode(response));
  }

  // Update User Details
  static Future<String> updateUserProfile({
    required String username,
    required String gender,
    required DateTime birthdate,
  }) async {
    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        return ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User not authenticated"],
        );
      }

      final response = await Supabase.instance.client
          .from('cw_user_profile')
          .update({
            'cw_username': username,
            'cw_gender': gender,
            'cw_birthdate': birthdate.toIso8601String(),
          })
          .eq('cw_user_id', user.id)
          .select();

      if (response.isEmpty) {
        return ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["No profile was updated UID may not exist"],
        );
      }

      return ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["User profile updated successfully"],
        data: {
          "uid": user.id,
          "username": username,
          "gender": gender,
          "birthdate": birthdate.toIso8601String()
        },
      );
    } catch (e) {
      return ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
  }

  // Sign in
  static Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final signInResponse = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
      if (signInResponse.user != null) {
        return ApiResponseJson.dataSessionResponseHandler(
          success: true,
          message: ["User logged in successfully"],
          data: signInResponse.user!.toJson(),
          session: signInResponse.session?.toJson() ?? {},
        );
      } else {
        return ApiResponseJson.dataSessionResponseHandler(
          success: false,
          message: ["User login failed"],
        );
      }
    } on AuthException catch (e) {
      return ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Sign in failed: ${e.message}"],
      );
    } catch (e) {
      return ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
  }

  // Authenticate
  static Future<bool> authenticateUser() async {
    return Supabase.instance.client.auth.currentSession != null;
  }

  // Sign out
  static Future<String> signOutUser() async {
    try {
      await Supabase.instance.client.auth.signOut();
      return ApiResponseJson.dataSessionResponseHandler(
        success: true,
        message: ["User signed out successfully"],
      );
    } on AuthException catch (e) {
      return ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Sign out failed: ${e.message}"],
      );
    } catch (e) {
      return ApiResponseJson.dataSessionResponseHandler(
        success: false,
        message: ["Unexpected error: $e"],
      );
    }
  }
}
