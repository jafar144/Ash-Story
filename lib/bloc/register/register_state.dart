abstract class RegisterState {}

class Idle extends RegisterState {}

class LoadingRegister extends RegisterState {}

class SuccessRegister extends RegisterState {}

class FailedRegister extends RegisterState {
  final String message;

  FailedRegister({required this.message});
}
