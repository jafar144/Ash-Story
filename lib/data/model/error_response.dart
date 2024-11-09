class ErrorResponse {
  final bool error;
  final String message;

  ErrorResponse({
    required this.error,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        error: json["error"],
        message: json["message"],
      );
}
