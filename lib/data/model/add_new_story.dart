class AddNewStoryResponse {
  final bool error;
  final String message;

  AddNewStoryResponse({
    required this.error,
    required this.message,
  });

  factory AddNewStoryResponse.fromJson(Map<String, dynamic> json) =>
      AddNewStoryResponse(
        error: json["error"],
        message: json["message"],
      );
}
