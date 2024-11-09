sealed class LogoutState {}

class Init extends LogoutState {}

class Loading extends LogoutState {}

class Success extends LogoutState {}

class Failed extends LogoutState {
  final String message;

  Failed({required this.message});
}
