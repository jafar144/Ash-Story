sealed class LoginState {}

class Idle extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {}

class FailedLogin extends LoginState {
  final String message;

  FailedLogin({required this.message});
}
