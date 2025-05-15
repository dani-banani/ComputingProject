import 'dart:convert';

class ResponseApi {
  static String dataSessionResponseHandler(
    List<String> message,
    bool success,
    Map<String, dynamic> data,
    Map<String, dynamic> session
  ) {
    return jsonEncode({
      "status": success ? "success" : "error",
      "message": message,
      "data": data,
      "session": session,
    });
  }
}
