import 'package:submission_intermediate/data/model/stories_response.dart';

sealed class HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  final List<ListStory> listStory;

  Success({required this.listStory});
}

class Error extends HomeState {
  final String error;

  Error({required this.error});
}
