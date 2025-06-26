class ApiResponse<T> {
  final bool success;
  final List<String> message;
  final T data;
  final bool session;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.session,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return ApiResponse<T>(
      success: json['success'],
      message: (json['message'] as List).map((e) => e.toString()).toList(),
      data: fromJson != null ? fromJson(json['data']) : json['data'] as T,
      session: json['session'],
    );
  }

  // // Optional: Factory for when you want raw Map<String, dynamic>
  // factory ApiResponse.raw(Map<String, dynamic> json) {
  //   return ApiResponse<T>(
  //     success: json['success'],
  //     message: (json['message'] as List).map((e) => e.toString()).toList(),
  //     data: json['data'],
  //     session: json['session'],
  //   );
  // }

  // factory ApiResponse.withNullData({
  //   required Map<String, dynamic> json,
  // }) {
  //   return ApiResponse<T>(
  //     success: json['success'],
  //     message: (json['message'] as List).map((e) => e.toString()).toList(),
  //     data: null as T,
  //     session: json['session'],
  //   );
  // }
}
