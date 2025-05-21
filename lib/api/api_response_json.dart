import 'dart:convert';

class ApiResponseJson {
  static String dataSessionResponseHandler(
    {List<String> message = const [],
    required bool success,
    Map<String, dynamic> data = const {},
    Map<String, dynamic> session = const {},
  }) {
    return jsonEncode({
      "success": success,
      "message": message,
      "data": data,
      "session": session,
    });
  }
}
