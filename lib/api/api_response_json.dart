import 'dart:convert';

class ApiResponseJson {
  static String dataSessionResponseHandler(
    {required bool success,
    List<String> message = const [],
    Map<String, dynamic> data = const {},
    bool session = true,
  }) {
    return jsonEncode({
      "success": success,
      "message": message,
      "data": data,
      "session": session,
    });
  }
}
