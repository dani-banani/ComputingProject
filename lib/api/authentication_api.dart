import 'package:supabase_flutter/supabase_flutter.dart';
import 'response_api.dart';

class RegistrationApi {
  final supabase = Supabase.instance.client;

  // Signup
  static Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      final signUpResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      if (signUpResponse.user != null) {
        return ResponseApi.dataSessionResponseHandler(
          ["User registered successfully"],
          true,
          signUpResponse.user!.toJson(),
          signUpResponse.session?.toJson() ?? {},
        );
      } else {
        return ResponseApi.dataSessionResponseHandler(
          ["User registration failed"],
          false,
          {},
          {},
        );
      }
    } on AuthException catch (e) {
      return ResponseApi.dataSessionResponseHandler(
        ["Sign up failed: ${e.message}"],
        false,
        {},
        {},
      );
    } catch (e) {
      return ResponseApi.dataSessionResponseHandler(
        ["Unexpected error: $e"],
        false,
        {},
        {},
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
        return ResponseApi.dataSessionResponseHandler(
          ["User logged in successfully"],
          true,
          signInResponse.user!.toJson(),
          signInResponse.session?.toJson() ?? {},
        );
      } else {
        return ResponseApi.dataSessionResponseHandler(
          ["User login failed"],
          false,
          {},
          {},
        );
      }
    } on AuthException catch (e) {
      return ResponseApi.dataSessionResponseHandler(
        ["Sign in failed: ${e.message}"],
        false,
        {},
        {},
      );
    } catch (e) {
      return ResponseApi.dataSessionResponseHandler(
        ["Unexpected error: $e"],
        false,
        {},
        {},
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
      return ResponseApi.dataSessionResponseHandler(
        ["User signed out successfully"],
        true,
        {},
        {},
      );
    } on AuthException catch (e) {
      return ResponseApi.dataSessionResponseHandler(
        ["Sign out failed: ${e.message}"],
        false,
        {},
        {},
      );
    } catch (e) {
      return ResponseApi.dataSessionResponseHandler(
        ["Unexpected error: $e"],
        false,
        {},
        {},
      );
    }
  }
}
