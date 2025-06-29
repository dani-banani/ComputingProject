class ApiResponse<T> {
  final bool success;
  final int statusCode;
  final List<String> message;
  final T data;

  ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? fromJson,
  }) {

    return ApiResponse<T>(
      success: json['success'],
      statusCode: json['statusCode'],
      message: (json['message'] as List).map((e) => e.toString()).toList(),
      data: fromJson != null ? fromJson(json['data']) : json['data'] as T,
    );
  }
}
