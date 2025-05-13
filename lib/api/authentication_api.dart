import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//Different classes can be created for different APIs, no specific use, just for organization purposes. Maybe an authenticaiton API can be created then before all functions that requrire auth call that function
class RegistrationApi {
  final supabase = Supabase.instance.client;

  //Each API function starts with static, when I acess from front end is just ClassName.functionName
  static Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String response = '{';
    try {
      final signUpResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      if (signUpResponse.user != null) {
        response += '"status": "success"';
      } else {
        response += '"status": "error", "message": "Unknown error occurred"';
      }
    } on AuthException catch (e) {
      response += '"status": "error", "message": "${e.message}"';
    } catch (e) {
      response += '"status": "error", "message": "Unexpected error: $e"';
    }
    response += '}';
    return response;
  }
  static Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String response = '{';
    try {
      final signInResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (signInResponse.user != null) {
        response += '"status": "success"';
      } else {
        response += '"status": "error", "message": "Unknown error occurred"';
      }
    } on AuthException catch (e) {
      response += '"status": "error", "message": "${e.message}"';
    } catch (e) {
      response += '"status": "error", "message": "Unexpected error: $e"';
    }
    response += '}';
    return response;
  }
  static Future<String> authenticateUser() async {
    String response = '{';
    try {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        response += '"status": "success"';
      } else {
        response += '"status": "error", "message": "User not authenticated"';
      }
    } catch (e) {
      response += '"status": "error", "message": "Unexpected error: $e"';
    }
    response += '}';
    return response;
  }
}
