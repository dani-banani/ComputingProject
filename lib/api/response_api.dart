import 'dart:convert';

class ResponseApi {
  static String dataSessionResponseHandler(
    List<String> message,
    bool success, [
    Map<String, dynamic> data = const {},
    Map<String, dynamic> session = const {},
  ]) {
    return jsonEncode({
      "status": success,
      "message": message,
      "data": data,
      "session": session,
    });
  }
}
