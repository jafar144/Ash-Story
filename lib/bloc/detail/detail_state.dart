import 'package:submission_intermediate/data/model/detail_story_response.dart';

sealed class DetailState {}

class Loading extends DetailState {}

class Success extends DetailState {
  final Story story;

  Success({required this.story});
}

class Error extends DetailState {
  final String error;

  Error({required this.error});
}
