sealed class AddStoryState {}

class Idle extends AddStoryState {}

class Loading extends AddStoryState {}

class Success extends AddStoryState {}

class Failed extends AddStoryState {
  final String error;

  Failed({required this.error});
}
