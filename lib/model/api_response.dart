class ApiResponse {
  final bool success;
  final List<String> message;
  final Map<String, dynamic> data;
  final Map<String, dynamic> session;

  ApiResponse(
      {required this.success,
      required this.message,
      required this.data,
      required this.session});

  factory ApiResponse.fromJson(Map<String, dynamic> json,
      {Function(Map<String, dynamic>)? fromJson}) {
    return ApiResponse(
        success: json['success'],
        message: (json['message'] as List).map((e) => e.toString()).toList(),
        data: fromJson != null ? fromJson(json['data']) : json['data'],
        session: json['session']);
  }
}
