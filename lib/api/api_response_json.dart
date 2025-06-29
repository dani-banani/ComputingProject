import 'dart:convert';

class ApiResponseJson {
  static String dataSessionResponseHandler(
    {required bool success,
    int statusCode = 200,
    List<String> message = const [],
    Map<String, dynamic> data = const {},
  }) {
    return jsonEncode({
      "success": success,
      "statusCode": statusCode,
      "message": message,
      "data": data,
    });
  }
}
